#!/bin/bash

# Carpeta donde tienes tus wallpapers
WALLPAPER_DIR="/home/eliabe/Pictures/Wpp"
USED_LIST="$HOME/.used_wallpapers.txt"

# Crear archivo de registro si no existe
touch "$USED_LIST"

# Obtener lista de todos los wallpapers
ALL_WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \))

# Filtrar los que ya se usaron
UNUSED_WALLPAPERS=$(grep -vxFf "$USED_LIST" <<< "$ALL_WALLPAPERS")

# Si no quedan sin usar, reiniciamos la lista
if [ -z "$UNUSED_WALLPAPERS" ]; then
    echo "Todos los wallpapers ya fueron usados, reiniciando lista..."
    > "$USED_LIST"  # vacía el archivo
    UNUSED_WALLPAPERS="$ALL_WALLPAPERS"
fi

# Elegir uno al azar
WALLPAPER=$(echo "$UNUSED_WALLPAPERS" | shuf -n 1)

# Aplicar el wallpaper con swww
if [ -n "$WALLPAPER" ]; then
    swww img "$WALLPAPER"
    echo "$WALLPAPER" >> "$USED_LIST"  # guardar como usado
    echo "Wallpaper aplicado: $WALLPAPER"
else
    echo "No se encontró ningún wallpaper en $WALLPAPER_DIR"
fi
