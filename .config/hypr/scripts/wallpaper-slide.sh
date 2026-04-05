#!/bin/bash

DIR="/usr/share/wallpapers/meowrch/"
INTERVAL=60   # segundos

while true; do
    IMG=$(find "$DIR" -type f | shuf -n 1)
    hyprctl hyprpaper wallpaper ",$IMG"
    sleep 2
done
