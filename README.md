# i3 Setup Guide

This document lists the software required to replicate this i3 window manager setup on a new system (specifically tailored for Debian/Ubuntu/Linux Mint based distributions).

## Core Software
- **i3-wm**: The window manager itself.
- **polybar**: The customizable status bar.
- **kitty**: The terminal emulator.
- **rofi**: The application launcher.

## System Utilities
- **nitrogen**: Wallpaper manager.
- **dunst**: Notification daemon.
- **playerctl**: Media playback controller (play/pause, next, prev).
- **pactl** (`pulseaudio-utils`): Volume control.
- **nm-applet** (`network-manager-gnome`): Network tray icon.
- **numlockx**: Enables numpad on startup.
- **dex**: Used to start XDG autostart `.desktop` files.
- **xss-lock** & **i3lock**: Screen locking utilities.

## Tools and Utilities
- **maim**: Screenshot utility.
- **xclip**: Clipboard manager (used for piping screenshots to clipboard).
- **xdotool**: Used for window manipulation (e.g., in screenshot shortcuts).
- **btop** / **htop**: System monitors.
- **gnome-calculator**: Default calculator application.
- **gnome-system-monitor**: System monitor GUI (started from Polybar memory module).

## Your Core Applications

Here is a comprehensive list of all the major applications you actively use on this laptop based on your configuration files:

### Web & Communication
- **Brave Browser** (`brave-browser`)
- **Google Chrome** (`google-chrome-stable`)
- **Mozilla Firefox** (`firefox`)
- **Evolution** (Email Client) (`evolution`)

### Development & Editing
- **Visual Studio Code** (`code`)
- **Neovim** (`neovim`)
- **Xed Text Editor** (`xed`)
- **GitHub CLI** (`gh`)

### Media & Entertainment
- **VLC Media Player** (`vlc`)
- **Celluloid Video Player** (`celluloid`)
- **Xviewer** (Image Viewer) (`xviewer`)

### File Management
- **Nemo**  (`nemo`)
- **Caja** (`caja`)

### System & Utilities
- **Kitty Terminal** (`kitty`)
- **Htop** (`htop`)
- **Btop** (`btop`)
- **Neofetch** (`neofetch`)
- **Brightness Controller** (`brightness-controller`)
- **Gnome Calculator** (`gnome-calculator`)
- **Gnome System Monitor** (`gnome-system-monitor`)

---

## Installation Commands

### 1. Core Window Manager & System Utilities
Install the core i3 setup and basic utilities on a Debian/Ubuntu/Linux Mint system:

```bash
sudo apt update && sudo apt install -y i3 polybar kitty rofi nitrogen dunst playerctl pulseaudio-utils network-manager-gnome numlockx dex xss-lock i3lock maim xclip xdotool btop htop gnome-calculator gnome-system-monitor neovim vlc celluloid
```

### 2. File Managers, Mail & Text Editors
Install your remaining local applications:

```bash
sudo apt install -y evolution xed gh xviewer nemo caja
```

### 3. Web Browsers & VS Code (External/Snap)
For Brave, Chrome, and VS Code, it is easiest to use `snap` (or your Linux Mint Software Manager flatpaks) to get the latest versions. If you have `snapd` enabled:

```bash
# Brave Browser
sudo snap install brave

# Visual Studio Code
sudo snap install code --classic

# Note: Google Chrome is best installed by downloading the .deb from google.com/chrome, or via flatpak!
```

### Additional Fonts and Themes
Based on your previous configurations, make sure you also install:
- **Hack Nerd Font** (or your preferred Nerd Font) for icons in Polybar and Kitty.
- **Catppuccin Theme** for Kitty if you want to maintain the same color aesthetic.

To apply your configurations, simply copy this entire `~/.config` backup to the new device!
