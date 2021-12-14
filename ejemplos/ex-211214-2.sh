#!/usr/bin/env bash

##### Archivo de origen
# nombre#apellido#tel#email#fechan
rm /tmp/agenda.txt
touch /tmp/agenda.txt
echo "Ana#Arranz#6222266454#anita.arranz@bbb.com#01/01/1991" >> /tmp/agenda.txt
echo "Jose Manuel#Perez#66554444#josemanu@yahuuuu.es#14/45/1111" >> /tmp/agenda.txt

OIFS=$IFS
IFS='#'

echo -e "nombre\t apellido \t email \t teléfono \t fechan\n=================================="
while read nombre apellido tel email fechan
    do
        echo -e "$nombre\t $apellido \t $tel \t $email \t $fechan"
    done < /tmp/agenda.txt

IFS=$OIFS