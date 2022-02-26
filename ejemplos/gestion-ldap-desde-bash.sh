##################################################################
##############              DISCLAIMER              ##############
#                                                                #
#            Este script ha sido creado por @Angelocho           #
#                                                                #
##############              DISCLAIMER              ##############
##################################################################


#!/usr/bin/env bash
op=0
org=0
cont=$(ldapsearch -x -LLL -b dc=bocalandro,dc=local "(objectClass=person)" | grep "uidNumber" | wc -l)
function faltas(){
    cont2=$(expr $cont + 1001)
    userPassword={SSHA}k4LG1STOQfpYpuQj2DFmI5doZGHmWRU0
    cont2=$(expr $cont2 + 1 )
    
    alta=`yad --form --field=Nombre --field=Apellido --field=Telefono --field=Correo`
    
    nom=`echo ${alta} | cut -f1 -d"|"`
    ape=`echo ${alta} | cut -f2 -d"|"`
    tel=`echo ${alta} | cut -f3 -d"|"`
    cor=`echo ${alta} | cut -f4 -d"|"`
   
    echo "${nom} ${ape} ${tel} ${cor}"
    if [[ "${nom}" == "" ]] | [[ "${ape}" == "" ]] | [[ "${tel}" == "" ]] | [[ "${cor}" == "" ]];
    then
		echo "Faltan parametros"
	else
		echo "dn: cn=${nom},dc=bocalandro,dc=local" >> dominio.ldif
		echo "objectClass: person" >> dominio.ldif
		echo "objectClass: organizationalPerson" >> dominio.ldif
		echo "objectClass: inetOrgPerson" >> dominio.ldif
		echo "objectClass: posixAccount" >> dominio.ldif
		echo "objectClass: shadowAccount" >> dominio.ldif
		echo "homeDirectory: /home/${nom}" >> dominio.ldif
		echo "loginShell: /bin/bash" >> dominio.ldif
		echo "sn: ${ape}" >> dominio.ldif
		echo "uid: ${nom}">> dominio.ldif
		echo "uidNumber: ${cont2}" >> dominio.ldif
		echo "gidNumber: ${cont2}" >> dominio.ldif
		echo "mobile: ${tel}" >> dominio.ldif
		echo "mail: ${cor}"	>> dominio.ldif
		echo "userPassword: ${userPassword}" >> dominio.ldif
		echo -e "\n"  >> dominio.ldif 
		 
        ldapadd -x -D cn=admin,dc=bocalandro,dc=local -W -f dominio.ldif
        bien=`echo $?`
			if [ ${bien} != 0 ] 
			then
				echo "Algo ha ido mal en la adicion del usuario en el dominio"
			else 
				echo "Todo genial !" 
			fi	
     fi
     
}
function fbajas(){
   baja=`yad --form --field=Nombre`
   nom=`echo ${baja} | cut -f1 -d"|"`
   existe=`ldapsearch -x -b dc=bocalandro,dc=local -LLL "(objectClass=inetOrgPerson)" | grep ${nom}`
   
   comp=`echo $?` 
   if [[ ${comp} != 0 ]] 
   then
		echo "Usuario no existente"
   else
		
		read -p "¿Es este el usuario que desea borrar (s/n)? " resp
		if [[ ${resp} == 's' ]] 
		then
			echo "dn=${nom},dc=bocalandro,dc=local" >> borrar.ldif
			ldapdelete -x -D cn=admin,dc=bocalandro,dc=local -W -f borrar.ldif
			bien=`echo $?`
			if [ ${bien} != 0 ]
			then
				echo "Algo ha ido mal al intentar borrar (en esta demo solo se permiten borrar usuarios que esten en la raiz)"
			fi
		fi
   fi
}
function fconsultas(){
echo "consulta"
	OIFS=$IFS
        IFS=#
        telefono=$(yad --form --title="Dame el telefono" --width=300 --height=300 --center --separator="#" \
    --field=telefono ) 
    
    while read nom ou tel cor
    do
		if [ "${tel}" == "${telefono}" ] 
		then
		n="${n}${nom}"
		a="${a}${ape}"
		t="${t}${tel}"
		c="${c}${cor}"
		
		yad --list --title="Resultado consulta" --width=400 --height=300 --center \
		--column=NOMBRE --column=OU --column=TELEFONO --column=EMAIL  \
		"${n}" "${a}" "${t}" "${c}"
		fi
    done < ./dominio.txt
  
    IFS=$OIFS
}
function flistados(){
echo "listado"
   # OIFS=$IFS
   # IFS=#
#	n=""
#	a=""
#	t=""
#	c=""
#	f=""
	
#	while read nom ape tel cor fn
 #   do
	#	n="${n}${nom}""\n"
	#	a="${a}${ape}""\n"
	#	t="${t}${tel}""\n"
	#	c="${c}${cor}""\n"
	#	f="${f}${fn}""\n"
		#cadena="${cadena}${nom}\t${ape}\t${tel}\t${cor}\t${fn}\n"
    #done < ./agenda.txt
#yad --info --title="CONTENIDO AGENDA" --text="${cadena}"
 #yad --list --title="Contenido agenda" --width=400 --height=300 --center \
 #--column=NOMBRE --column=APELLIDO --column=TELEFONO --column=EMAIL --column="F.NACIMIENTO" \
 #"${n}" "${a}" "${t}" "${c}" "${f}"
 
  #  IFS=$OIFS
}
function fmodificaciones(){
    echo "Modificar contenido de la agenda"
   # nombre=`yad --entry --title="Dime el nombre" --test="NOMBRE" --center `
   #OIFS=$IFS
   #IFS=#
    #while read nom ape tel cor fn
    #do
	#	if [ "${nom}" == "${nombre}" ] 
	#		then
	#			n="${n}${nom}"
	#			a="${a}${ape}"
	#			t="${t}${tel}"
	#			c="${c}${cor}"
	#			f="${f}${fn}"
   
	#			registro=$(yad --form --title="MODIFICAR REGISTRO REGISTRO" --width=300 --height=300 --center \
	#			--field=NOMBRE:RO --field=APELLIDO:RO --field=TELEFONO --field=EMAIL --field="FECHA NACIMIENTO":DT \
	#			${nom} ${ape} ${tel} ${cor} ${fn}) 
	#			echo ${registro} | tr "|" "#" > ./temp.txt
	#		else
	#			echo ${nom}"#"${ape}"#"${tel}"#"${cor}"#"${fn}"#" >> temp.txt
	#		rm agenda.txt
	#		mv temp.txt agenda.txt
	#	fi
	#done < ./agenda.txt
	
	#IFS=$OIFS
}


while [ $op -ne 6 ] 
do
op=$(yad --list --title="Agenda" --width=200 --height=400 --center \
--column="" --column="" 1 "ALTA DE UN USUARIO" 2 "BAJAS" 3 "CONSULTAS" 4 "LISTADOS" 5 "MODIFICACIONES" 6 "SALIR")
op=$(echo $op | cut -f1 -d"|")
    case $op in
    1) faltas;;
    2) fbajas;;
    3) fconsultas;;
    4) flistados;;
    5) fmodificaciones 
    esac
done
