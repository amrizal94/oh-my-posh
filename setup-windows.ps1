<#
Samakan tampilan PowerShell (oh-my-posh kushal + Terminal-Icons + z) dan Windows Terminal.

Jalankan di PowerShell 7:
  irm https://raw.githubusercontent.com/amrizal94/oh-my-posh/main/setup-windows.ps1 | iex
#>

$ErrorActionPreference = 'Stop'
$RepoRaw = 'https://raw.githubusercontent.com/amrizal94/oh-my-posh/main'
function Step($m) { Write-Host "==> $m" -ForegroundColor Cyan }

# 1. PowerShell 7
if (-not (Get-Command pwsh -ErrorAction SilentlyContinue)) {
    Step 'Install PowerShell 7'
    winget install --id Microsoft.PowerShell --exact --silent --accept-package-agreements --accept-source-agreements
}

# 2. oh-my-posh
if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Step 'Install oh-my-posh'
    winget install --id JanDeDobbeleer.OhMyPosh --exact --silent --accept-package-agreements --accept-source-agreements
    $env:PATH = "$env:LOCALAPPDATA\Programs\oh-my-posh\bin;$env:PATH"
}

# 3. Font 0xProto Nerd Font
Step 'Install font 0xProto Nerd Font'
try { oh-my-posh font install 0xProto } catch { Write-Warning 'Font gagal dipasang. Pasang manual dari https://www.nerdfonts.com/font-downloads' }

# 4. Modul PowerShell
foreach ($m in 'Terminal-Icons', 'z') {
    if (-not (Get-Module -ListAvailable -Name $m)) {
        Step "Install module $m"
        Install-Module -Name $m -Force -Scope CurrentUser -AllowClobber
    }
}

# 5. Profil PowerShell (diambil dari repo ini)
$profileDir = Split-Path -Parent $PROFILE
if (-not (Test-Path $profileDir)) { New-Item -ItemType Directory -Force -Path $profileDir | Out-Null }
if (Test-Path $PROFILE) { Copy-Item $PROFILE "$PROFILE.bak-$(Get-Date -Format yyyyMMddHHmmss)" }
Step 'Ambil profil dari repo'
$p = Invoke-RestMethod "$RepoRaw/Microsoft.PowerShell_profile.ps1"
# path tema dibuat portabel, tidak mengikuti username mesin asal
$p = $p -replace "'C:\Users\[^\]+\AppData\Local\Programs\oh-my-posh\themes\kushal\.omp\.json'", '"$env:POSH_THEMES_PATH\kushal.omp.json"'
Set-Content -Path $PROFILE -Value $p -Encoding UTF8
Step "Profil ditulis: $PROFILE"

# 6. Windows Terminal: font, skema warna, profil default
$wt = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
if (Test-Path $wt) {
    Copy-Item $wt "$wt.bak-$(Get-Date -Format yyyyMMddHHmmss)"
    $j = Get-Content $wt -Raw | ConvertFrom-Json
    if (-not $j.profiles.defaults) { $j.profiles | Add-Member -NotePropertyName defaults -NotePropertyValue ([pscustomobject]@{}) -Force }
    $j.profiles.defaults | Add-Member -NotePropertyName font -NotePropertyValue ([pscustomobject]@{ face = '0xProto Nerd Font'; size = 13 }) -Force
    $j.profiles.defaults | Add-Member -NotePropertyName colorScheme -NotePropertyValue 'One Half Dark' -Force
    $pwshProfile = $j.profiles.list | Where-Object { $_.commandline -match 'pwsh' -or $_.name -match 'PowerShell' } | Select-Object -First 1
    if ($pwshProfile) { $j.defaultProfile = $pwshProfile.guid }
    $j | ConvertTo-Json -Depth 32 | Set-Content $wt -Encoding UTF8
    Step 'Windows Terminal diatur'
} else {
    Write-Warning 'Windows Terminal belum terpasang: winget install Microsoft.WindowsTerminal'
}

Step 'Selesai. Tutup dan buka lagi Windows Terminal.'
Write-Host 'Kalau pakai openclaw-local, set dulu: setx OPENCLAW_API_KEY "kunci-anda"' -ForegroundColor Yellow
