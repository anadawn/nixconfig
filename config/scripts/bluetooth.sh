n="$(bluetoothctl devices | dmenu -l 3 | awk -F ' ' '{print $2}')"

notify-send "$(bluetoothctl connect $n | grep -i -m3 'connect' | tail -n1)"
