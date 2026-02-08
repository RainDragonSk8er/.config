#!/bin/sh

# Define swaylock options
SWAYLOCK_OPTIONS="-l -k --image ${WALLPAPER_PATH} --font JetBrainsMono-ExtraBold"

# Define color variables
SWAYLOCK_COLOURS="" # set in config file

# Launch swaylock with combined options
LAUNCH_SCRIPT="swaylock ${SWAYLOCK_OPTIONS} ${SWAYLOCK_COLOURS}"
$SHELL -c $LAUNCH_SCRIPT
