#!/usr/bin/env bash
set -euo pipefail

# Caminho do Hyprland.conf
HYPR_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/my-settings.conf"
BACKUP="${HYPR_CONF}.bak.$(date +%s)"

# Definição das GPUs
DGPU="/dev/dri/card0"   # NVIDIA
IGPU="/dev/dri/card1"   # Integrada

# Detecta se existe monitor externo (HDMI ou DP)
if hyprctl monitors | grep -Eq "HDMI-A-|DP-"; then
    TARGET="$DGPU:$IGPU"
    MSG="Forçando NVIDIA (externo)"
else
    TARGET="$IGPU:$DGPU"
    MSG="Revertendo para integrada (painel interno)"
fi

# Verifica se o Hyprland.conf já tem essa configuração
CURRENT_LINE=$(grep -E '^env[[:space:]]*=.*AQ_DRM_DEVICES' "$HYPR_CONF" || true)
if [[ "$CURRENT_LINE" == "env = AQ_DRM_DEVICES,$TARGET" ]]; then
    echo "AQ_DRM_DEVICES já está definido corretamente: $TARGET"
    exit 0
fi

# Faz backup
cp "$HYPR_CONF" "$BACKUP"

# Atualiza ou adiciona a linha no Hyprland.conf
awk -v new="env = AQ_DRM_DEVICES,$TARGET" '
  BEGIN{found=0}
  /^env[[:space:]]*=.*AQ_DRM_DEVICES/ { print new; found=1; next }
  { print }
  END { if (!found) print ""; if (!found) print new }
' "$BACKUP" > "${HYPR_CONF}.tmp" && mv "${HYPR_CONF}.tmp" "$HYPR_CONF"

# Recarrega o compositor de forma segura
if pgrep -x Hyprland >/dev/null; then
    notify-send "Hyprland" "$MSG"
    hyprctl dispatch exit
else
    echo "Hyprland não está rodando; configuração salva em $HYPR_CONF (backup: $BACKUP)"
fi
