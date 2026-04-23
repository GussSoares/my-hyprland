#!/bin/bash

# evita abrir múltiplas instâncias
if pgrep -x bluetui >/dev/null; then
    exit 0
fi

kitty --class bluetui-floating -e bluetui
