#!/usr/bin/env sh


input=$(awk -F' ' '{print $1}' ~/nixconfig/config/scripts/bookmarks | dmenu -i -l 10 -p "Bookmarks")

wtype $(grep $input ~/nixconfig/config/scripts/bookmarks | awk -F' ' '{print $2}') 
