#!/bin/bash
# Init

# LADE DAS LOG FEATURE
rm .log4bash.sh
clear
curl --progress-bar https://raw.githubusercontent.com/Mobulos/multi-install/master/log4bash.sh -o .log4bash.sh
chmod +x .log4bash.sh
source .log4bash.sh
clear


############################################
################# CHANGE ###################
ver=1.3.2
dat=30.08.2021
betafile=multi-install-beta.sh



# Version can be public or beta
version="public"
if [ "$version" == "public" ]; then
	link="https://raw.githubusercontent.com/Mobulos/multi-install/master/multi-install.sh"
	file=multi-install.sh
	continue
elif [ "$version" == "beta" ]; then
	link="https://raw.githubusercontent.com/Mobulos/multi-install/developer/multi-install-beta.sh"
	file=multi-install-beta.sh
	continue
else
	echo
	echo
	echo
	log_warning "Ein Fehler ist aufgetreten!"
	log_error "Die Version konnte nicht erkannt werden"
	echo
	echo 'Bitte erstelle ein "issue" auf GitHub "https://github.com/Mobulos/multi-install/issues"'
	sleep 2
	log_warning "Das Script wird beendet!"
	exit 0
fi

### INSTALL ###
debianinstall="curl wget sudo screen dialog"
linuxinstall="curl wget sudo screen dialog"
### INSTALL ###

files="202* .debian .dev .log4bash.sh .version java nano install essentials"
essentialslist="htop nano speedtest-cli"
deletefilesonclose="java nano install essentials"

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
tput1=($(tput setaf 1))
tput2=($(tput setaf 2))
tput3=($(tput setaf 3))
tput4=($(tput setaf 4))
tput5=($(tput setaf 5))
tput6=($(tput setaf 6))
tput7=($(tput setaf 7))
tput8=($(tput setaf 8))
tput9=($(tput setaf 9))





function check () {
	if [ -f betafile ]; then
		log_error "Die Developer Version des Scripts wird zurzeit nicht unterstützt!"
	fi
}


#   ____    ____    _____ 
#  |  _ \  |  _ \  | ____|
#  | |_) | | |_) | |  _|  
#  |  __/  |  _ <  | |___ 
#  |_|     |_| \_\ |_____|

function pre () {
		for i in $deletefilesonclose
	do
		screen -dmS delete rm $i || :
	done
	echo "$yellow##########################################"
	sleep .1
	echo "#### Multi-Install  Script By Mobulos ####"
	sleep .1
	echo "##########################################"
	sleep .1
	echo
	echo "$reset""Version $ver"
	#echo "$red""[DEVELOPER] "$reset"Version $ver"
	echo "Update $dat"
	echo -n "$reset"
	echo
	#log_warning "Dies ist die PRE-RELEASE Version, das Script verfügt noch nicht über alle Funktionen!"
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
	echo "$tput5 [1] Installationen"

	sleep .1
	echo "$tput4 [2] Update"

	sleep .1
	echo "$tput4 [3] Einstellungen"

	sleep .1
	echo "$red [4] Exit"

	echo -n "$tput3"
	read -n1 -p "Was willst du tun?: " menbef
	clear
	echo -n "$reset"
	case $menbef in
	1)
		installation
		;;
	2)
		rm 20*
		update
		;;
	3)
		settings
		;;
	4)
		echo
		;;
	*)
		clear
		log_error "Du musst dich vertippt haben..."
		read -n1 -t2
		menue
		;;
	esac
exit 0
}



#   ____    _____   _____   _____   ___   _   _    ____   ____  
#  / ___|  | ____| |_   _| |_   _| |_ _| | \ | |  / ___| / ___| 
#  \___ \  |  _|     | |     | |    | |  |  \| | | |  _  \___ \ 
#   ___) | | |___    | |     | |    | |  | |\  | | |_| |  ___) |
#  |____/  |_____|   |_|     |_|   |___| |_| \_|  \____| |____/ 

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
	echo "[1] Linux Version"
	sleep .1
	tmp=($(tput setaf 4))
	echo -n "$tmp"
	echo "[2] Developer Updates (Nicht verfügbar)."
	sleep .1
	tmp=($(tput setaf 5))
	echo -n "$tmp"
	echo "[3] Script zurücksetzen"
	sleep .1
	tmp=($(tput setaf 6))
	echo -n "$red"
	echo "[4] Zurück"
	echo -n "$reset"
	read -n1 -p "Was willst du tun?: " setbef
	clear
	echo -n "$reset"
	case $setbef in
	1)
		clear
		log_warning "Um die Linux version zu ändern muss das Script über die Einstellung 'Script zurücksetzten' auf Werkeinstellungen zurückgesetzt werden."
		sleep 5
		echo
		echo
		settings
		exit 0
	;;
	2)
		clear
		log_error "Developer Updates sind zurzeit nicht verfügbar!"
		exit 1
		developer
		exit 0
	;;
	3)
		clear
		log_warning "Es werden alle Daten zurückgesetzt"
		log_warning 'Der vorgang kann innerhalb 10 SEKUNDEN ( "Strg" + "c") ABGEBROCHEN werden!'
		sleep 10
		clear
		for i in $files
		do
			rm $i || :
			clear
		done
		log_success "Das Script wurde erfolgreich zurückgesetzt!"
		exit 0
	;;
	4)
		menue
		echo
	;;
	*)
		clear
		log_error "Du musst dich vertippt haben..."
		read -n1 -t2
		settings
		echo
	;;
	esac
}


#   ___   _   _   ____    _____      _      _       _          _      _____   ___    ___    _   _ 
#  |_ _| | \ | | / ___|  |_   _|    / \    | |     | |        / \    |_   _| |_ _|  / _ \  | \ | |
#   | |  |  \| | \___ \    | |     / _ \   | |     | |       / _ \     | |    | |  | | | | |  \| |
#   | |  | |\  |  ___) |   | |    / ___ \  | |___  | |___   / ___ \    | |    | |  | |_| | | |\  |
#  |___| |_| \_| |____/    |_|   /_/   \_\ |_____| |_____| /_/   \_\   |_|   |___|  \___/  |_| \_|
                                                                                                
                                                                                                                              


installation () {
	rm install || :
	clear

	while true; do
		sleep .5
		echo "Auswahlmöglichkeiten:"

		sleep .1
		echo "$tput5 [1] Nano"

		sleep .1
		echo "$tput4 [2] Java"

		sleep .1
		echo "$tput5 [3] Essentials"

		sleep .1
		echo "$red [9] Exit"

		echo -n "$tput3"
		read -n1 -p "Was willst du installieren?: " insmen
		clear
		echo -n "$reset"
		case $insmen in
		1)
			touch nano
			break
		;;
		2)
			touch java
			break
		;;
		3)
			touch essentials
			break
		;;
		9)
			clear
			log_warning "Das Script wird beendet!"
			exit 0
		;;
		*)
			clear
			log_error "Du musst dich vertippt haben..."
			read -n1 -t2
		;;
		esac
	done
	
 	# NANO

	if [ -f "nano" ]; then
		clear
		if [ -f ".debian" ]; then
apt -qq list nano | grep -v "installed" | awk -F/ '{print $1}' > /root/list.txt
			packages=$(cat /root/list.txt)
			grep -q '[^[:space:]]' < /root/list.txt
			CHECK_LIST=$?
			if [ $CHECK_LIST -eq 1 ]; then
				log_warning "Du hast Nano bereits installiert!"
				read -n1 -t5
				else
				apt-get  install -y nano
apt -qq list nano | grep -v "installed" | awk -F/ '{print $1}' > /root/list.txt
				packages=$(cat /root/list.txt)
				grep -q '[^[:space:]]' < /root/list.txt
				CHECK_LIST=$?
				if [ $CHECK_LIST -eq 1 ]; then
					clear
					log_success "Nano wurde Erfolgreich installiert!"
					sleep 2
				else
					error_state="state= install >> Nano >> not correctly installed"
					error
				fi
			fi
		else
		log_warning "Die installation von Nano steht noch nicht für dein System zur verfügung!"
		read -n1
		fi
	else
	echo
	fi
	
		# JAVA

	if [ -f "java" ]; then
		clear
		if [ -f ".debian" ]; then
apt -qq list default-jre | grep -v "installed" | awk -F/ '{print $1}' > /root/list.txt
			packages=$(cat /root/list.txt)
			grep -q '[^[:space:]]' < /root/list.txt
			CHECK_LIST=$?
			if [ $CHECK_LIST -eq 1 ]; then
				log_warning "Du hast Java bereits installiert!"
				sleep 5
			else
				apt-get  install -y default-jre
apt -qq list default-jre | grep -v "installed" | awk -F/ '{print $1}' > /root/list.txt
				packages=$(cat /root/list.txt)
				grep -q '[^[:space:]]' < /root/list.txt
				CHECK_LIST=$?
				clear
				if [ $CHECK_LIST -eq 1 ]; then
					log_success "Java wurde Erfolgreich installiert!"
					sleep 2
				else
					error_state="state= install >> Java >> not correctly installed"
					error
					sleep 2
				fi
			fi
		else
			log_warning "Die installation von Java steht noch nicht für dein System zur verfügung!"
			read -n1 -t1
		fi
	fi

	# ESSENTIALS
	if [ -f "essentials" ]; then
		clear
		echo "Es werden follgende Pakete installiert:"
		sleep .1
		echo
		for i in $essentialslist
		do
			sleep .1
			echo $i
		done
		echo
		sleep .5
		read -n1 -p "Sollen diese installiert werden? (Y|N)" essins
		case $essins in
		y|Y|j|J)
			clear
			for i in $essentialslist
			do
				apt-get install -y $i
			done
			clear
			log_warning "Es wird kein installations-check ausgeführt."
			echo "Die installation wurde beendet"
		;;
		N|n)
			clear
			log_warning "Die Pakete werden NICHT installiert und das Script wird beendet."
		;;
		esac
	fi
for i in $deletefilesonclose
do
	screen -dmS delete rm $i || :
done
exit 0
}

#   ____    _____  __     __  _____   _        ___    ____    _____   ____  
#  |  _ \  | ____| \ \   / / | ____| | |      / _ \  |  _ \  | ____| |  _ \ 
#  | | | | |  _|    \ \ / /  |  _|   | |     | | | | | |_) | |  _|   | |_) |
#  | |_| | | |___    \ V /   | |___  | |___  | |_| | |  __/  | |___  |  _ < 
#  |____/  |_____|    \_/    |_____| |_____|  \___/  |_|     |_____| |_| \_\

developer () {
	clear
	if [ -f ".dev" ]; then
		echo "Du erhälst bereits die Developer Version (fast)"
		echo
		read -n1 -p "Möchtest du zuräck zur release Version (slow) [Y/N] " versionl
		case $versionl in
			Y | y | J | j)
				# DEVOLOPER STAY
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
				exit 0
			;;
			N | n)
				clear
				echo "Du erhälstst weiterhin Developer Updates."
				sleep 3
				./$file
				exit 0
				;;
				*)
				clear
				read -n1 "Eingabe nicht erkannt"
				jumpto settings
				exit 0
			;;
		esac
  else
    read -n1 -p "Möchtest du jetzt die Developer-Version erhalten?(fast) (Y/N) " versionj
    case $versionj in
    Y | y | j | J)
		touch .dev
		rm 20*
		clear
		echo "Du erhälst ab jetzt die neuste (Alpha) Version!"
		sleep 3
		# SWITCH TO DEVELOPER
		touch "$(date +%Y-%m-%d)"
		rm 20*
		clear
		echo "$red Die neuste Version wird heruntergeladen"
		rm multi-install*
		curl --progress-bar https://raw.githubusercontent.com/Mobulos/multi-install/developer/multi-install-beta.sh -o multi-install-beta.sh.1
		# wget https://raw.githubusercontent.com/Mobulos/multi-install/developer/multi-install-beta.sh
		sleep 2
		echo "$reset"
		mv multi-install-beta.sh.1 multi-install-beta.sh
		clear
		log_success "Das Update wurde Erfolgreich heruntergeladen!"
		sleep 1
		chmod +x multi-install-beta.sh
		./multi-install-beta.sh
		exit 0
      ;;
    N | n)
		rm 20*
		clear
		echo "Du erhältst weiterhin die offizielle Version!"
		sleep 3
		./$file
		exit 0
      ;;
    *)
		clear
		read -n1 "Eingabe nicht erkannt"
		developer
		exit 0
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
		exit 0
	else
		# WENN HEUTE NICHT UPGEDATED GEHE WEITER
		# LÖSCHE "ZULETZT UPGEDATED" DATEI
		touch "$(date +%Y-%m-%d)"
		rm 20* || :
		clear
		echo "$red Die neuste Version wird heruntergeladen"
		rm $file
		curl --progress-bar $link -o $file.1
		sleep 2
		echo "$reset"
		rm $file
		cp $file.1 $file
		rm $file.1
		clear
		log_success "Das Update wurde Erfolgreich heruntergeladen!"
		chmod +x $file
		touch "$(date +%Y-%m-%d)"
		sleep 1
	fi
	exit 0
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


#   _____   _                _      ____    _                    _   
#  |  ___| (_)  _ __   ___  | |_   / ___|  | |_    __ _   _ __  | |_ 
#  | |_    | | | '__| / __| | __|  \___ \  | __|  / _` | | '__| | __|
#  |  _|   | | | |    \__ \ | |_    ___) | | |_  | (_| | | |    | |_ 
#  |_|     |_| |_|    |___/  \__|  |____/   \__|  \__,_| |_|     \__|

# ÜBRPRÜFE OB ERSTER START
if [ -f $(date +%Y-%m*) ]; then
	# WENN NICHT ERSTER START:
	update
else
	for i in $files
	do
		rm $i || :
		clear
	done
	# WENN ERSTER START:
	# ERKENNE LINUX VERSION
		echo "Folgende Linux Version wurde erkannt:"
		echo
		echo "######################################"
		cat /etc/issue
		echo "######################################"
		echo
		echo "Welche Linux Distribution ist installiert?"
		echo "[1] Debian"
		echo "[2] Linux"
		echo "[3] Andere"
		read -n1 -p "Deine Version: " verl
		case $verl in
			1)
				clear
				read -n1 -p "Bist du dir sicher, dass du Debian hast? (Y|N)" verjn
				case $verjn in
					Y | y | j | J)
						touch .debian
						clear
						echo "Deine Version wurde nun auf Debian gestellt!"
						echo
						sleep 2
							apt-get update
							clear
							apt-get upgrade -y

							# INSTALLATION BENÖTIGTER PAKETE
							for i in $debianinstall
							do
								apt-get install $i -y
								clear
							done
							update

					;;
					N | n)
						clear
						echo "Okay, wir müssen das Script jedoch schließen!"
						sleep 3
						exit 0
					;;
				esac
			;;
			2)
				clear
				read -n1 -p "Bist du dir sicher, dass du Linux hast? (Y|N)" verjn
				case $verjn in
					Y | y | j | J)
						touch .linux
						clear
						log_success "Deine Version wurde nun auch Linux gestellt!"
						echo
						log_warning "Linux wurde bissher noch nicht getestet!"
						echo
						echo
						echo 'Wir bitten dich, fehler über Github zu melden ("https://github.com/Mobulos/multi-install/issues")!'
						sleep 10
						clear
							apt-get update
							clear
							apt-get upgrade -y

							# INSTALLATION BENÖTIGTER PAKETE
							for i in $linuxinstall
							do
								apt-get install $i -y
								clear
							done
							update


					;;
					N | n)
						clear
						echo "Okay, wir müssen das Script jedoch schließen!"
						exit 0
					;;
				esac
			;;
			3)
				echo
				log_warning "Deine Linux Versin wird noch nicht unterstützt!"
				echo 'Bitte erstelle ein "Issue" unter "https://github.com/Mobulos/multi-install/issues"!' 
				echo
				log_warning "Das Script wird nun beendet!"
				exit 0
			;;
			*)
				clear
				echo "Die Eingabe wurde nicht erkannt."
				log_warning "Das Script wird beendet!"
				exit 0
			;;
		esac

fi

#   _____                              
#  | ____|  _ __   _ __    ___    _ __ 
#  |  _|   | '__| | '__|  / _ \  | '__|
#  | |___  | |    | |    | (_) | | |   
#  |_____| |_|    |_|     \___/  |_|   


function error () {
	echo
	echo
	echo
	log_warning "Ein Fehler ist aufgetreten!"
	log_error "$state"
	echo
	echo 'Bitte erstelle ein "issue" auf GitHub "https://github.com/Mobulos/multi-install/issues"'
	sleep 2
	log_warning "Das Script wird beendet!"
	for i in $deletefilesonclose
	do
		screen -dmS delete rm $i || :
	done
	exit 0
}




menue
for i in $deletefilesonclose
do
	screen -dmS delete rm $i || :
done
exit 0