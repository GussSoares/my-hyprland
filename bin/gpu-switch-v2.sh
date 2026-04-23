#!/usr/bin/env bash
set -euo pipefail

HYPR_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/my-settings.conf"
BACKUP="${HYPR_CONF}.bak.$(date +%s)"

LINE="env = AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1"

# Faz backup
cp "$HYPR_CONF" "$BACKUP"

# Detecta se há HDMI ou DP conectado
if hyprctl monitors | grep -E "HDMI-A-|DP-" | grep -v "eDP-1" >/dev/null; then
    # Se a linha não existir, adiciona
    if ! grep -Fxq "$LINE" "$HYPR_CONF"; then
        echo "$LINE" >> "$HYPR_CONF"
        echo "Linha adicionada: $LINE"
    else
        echo "Linha já presente"
    fi
else
    # Remove a linha se existir
    if grep -Fxq "$LINE" "$HYPR_CONF"; then
        grep -Fxv "$LINE" "$HYPR_CONF" > "${HYPR_CONF}.tmp" && mv "${HYPR_CONF}.tmp" "$HYPR_CONF"
        echo "Linha removida: $LINE"
    else
        echo "Linha não encontrada, nada a remover"
    fi
fi

# Recarrega o compositor de forma segura
if pgrep -x Hyprland >/dev/null; then
    notify-send "Hyprland" "$MSG"
    hyprctl dispatch exit
else
    echo "Hyprland não está rodando; configuração salva em $HYPR_CONF (>
fi

