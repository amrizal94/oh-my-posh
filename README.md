for installation, follow this link: 
1. https://learn.microsoft.com/en-us/windows/terminal/tutorials/custom-prompt-setup#install-a-nerd-font
2. https://learn.microsoft.com/en-us/powershell/scripting/learn/shell/creating-profiles?view=powershell-7.5

if failed to load the file, follow step below:
```
Set-ExetionPolicy RemoteSigned -Scope currentUser
Unblock-File -Path $PROFILE
```

## Windows Terminal settings

File `windows-terminal-settings.json` is the Windows Terminal config (keybindings, color scheme, font).

- Font used: **0xProto Nerd Font** — install it first (any Nerd Font works).
- To apply: copy it to
  `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`
  (close Windows Terminal first, then replace the file).

## macOS (zsh + Powerlevel10k)

Folder `macos/` contains the zsh terminal setup (matches the prompt used on the Macs).

- `macos/.zshrc` — clean zsh config (Oh My Zsh + Powerlevel10k theme + plugins). No secrets/machine-specific paths.
- `macos/.p10k.zsh` — Powerlevel10k prompt configuration.

**Setup on a new Mac:**
```bash
# 1. Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# 2. Powerlevel10k + plugins
ZC=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZC/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ZC/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting $ZC/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting $ZC/plugins/fast-syntax-highlighting
git clone --depth=1 https://github.com/marlonrichert/zsh-autocomplete $ZC/plugins/zsh-autocomplete
# 3. Copy configs from this repo
cp macos/.zshrc ~/.zshrc
cp macos/.p10k.zsh ~/.p10k.zsh
# 4. Nerd Font
brew install --cask font-meslo-lg-nerd-font
```
Then set the terminal font to **MesloLGS Nerd Font** (Terminal/iTerm → Preferences → Profile → Font) and restart the terminal.
