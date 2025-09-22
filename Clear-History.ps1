# This script clears Windows Run history and PowerShell history

# -------- Clear Windows Run (Win+R) history --------
Write-Host "Clearing Windows Run history..."
$runMRUPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"

if (Test-Path $runMRUPath) {
    Get-ItemProperty -Path $runMRUPath | ForEach-Object {
        $_.PSObject.Properties | Where-Object { $_.Name -match '^[a-z]$' } | ForEach-Object {
            Remove-ItemProperty -Path $runMRUPath -Name $_.Name -ErrorAction SilentlyContinue
        }
    }
    Write-Host "Windows Run history cleared."
} else {
    Write-Host "RunMRU registry key not found."
}

# -------- Clear PowerShell history --------
Write-Host "Clearing PowerShell history..."
$psHistory = (Get-PSReadlineOption).HistorySavePath
if (Test-Path $psHistory) {
    Remove-Item $psHistory -Force -ErrorAction SilentlyContinue
    Write-Host "PowerShell history cleared."
} else {
    Write-Host "PowerShell history file not found."
}
