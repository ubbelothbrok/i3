#!/bin/bash
# Keyboard backlight control script for Acer Nitro AN515-47
# Uses facer_rgb.py from acer-predator-turbo-and-rgb-keyboard-linux-module

FACER="/opt/turbo-fan/facer_rgb.py"
STATE_FILE="/tmp/kbd-backlight-state"
MODE_FILE="/tmp/kbd-backlight-mode"
BRIGHT_FILE="/tmp/kbd-brightness-level"

# Modes array (defines the cycle order)
MODES=("static-white" "static-red" "static-green" "static-blue" "static-yellow" "static-magenta" "static-cyan" "breath" "neon" "wave" "shifting" "zoom")

get_state() {
    cat "$STATE_FILE" 2>/dev/null || echo "on"
}

get_level() {
    cat "$BRIGHT_FILE" 2>/dev/null || echo "100"
}

get_current_mode_idx() {
    cat "$MODE_FILE" 2>/dev/null || echo "0"
}

set_static() {
    local r=$1
    local g=$2
    local b=$3
    local level=$(get_level)
    python3 "$FACER" -m 0 -z 1 -cR $r -cG $g -cB $b -b "$level"
    python3 "$FACER" -m 0 -z 2 -cR $r -cG $g -cB $b -b "$level"
    python3 "$FACER" -m 0 -z 3 -cR $r -cG $g -cB $b -b "$level"
    python3 "$FACER" -m 0 -z 4 -cR $r -cG $g -cB $b -b "$level"
}

apply_mode() {
    local mode_name=$1
    local level=$(get_level)
    
    case "$mode_name" in
        static-white)   set_static 255 255 255 ;;
        static-red)     set_static 255 0 0 ;;
        static-green)   set_static 0 255 0 ;;
        static-blue)    set_static 0 0 255 ;;
        static-yellow)  set_static 255 255 0 ;;
        static-magenta) set_static 255 0 255 ;;
        static-cyan)    set_static 0 255 255 ;;
        breath)
            python3 "$FACER" -m 1 -s 4 -b "$level" -cR 0 -cG 255 -cB 255
            ;;
        neon)
            python3 "$FACER" -m 2 -s 4 -b "$level"
            ;;
        wave)
            python3 "$FACER" -m 3 -s 5 -b "$level"
            ;;
        shifting)
            python3 "$FACER" -m 4 -s 5 -b "$level" -cR 255 -cG 0 -cB 255
            ;;
        zoom)
            python3 "$FACER" -m 5 -s 5 -b "$level" -cR 255 -cG 255 -cB 0
            ;;
    esac
    echo "on" > "$STATE_FILE"
}

case "$1" in
    toggle)
        if [ "$(get_state)" = "on" ]; then
            set_static 0 0 0
            echo "off" > "$STATE_FILE"
        else
            idx=$(get_current_mode_idx)
            apply_mode "${MODES[$idx]}"
        fi
        ;;
    up)
        LEVEL=$(get_level)
        LEVEL=$((LEVEL + 20))
        [ "$LEVEL" -gt 100 ] && LEVEL=100
        echo "$LEVEL" > "$BRIGHT_FILE"
        idx=$(get_current_mode_idx)
        apply_mode "${MODES[$idx]}"
        ;;
    down)
        LEVEL=$(get_level)
        LEVEL=$((LEVEL - 20))
        [ "$LEVEL" -lt 0 ] && LEVEL=0
        echo "$LEVEL" > "$BRIGHT_FILE"
        if [ "$LEVEL" -eq 0 ]; then
            set_static 0 0 0
            echo "off" > "$STATE_FILE"
        else
            idx=$(get_current_mode_idx)
            apply_mode "${MODES[$idx]}"
        fi
        ;;
    cycle)
        idx=$(get_current_mode_idx)
        idx=$(( (idx + 1) % ${#MODES[@]} ))
        echo "$idx" > "$MODE_FILE"
        apply_mode "${MODES[$idx]}"
        ;;
    static-*|breath|neon|wave|shifting|zoom)
        # Find index of the passed mode
        for i in "${!MODES[@]}"; do
            if [ "${MODES[$i]}" = "$1" ]; then
                echo "$i" > "$MODE_FILE"
                break
            fi
        done
        apply_mode "$1"
        ;;
    *)
        echo "Usage: $0 {toggle|up|down|cycle|static-white|static-red|static-green|static-blue|static-yellow|static-magenta|static-cyan|breath|neon|wave|shifting|zoom}"
        exit 1
        ;;
esac
