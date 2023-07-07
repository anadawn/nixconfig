#!/usr/bin/env bash

wpctl set-default "$(wpctl status | grep -A 3 Sinks | dmenu -l 3 | awk -F ' ' '{print $2}' )"
