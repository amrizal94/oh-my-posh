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
