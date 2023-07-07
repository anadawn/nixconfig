#usr/bin/sh


set -eu

laptopscreen() {
	case "$1" in 
		"")
		;;
	Screenoff)
	         swaymsg output eDP-1 dpms off || hyprctl dispatch dpms off eDP-1
		;;
	Screenon)
		 swaymsg output eDP-1 dpms on || hyprctl dispatch dpms on eDP-1
		;;
	esac
}

OPTIONS="Screenoff\nScreenon"

laptopscreen "$(printf "%b" "$OPTIONS" | sort | dmenu -i -l 2 -p "Screen")"
