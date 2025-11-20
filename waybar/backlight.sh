#!/bin/bash
MIN=5
MAX=80
INTERVAL=5

dp1_name=intel_backlight
dp2_name=card1-eDP-2-backlight

# Calculate percentages as different monitors might have different max
dp1=$(brightnessctl -d $dp1_name get)
dp1_max=$(brightnessctl -d $dp1_name m)
dp1_current_percent=$((dp1 * 100 / dp1_max))

# Calculate percentages as different monitors might have different max
dp2=$(brightnessctl -d $dp2_name get)
dp2_max=$(brightnessctl -d $dp2_name m)
dp2_current_percent=$((dp2 * 100 / dp2_max))

# average
current=$(((dp1_current_percent + dp2_current_percent) / 2))

case "$1" in
up)
  echo "Increasing brightness from $current%" >&2
  new_percent=$((current + INTERVAL))
  if [ $new_percent -gt $MAX ]; then
    new_percent=$MAX
  fi
  brightnessctl -d $dp1_name set ${new_percent}% -q
  brightnessctl -d $dp2_name set ${new_percent}% -q
  echo "setting brightness to $new_percent%" >&2
  ;;
down)
  echo "Decreasing brightness from $current%" >&2
  new_percent=$((current - INTERVAL))
  if [ $new_percent -lt $MIN ]; then
    new_percent=$MIN
  fi
  brightnessctl -d $dp1_name set ${new_percent}% -q
  brightnessctl -d $dp2_name set ${new_percent}% -q
  echo "setting brightness to $new_percent%" >&2
  ;;
get)
  echo $current
  ;;
*)
  echo "Usage: $0 {up|down|get}"
  exit 1
  ;;
esac
