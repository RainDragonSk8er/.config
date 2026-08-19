#!/bin/bash

# List available Wi-Fi networks and store SSIDs in an array
mapfile -t ssids < <(nmcli -g SSID dev wifi | grep -v '^$' | sort -u)

# Check if any networks were found
if [ ${#ssids[@]} -eq 0 ]; then
    echo "No Wi-Fi networks found."
    exit 1
fi

# Display menu
echo "Available Wi-Fi Networks:"
for i in "${!ssids[@]}"; do
	printf "%3d) %s\n" "$((i+1))" "${ssids[$i]}"
done

# Prompt user to select a network
read -p "Select a network by number: " choice

# Validate input
if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -ge "$((${#ssids[@]}+1))" ]; then
    echo "Invalid selection."
    exit 1
fi

# Connect to selected network
selected_ssid="${ssids[$((choice-1))]}"
echo "Connecting to '$selected_ssid'..."
nmcli device wifi connect "$selected_ssid" --ask

