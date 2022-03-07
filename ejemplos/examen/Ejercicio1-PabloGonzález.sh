#!/usr/bin/env bash

# Se ha importado la BDD con mysql < fabrica.sql

mysql_connection="mysql -u root -proot"

$mysql_connection<<EOF
SELECT * FROM fabrica.almacen
WHERE (horas_trabajo - horas_trabajadas) < 2000
INTO OUTFILE '/var/lib/mysql/horas.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
EOF
## El archivo contiene:
# 'id_pieza','nombre','horas_trabajo','horas_trabajadas','foto'
# '1','ANILLO TURBINA','26280','25007','anillo_turbina.jpg'
# '2','FILTRO','8760','8700','filtro.jpg'
# '3','SOLENOIDE','12467','12450','solenoide,jpg'
# '4','VALVULA ABS','5670','4832','4832'



cont=0
OIFS=$IFS
IFS=","
while read id_pieza nombre horas_trabajo horas_trabajadas foto
    do
		echo -e "$id_pieza \t \t \t $nombre \t \t \t $horas_trabajo \t\t \t $horas_trabajadas" 
        cont=$(($cont + 1))
    done <   /var/lib/mysql/horas.csv

echo "Existen $cont piezas en peligro de caducar"  
