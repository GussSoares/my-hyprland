#!/usr/bin/env bash
set -euo pipefail

HYPR_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/my-settings.conf"
LINE="env = AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1"

if hyprctl monitors | grep -E "HDMI-A-|DP-" | grep -v "eDP-1" >/dev/null; then
    # Se a linha não existir, adiciona
    if ! grep -Fxq "$LINE" "$HYPR_CONF"; then
        echo "$LINE" >> "$HYPR_CONF"
        echo "Linha adicionada: $LINE"

        # Recarrega o compositor de forma segura
        if pgrep -x Hyprland >/dev/null; then
            notify-send "Hyprland" "$MSG"
            hyprctl dispatch exit
        fi
    else
        echo "Linha já presente"
    fi
fi
