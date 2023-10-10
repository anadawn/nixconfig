#!/usr/bin/env bash

youtube_url='firefox --new-tab https://www.youtube.com'
nixpkgs_url='firefox --new-tab https://search.nixos.org/packages'
hm_url='firefox --new-tab https://mipmip.github.io/home-manager-option-search'
browser_workspace='hyprctl dispatch workspace name:browser'

browser ()
{
	if pgrep "firefox" > /dev/null
	then
		$browser_workspace
	else
		firefox & disown
	fi
}

youtube_in_browser ()
{
	if [[ $(hyprctl activeworkspace | grep "browser" | awk '{print $4}') == "(browser)" ]]; then
		$youtube_url
	else
		$browser_workspace
		$youtube_url
	fi
}


nixpkgs_search ()
{
	if [[ $(hyprctl activeworkspace | grep "browser" | awk '{print $4}') == "(browser)" ]]; then
		$nixpkgs_url
	else
		$browser_workspace
		$nixpkgs_url
	fi
}

home_manager_search ()
{
	if [[ $(hyprctl activeworkspace | grep "browser" | awk '{print $4}') == "(browser)" ]]; then
		$hm_url
	else
		$browser_workspace
		$hm_url
	fi
}

terminal ()
{
	if pgrep "kitty" > /dev/null
	then
		hyprctl dispatch togglespecialworkspace terminal 
	else
		kitty -1 --title Main --class=main --listen-on unix:/tmp/mykitty & disown
	fi
}


case "$1" in
	"") ;;
	browser) "$@"; exit;;
	terminal) "$@"; exit;;
	youtube_in_browser) "$@"; exit;;
	nixpkgs_search) "$@"; exit;;
	home_manager_search) "$@"; exit;;
	*) echo "Unkown function: $1()"; exit 2;;
esac
