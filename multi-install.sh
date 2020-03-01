#!/bin/bash
# Init

function menue() {
	set -u
	clear
	echo "$yellow########################################"
	sleep .1
	echo "###  Multi-install Script by Mobulos ###"
	sleep .1
	echo "########################################"
	sleep .1
	echo
	echo "Version 0.0.3"
	echo "Update 01.03.2020" #TODO Version und Datum ändern
	echo "$reset"
	echo
	log_warning "Dies ist die PRE-RELEASE Version, das Script verfügt noch nicht über alle Funktionen!"
	echo
	echo
	sleep .5
	echo "Auswahlmöglichkeiten:"
	sleep .1
	tmp=($(tput setaf 3))
	echo -n "$tmp"
	echo "[1] soon"
	tmp=($(tput setaf 4))
	echo -n "$tmp"
	sleep .1
	echo "[2] Update"
	tmp=($(tput setaf 5))
	echo -n "$tmp"
	sleep .1
	echo "[3] Exit"
	read -n1 -p "Was willst du tun?: " befehl
	clear
	echo -n "$reset"
	case $befehl in
	1)
		soon
		;;
	2)
		rm 20*
		update
		;;
	3)
		exit
		;;
	*)
		clear
		log_error "Du musst dich vertippt haben..."
		menue
		;;
	esac

}

function update() {
	# CHECK, OB DAS SCRIPT HEUTE UPGEDATED WURDE
	if [ -f $(date +%Y-%m-%d) ]; then
		# WENN HEUTE BEREITS UPGEDATED GEHE ZUM MENÜ
		menue
	elif [[ * ]]; then
		# WENN HEUTE NICHT UPGEDATED GEHE WEITER
		# LÖSCHE "ZULETZT UPGEDATED" DATEI
		touch "$(date +%Y-%m-%d)"
		rm 20* || :
		clear
		echo "$red Die neuste Version wird heruntergeladen"
		curl --progress-bar https://raw.githubusercontent.com/Mobulos/multi-install/master/multi-install.sh -o multi-install.sh
		sleep 2
		# wget https://raw.githubusercontent.com/Mobulos/multi-install/master/multi-install.sh
		echo "$reset"
		sleep .5
		clear
		log_success "Das Update wurde Erfolgreich heruntergeladen!"
		sleep 1
		chmod +x multi-install.sh
	fi
	touch "$(date +%Y-%m-%d)"
	./multi-install.sh

}

function soon() {
	clear
	log_warning "Diese Funktion wird später hinzugefügt!"
	read -n1
	clear
	menue
}

particular_script() {
	false
}

# LADE DAS LOG FEATURE
rm .log4bash.sh
clear
curl --progress-bar https://raw.githubusercontent.com/Mobulos/multi-install/master/log4bash.sh -o .log4bash.sh
chmod +x .log4bash.sh
source .log4bash.sh
clear

# ROOT CHECK
FILE="/tmp/out.$$"
GREP="/bin/grep"
if [ "$(id -u)" != "0" ]; then
	log_warning "Das Script muss als root gestartet werden."
	exit 1
fi

# SETZE FARBCODES
red=($(tput setaf 1))
green=($(tput setaf 2))
yellow=($(tput setaf 3))
reset=($(tput sgr0))

# ÜBRPRÜFE OB ERSTER START
if [ -f $(date +%Y-%m*) ]; then
	# WENN NICHT ERSTER START:
	update
elif [[ * ]]; then
	# WENN ERSTER START:
	apt-get update
	clear
	apt-get upgrade -y

	# INSTALLATION BENÖTIGTER PAKETE
	for i in curl wget sudo screen; do
		apt-get install $i -y
		clear
	done
	update
fi
