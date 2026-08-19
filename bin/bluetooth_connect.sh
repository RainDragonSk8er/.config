#!/bin/bash

# List available Bluetooth devices, store to array
mapfile -t devices < <(bluetoothctl devices | grep "Device" | awk -F ' ' '{print $2}' | sort -u)

# Check if a ny devices were found
if [ ${#devices[@]} -eq 0 ]; then
    echo "No Wi-Fi networks found."
    exit 1
fi

# Display menu
echo "Availible bluetooth devices:"
for i in "${!devices[@]}"; do
    printf "%3d) %s\n" "$i" "${devices[$1]}"
done

# Prompt user to select a network
read -p "Select a device by number: " choice

# Validate input
if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ $choice -ge "${#devices[@]}" ]; then
    echo "Invalid selection."
    exit 1
fi

# Connect to selected bluetooth device
selected_device="${devices[$choice]}"
echo "Connecting to '$selected_device'..."
bluetoothctl connect "${selected_device}"
