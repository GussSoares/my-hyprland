#!/usr/bin/env bash
set -euo pipefail

HYPR_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/my-settings.conf"
LINE="env = AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1"

if grep -Fxq "$LINE" "$HYPR_CONF"; then
    grep -Fxv "$LINE" "$HYPR_CONF" > "${HYPR_CONF}.tmp" && mv "${HYPR_CONF}.tmp" "$HYPR_CONF"
    echo "Linha removida: $LINE"
fi
