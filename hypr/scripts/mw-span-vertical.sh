#!/usr/bin/env bash
set -euo pipefail

APP_NAME="${1:-MotiveWave}"
STATE_FILE="/tmp/hypr-motivewave-state"

# ----------------------------------------
# Helper: Log
log() { printf '%s\n' "$*"; }

# ----------------------------------------
# Detect running process
PID=$(pgrep -f -n "$APP_NAME" || true)
if [[ -z "$PID" ]]; then
  log "MotiveWave process not found."
  exit 1
fi

# ----------------------------------------
# Find matching Hyprland window
CLIENT=$(hyprctl clients -j | jq -r --arg pid "$PID" '.[] | select(.pid|tostring==$pid)')
if [[ -z "$CLIENT" || "$CLIENT" == "null" ]]; then
  log "Cannot find Hyprland window for MotiveWave."
  exit 2
fi

ADDR=$(jq -r '.address' <<<"$CLIENT")
FLOATING=$(jq -r '.floating' <<<"$CLIENT")
WIN_X=$(jq -r '.at[0]' <<<"$CLIENT")
WIN_Y=$(jq -r '.at[1]' <<<"$CLIENT")
WIN_W=$(jq -r '.size[0]' <<<"$CLIENT")
WIN_H=$(jq -r '.size[1]' <<<"$CLIENT")

# ----------------------------------------
# If the window is "expanded", restore
if [[ -f "$STATE_FILE" ]]; then
  log "Restoring MotiveWave window."

  read ORIG_X ORIG_Y ORIG_W ORIG_H <"$STATE_FILE"

  hyprctl dispatch focuswindow "$ADDR"
  hyprctl dispatch movewindow "$ADDR" "$ORIG_X" "$ORIG_Y"
  hyprctl dispatch resizewindowpixel exact "$ADDR" "$ORIG_W" "$ORIG_H"

  # turn off floating
  hyprctl dispatch togglefloating

  rm -f "$STATE_FILE"
  exit 0
fi

# ----------------------------------------
# Otherwise: expand the window (save original pos)
log "Expanding MotiveWave window."

echo "$WIN_X $WIN_Y $WIN_W $WIN_H" >"$STATE_FILE"

# Ensure floating
hyprctl dispatch focuswindow "$ADDR"
if [[ "$FLOATING" == "false" ]]; then
  hyprctl dispatch togglefloating
fi

# ----------------------------------------
# Get monitors & compute spanning vertical layout
mons=$(hyprctl monitors -j | jq -r '.[] | "\(.width) \(.height) \(.x) \(.y)"' | sort -k4n)

read T_W T_H T_X T_Y <<<"$(echo "$mons" | sed -n '1p')"
read B_W B_H B_X B_Y <<<"$(echo "$mons" | sed -n '2p')"

TOTAL_H=$((T_H + B_H))
WIN_W_NEW=$T_W
WIN_X_NEW=$T_X
WIN_Y_NEW=$T_Y

# ----------------------------------------
# Apply spanning geometry
hyprctl dispatch movewindow "$ADDR" "$WIN_X_NEW" "$WIN_Y_NEW"
hyprctl dispatch resizewindowpixel exact "$ADDR" "$WIN_W_NEW" "$TOTAL_H"

log "MotiveWave is now spanning both screens."
