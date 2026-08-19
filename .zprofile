# Base of change, make nvidia and HDMI port functional: https://forum.endeavouros.com/t/sway-with-nvidia-tutorial/23733
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
	export SDL_VIDEODRIVER=wayland
	export _JAVA_AWT_WM_NONREPARENTING=1
	export QT_QPA_PLATFORM=wayland
	export XDG_CURRENT_DESKTOP=sway
	export XDG_SESSION_DESKTOP=sway

	# Wallpaper used by sway/config's `output "*" bg $WALLPAPER_PATH fill`
	export WALLPAPER_PATH=/usr/share/backgrounds/downloaded/galaxy_purple_1440p.png

	# killall xdg-desktop-portal
	systemctl --user restart pipewire
    # start automounting of USB devices
    udiskie -a &
 
    # Start window manager
	exec sway --unsupported-gpu
fi
