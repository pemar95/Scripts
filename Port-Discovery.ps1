([Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()).GetActiveTcpListeners() |
    Where-Object { $_.Address -eq "0.0.0.0" }
