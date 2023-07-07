#!/usr/bin/env sh


input=$(awk -F' ' '{print $1}' ~/nixconfig/config/scripts/playlists | dmenu -i -l 2 -p "Playlists")

notify-send "Playing Album: $(grep $input ~/nixconfig/config/scripts/playlists | awk -F' ' '{print $1}')" 

mpv --shuffle --loop-playlist --title=playlist "$(grep $input ~/nixconfig/config/scripts/playlists | awk -F' ' '{print $2}')" 
