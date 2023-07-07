#!/usr/bin/env sh

#set -eu 
n=4
config() {

	case "$1" in 
		"")
		;;
	Nixconfig)
		  kitty --class=ytfzf -e sh -c "pushd ~; find nixconfig -name '*.nix' | fzf --preview=\"pistol {}\" | tee /tmp/path | xargs vi; popd"
		;;
	Scripts)
		 kitty --class=ytfzf -e sh -c "pushd ~; find nixconfig/config/scripts -name '*.sh' | fzf --preview=\"pistol {}\" | tee /tmp/path | xargs vi; popd"
		;;
	Notes)
		 kitty --class=ytfzf -e sh -c "pushd ~; find nixconfig -name '*.md' | fzf --preview=\"pistol {}\" | tee /tmp/path | xargs vi; popd" 
		 ;;
	Exit) 
		n=5
esac

}

OPTIONS="Nixconfig\nScripts\nNotes\nExit"

conf() { 
	config "$(printf "%b" "$OPTIONS" | dmenu -i -l 4 -p "Config")";
}

while [ $n == 4 ]
do
	conf
done

~/.config/scripts/rebuild.sh;

if test -f /tmp/build_failed;
then 
	kitty --class=ytfzf -e sh -c "vi $(cat /tmp/path)"
	~/.config/scripts/rebuild.sh
fi 



