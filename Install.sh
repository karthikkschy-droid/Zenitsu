#!/bin/bash

# --- THE ZENITSU "LIQUID GLASS" BLUEPRINT ---
YELLOW='\033[1;33m'
RESET='\033[0m'

echo -e "${YELLOW}Starting Zenitsu Build: Lightning Flash Execution...${RESET}"

# 1. SYSTEM CHECK & SYNC
echo "Checking repositories..."
sudo pacman -Syu --noconfirm

# 2. CORE DEPENDENCY CHECK (The "Check if I have it" Logic)
PACKAGES=(hyprland kitty waybar hyprpaper wofi dunst dolphin mpv sddm qt5-wayland qt6-wayland xdg-desktop-portal-hyprland brightnessctl pamixer ttf-jet-brains-mono otf-font-awesome)

for pkg in "${PACKAGES[@]}"; do
    if pacman -Qi "$pkg" > /dev/null 2>&1; then
        echo "$pkg is already installed. Skipping..."
    else
        echo "Installing $pkg..."
        sudo pacman -S --noconfirm "$pkg"
    fi
done

# 3. DIRECTORY STRUCTURE
mkdir -p ~/.config/{hypr,waybar,kitty,wofi,dunst}
mkdir -p ~/Pictures/Wallpapers

# 4. DEPLOY HYPRLAND CONFIG (Liquid Glass + Electric Yellow)
cat <<EOF > ~/.config/hypr/hyprland.conf
monitor=,preferred,auto,1

exec-once = waybar & hyprpaper & sddm

input { kb_layout = us }

general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(FFD700ee) rgba(FFFFFFee) 45deg
    col.inactive_border = rgba(1a1a1aee)
    layout = dwindle
}

decoration {
    rounding = 10
    blur {
        enabled = true
        size = 8
        passes = 3
        new_optimizations = true
        ignore_opacity = true
    }
    drop_shadow = yes
    shadow_range = 15
    col.shadow = rgba(FFD70033)
}

# Keybindings
bind = SUPER, Q, exec, kitty
bind = SUPER, SPACE, exec, wofi --show drun
bind = SUPER, E, exec, dolphin
bind = SUPER, C, killactive,
bind = SUPER, M, exit,
bind = , XF86AudioRaiseVolume, exec, pamixer -i 5
bind = , XF86AudioLowerVolume, exec, pamixer -d 5
EOF

# 5. CONFIGURE TERMINAL (Kitty - Black & Gold)
cat <<EOF > ~/.config/kitty/kitty.conf
background_opacity 0.8
background #0f0f0f
foreground #FFD700
font_family JetBrains Mono
confirm_os_window_close 0
EOF

# 6. ENABLE LOGIN SCREEN
sudo systemctl enable sddm

echo -e "${YELLOW}BLUEPRINT DEPLOYED.${RESET}"
echo "Restart your laptop or type 'Hyprland' to enter the environment."
