#!/usr/bin/env bash

fzf='fzf --preview="pistol {}"'
source_dir="/persist/home/aruna/nixconfig/"
find='find '$source_dir' -name'
tee='tee /tmp/path'
kitty='kitty --single-instance --wait-for-single-instance-window-close'
nix_config='$('$find' "*.nix" | '$fzf'  | '$tee')'
notes='$('$find' "*.md" | '$fzf'  | '$tee')'
scripts='$('$find' "*.sh" | '$fzf'  | '$tee')'
conf_options="Nixconfig\nScripts\nNotes\nExit"
rebuild_options="Yes\nNo"
dmenu='dmenu -sync -i -p'
n=4


index_options() {

	case "$1" in 
		"")
		;;
	Nixconfig)
                  $kitty $SHELL -c "vi $nix_config"
	        ;;
	Scripts)
		  $kitty $SHELL -c "vi $scripts"
		;;
	Notes)
		  $kitty $SHELL -c "vi $notes"
	        ;;
	Exit) 
		n=5
esac

}


# rebuild
rebuild_menu() {
	case "$1" in 
		"")
			;;
	Yes)
		$kitty --hold $SHELL -c "cd /persist/home/aruna/nixconfig; doas nixos-rebuild switch --flake .#laptop"
		nix_rebuild

	;;
No)
	notify-send "ok" 
	rm -f /tmp/build_failed
esac
}


index_menu() {
	index_options "$(printf "%b" "$conf_options" | $dmenu "Config")";
}

rebuild_query() {
     rebuild_menu "$(printf "%b" "$rebuild_options" | sort | $dmenu "Rebuild?")";
}

nix_rebuild() {
echo $?
if [ $? -ne 0 ];
then touch /tmp/build_failed
else 
	rm -f /tmp/build_failed 
fi
}


main() {
while [ $n == 4 ]
do
      index_menu
done

rebuild_query

if test -f /tmp/build_failed;
then 
	$kitty $SHELL -c "vi $(cat /tmp/path)"
	rebuild_query
fi

}


main 

