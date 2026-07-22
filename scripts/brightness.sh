#!/bin/bash

# Brightness control script for Acer Nitro AN515-47
# Tries hardware control (brightnessctl) first, falls back to xrandr software control

STEP_HW="5%"
STEP_SW=0.05
BRIGHTNESS_FILE="$HOME/.config/i3/.current_brightness"
DISPLAY_OUT=$(xrandr | grep " connected" | head -n1 | cut -d' ' -f1)

# Default to 1.0 if no file exists
if [ ! -f "$BRIGHTNESS_FILE" ]; then
    echo "1.0" > "$BRIGHTNESS_FILE"
fi

CURRENT_SW=$(cat "$BRIGHTNESS_FILE")

case $1 in
    up)
        # Try hardware
        if brightnessctl set +$STEP_HW > /dev/null 2>&1; then
            exit 0
        fi
        
        # Fallback to software
        NEW_SW=$(echo "$CURRENT_SW + $STEP_SW" | bc)
        if (( $(echo "$NEW_SW > 1.0" | bc -l) )); then
            NEW_SW=1.0
        fi
        ;;
    down)
        # Try hardware
        if brightnessctl set $STEP_HW- > /dev/null 2>&1; then
            exit 0
        fi
        
        # Fallback to software
        NEW_SW=$(echo "$CURRENT_SW - $STEP_SW" | bc)
        if (( $(echo "$NEW_SW < 0.2" | bc -l) )); then
            NEW_SW=0.2
        fi
        ;;
esac

if [ -n "$NEW_SW" ]; then
    xrandr --output "$DISPLAY_OUT" --brightness "$NEW_SW"
    echo "$NEW_SW" > "$BRIGHTNESS_FILE"
fi
