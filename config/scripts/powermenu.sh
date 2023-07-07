#!/bin/sh

set -eu

chpower() {
	case "$1" in
		"")
		;;
		Poweroff)
			exec systemctl poweroff
		;;
		Reboot)
			exec systemctl reboot
		;;
                Suspend)
                        exec systemctl suspend 
                ;;
		Logout)
			swaymsg exit
		;;
      	Hybrid-sleep)
		exec systemctl hybrid-sleep
		;;
	Hibernate)
		exec systemctl hibernate
		;;
	lock)
		exec swaylock -c 000000
		;;
	esac
}

OPTIONS="Poweroff\nReboot\nHibernate\nLogout\nSuspend\nHybrid-sleep\nlock"

chpower "$(printf "%b" "$OPTIONS" | sort | dmenu -i -l 7 -p "Power Menu")"

