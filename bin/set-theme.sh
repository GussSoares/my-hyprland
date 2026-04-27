#!/bin/bash

# --- CONFIGURAÇÃO ---
THEME_DIR="$HOME/.config/hypr/themes"
CACHE_DIR="$HOME/.cache/hypr_theme"
THUMB_DIR="$CACHE_DIR/thumbs"
VSCODIUM_SETTINGS_JSON="$HOME/.config/VSCodium/User/settings.json"
THUMB_SIZE="220x120"
mkdir -p "$THUMB_DIR"

# 1. GERAR THUMBS (Se não existirem)
# Como você é dev, sabe que fazer isso on-the-fly é lento. 
# O script verifica se a thumb já existe para ganhar performance.
for d in "$THEME_DIR"/*/; do
    THEME_NAME=$(basename "$d")
    WALL=$(find "$d" -type f \( -name "*.jpg" -o -name "*.png" \) | head -n 1)
    
    if [ ! -f "$THUMB_DIR/$THEME_NAME.png" ] && [ -f "$WALL" ]; then
        # Gera uma thumb quadrada de 64x64 com cantos arredondados (estética Catppuccin)
        magick "$WALL" -strip -thumbnail "$THUMB_SIZE^" -gravity center -extent "$THUMB_SIZE^" "$THUMB_DIR/$THEME_NAME.png"
    fi
done

# 2. LISTAR PARA O WOFI COM ÍCONES
declare -a OPTIONS
for d in "$THEME_DIR"/*/; do
    [ -d "$d" ] || continue

    THEME_NAME=$(basename "$d")
    OPTIONS+=("img:$THUMB_DIR/$THEME_NAME.png:text:$THEME_NAME")
done


# Seleção via Wofi (Note a flag --allow-images)
CHOICE=$(printf "%s\n" "${OPTIONS[@]}" | wofi --style ~/.config/wofi/style.theme.css --conf ~/.config/wofi/config.theme --cache-file /dev/null)
[ -z "$CHOICE" ] && exit 0

CHOICE=$(echo "$CHOICE" | sed 's/.*:text://')

echo $CHOICE

THEME_PATH="$THEME_DIR/$CHOICE"

# --- 3. APLICAR CONFIGURAÇÕES ---

# Hyprland & Waybar
# ln -sf "$THEME_PATH/variables.conf" "$HOME/.config/hypr/theme.conf"
ln -sf "$THEME_PATH/waybar.css" "$HOME/.config/waybar/theme.css"
ln -sf "$THEME_PATH/wofi.css" "$HOME/.config/wofi/style.css"
ln -sf "$THEME_PATH/hyprland.conf" "$HOME/.config/hypr/theme.conf"
ln -sf "$THEME_PATH/swaync.css" "$HOME/.config/swaync/theme.css"


# vscodium
case $CHOICE in
    "catppuccin-macchiato")     THEME="Catppuccin Macchiato" ;;
    "catppuccin-mocha")         THEME="Catppuccin Mocha" ;;
    "catppuccin-latte")         THEME="Catppuccin Latte" ;;
    "catppuccin-frappe")        THEME="Catppuccin Frappé" ;;
    "gruvbox")                  THEME="Gruvbox Dark Soft" ;;
    "rose-pine")                THEME="Rosé Pine Moon" ;;
    "tokyo-night")              THEME="Tokyo Night Storm" ;;
esac
sed -i "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"$THEME\"/" "$VSCODIUM_SETTINGS_JSON"


# Wallpaper (Corrigi de 'awww' para 'swww')
WALL=$(find "$THEME_PATH" -type f \( -name "*.jpg" -o -name "*.png" \) | head -n 1)
awww img "$WALL" --transition-type grow --transition-pos "$(hyprctl cursorpos | tr -d ' ')" --transition-fps 144


# Terminal Kitty (Sinal USR1 para reload instantâneo)
if [ -f "$THEME_PATH/kitty.conf" ]; then
    ln -sf "$THEME_PATH/kitty.conf" "$HOME/.config/kitty/theme.conf"
    kill -USR1 $(pidof kitty) 2>/dev/null
fi

# GTK Settings (Lendo do seu settings.ini)
# if [ -f "$THEME_PATH/settings.ini" ]; then
#     GTK_THEME=$(grep "gtk_theme" "$THEME_PATH/settings.ini" | cut -d'=' -f2)
#     ICON_THEME=$(grep "icon_theme" "$THEME_PATH/settings.ini" | cut -d'=' -f2)
    
#     gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
#     gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"
    
#     # GTK4 Link (Opcional, mas recomendado para o System Monitor)
#     mkdir -p ~/.config/gtk-4.0
#     ln -sf "/usr/share/themes/$GTK_THEME/gtk-4.0/gtk.css" "$HOME/.config/gtk-4.0/gtk.css"
#     ln -sf "/usr/share/themes/$GTK_THEME/gtk-4.0/gtk-dark.css" "$HOME/.config/gtk-4.0/gtk-dark.css"
# fi

# Reload Apps
killall -SIGUSR2 waybar
swaync-client -rs

# Persistência e Notificação
echo "$CHOICE" > "$CACHE_DIR/current_theme"
notify-send "Rice Switcher" "Ambiente $CHOICE aplicado." -i "$THUMB_DIR/$CHOICE.png"