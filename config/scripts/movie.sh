#!/usr/bin/env bash

find Videos/ -type f -printf "%f\n" | dmenu -i -p "Movies" |
xargs -I '{}' find ~/Videos/ -name {} | xargs mpv
