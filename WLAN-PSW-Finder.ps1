# Retrieve the original installation language code
$installLanguage = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Nls\Language").InstallLanguage

# Set the translation based on the original language
if ($installLanguage -eq "0410") {
    $profileHeaderText = "Tutti i profili utente"
    $ssidHeaderText = "Nome SSID"
    $passwordHeaderText = "Contenuto Chiave"
}
elseif ($installLanguage -eq "0409") {
    $profileHeaderText = "All User Profile"
    $ssidHeaderText = "SSID name"
    $passwordHeaderText = "Key Content"
}
elseif ($installLanguage -eq "0407") {
    $profileHeaderText = "Alle Benutzerprofile"
    $ssidHeaderText = "SSID-Name"
    $passwordHeaderText = "Schlüsselinhalt"
}
elseif ($installLanguage -eq "040C") {
    $profileHeaderText = "Tous les profils d'utilisateur"
    $ssidHeaderText = "Nom SSID"
    $passwordHeaderText = "Contenu de la clé"
}
elseif ($installLanguage -eq "0C0A") {
    $profileHeaderText = "Todos los perfiles de usuario"
    $ssidHeaderText = "Nombre del SSID"
    $passwordHeaderText = "Contenido de la clave"
}
# Add more language translations here as needed

# Get the Wi-Fi profiles using the translated header text
$profiles = (netsh wlan show profiles) | Select-String "$profileHeaderText\s+:\s(.+)" | ForEach-Object { $_.Matches.Groups[1].Value }

# Loop through each profile and retrieve SSID and password
Write-Host ""
Write-Host " --------------------------------------------------"
Write-Host "|          WLAN SSID-PASSWORD COMBINATION          |"
Write-Host " --------------------------------------------------"
Write-Host ""
foreach ($profile in $profiles) {
    $results = Invoke-Expression "netsh wlan show profile name=`"$profile`" key=clear"
    $ssid = ($results | Select-String "$ssidHeaderText\s+:\s(.+)").Matches.Groups[1].Value
    $password = ($results | Select-String "$passwordHeaderText\s+:\s(.+)").Matches.Groups[1].Value

    Write-Host "SSID: $ssid"
    Write-Host "Password: $password"
    Write-Host "-------------------------"
}
