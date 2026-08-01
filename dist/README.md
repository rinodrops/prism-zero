# Generated artifacts

Importable theme files for each supported app. Prefer the Marketplace for Visual Studio Code and Cursor; use a Release `.vsix` only when the Marketplace is unavailable.

End-user installers (repo root, not under `dist/`):

- [`../install.sh`](../install.sh) — detect Neovim / Ptyxis and copy files
- [`../install-windows-terminal.ps1`](../install-windows-terminal.ps1) — merge schemes into Windows Terminal `settings.json`

| Path                                                                 | Use                                                      |
| -------------------------------------------------------------------- | -------------------------------------------------------- |
| [`iterm/`](iterm/)                                                   | iTerm 2 / Prompt 3 color presets (Light + Dark)          |
| [`ptyxis/`](ptyxis/)                                                 | Ptyxis palettes                                          |
| [`windows-terminal/`](windows-terminal/)                             | Windows Terminal `schemes` fragments                     |
| [`vscode/extension/`](vscode/extension/)                             | Theme sources packaged for the Marketplace               |
| [`vscode/prism-zero-*-terminal*.json`](vscode/)                      | Terminal-only color references (optional)                |
| [`nova/Prism Zero.novaextension/`](nova/Prism%20Zero.novaextension/) | Panic Nova themes (prefer Extension Library when listed) |
| [`nvim/`](nvim/)                                                     | Neovim colorscheme files                                 |
| [`typora/`](typora/)                                                 | Typora theme CSS (copy into theme folder)                |

Do not edit these files by hand. VSIX builds are attached to GitHub Releases (not stored here).
