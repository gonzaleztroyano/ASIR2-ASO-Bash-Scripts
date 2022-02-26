#!/usr/bin/env bash

# Realizar el ejercicio 1 del examen de PowerShell
clear
letras=(a b c d e f g h i j k l m n ñ o p q r s t u v w x y z)
for (( i=0; $i < ${#letras[@]}; i++ ))
	do
		mkdir /home/raul/prueba/${letras[${i}]}
	done
echo "Carpetas creadas en /home/raul/prueba"


OIFS=$IFS
IFS=#
while read p1 p2 p3 p4 p5 p6
	do
		for (( j=0; $j < ${#letras[@]}; j++ ))
			do
				cd /home/raul/prueba/${letras[${j}]}
					if [ ${letras[${j}]} = ${p1:0:1} ]
						then
							touch fichero.txt
							echo ${p1} >> fichero.txt
					fi
					
					if [ ${letras[${j}]} = ${p2:0:1} ]
						then
							touch fichero.txt
							echo ${p2} >> fichero.txt
					fi
					
					if [ ${letras[${j}]} = ${p3:0:1} ]
						then
							touch fichero.txt
							echo ${p3} >> fichero.txt
					fi
					
					if [ ${letras[${j}]} = ${p4:0:1} ]
						then
							touch fichero.txt
							echo ${p4} >> fichero.txt
					fi
					
					if [ ${letras[${j}]} = ${p5:0:1} ]
						then
							touch fichero.txt
							echo ${p5} >> fichero.txt
					fi
					
					if [ ${letras[${j}]} = ${p6:0:1} ]
						then
							touch fichero.txt
							echo ${p6} >> fichero.txt
					fi
			done
	done < /home/raul/palabras.txt 2>>/dev/null
IFS=$OIFS
