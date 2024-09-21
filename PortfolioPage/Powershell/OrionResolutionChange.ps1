# Paths to NirCmd and the game
$nircmdPath = "C:\Users\nicho\Desktop\nircmd.exe"
$orionLauncherPath = "C:\Users\nicho\Desktop\Orion Launcher.lnk"
$gameClientExe = "OrionUO64"  # Process name for the game client
$orionLauncherExe = "OrionLauncher64"  # Process name for Orion Launcher
$logFile = "C:\Users\nicho\Desktop\resolution_change_log.txt"

# Log function
function Log-Message {
    param (
        [string]$message
    )
    Add-Content -Path $logFile -Value "$(Get-Date): $message"
}

# Set the resolution to 1920x1080 before launching the Orion Launcher
Log-Message "Starting script."
Log-Message "Changing resolution to 1920x1080"
try {
    & "$nircmdPath" setdisplay 1920 1080 32
    Log-Message "Resolution set to 1920x1080 successfully."
} catch {
    Log-Message "Error setting resolution: $_"
}

# Launch the Orion Launcher
Log-Message "Launching Orion Launcher"
Start-Process "$orionLauncherPath"

# Wait for the Orion Launcher to open and start the game client
Start-Sleep -Seconds 15

# Function to check if any of the specified processes are running
function Check-Processes {
    param (
        [string[]]$processNames
    )
    $processRunning = $false
    foreach ($name in $processNames) {
        $process = Get-Process -Name $name -ErrorAction SilentlyContinue
        if ($process) {
            $processRunning = $true
            break
        }
    }
    return $processRunning
}

# Function to get window handle and check if the window is minimized
function Get-WindowState {
    param (
        [string]$processName
    )
    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($process) {
        $handle = $process.MainWindowHandle
        if ($handle -ne [IntPtr]::Zero) {
            $state = [User32]::IsIconic($handle)
            return $state
        }
    }
    return $false
}

# Load User32.dll for window state checking
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class User32 {
    [DllImport("user32.dll")]
    public static extern bool IsIconic(IntPtr hWnd);
}
"@

# Monitor the game client state
$processNames = @($gameClientExe, $orionLauncherExe)
$keepRunning = $true

while ($keepRunning) {
    if (Check-Processes -processNames $processNames) {
        $minimized = Get-WindowState -processName $gameClientExe
        if ($minimized) {
            Log-Message "Game client minimized, changing resolution to 2560x1440"
            try {
                & "$nircmdPath" setdisplay 2560 1440 32
                Log-Message "Resolution set to 2560x1440 successfully."
            } catch {
                Log-Message "Error setting resolution: $_"
            }
        } else {
            Log-Message "Game client running and not minimized, changing resolution to 1920x1080"
            try {
                & "$nircmdPath" setdisplay 1920 1080 32
                Log-Message "Resolution set to 1920x1080 successfully."
            } catch {
                Log-Message "Error setting resolution: $_"
            }
        }
    } else {
        Log-Message "No game or launcher processes detected, exiting loop."
        $keepRunning = $false
    }
    Start-Sleep -Seconds 1
}

# Revert the resolution to 2560x1440 after all processes close
Log-Message "Reverting resolution to 2560x1440"
try {
    & "$nircmdPath" setdisplay 2560 1440 32
    Log-Message "Resolution reverted to 2560x1440 successfully."
} catch {
    Log-Message "Error reverting resolution: $_"
}
