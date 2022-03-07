 #!/usr/bin/env bash

function disco(){
	uso_porcentaje=$(df | grep "/dev/sda" | grep -o -e "[0-9]*%")
	uso_disco=${uso_porcentaje:0:1}
	
	# Para probar modificar esto: 
	# uso_disco=80
	
	if [ $uso_disco -lt 50 ] 
		then
			yad --info --image=/home/user/Escritorio/recursos/verde.svg --text "\n         El uso del disco es del $uso_porcentaje         "
	else [ $uso_disco -gt 50 ]
		if [ $uso_disco -lt 80 ]
			then 
				yad --info --image=/home/user/Escritorio/recursos/ambar.svg --text "\n         El uso del disco es del $uso_porcentaje         "
			else 
				yad --info --image=/home/user/Escritorio/recursos/roja.svg --text "\n         El uso del disco es del $uso_porcentaje         "
		fi
	fi
}

function memoria(){
	memoria_total_en_kb=$(cat /proc/meminfo  | grep "MemTotal" | grep -o -e "[0-9]*")	
	memoria_free_en_kb=$(cat /proc/meminfo  | grep "MemFree" | grep -o -e "[0-9]*")
	
	memoria_porcentaje_ocupado=$(expr $memoria_total_en_kb / $memoria_free_en_kb)
	
	# Para probar modificar esto:
	# Memoria_porcentaje_ocupado=80
	
	if [ $memoria_porcentaje_ocupado -lt 40 ] 
		then
			yad --info --image=/home/user/Escritorio/recursos/verde.svg --text "\n El uso de la memroia es de $memoria_porcentaje_ocupado %"
	else [ $memoria_porcentaje_ocupado -gt 40 ]
		if [ $memoria_porcentaje_ocupado -lt 60 ]
			then 
				yad --info --image=/home/user/Escritorio/recursos/ambar.svg --text "\n El uso de la memroia es de $memoria_porcentaje_ocupado %"
			else 
				yad --info --image=/home/user/Escritorio/recursos/roja.svg --text "\n El uso de la memroia es de $memoria_porcentaje_ocupado %"
		fi
	fi
}

function conexiones(){
	if [ ! -f /home/$USER/conectados.txt ]
		then
			touch /home/$USER/conectados.txt
	fi
	 
	cuenta=0
	for((i=1;i<10;i++))
		do
			ping -c 1 10.0.10.$i -t 1 > /dev/null
		if [ $? -eq 0 ]
			then 
				cuenta=$(($cuenta + 1)) 
				fecha=$(date  --rfc-3339=seconds | cut -d" " -f1)
				hora=$(date  --rfc-3339=seconds | cut -d" " -f2)
				
				echo "$fecha#$hora#10.0.10.$i" >> /home/$USER/conectados.txt
		fi
	done
	yad --info --text "Se han encontrado $cuenta IPs\n Los detalles se encuentran en el archivo 'conectados.txt' de tu home"
	
	## Después se te abre el archivo
	gedit /home/$USER/conectados.txt
}

function menu(){
    op="CONT"
    while [ "$op" != "4" ]
        do
            op=$(yad --list --title="Menú Utilidades" --separator= --print-column=1 --width=400 --height=400 --center --column="Opción" --column="Descripción" "1" "Ocupación de disco" "2" "Ocupación de memoria" "3" "Máquinas conectadas" "4" "Salir")
        case $op in 
            "1") disco;;
            "2") memoria;;
            "3") conexiones;;
            "4") exit;;
        esac
    done
}

menu
