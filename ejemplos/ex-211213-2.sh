#!/usr/bin/env bash

# Colores

C_RED="\E[31m"
C_GREEN="\E[32m"
C_YELLOW="\E[33m"
C_BLUE="\E[34m"
C_REDBOLD="\E[1;31m"
C_GREENBOLD="\E[1;32m"
C_YELLOWBOLD="\E[1;33m"
C_BLUEBOLD="\E[1;33m"
C_NORMAL="\E[0m"
C_BOLD="\E[1m"

colores=("$C_RED" "$C_GREEN" "$C_YELLOW" "$C_BLUE" "$C_REDBOLD" "$C_GREENBOLD" "$C_YELLOWBOLD" "$C_BLUEBOLD" "$C_NORMAL" "$C_BOLD")
read -p "Introduce una cadena: " cadena



for (( letra=0;letra<${#cadena};letra++ ));
    do {
        pos=($(( RANDOM % 10 )))
        color="${colores[${pos}]}"
        echo -e " $color ${cadena:$letra:1} $C_NORMAL"
    } 
done