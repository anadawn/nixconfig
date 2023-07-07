#!/usr/bin/env sh



url=$(dmenu -l 0 -p "Enter url")

name=$(dmenu -l 0 -p "Enter name")

if [[ "d" != "d$url" ]] && [[ "d" != "d$name" ]]; then
	echo "$name   $url" >> ~/nixconfig/config/scripts/bookmarks
	pushd ~/nixconfig; 
	git add ~/nixconfig/config/scripts/bookmarks
	git commit -m "added a new bookmark"
	git push
	popd
fi
