# Acer Nitro Keyboard Backlight Guide

This guide explains how to control and customize your Acer Nitro's RGB keyboard backlight in i3wm. A custom control script and i3 keybindings have been set up for you.


## 💻 Command-Line Interface (CLI)
Behind the scenes, the shortcuts run a helper script located at `~/.config/i3/scripts/kbd-backlight.sh`. 
You can run this script directly from your terminal if you prefer!

### 1. Set a Specific Mode Directly
You don't have to cycle through them all; you can activate a mode directly using its name:
```bash
~/.config/i3/scripts/kbd-backlight.sh wave
~/.config/i3/scripts/kbd-backlight.sh neon
~/.config/i3/scripts/kbd-backlight.sh breath
~/.config/i3/scripts/kbd-backlight.sh shifting
~/.config/i3/scripts/kbd-backlight.sh zoom
~/.config/i3/scripts/kbd-backlight.sh static-white
~/.config/i3/scripts/kbd-backlight.sh static-red
~/.config/i3/scripts/kbd-backlight.sh static-green
~/.config/i3/scripts/kbd-backlight.sh static-blue
~/.config/i3/scripts/kbd-backlight.sh static-yellow
~/.config/i3/scripts/kbd-backlight.sh static-magenta
~/.config/i3/scripts/kbd-backlight.sh static-cyan
```

### 2. Available Modes Explained
- **Static:** Solid color light across all 4 zones.
- **Breath:** Fades in and out smoothly (currently set to purple).
- **Neon:** Smoothly transitions between the entire color spectrum.
- **Wave:** A fast rainbow wave that rolls across your keyboard.
- **Shifting:** Colors shift from one zone to the next (currently set to purple).
- **Zoom:** Colors zoom out from the center (currently set to yellow).

---

## 🛠️ Advanced Customization
If you want to change the specific colors used for `breath`, `shifting`, or `zoom`, you can edit the helper script:

1. Open `~/.config/i3/scripts/kbd-backlight.sh` in your favorite text editor.
2. Find the `apply_mode()` function.
3. You will see commands calling `python3 "$FACER" ...`
4. Change the RGB values (`-cR`, `-cG`, `-cB`) to your liking. Colors are from `0` to `255`.

**Example:**
To make the `breath` effect Red instead of Purple, change `-cR 0 -cG 255 -cB 255` to `-cR 255 -cG 0 -cB 0`.
