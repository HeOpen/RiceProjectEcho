#!/bin/bash

DIR="$HOME/Pictures/Wpp"
STATE_FILE="$HOME/.config/hypr/last_wallpaper.txt"

# Crear el archivo de estado si no existe
mkdir -p "$(dirname "$STATE_FILE")"
touch "$STATE_FILE"

# Listar todos los wallpapers
WALLPAPERS=("$DIR"/*)

# Leer el índice del último wallpaper usado
LAST_INDEX=$(cat "$STATE_FILE")
if ! [[ "$LAST_INDEX" =~ ^[0-9]+$ ]] || [ "$LAST_INDEX" -ge "${#WALLPAPERS[@]}" ]; then
    LAST_INDEX=-1
fi

# Calcular el índice del siguiente wallpaper
NEXT_INDEX=$((LAST_INDEX + 1))
if [ "$NEXT_INDEX" -ge "${#WALLPAPERS[@]}" ]; then
    NEXT_INDEX=0
fi

# Aplicar wallpaper a todos los monitores
for MON in $(swww query | awk -F: '{print $1}'); do
    swww img -o "$MON" "${WALLPAPERS[$NEXT_INDEX]}"
done

# Guardar el nuevo índice
echo "$NEXT_INDEX" > "$STATE_FILE"
