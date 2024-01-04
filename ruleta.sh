#!/bin/bash

# Colors
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c() {
	echo -e "\n\n ${redColour} [!] Saliendo...${endColour}\n"
	tput cnorm && exit 1
}

# ctrl+c
trap ctrl_c INT

function helpPanel() {
	echo -e "\n$yellowColour[+]${endColour}${grayColour} Uso:${endColour}${purpleColour} $0${endColour}\n"
	echo -e "\n${blueColour}-m)${endColour}${grayColour} Dinero con el que se desea jugar${endColour}\n"
	echo -e "\n${blueColour}-t)${endColour}${grayColour} Técnica a utilizar${endColour}${purpleColour} (${endColour}${yellowColour}martingala${endColour}${blueColour}/${endColour}${yellowColour}inverseLabrouchere${endColour}${purpleColour})${endColour}\n"
	exit 1
}

function martingala() {
	echo -e "\n${yellowColour}[+]${endColour}${grayColour} Dinero actual:${endColour}${yellowColour} €$money${endColour}"
	echo -ne "${yellowColour}[+]${endColour}${grayColour} ¿Cuánto dinero tienes pensado apostar? ->${endColour} " && read initial_bet
	echo -ne "${yellowColour}[+]${endColour}${grayColour} ¿A qué deseas apostar continuamente (par/impar)? ->${endColour} " && read par_impar

	echo -e "\n${yellowColour}[+]${endColour}${grayColour} Vamos a jugar con una cantidad inicial de${endColour}${yellowColour} €$initial_bet${endColour}${grayColour} a${endColour}${yellowColour} $par_impar${endColour}"

	backup_bet=$initial_bet
	play_counter=0
	jugadas_malas=""
	mayor_cantidad=$money

	tput civis #ocultar el cursor
	while true; do
		money=$(($money - $initial_bet))
		#		echo -e "\n${yellowColour}[+]${endColour}${grayColour} Acabas de apostar${endColour}${yellowColour} €$initial_bet${endColour}${grayColour} y tienes${endColour}${yellowColour} €$money${endColour}"
		random_number="$(($RANDOM % 37))"
		#		echo -e "${yellowColour}[+]${endColour}${grayColour} Ha salido el número${endColour}${yellowColour} $random_number${endColour}"

		if [ ! "$money" -lt 0 ]; then
			if [ "$par_impar" == "par" ]; then #Elegimos un número par
				if [ "$((random_number % 2))" -eq 0 ]; then
					if [ "$random_number" -eq 0 ]; then
						#						echo -e "${redColour}[+] Ha salido el 0, por tanto perdemos${endColour}"
						initial_bet=$(($initial_bet * 2))
						#						echo -e "${yellowColour}[+]${endColour}${grayColour} Ahora mismo te quedas en${endColour}${yellowColour} €$money${endColour}"
						if [ $money -gt $mayor_cantidad ]; then
							mayor_cantidad=$money
						fi

					else
						#						echo -e "${yellowColour}[+]${endColour}${greenColour} El número es par, ¡Ganas!${endColour}"
						reward=$(($initial_bet * 2))
						jugadas_malas+="$random_number "
						#						echo -e "${yellowColour}[+]${endColour}${grayColour} Ganas un total de${endColour}${yellowColour} €$reward${endColour}"
						money=$(($money + $reward))
						if [ $money -gt $mayor_cantidad ]; then
							mayor_cantidad=$money
						fi
						#						echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes${endColour}${yellowColour} €$money${endColour}"
						initial_bet=$backup_bet
						jugadas_malas=""
					fi

				else
					#					echo -e "${yellowColour}[+]${endColour}${redColour} El número que ha salido es impar ¡Pierdes!${endColour}"
					initial_bet=$(($initial_bet * 2))
					jugadas_malas+="$random_number "
					#					echo -e "${yellowColour}[+]${endColour}${grayColour} Ahora mismo te quedas en${endColour}${yellowColour} €$money${endColour}"
				fi

			else
				if [ "$((random_number % 2))" -eq 1 ]; then #Elegimos apostar por impar y salió un número impar
					#echo -e "${yellowColour}[+]${endColour}${greenColour} El número es impar, ¡Ganas!${endColour}"
					reward=$(($initial_bet * 2))
					#echo -e "${yellowColour}[+]${endColour}${grayColour} Ganas un total de${endColour}${yellowColour} €$reward${endColour}"
					money=$(($money + $reward))
					if [ $money -gt $mayor_cantidad ]; then
						mayor_cantidad=$money
					fi
					#echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes${endColour}${yellowColour} €$money${endColour}"
					initial_bet=$backup_bet
					jugadas_malas=""
				else #Elegimos apostar por impar y salió un número par
					#echo -e "${yellowColour}[+]${endColour}${redColour} El número que ha salido es par ¡Pierdes!${endColour}"
					initial_bet=$(($initial_bet * 2))
					jugadas_malas+="$random_number "
					#echo -e "${yellowColour}[+]${endColour}${grayColour} Ahora mismo te quedas en${endColour}${yellowColour} €$money${endColour}"
				fi
			fi
		else
			echo -e "\n${redColour}[+] ¡Te has quedado sin dinero!${endColour}\n"
			echo -e "${yellowColour}[+]${endColour}${grayColour} Han habido un total de${endColour}${yellowColour} $play_counter${endColour}${grayColour} jugadas"

			echo -e "${yellowColour}[+]${endColour}${grayColour} La mayor cantidad de dinero que tuviste fue de${endColour}${yellowColour} €$mayor_cantidad${endColour}"
			echo -e "${yellowColour}[+]${endColour}${grayColour} A continuación se van a mostrar las malas jugadas consecutivas que han salido:${endColour}"
			echo -e "${blueColour}[ $jugadas_malas]${endColour}"
			tput cnorm && exit 0
		fi

		let play_counter+=1
	done

	tput cnorm #recuperamos el cursor
}

while getopts "m:t:h" arg; do
	case $arg in
	m) money=$OPTARG ;;
	t) technique=$OPTARG ;;
	h) helpPanel ;;
	esac
done

if [ $money ] && [ $technique ]; then
	if [ $technique == martingala ]; then
		martingala
	else
		echo -e "${redColour}[!] La técnica introducida no existe${endColour}\n"
	fi
else
	helpPanel
fi
