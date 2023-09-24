#!/usr/bin/env bash

browser ()
{
if pgrep "firefox" > /dev/null
then
hyprctl dispatch workspace name:browser
else
	firefox & disown
fi
}

terminal ()
{
if pgrep "kitty" > /dev/null
then
hyprctl dispatch togglespecialworkspace kitty
else
        kitty -1 --title Main --class=main --listen-on unix:/tmp/mykitty & disown
fi
}

case "$1" in
    "") ;;
    browser) "$@"; exit;;
    terminal) "$@"; exit;;
    *) echo "Unkown function: $1()"; exit 2;;
esac
