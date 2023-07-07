#!/usr/bin/env sh

 notify-send "fetching formats"
 wl-paste | xargs ytfzf -D -a -f
 if [ $? -ne 0 ];
  then notify-send "failed to play video"
 fi
