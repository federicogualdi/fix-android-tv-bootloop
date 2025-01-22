# Android TV Recovery Script

This repository contains a Bash script that will resolve boot loop issues.

## Features
- Fix the boot loop issue
- Reboots the device after cleanup

## Requirements

1. **ADB Installed:**
   - Linux (Debian/Ubuntu): `sudo apt install adb`
   - macOS: `brew install adb`
   - Windows: Download and install ADB from the official [Android Developer website](https://developer.android.com/studio/releases/platform-tools)

2. **Android TV Setup:**
   - Plug the network cable into your TV

## How to Find Your Android TV's IP Address

To connect via Ethernet/Wi-Fi, you need the IP address of your Android TV.

### Method 1: Find the IP Address from a Network Analyzer App
1. Go to your app store and search for it (e.g., [`Network Analyzer`](https://play.google.com/store/apps/details?id=net.techet.netanalyzerlite.an&hl=it))

### Method 2: Check the Router Interface
Log into your router's admin panel and look for connected devices.

### Method 3: Use a Network Scanner (Linux/macOS/Windows)
You can find the TV's IP address by scanning your local network.
> remember to use your IP class
```bash
# Linux/macOS
nmap -sn 192.168.1.0/24

# Windows (PowerShell)
Get-NetNeighbor | Select-String "192.168."
```

## Usage

You can run the script directly from GitHub 'without downloading it' first. Use the appropriate command for your operating system.

> remember to enter the TV IP ADDRESS in place of <YOUR_TV_IP>

### Linux/macOS (Using `wget`)
```bash
bash <(wget -qO- https://raw.githubusercontent.com/federicogualdi/fix-android-tv-bootloop/main/fix_android_tv_bootloop.sh) YOUR_TV_IP [PORT]
```
### Windows
```powershell
powershell -Command "& {Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/federicogualdi/fix-android-tv-bootloop/main/fix_android_tv_bootloop.ps1' -Headers @{'Cache-Control'='no-cache'} -OutFile 'fix_android_tv_bootloop.ps1'; ./fix_android_tv_bootloop.ps1 -IP_ADDRESS 'YOUR_TV_IP' -PORT 5555}"
```

## Troubleshooting

- **"Device not found" error:**
  - Ensure the TV is on the same network as your computer.
  - Check if ADB debugging is enabled.

- **Port not open:**
  - Ensure `adb` is allowed through the firewall.
  - Try enabling network debugging again in the TV settings.

- **If the TV is not detected:**
  - Try connecting a mouse and keyboard to the TV while it is in bootloop.
  - Pressing keys on the keyboard while moving the mouse might make the loading screen disappear, leaving only the mouse pointer visible (this has been observed on Akai-Nordmende family TVs).
  - Now the TV should be visible on the network. If not, you can also try disconnecting and reconnecting the network cable.

