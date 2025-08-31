#!/bin/bash

# Nome do seu teclado (substitua pelo nome correto)
DEVICE="at-translated-set-2-keyboard"

# Aplica o próximo layout
hyprctl switchxkblayout "$DEVICE" next
