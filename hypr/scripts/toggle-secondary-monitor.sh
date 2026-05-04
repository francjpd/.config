#!/bin/bash

# Toggle eDP-2 (secondary laptop screen)

MONITOR="eDP-2"

# Check if monitor is currently enabled
if hyprctl monitors | grep -q "^Monitor $MONITOR"; then
    # Disable the monitor
    hyprctl keyword monitor "$MONITOR, disable"
    hyprctl notify 5 3000 0xff6464 "Monitor $MONITOR disabled"
else
    # Enable the monitor (restore with config from hyprland.conf)
    hyprctl keyword monitor "$MONITOR, preferred, auto-down, 1.33"
    hyprctl notify 2 3000 0x64ff64 "Monitor $MONITOR enabled"
fi
