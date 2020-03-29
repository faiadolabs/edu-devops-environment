#! /bin/bash

# Colors: https://misc.flogisoft.com/bash/tip_colors_and_formatting

green='\033[32m'
red='\033[31m'
blue='\033[34m'
default='\033[39m' # Default Color

ok="${green}[OK]${default} "
fallo="${red}[FALLO]${default} "

is_git_basedir(){
	if [ ! -d ".git" ]; then
		echo "[ERROR] Debes encontrarte en el directorio base de un repo git"
		return 1
	else
		return 0
	fi
}

exist_file(){
	if [ ! -f "$1" ]; then
		# 1 No existe
		return 1
	fi
	# Existe
	return 0
}

exist_file_alumnos(){
	if [ ! -f ".git/alumnos" ]; then
		echo "[ERROR] Debes existir un fichero en .git/alumnos"
		return 1
	else
		return 0
	fi
}

read_user_input(){
	# $1 mensaje
	# $2 valor por defecto
	# https://linuxhint.com/return-string-bash-functions/
	unset read_user_input_response # global variable
	while [ -z "$read_user_input_response" ]
	do
		if [ -n "$2" ]; then
			echo -n "$1 [$2]: "
		else
			echo -n "$1: "
		fi
		read read_user_input_response
		#if [ "$read_user_input_response" = "" ]; then
		if [ -z "$read_user_input_response" ] && [ -n "$2" ]; then
			read_user_input_response="$2"
			return 0
		fi
	done
}

read_user_password(){
	echo "password: "
	read -s password
	return password
}