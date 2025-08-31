#!/bin/bash

# Checa o status do Num Lock via evdev
# Requer `python3` e `evdev` instalado

# Substitua "/dev/input/event0" pelo dispositivo correto do seu teclado
DEVICE=$(python3 -c "
from evdev import InputDevice, list_devices
for path in list_devices():
    d = InputDevice(path)
    if 'keyboard' in d.name.lower() or 'kbd' in d.name.lower():
        print(path)
        break
")

if [ -z "$DEVICE" ]; then
    echo "⛔"
    exit 0
fi

python3 -c "
from evdev import InputDevice
dev = InputDevice('$DEVICE')
leds = dev.leds()
print('' if 0 in leds else '')  # 0 = LED_NUML
"
