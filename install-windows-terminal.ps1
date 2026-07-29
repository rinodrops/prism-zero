#Requires -Version 5.1
<#
.SYNOPSIS
  Merge Prism Zero color schemes into Windows Terminal settings.json.

.DESCRIPTION
  Upserts "Prism Zero Light" and "Prism Zero Dark" into the schemes array.
  Does not change profile colorScheme unless -SetActiveScheme is passed.
  Creates a timestamped backup next to settings.json before writing.

.PARAMETER RepoRoot
  Path to a prism-zero checkout (directory that contains dist/).

.PARAMETER SettingsPath
  Explicit path to Windows Terminal settings.json.
  Also accepted via env WINDOWS_TERMINAL_SETTINGS.

.PARAMETER SetActiveScheme
  Optionally set the default profile's colorScheme to Light or Dark.

.EXAMPLE
  pwsh -File .\install-windows-terminal.ps1

.EXAMPLE
  pwsh -File .\install-windows-terminal.ps1 -SetActiveScheme Dark
#>
[CmdletBinding()]
param(
  [string] $RepoRoot = "",
  [string] $SettingsPath = "",
  [ValidateSet("", "Light", "Dark")]
  [string] $SetActiveScheme = ""
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-RepoRoot {
  param([string] $Hint)
  if ($Hint) {
    $p = (Resolve-Path -LiteralPath $Hint).Path
    if (-not (Test-Path -LiteralPath (Join-Path $p "dist/windows-terminal"))) {
      throw "RepoRoot does not contain dist/windows-terminal: $p"
    }
    return $p
  }
  $scriptDir = Split-Path -Parent $PSCommandPath
  if (Test-Path -LiteralPath (Join-Path $scriptDir "dist/windows-terminal")) {
    return $scriptDir
  }
  throw "Could not find dist/windows-terminal. Pass -RepoRoot or run from a prism-zero checkout."
}

function Get-SettingsCandidates {
  $list = New-Object System.Collections.Generic.List[string]
  if ($env:WINDOWS_TERMINAL_SETTINGS) {
    $list.Add($env:WINDOWS_TERMINAL_SETTINGS)
  }
  $local = $env:LOCALAPPDATA
  if ($local) {
    $list.Add((Join-Path $local "Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"))
    $list.Add((Join-Path $local "Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"))
    $list.Add((Join-Path $local "Microsoft\Windows Terminal\settings.json"))
  }
  return $list
}

function Resolve-SettingsPath {
  param([string] $Explicit)
  if ($Explicit) {
    if (-not (Test-Path -LiteralPath $Explicit)) {
      throw "SettingsPath not found: $Explicit"
    }
    return (Resolve-Path -LiteralPath $Explicit).Path
  }
  foreach ($c in Get-SettingsCandidates) {
    if ($c -and (Test-Path -LiteralPath $c)) {
      return (Resolve-Path -LiteralPath $c).Path
    }
  }
  throw @"
Windows Terminal settings.json not found.
Set -SettingsPath or WINDOWS_TERMINAL_SETTINGS, or install Windows Terminal first.
"@
}

function Remove-JsonComments {
  param([string] $Text)
  # Windows Terminal allows // and /* */ comments; ConvertFrom-Json does not.
  $sb = New-Object System.Text.StringBuilder
  $i = 0
  $n = $Text.Length
  $inString = $false
  while ($i -lt $n) {
    $c = $Text[$i]
    $next = if ($i + 1 -lt $n) { $Text[$i + 1] } else { [char]0 }
    if ($inString) {
      [void]$sb.Append($c)
      if ($c -eq '\' -and $i + 1 -lt $n) {
        [void]$sb.Append($Text[$i + 1])
        $i += 2
        continue
      }
      if ($c -eq '"') { $inString = $false }
      $i++
      continue
    }
    if ($c -eq '"') {
      $inString = $true
      [void]$sb.Append($c)
      $i++
      continue
    }
    if ($c -eq '/' -and $next -eq '/') {
      $i += 2
      while ($i -lt $n -and $Text[$i] -ne "`n") { $i++ }
      continue
    }
    if ($c -eq '/' -and $next -eq '*') {
      $i += 2
      while ($i + 1 -lt $n -and -not ($Text[$i] -eq '*' -and $Text[$i + 1] -eq '/')) { $i++ }
      $i += 2
      continue
    }
    [void]$sb.Append($c)
    $i++
  }
  return $sb.ToString()
}

function Read-JsonFile {
  param([string] $Path)
  $raw = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
  # Strip UTF-8 BOM if present
  if ($raw.Length -gt 0 -and [int][char]$raw[0] -eq 0xFEFF) {
    $raw = $raw.Substring(1)
  }
  $raw = Remove-JsonComments -Text $raw
  return $raw | ConvertFrom-Json
}

function Get-SchemeFragments {
  param([string] $Root)
  $dir = Join-Path $Root "dist\windows-terminal"
  $files = @(
    (Join-Path $dir "prism-zero-light.json"),
    (Join-Path $dir "prism-zero-dark.json")
  )
  $schemes = @()
  foreach ($f in $files) {
    if (-not (Test-Path -LiteralPath $f)) {
      throw "Missing scheme fragment: $f"
    }
    $doc = Read-JsonFile -Path $f
    if (-not $doc.schemes) {
      throw "No schemes array in $f"
    }
    foreach ($s in @($doc.schemes)) {
      $schemes += $s
    }
  }
  return $schemes
}

function Upsert-Schemes {
  param(
    [object] $Settings,
    [object[]] $Incoming
  )
  if (-not $Settings.PSObject.Properties["schemes"]) {
    $Settings | Add-Member -NotePropertyName schemes -NotePropertyValue @()
  }
  $existing = @($Settings.schemes)
  $byName = @{}
  foreach ($s in $existing) {
    if ($null -ne $s.name) {
      $byName[[string]$s.name] = $s
    }
  }
  foreach ($s in $Incoming) {
    $byName[[string]$s.name] = $s
    Write-Host "upsert scheme: $($s.name)"
  }
  $Settings.schemes = @($byName.Values)
}

function Set-DefaultProfileScheme {
  param(
    [object] $Settings,
    [string] $SchemeName
  )
  $guid = $Settings.defaultProfile
  if (-not $guid) {
    Write-Warning "No defaultProfile in settings.json; skipped -SetActiveScheme."
    return
  }
  if (-not $Settings.profiles -or -not $Settings.profiles.list) {
    Write-Warning "No profiles.list in settings.json; skipped -SetActiveScheme."
    return
  }
  $found = $false
  foreach ($p in @($Settings.profiles.list)) {
    if ([string]$p.guid -eq [string]$guid) {
      if ($p.PSObject.Properties["colorScheme"]) {
        $p.colorScheme = $SchemeName
      } else {
        $p | Add-Member -NotePropertyName colorScheme -NotePropertyValue $SchemeName
      }
      $found = $true
      Write-Host "default profile colorScheme -> $SchemeName"
      break
    }
  }
  if (-not $found) {
    Write-Warning "defaultProfile guid not found in profiles.list; skipped -SetActiveScheme."
  }
}

$root = Resolve-RepoRoot -Hint $RepoRoot
$settingsFile = Resolve-SettingsPath -Explicit $SettingsPath
$incoming = Get-SchemeFragments -Root $root

$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$backup = "$settingsFile.bak-$stamp"
Copy-Item -LiteralPath $settingsFile -Destination $backup -Force
Write-Host "backup: $backup"

$settings = Read-JsonFile -Path $settingsFile
Upsert-Schemes -Settings $settings -Incoming $incoming

if ($SetActiveScheme -eq "Light") {
  Set-DefaultProfileScheme -Settings $settings -SchemeName "Prism Zero Light"
} elseif ($SetActiveScheme -eq "Dark") {
  Set-DefaultProfileScheme -Settings $settings -SchemeName "Prism Zero Dark"
}

$json = $settings | ConvertTo-Json -Depth 100
# PowerShell 5 may emit ASCII-escaped unicode; WT accepts that.
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($settingsFile, $json + [Environment]::NewLine, $utf8NoBom)

Write-Host "updated: $settingsFile"
if (-not $SetActiveScheme) {
  Write-Host "Set a profile colorScheme to `"Prism Zero Light`" or `"Prism Zero Dark`" in Windows Terminal settings (or re-run with -SetActiveScheme Light|Dark)."
}
