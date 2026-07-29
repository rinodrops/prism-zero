[English](README.md) | **日本語**

# Prism Zero

[PrismJS](https://prismjs.com/) の構文色（UI クロームとダーク背景向けに調整）を基にした、エディタ／端末向けカラーテーマです。Light / Dark の両方を含みます。

対応: Visual Studio Code、Cursor、Panic Nova、Neovim、iTerm 2、Prompt 3、Ptyxis、Windows Terminal。

## スクリーンショット

### Cursor

![Prism Zero Light in Cursor](screenshots/light-cursor.webp)

![Prism Zero Dark in Cursor](screenshots/dark-cursor.webp)

### Visual Studio Code

| Light                                                                    | Dark                                                                   |
| ------------------------------------------------------------------------ | ---------------------------------------------------------------------- |
| ![Prism Zero Light in Visual Studio Code](screenshots/light-vscode.webp) | ![Prism Zero Dark in Visual Studio Code](screenshots/dark-vscode.webp) |

### Panic Nova

| Light                                                          | Dark                                                         |
| -------------------------------------------------------------- | ------------------------------------------------------------ |
| ![Prism Zero Light in Panic Nova](screenshots/light-nova.webp) | ![Prism Zero Dark in Panic Nova](screenshots/dark-nova.webp) |

### Neovim

| Light                                                        | Dark                                                       |
| ------------------------------------------------------------ | ---------------------------------------------------------- |
| ![Prism Zero Light in Neovim](screenshots/light-neovim.webp) | ![Prism Zero Dark in Neovim](screenshots/dark-neovim.webp) |

### iTerm 2

| Light                                                        | Dark                                                       |
| ------------------------------------------------------------ | ---------------------------------------------------------- |
| ![Prism Zero Light in iTerm 2](screenshots/light-iterm.webp) | ![Prism Zero Dark in iTerm 2](screenshots/dark-iterm.webp) |

### Prompt 3

| Light                                                          | Dark                                                         |
| -------------------------------------------------------------- | ------------------------------------------------------------ |
| ![Prism Zero Light in Prompt 3](screenshots/light-prompt.webp) | ![Prism Zero Dark in Prompt 3](screenshots/dark-prompt.webp) |

### Ptyxis

| Light                                                        | Dark                                                       |
| ------------------------------------------------------------ | ---------------------------------------------------------- |
| ![Prism Zero Light in Ptyxis](screenshots/light-ptyxis.webp) | ![Prism Zero Dark in Ptyxis](screenshots/dark-ptyxis.webp) |

### Windows Terminal

| Light                                                                            | Dark                                                                           |
| -------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ![Prism Zero Light in Windows Terminal](screenshots/light-windows-terminal.webp) | ![Prism Zero Dark in Windows Terminal](screenshots/dark-windows-terminal.webp) |

## インストール

### Visual Studio Code / Cursor

Marketplace から **Prism Zero** をインストールし、カラーテーマ一覧で **Prism Zero Light** または **Prism Zero Dark** を選びます。

Marketplace が使えない場合（例: code-server）は、リポジトリの Releases から最新の `.vsix` を入手して実行します:

```bash
code --install-extension prism-zero-*.vsix
# または: cursor --install-extension prism-zero-*.vsix
```

### Panic Nova

Nova の Extension Library（Extensions → Extension Library、または [extensions.panic.com](https://extensions.panic.com/)）から **Prism Zero** をインストールし、Themes で **Prism Zero Light** または **Prism Zero Dark** を選びます。

Library を使わない場合は [`dist/nova/Prism Zero.novaextension`](dist/nova/Prism%20Zero.novaextension) を開くかコピーして Nova に入れます。

### クイックインストール（Neovim / Ptyxis）

macOS / Linux では、検出できたアプリ（Neovim および／または Ptyxis）にだけテーマファイルをコピーするスクリプトがあります。Marketplace 拡張（VS Code、Cursor、Nova）のインストールや、iTerm / Prompt のプロファイル適用は行いません。

クローンから:

```bash
sh install.sh
```

または（このリポジトリが GitHub に載ったあと）:

```bash
curl -fsSL https://raw.githubusercontent.com/rinodrops/prism-zero/main/install.sh | sh
```

iTerm 2 と Prompt 3 は手動インポートのままです（スクリプトが `curl` での取得コマンドを表示します）。Windows Terminal は下記の専用スクリプトを使います。

### Neovim

上記インストーラは Neovim 検出時に両 colorscheme を配置します。手動の場合:

[`dist/nvim/prism_zero_light.lua`](dist/nvim/prism_zero_light.lua) と [`prism_zero_dark.lua`](dist/nvim/prism_zero_dark.lua) を `~/.config/nvim/colors/` にコピーし:

```vim
:colorscheme prism_zero_light
" または
:colorscheme prism_zero_dark
```

プラグイン配置（任意）: [`dist/nvim/prism-zero.nvim/`](dist/nvim/prism-zero.nvim/)。

### iTerm 2

プリセットをダウンロードしてインポートし、プロファイルに適用します:

```bash
mkdir -p ~/Downloads
curl -fsSL -o ~/Downloads/"Prism Zero Light.itermcolors" \
  https://raw.githubusercontent.com/rinodrops/prism-zero/main/dist/iterm/Prism%20Zero%20Light.itermcolors
# または Dark:
curl -fsSL -o ~/Downloads/"Prism Zero Dark.itermcolors" \
  https://raw.githubusercontent.com/rinodrops/prism-zero/main/dist/iterm/Prism%20Zero%20Dark.itermcolors
```

iTerm 2: Profiles → Colors → Color Presets… → Import から取り込み、プリセットを選びます。

クローンがある場合は [`dist/iterm/Prism Zero Light.itermcolors`](dist/iterm/Prism%20Zero%20Light.itermcolors) または [`Prism Zero Dark.itermcolors`](dist/iterm/Prism%20Zero%20Dark.itermcolors) を直接インポートしても構いません。

### Prompt 3

同じ iTerm プリセットを Settings → Themes（歯車 → Import）からインポートします。

### Ptyxis

上記インストーラは Ptyxis 検出時にパレットをコピーします。手動の場合:

[`Prism Zero Light.palette`](dist/ptyxis/Prism%20Zero%20Light.palette) または [`Dark`](dist/ptyxis/Prism%20Zero%20Dark.palette) を `~/.local/share/org.gnome.Ptyxis/palettes/`（Flatpak: アプリデータ `…/org.gnome.Ptyxis/palettes/`）へコピーし、Preferences → Appearance で選びます。

注: Ptyxis は bold テキストを常に bright ANSI 色で描画します。この対応は設定できません。

### Windows Terminal

クローンから（推奨）:

```powershell
pwsh -File .\install-windows-terminal.ps1
# 任意: 既定プロファイルのスキームも設定
pwsh -File .\install-windows-terminal.ps1 -SetActiveScheme Dark
```

スクリプトは `settings.json` をバックアップしたうえで、`schemes` に **Prism Zero Light** / **Prism Zero Dark** を upsert します。既定ではプロファイルの `colorScheme` は変更しません（変更する場合は `-SetActiveScheme Light|Dark`）。

`settings.json` の場所が標準と違う場合は `-SettingsPath` または環境変数 `WINDOWS_TERMINAL_SETTINGS` を指定します。

手動マージ: [`prism-zero-light.json`](dist/windows-terminal/prism-zero-light.json) または [`prism-zero-dark.json`](dist/windows-terminal/prism-zero-dark.json) の `schemes` 要素を `settings.json` に取り込み、プロファイルの `colorScheme` を設定します。

## ライセンス

MIT — Copyright (c) Rino, eMotionGraphics Inc.
