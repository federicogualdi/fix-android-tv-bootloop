# Get IP and port from arguments
param (
    [string]$IP_ADDRESS,
    [int]$PORT = 5555
)

if (-not $IP_ADDRESS) {
    Write-Host "Usage: .\fix_android_tv_bootloop.ps1 <IP_ADDRESS> [PORT]" -ForegroundColor Yellow
    exit 1
}

# Function to check if ADB is installed
function Check-ADB {
$adbPath = (Get-Command adb -ErrorAction SilentlyContinue).Source

if (-not $adbPath) {
        # If ADB is not found in the system, check the current directory
        if (Test-Path ".\adb.exe") {
            $adbPath = ".\adb.exe"
        } else {
            Write-Host "ADB is not installed and not found in the current directory. Please install it or place adb.exe in the script directory." -ForegroundColor Red
    exit 1
        }
    }
    return $adbPath
}

# Find ADB binary
$ADB = Check-ADB

# Connect to the device via network
Write-Host "Connecting to the Android TV device at ${IP_ADDRESS}:${PORT}..."
& $ADB connect "${IP_ADDRESS}:${PORT}"

if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to connect to ${IP_ADDRESS}:${PORT}. Ensure that ADB is enabled on the device and the IP is correct." -ForegroundColor Red
    exit 1
}

Write-Host "Device connected successfully!" -ForegroundColor Green

# Fixing Android TV bootloop
Write-Host "Fixing Android TV bootloop..."
& $ADB shell "rm -rf /data/* /cache/*"

if ($LASTEXITCODE -eq 0) {
    Write-Host "Android TV successfully fixed." -ForegroundColor Green
} else {
    Write-Host "Failed to fix Android TV bootloop. Check device connection or permissions." -ForegroundColor Red
    exit 1
}

# Reboot the device
Write-Host "Rebooting the device..."
& $ADB reboot

Write-Host "The device is rebooting. Please wait..." -ForegroundColor Cyan
exit 0
