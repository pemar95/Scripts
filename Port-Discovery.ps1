([Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()).GetActiveTcpListeners() |
    Where-Object { $_.Address -eq [System.Net.IPAddress]::Any } |
    Select-Object Port
