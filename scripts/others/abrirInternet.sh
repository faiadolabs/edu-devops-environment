#!/bin/bash

# Colores
green='\e[32m'
default='\e[39m' # Default Color

# Me situo en mi HOME para utilizarlo como path relativo
cd $HOME

# Usuario que registrará la apertura de Internet
usuario="agrasar"

# Aula default (13) DAW
codAula="65"

# Cookie filename
cookieFilename=./cookieRouter

diaSemana=$(date '+%A')
horaActual=$(date '+%H') 
cierreInternet="X"

if [ "$diaSemana" == "lunes" ]; then
	# Estoy en DAW-DAPW Tengo clase hasta las 22:10
	cierreInternet="22:20"
	codAula="65"
fi
if [ "$diaSemana" == "martes" ]; then
	# Estoy en ASIR-IAW Tengo clase hasta las 19:40
	cierreInternet="19:45"
	codAula="24"
fi
if [ "$diaSemana" == "miércoles" ]; then
	# Estoy en DAM-PSP Tengo clase hasta las 10:25
	cierreInternet="10:30"
	codAula="65"
fi
if [ "$diaSemana" == "jueves" ]; then
	# Estoy en DAM-PSP Tengo clase hasta las 22:10
	cierreInternet="22:20"
	codAula="24"
fi
if [ "$diaSemana" == "viernes" ]; then
		cierreInternet="19:45"
		codAula="65"
fi
if [ "$cierreInternet" == "X" ]; then
	exit 1
fi


echo -e "${default}\nLogin en el sistema...  ${green}"

# Retardo para anular
sleep 1

# Login (https://stackoverflow.com/questions/12399087/curl-to-access-a-page-that-requires-a-login-from-a-different-page)
curl -s -d @.acl_sc --cookie-jar $cookieFilename https://router.iessanclemente.net/internet/id1.php

# Abrir Internet
echo -e "${default}\nAbriendo internet en Aula $codAula hasta las $cierreInternet...  ${green}"

# Retardo para anular
sleep 1

curl 		--cookie $cookieFilename -s\
			-d "Cod_Aula=$codAula&horacierre=$cierreInternet&envio=Abrir" \
			-s https://router.iessanclemente.net/internet/xestion.php


if [ "$1" == "--cerrar" ]; then
	#Cerrar  Internet
	echo -e "${default}\nCerrando inmediatamente internet en Aula $codAula... ${green}"
	
	# Retardo para anular
	sleep 1
	
	curl 	--cookie $cookieFilename -s \
			-d "Cod_Aula=$codAula&envio=Cerrar Ahora" \
			-X POST https://router.iessanclemente.net/internet/xestion.php

fi

# Borrando la cookie
rm $cookieFilename
echo -e "${default}\nCookie borrada"


sleep 30

exit 0