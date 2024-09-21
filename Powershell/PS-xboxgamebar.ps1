param (
    [string]$deathMsg
)

# Output the received phrase for debugging
Write-Output "Received death message: $deathMsg"

# Create a new object for sending keystrokes
$shell = New-Object -ComObject "WScript.Shell"

# Send Ctrl+5 keystrokes to trigger the recording in Xbox Game Bar
$shell.SendKeys("^5")

# Wait for a moment to ensure the recording has started
Start-Sleep -Milliseconds 500

# Define the path to the captures folder
$capturesFolder = "$env:USERPROFILE\Videos\Captures"

# Generate the timestamp
$timestamp = Get-Date -Format "HHmmss"

# Generate the full path for the new file name with the timestamp
$newFileName = "$capturesFolder\$deathMsg-$timestamp.mp4"

# Get the path to the latest captured video file
$latestVideoFile = Get-ChildItem -Path $capturesFolder | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1

# Rename the latest captured video file to match the death message with the timestamp
Rename-Item -Path $latestVideoFile.FullName -NewName $newFileName
