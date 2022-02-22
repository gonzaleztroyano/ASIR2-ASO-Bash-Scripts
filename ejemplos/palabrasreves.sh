#!/usr/bin/env bash

	read -p "Dime la palabra y la pongo al reves: " caracter
	
	for (( i=${#caracter}-1; i>=0; i-- )) 
	do
		palabra="${palabra}${caracter:$i:1}"
	done
		echo "${palabra}"
