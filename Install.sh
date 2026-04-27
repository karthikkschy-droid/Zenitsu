#!/bin/bash
# --- THE GOD SPEED ZENITSU INSTALLER ---

# 1. Update and Install ALL required tools
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm hyprland kitty waybar swww wofi dunst dolphin mpv sddm \
ttf-jetbrains-mono-nerd ttf-font-awesome qt5-wayland qt6-wayland \
xdg-desktop-portal-hyprland brightnessctl pamixer wget

# 2. Create the entire directory structure
mkdir -p ~/.config/{hypr,waybar,kitty,wofi,dunst}
mkdir -p ~/Pictures/Wallpapers

# 3. Create the Liquid Glass Hyprland Config
cat <<EOF > ~/.config/hypr/hyprland.conf
monitor=,preferred,auto,1
exec-once = waybar & swww-daemon
input { kb_layout = us }

general {
    gaps_in = 8
    gaps_out = 15
    border_size = 3
    col.active_border = rgb(F9D423) rgb(FFFFFF) 45deg
    col.inactive_border = rgba(1a1a1aee)
    bezier = lightning, 0.05, 0.9, 0.1, 1.05
}

decoration {
    rounding = 12
    blur {
        enabled = true
        size = 12
        passes = 4
        new_optimizations = true
        xray = true
    }
    shadow {
        enabled = true
        range = 30
        render_power = 4
        color = rgba(F9D42366)
    }
}

animations {
    enabled = yes
    animation = windows, 1, 7, lightning, slide
    animation = workspaces, 1, 6, lightning, slidevert
}

# Keybindings
bind = SUPER, Q, exec, kitty
bind = SUPER, SPACE, exec, wofi --show drun
bind = SUPER, E, exec, dolphin
bind = SUPER, C, killactive,
bind = SUPER, M, exit,
EOF

# 4. Configure Kitty (Electric Yellow Terminal)
cat <<EOF > ~/.config/kitty/kitty.conf
background_opacity 0.7
background #0a0a0a
foreground #F9D423
font_family JetBrainsMono Nerd Font
EOF

echo "BLUEPRINT LOADED. REBOOT NOW."
