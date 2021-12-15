#!/usr/bin/env bash

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