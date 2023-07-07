#!/usr/bin/env sh


cd ~/nixconfig; doas nixos-rebuild switch --flake '.#laptop';
if [ $? -ne 0 ];
then touch /tmp/build_failed
else 
	rm -f /tmp/build_failed 
fi
