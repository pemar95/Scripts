function Get-RDPCredentials {
    param (
        [Parameter(Mandatory = $true)]
        [string]$computerName
    )

    $rdpRegistryPath = "Registry::HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client\Servers\$computerName"

    $serverAddress = $computerName
    $userName = (Get-ItemProperty -Path $rdpRegistryPath).UsernameHint
    $passwordHashBytes = (Get-ItemProperty -Path $rdpRegistryPath).CertHash
    $passwordHash = [System.BitConverter]::ToString($passwordHashBytes) -replace "-", ""

    Write-Host "----------------------------------------"
    Write-Host "Server Address: $serverAddress"
    Write-Host "Username: $userName"
    Write-Host "Password Hash: $passwordHash"
    Write-Host "----------------------------------------"
}

$rdpConnections = Get-ChildItem "Registry::HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client\Servers" -ErrorAction SilentlyContinue

if ($rdpConnections) {
    foreach ($rdpConnection in $rdpConnections) {
        $computerName = $rdpConnection.PSChildName
        Get-RDPCredentials -computerName $computerName
    }
} else {
    Write-Host "No saved RDP connections found in the registry."
}
