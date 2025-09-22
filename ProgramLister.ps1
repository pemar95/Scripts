# Query the Windows Registry to enumerate installed software
$softwareKeys = Get-ChildItem -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty

# Filter and display relevant information about installed software
$installedSoftware = $softwareKeys | Where-Object { $_.DisplayName -ne $null } | Select-Object DisplayName, DisplayVersion | Sort-Object DisplayName

# Display the list of installed software and their versions
$installedSoftware | Format-Table -AutoSize
Pause
