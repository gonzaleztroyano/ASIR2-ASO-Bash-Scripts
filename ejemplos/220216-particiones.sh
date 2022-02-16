#!/bin/bash

C_RED="\E[31m"
C_NORMAL="\E[0m"

if [ "${EUID}" -ne 0 ]
  then echo "Este script de gestión solo puede ser ejecutado por el usuario root"
  exit
fi

function listar_part(){
    # RECIBE $disk_id_list_part como $1
    # cat /proc/partitions | grep -v loop | grep -E -o "$1[0-9]{1,}"
    fdisk -l /dev/"${1}"
}
function listar(){
    echo -e "\nSe han encontrado los siguientes discos:\n $C_RED"
    
    fdisk -l | grep "Disco" | grep -v "loop" | grep -E "sd[a-z]{1}[0-9]{0,1}"
    
    echo -e "\n\n$C_NORMAL Si quiere listar las particiones de algún disco introduzca 'p' o cualquier tecla para volver al menú \n"

    read -p "Opción elegida: " opt
    
    case $opt in
        "p")
            echo -e "Introduce el identificador del disco (por ejemplo $C_RED sda $C_NORMAL)" 
            read -p "   Identificador: " disk_id_list_part

            echo -e "\nEstas son las particiones:\n\n$C_RED"
            listar_part "$disk_id_list_part"
            echo -e "$C_NORMAL"
            read -p "Pulse cualquier tecla para volver al menú" temp
            menu
            ;;
        *) 
            clear
            menu
    esac
    #cat /proc/partitions | grep -v loop | grep -E -o "sd[a-z]{1}[0-9]{0,1}"
}
function crear_part(){
    echo -e "$C_RED ATENCIÓN: Usa este script con responsabilidad. Puede ser destructivo. $C_NORMAL"
    echo -e "Estos son los discos encontrados:\n"
        fdisk -l | grep "Disco" | grep -v "loop" | grep -E "sd[a-z]{1}[0-9]{0,1}"
    read -p "Inserte la ruta completa ($C_RED /dev/sdb $C_NORMAL) del disco de trabajo: " disco_trabajo

    if [[ $disco_trabajo = "/dev/sda" ]]
        then
            read -p "Se ha seleccionado $disco_trabajo \n Sea cuidadoso. "
    fi

    read -p "¿Desea inicializar el disco? [s/n]: " inicializar
    
    if [[ $inicializar = s ]] 
        then
            echo "Inicializar"
            parted $disco_trabajo << EOF
mktable gpt
EOF
            echo "El disco ha sido inicializado"
    else 
        echo "No inicializando el disco"
    fi

}
function menu(){
    clear
    echo "Bienvenido al programa inútil de creación de particiones"
    echo "CC BY Pablo González, 2022"
    echo ""
    echo " 1. Listar particiones"
    echo " 2. Crear particiones"
    echo " 3. Salir del programa"
    echo ""
    opt=0
    read -p "Opción elegida: " opt
    case $opt in
        1) listar
        ;;
        2) crear
        ;;
        3) exit
        ;;
        *) read -p "Opción Incorrecta "
            menu
    esac
}

menu