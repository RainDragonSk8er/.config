#!/bin/bash
# Filter 'bluetoothctl devices' output, uniqueify, give to fuzzel for the selection

# NB! This script does not currently function!

echo "Hello?"

declare -A BTID_hashmap

bluetoothctl devices Trusted | grep "Device" | awk -F ' ' '{print $2"|"$3}' | while IFS='|' read -r BTID name; do
	echo "$name : $BTID"
	BTID_hashmap["$name"]="$BTID"
	echo "$name : ${BTID_hashmap["$name"]}"
done

# echo "$(typeset -p BTID_hashmap)"
fuzzel -d <(for name in "${!BTID_hashmap[@]}" ; do echo "$name" ; done)

# BT_dev_name=$("${!BTID_hashmap[@]}" | fuzzel -d)

# echo "Device BTID: ${BTID_hashmap["$BT_dev_name"]}"
# echo "${BT_str_arr}"

# for BT_str in "${BT_str_arr[@]}"; do
#     echo "${BT_str}"
# done

# BTID=$(bluetoothctl devices Trusted | grep "Device" | awk -F ' ' '{print $3}' | sort -u | fuzzel -d)

# [ -z "$BTID" ] && exit 1 || echo "Connecting to '$BTID'..."

# bluetoothctl connect $BTID

# Oneline?

# nmcli -g SSID dev wifi | grep -v '^$' | sort -u | fuzzel -d | nmcli device wifi connect --ask 
