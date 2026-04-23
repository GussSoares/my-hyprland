#!/usr/bin/env bash

# Configuração das opções: "Nome" -> "Comando | Caminho_do_Ícone"
declare -A MENU_OPTIONS=(
    ["Lock"]="loginctl lock-session|/usr/share/icons/BeautyLine/actions/scalable/lock.svg"
    ["Logout"]="hyprctl dispatch exit|/usr/share/icons/BeautyLine/actions/scalable/xfsm-logout.svg"
    ["Power Off"]="systemctl poweroff|/usr/share/icons/BeautyLine/actions/scalable/system-shutdown-symbolic.svg"
    ["Reboot"]="systemctl reboot|/usr/share/icons/BeautyLine/actions/scalable/system-reboot-symbolic.svg"
    ["Suspend"]="systemctl suspend|/usr/share/icons/BeautyLine/actions/scalable/media-playback-pause.svg"
)

# Criamos um array temporário para evitar problemas com quebras de linha
MENU_ITEMS=()
for name in "${!MENU_OPTIONS[@]}"; do
    icon="${MENU_OPTIONS[$name]#*|}"
    MENU_ITEMS+=("img:${icon}:text:${name}")
done

# O printf resolve o problema da linha em branco melhor que o echo
CHOICE=$(printf "%s\n" "${MENU_ITEMS[@]}" | sort | wofi --normal-window --show dmenu --allow-images --prompt "Sistema" --width 250 --height 300)

[[ -z "$CHOICE" ]] && exit 0

SELECTED_NAME="${CHOICE#*:text:}"
COMMAND_TO_RUN="${MENU_OPTIONS[$SELECTED_NAME]%|*}"

if [[ -n "$COMMAND_TO_RUN" ]]; then
    exec $COMMAND_TO_RUN
fi
