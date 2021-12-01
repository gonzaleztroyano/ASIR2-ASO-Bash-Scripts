#!/bin/bash

# echo -e "${C_RED}H$"

# Para definir un Array
array_ejemplo=(1 2 3 4 5 6)
array_ejemplo2=(Pepe Ana Luisa "Victor Manuel")

# Mostrar un elemento del array, index starts 0
echo "${array_ejemplo2[2]}"

# Mostrar la cuenta de elementos
echo "La tabla nombres tiene ${#array_ejemplo2[@]} elementos"

# Mostrar todos los elementos
echo "La tabla contiene los siguientes elementos: ${array_ejemplo2[@]}"

apellido="Ruiz Ramirez"
echo "La cadena "$apellido" tiene ${#apellido} caracteres."