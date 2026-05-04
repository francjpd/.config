#!/bin/bash

# Set the wallpaper directory
DIR="$HOME/projects/wallpaper"

# Check if directory exists
if [ ! -d "$DIR" ]; then
  notify-send "Wallpaper Error" "Directory $DIR not found."
  exit 1
fi

# Get two random images from the directory
mapfile -t IMAGES < <(find "$DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 2)

# Check if enough images were found
if [ ${#IMAGES[@]} -lt 2 ]; then
  notify-send "Wallpaper Error" "Not enough images found in $DIR"
  exit 1
fi

IMAGE1="${IMAGES[0]}"
IMAGE2="${IMAGES[1]}"

# Check if images were found
if [ -z "$IMAGE1" ] || [ -z "$IMAGE2" ]; then
  notify-send "Wallpaper Error" "No images found in $DIR"
  exit 1
fi

# Wait for hyprpaper to be ready by checking if the IPC is available
# for i in {1..10}; do
#   if hyprctl hyprpaper monitors | grep -q "Monitor"; then
#     echo "Hyprpaper is ready"
#     break
#   fi
#   sleep 0.1
# done

#wait for hyprpaper process to exist
while ! pidof hyprpaper >/dev/null 2>&1; do
  sleep 0.01
done

until hyprctl hyprpaper monitors 2>/dev/null | grep -q "Monitor"; do
  sleep 0.01
done

# Preload and set wallpapers
hyprctl hyprpaper preload "$IMAGE1"
hyprctl hyprpaper wallpaper "eDP-1,$IMAGE1"

hyprctl hyprpaper preload "$IMAGE2"
hyprctl hyprpaper wallpaper "eDP-2,$IMAGE2"

# Unload unused
hyprctl hyprpaper unload unused
