#usr/bin/sh


set -eu

rebuild() {
	case "$1" in 
		"")
			;;
	Yes)
	kitty --class=ytfzf --hold sh -c "~/.config/scripts/actual_rebuild.sh" 
	;;
No)
	notify-send "ok" 
	rm -f /tmp/build_failed
esac
}

OPTIONS="Yes\nNo"

rebuild "$(printf "%b" "$OPTIONS" | sort | dmenu -i -l 2 -p "Rebuild?")";

