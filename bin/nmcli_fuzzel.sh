#!/bin/bash
# Filter nmcli output, uniqueify, give to fuzzel for the selection
SSID=$(nmcli -g SSID dev wifi | grep -v '^$' | sort -u | fuzzel -d)

[ -z "$SSID" ] && exit 1 || echo "Connecting to '$SSID'..."

nmcli device wifi connect "$SSID" --ask

# Oneline?

# nmcli -g SSID dev wifi | grep -v '^$' | sort -u | fuzzel -d | nmcli device wifi connect --ask 
