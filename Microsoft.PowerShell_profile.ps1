oh-my-posh init pwsh --config 'C:\Users\KK\AppData\Local\Programs\oh-my-posh\themes\kushal.omp.json' | Invoke-Expression
# Daftar nama modul
$modules = @('Terminal-Icons', 'z')

# Loop untuk setiap modul
foreach ($module in $modules) {
    # Cek apakah modul sudah ada
    if (-not (Get-Module -ListAvailable -Name $module)) {
        # Jika modul belum ada, install terlebih dahulu
        Install-Module -Name $module -Force -Scope CurrentUser
    }

    # Import modul
    Import-Module $module
}
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

function openclaw-local {
    $env:ANTHROPIC_BASE_URL = "https://llm.amrzaki.online"
    # Jangan hardcode API key di file public ini.
    # Set sekali per-mesin:  setx OPENCLAW_API_KEY "kunci-anda"  (lalu buka terminal baru)
    $env:ANTHROPIC_API_KEY = $env:OPENCLAW_API_KEY
    openclaw @args
    Remove-Item Env:\ANTHROPIC_BASE_URL -ErrorAction SilentlyContinue
    Remove-Item Env:\ANTHROPIC_API_KEY -ErrorAction SilentlyContinue
}
