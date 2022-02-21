#!/usr/bin/env bash

# 98.	Dado un número que se solicita a un usuario, que calcule la suma de los pares y el producto de los impares, hasta dicho número.
suma_pares=0
producto_impares=1

read -p "Introduce un número, por favor: " num
re='^[0-9]+$'

if ! [[ $num =~ $re ]]
    then 
        echo -e "El valor introducido no es un número \n Saliendo..."
        read -p ""
fi

for (( i=1; i <= $num; i++ )) 
    do
    if  [[ $((i%2)) -eq 0 ]] # Es par
        then 
        # echo "$i es par"
        suma_pares=$(($suma_pares + $i))
    elif [[ $((i%2)) -ne 0 ]]
        then
        # echo "$i es impar" 
        producto_impares=$(($producto_impares*$i))
    fi
done
clear
echo -e "\n\n               ---- RESULTADOS ---- \n"
echo " La suma de los pares hasta el número $num es: $suma_pares"
echo " El producto de los impares hasta en $num es : $producto_impares"
echo -e "\n\n"