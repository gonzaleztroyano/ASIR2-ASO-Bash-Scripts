#!/usr/bin/env bash

# IFS guarda el separador por defecto

OIFS=$IFS
IFS=':'
while read usuario pass nid resto
    do
        if [ $nid -ge 1000 ]
            then
                echo $nid
                cont=`expr ${cont} + 1`
        fi
    done < /etc/passwd

echo "Existen $cont usuarios"  

# cat /etc/passwd | cut -d ':' -f 3 | egrep "^[0-9]{4}$" | wc -l

##################

IFS=$OIFS