#!/bin/bash

# Check if ADB is installed
if ! command -v adb &> /dev/null; then
    echo "ADB is not installed. Please install it before running the script."
    exit 1
fi

# Get IP and port from arguments
IP_ADDRESS=$1
PORT=${2:-5555}

if [ -z "$IP_ADDRESS" ]; then
    echo "Usage: $0 <IP_ADDRESS> [PORT]"
    exit 1
fi

# Connect to the device via network
echo "Connecting to the Android TV device at $IP_ADDRESS:$PORT..."
adb connect "$IP_ADDRESS:$PORT"

if [ $? -ne 0 ]; then
    echo "Failed to connect to $IP_ADDRESS:$PORT. Ensure that ADB is enabled on the device and the IP is correct."
    exit 1
fi

echo "Device connected successfully!"

# Fixing Android TV bootloop
echo "Fixing Android TV bootloop..."

adb shell "rm -rf /data/* /cache/*"
if [ $? -eq 0 ]; then
    echo "Android TV successfully fixed."
else
    echo "Failed to fix Android TV bootloop. Check device connection or permissions."
    exit 1
fi

# Reboot the device
echo "Rebooting the device..."
adb reboot

echo "The device is rebooting. Please wait..."
exit 0
