#!/usr/bin/env bash

function altas(){
    echo "altas"
}

function bajas(){
    
}
function consulta(){
    
}
function listar(){
    
}

function modificaciones(){
    
}
function menu(){

op="CONT"
while [ "$op" != "SALIR" ]
    do
        op=`yad --list --title="Gestión de agenda" --separator= --print-column=1 --width=400 --height=400 --center --column="Opción" --column="Descripción"  "ALTA" "Añada un contacto a su agenda" "BAJA" "Elimine un contacto de su agenda" "CONSULTA" "Busque entre sus contactos" "LISTADO" "Obtenga todos sus contactos" "MODIFICAR" "Modifique un contacto guardado" "SALIR" "Cerrar el programa :("`
    case $op in 
        "ALTA") altas;;
        "BAJA") bajas;;
        "CONSULTA") consulta;;
        "LISTADO") listar;;
        "MODIFICAR") modificaciones;;
    esac
done

}

