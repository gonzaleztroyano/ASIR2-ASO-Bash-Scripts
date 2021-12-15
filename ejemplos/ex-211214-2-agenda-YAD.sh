#!/usr/bin/env bash

touch /tmp/agenda.txt
echo "Ana#Arranz#6222266454#anita.arranz@bbb.com#01/01/1991" > /tmp/agenda.txt
echo "Jose Manuel#Perez#66554444#josemanu@yahuuuu.es#14/45/1111" >> /tmp/agenda.txt


function alta() {
    cuenta_registros=$(wc -l < /tmp/agenda.txt)
    id_registro_nuevo=$(expr $cuenta_registros + 1)
    yad --form --title="Agenda > Alta contacto" --width=300 --height=500 --center  --separator="#"  --field="Nombre" --field="Apellido" --field="Teléfono" --field="Correo electrónico" --field="Fecha de nacimiento:DT" --field="ID de contacto:RO" "${id_registro_nuevo}"

    echo ${new_entry} >> /tmp/agenda.txt
}

function baja(){
    echo "bajas"
}
function consulta(){
    echo "consulta"
}
function listar(){
OIFS=$IFS
IFS="#"
personas=""
while read nom ape tel cor fn
do
    comando='--list --title="Agenda > Listar contactos" --width=500 --height=400 --center --column="Nombre" --column="Apellidos" --column="Teléfono" --column="Correo-e"  --column="F.Nac"'

    personas=" ${personas} '${nom}' '${ape}' '${tel}' '${cor}' '${fn}' "
#    
#    echo -e "Comandos: ${comando}\n "
#    echo -e "Personas: ${personas}\n"
done < /tmp/agenda.txt

    comando_final="${comando[*]} ${personas[*]}"
#    echo "Final command:  $comando_final"
function mostrar_listado(){
    #/usr/bin/yad ${comando_final[@]}

    touch /tmp/listar.sh
    echo -e "/usr/bin/yad ${comando_final[@]}" > /tmp/listar.sh
    chmod +x /tmp/listar.sh
    bash /tmp/listar.sh
}
mostrar_listado
IFS=$OIFS
}

function modificaciones(){
    echo "modi"
}
function menu(){
    op="CONT"
    while [ "$op" != "SALIR" ]
        do
            op=$(yad --list --title="Gestión de agenda" --separator= --print-column=1 --width=400 --height=400 --center --column="Opción" --column="Descripción"  "ALTA" "Añada un contacto a su agenda" "BAJA" "Elimine un contacto de su agenda" "CONSULTA" "Busque entre sus contactos" "LISTADO" "Obtenga todos sus contactos" "MODIFICAR" "Modifique un contacto guardado" "SALIR" "Cerrar el programa :(")
        case $op in 
            "ALTA") alta;;
            "BAJA") baja;;
            "CONSULTA") consulta;;
            "LISTADO") listar;;
            "MODIFICAR") modificaciones;;
        esac
    done
}

menu