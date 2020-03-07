#!/bin/bash
# Init


############################################
################# CHANGE ###################
ver=0.2.2
dat=07.03.2020
file=multi-install-beta.sh
############################################
############################################

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


# LADE DAS LOG FEATURE
rm .log4bash.sh
clear
curl --progress-bar https://raw.githubusercontent.com/Mobulos/multi-install/master/log4bash.sh -o .log4bash.sh
chmod +x .log4bash.sh
source .log4bash.sh
clear

function exit () {
	clear
	echo 'Wenn das Script nicht korrekt beendet wurde kannst du es JEDERZEIT mit "STRG" + "C" ("CTRL" + "C") beenden!'
	exit 0
	sleep 5
}

function pre () {
	echo "$yellow##########################################"
	sleep .1
	echo "#### Multi-Install  Script By Mobulos ####"
	sleep .1
	echo "##########################################"
	sleep .1
	echo
	echo "$red""[DEVELOPER] "$reset"Version $ver"
	echo "Update $dat"
	echo "$reset"
	echo
	log_warning "Dies ist die PRE-RELEASE Version, das Script verfügt noch nicht über alle Funktionen!"
	echo
	echo

}

#   __  __   _____   _   _   _   _   _____ 
#  |  \/  | | ____| | \ | | | | | | | ____|
#  | |\/| | |  _|   |  \| | | | | | |  _|  
#  | |  | | | |___  | |\  | | |_| | | |___ 
#  |_|  |_| |_____| |_| \_|  \___/  |_____|


                            
function menue () {
	set -u
	clear
	pre
	sleep .5
	echo "Auswahlmöglichkeiten:"
	sleep .1
	tmp=($(tput setaf 4))
	echo -n "$tmp"
	echo "[1] Einstellungen"
	tmp=($(tput setaf 5))
	echo -n "$tmp"
	sleep .1
	echo "[2] Update"
	tmp=($(tput setaf 6))
	echo -n "$tmp"
	sleep .1
	echo "[3] Exit"
	tmp=($(tput setaf 3))
	echo -n "$tmp"
	read -n1 -p "Was willst du tun?: " befehl
	clear
	echo -n "$reset"
	case $befehl in
	1)
		settings
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
		read -t2 -n1
		menue
		;;
	esac

}

function settings () {
	pre
	sleep .5
	 echo " _____   ___   _   _   ____    _____   _____   _       _       _   _   _   _    ____   _____   _   _"
	 echo "| ____| |_ _| | \ | | / ___|  |_   _| | ____| | |     | |     | | | | | \ | |  / ___| | ____| | \ | |"
	 echo "|  _|    | |  |  \| | \___ \    | |   |  _|   | |     | |     | | | | |  \| | | |  _  |  _|   |  \| |"
	 echo "| |___   | |  | |\  |  ___) |   | |   | |___  | |___  | |___  | |_| | | |\  | | |_| | | |___  | |\  |"
	 echo "|_____| |___| |_| \_| |____/    |_|   |_____| |_____| |_____|  \___/  |_| \_|  \____| |_____| |_| \_|"
	echo
	echo
	sleep .5
	echo -n "$reset"
	echo "Auswahlmöglichkeiten:"
	sleep .1
	tmp=($(tput setaf 4))
	echo -n "$tmp"
	echo "[1] Developer Updates"
	sleep .1
	tmp=($(tput setaf 6))
	echo -n "$tmp"
	echo "[2] Zurück"
	echo -n "$reset"
	read -n1 -p "Was willst du tun?: " befehl
	clear
	echo -n "$reset"
	case $befehl in
	1)
		developer
		exit
		;;
	2)
		resume
		;;
	*)
		clear
		log_error "Du musst dich vertippt haben..."
		read -t2 -n1
		settings
		;;
	esac
}

developer () {
	clear
	if [ -f ".dev" ]; then
		echo "Du erhälst bereits die Developer Version (fast)"
		echo
		read -n1 -p "Möchtest du zuräck zur release Version (slow) [Y/N] " versionl
		case $versionl in
		Y | y | J | j)
		rm .dev
		rm 20*
		clear
		echo "Du erhältst nun keine Developer-Versionen mehr!"
		sleep 3
			touch "$(date +%Y-%m-%d)"
			rm 20*
			clear
			echo "$red Die neuste Version wird heruntergeladen"
			rm multi-install*
			curl --progress-bar https://raw.githubusercontent.com/Mobulos/multi-install/master/multi-install.sh -o multi-install.sh.1
			# wget https://raw.githubusercontent.com/Mobulos/multi-install/master/multi-install.sh
			sleep 2
			echo "$reset"
			mv multi-install.sh.1 multi-install.sh
			clear
			log_success "Das Update wurde Erfolgreich heruntergeladen!"
			sleep 1
			chmod +x multi-install.sh
		./multi-install.sh
		exit
		;;
		N | n)
		echo "Du erhälstst weiterhin Developer Updates."
		sleep 3
		./$file
		exit
		;;
		*)
		clear
		read -n1 "Eingabe nicht erkannt"
		jumpto settings
		exit
		;;
		esac
  elif [[ * ]]; then
    read -n1 -p "Möchtest du jetzt die Developer-Version erhalten? (Y/N) " versionj
    case $versionj in
    Y | y | j | J)
      touch .dev
      rm 20*
      clear
      echo "Du erhälst ab jetzt die neuste (Alpha) Version!"
      sleep 3
			touch "$(date +%Y-%m-%d)"
			rm 20*
			clear
			echo "$red Die neuste Version wird heruntergeladen"
			rm multi-install*
			curl --progress-bar hhttps://raw.githubusercontent.com/Mobulos/multi-install/develop/multi-install-beta.sh -o multi-install-beta.sh.1
			# wget https://raw.githubusercontent.com/Mobulos/multi-install/develop/multi-install-beta.sh
			sleep 2
			echo "$reset"
			mv multi-install-beta.sh.1 multi-install-beta.sh
			clear
			log_success "Das Update wurde Erfolgreich heruntergeladen!"
			sleep 1
			chmod +x multi-install-beta.sh
		./multi-install-beta.sh
      exit
      ;;
    N | n)
      rm 20*
      clear
      echo "Du erhältst weiterhin die offizielle Version!"
      sleep 3
      ./$file
      exit
      ;;
    *)
      clear
      read -n1 "Eingabe nicht erkannt"
      jumpto settings
      exit
      ;;
    esac

  fi
}

#   _   _   ____    ____       _      _____   _____ 
#  | | | | |  _ \  |  _ \     / \    |_   _| | ____|
#  | | | | | |_) | | | | |   / _ \     | |   |  _|  
#  | |_| | |  __/  | |_| |  / ___ \    | |   | |___ 
#   \___/  |_|     |____/  /_/   \_\   |_|   |_____|
                                                  


function update () {
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
		rm $file
		curl --progress-bar https://raw.githubusercontent.com/Mobulos/multi-install/develop/multi-install-beta.sh -o $file.1
		# wget https://raw.githubusercontent.com/Mobulos/multi-install/develop/multi-install-beta.sh
		sleep 2
		echo "$reset"
		rm $file
		mv $file.1 $file
		clear
		log_success "Das Update wurde Erfolgreich heruntergeladen!"
		sleep 1
		chmod +x $file
	fi
	touch "$(date +%Y-%m-%d)"
	./$file

}

#   ____     ___     ___    _   _ 
#  / ___|   / _ \   / _ \  | \ | |
#  \___ \  | | | | | | | | |  \| |
#   ___) | | |_| | | |_| | | |\  |
#  |____/   \___/   \___/  |_| \_|
                                


function soon () {
	clear
	log_warning "Diese Funktion wird später hinzugefügt!"
	read -n1
	clear
	menue
}



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
	for i in curl wget sudo screen
	do
		apt-get install $i -y
		clear
	done
	update
fi

menue
exit
