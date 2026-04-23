#!/usr/bin/env bash

# Configurações
WALLPAPER_DIR="/usr/share/wallpapers/hollow"
CACHE_DIR="$HOME/.cache/wallpaper-thumbnails"
THUMB_SIZE="120x68" # Tamanho da miniatura no menu

# Cria a pasta de cache se não existir
mkdir -p "$CACHE_DIR"

# Verifica se o ImageMagick está instalado
if ! command -v magick &> /dev/null; then
    notify-send "Erro" "Instale o 'imagemagick' para ver as thumbnails."
    exit 1
fi

MENU_ITEMS=()

# Loop pelos arquivos de imagem
while IFS= read -r img; do
    filename=$(basename "$img")
    thumb="$CACHE_DIR/$filename"

    # Gera a thumbnail se ela ainda não existir (otimização)
    if [ ! -f "$thumb" ]; then
        magick "$img" -strip -thumbnail "$THUMB_SIZE^" -gravity center -extent "$THUMB_SIZE" "$thumb"
    fi

    MENU_ITEMS+=("img:${thumb}:text:${filename}")
done < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \))

# Exibe o wofi
CHOICE=$(printf "%s\n" "${MENU_ITEMS[@]}" | wofi --normal-window --show dmenu --allow-images --prompt "Selecione o Wallpaper" --width 250 --height 300)

[[ -z "$CHOICE" ]] && exit 0

# Extrai o nome do arquivo selecionado
SELECTED_FILE="${CHOICE#*:text:}"
FULL_PATH="$WALLPAPER_DIR/$SELECTED_FILE"

# Aplica o wallpaper (ajuste conforme o que você usa: swww, hyprpaper, feh)
# Exemplo usando swww (comum no Hyprland):
if command -v awww &> /dev/null; then
    awww img "$FULL_PATH" --transition-type grow --transition-pos 0.854,0.977 --transition-step 90
    notify-send "Wallpaper Selecionado" "$SELECTED_FILE" -i "$FULL_PATH" -a "Wallpaper"
else
    # Caso use hyprpaper ou outro, altere aqui
    notify-send "Wallpaper Selecionado" "$SELECTED_FILE"
fi