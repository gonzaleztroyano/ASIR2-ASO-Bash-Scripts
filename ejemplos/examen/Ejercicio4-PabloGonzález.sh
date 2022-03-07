#!/usr/bin/env bash

#ldapsearch -xLLL -b dc=gonzalez,dc=local "(objectClass=person)" cn description mail mobile | grep -v -e "^$" | grep -v "dn:" > resultado-data.txt

# El archivo generado queda de la siguiente manera:

#cn: evalopez
#description: administrativo
#mail: evalopez@gonzalez.local
#mobile: 922997477
#gecos: /home/evalopez/evalopez2.jpg
#cn: luisramos
#description: supervisor
#mail: luisramos@gonzalez.local
#mobile: 655455599
#gecos: /home/luisramos/luisramos2.jpg
#cn: juanpizarro
#description: comercial
#mail: juanpizarro@gonzalez.local
#mobile: 6998000009
#gecos: /home/juanpizarro/juanpizarro2.jpg
#cn: susanaortega
#description: comercial
#mail: sandraherrero@gonzalez.local
#mobile: 65547766
#gecos: /home/sandraherrero/sandraherrero2.jpg


touch /home/$USER/resultado.html

echo "
<table style='border: 1px solid black'>
<tr>
	<td style='border: 1px solid black'>NOMBRE</td>
	<td style='border: 1px solid black'>PUESTO</td>
	<td style='border: 1px solid black'>E-MAIL</td>
	<td style='border: 1px solid black'>TELEFONO</td>
	<td style='border: 1px solid black'>FOTO</td>
</tr>
<tr style='border: 1px solid black'>
"> /home/$USER/resultado.html


cuenta=1
OIFS=$IFS
IFS=': '
while read atributo datos
    do
		echo "$datos"
		if [[ $cuenta -ne 5 ]]
			then 
				echo -e "\t<td style='border: 1px solid black'> $datos </td>" >> /home/$USER/resultado.html
				cuenta=$(($cuenta + 1))
		elif [[ $cuenta -eq 5 ]] 
			then
				echo -e "\t<td style='border: 1px solid black'> <img src='$datos'></td>" >> /home/$USER/resultado.html
				cuenta=$(($cuenta + 1))
		fi
		if [[ $cuenta -ge 6 ]]
			then
				echo -e "</tr>\n<tr  style='border: 1px solid black'>" >> /home/$USER/resultado.html
				cuenta=1
		fi
   done < /home/$USER/resultado-data.txt
    
    
