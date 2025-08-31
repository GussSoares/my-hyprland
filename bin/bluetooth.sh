#!/bin/bash

# Cores (ajuste conforme seu tema)
COLOR_OFF="#585b70"     # Cinza
COLOR_ON="#89b4fa"      # Azul
COLOR_CONNECTED="#a6e3a1"  # Verde

# Ícones Nerd Font
ICON_OFF="󰂲  "
ICON_ON="󰂯  "
ICON_CONNECTED="󰂱  "

# Verifica se o Bluetooth está ligado
if bluetoothctl show | grep -q "Powered: yes"; then
    # Bluetooth ligado
    connected_devices=$(bluetoothctl info | grep "Connected: yes")

    if [ -n "$connected_devices" ]; then
        # Pelo menos um dispositivo conectado
        # (opcional) Pega o nome do dispositivo conectado
        name=$(bluetoothctl devices Connected | sed -n 's/^Device [^ ]* //p' | head -n 1)
        echo "<span color=\"$COLOR_CONNECTED\">$ICON_CONNECTED</span> $name  "
    else
        # Ligado, mas sem conexão
        echo "<span color=\"$COLOR_ON\">$ICON_ON</span>"
    fi
else
    # Bluetooth desligado
    echo "<span color=\"$COLOR_OFF\">$ICON_OFF</span>"
fi
