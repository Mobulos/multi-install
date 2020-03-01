#!/bin/bash
# Init

# LADE "jumpto"

function jumpto() {
	label=$1
	cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
	eval "$cmd"
	exit
}

# LEGE JUMPTOs AN
menue=${1:-"menue"}
update=${2:-"update"}
# ---=${3:-"---"}
# ---=${4:-"---"}
# ---=${5:-"---"}
# ---=${6:-"---"}
# ---=${7:-"---"}
# ---=${8:-"---"}
# ---=${9:-"---"}
# ---=${10:-"---"}
# ---=${11:-"---"}

# LADE DAS LOG FEATURE
rm log4bash.sh
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
	clear
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
fi

# DAS MENÜ

$2:
log_success "test"
echo hi
exit

# UPDATE DAS SCRIPT
$1:
# CHECK, OB DAS SCRIPT HEUTE UPGEDATED WURDE
if [ -f $(date +%Y-%m-%d) ]; then
	# WENN HEUTE BEREITS UPGEDATED GEHE ZUM MENÜ
	jumpto menue
elif [[ * ]]; then
	# WENN HEUTE NICHT UPGEDATED GEHE WEITER
	# LÖSCHE "ZULETZT UPGEDATED" DATEI
	touch "$(date +%Y-%m-%d)"
	rm 20*
	clear
	echo "$red Die neuste Version wird heruntergeladen"
	curl --progress-bar https://raw.githubusercontent.com/Mobulos/multi-install/master/multi-install.sh -o multi-install.sh
	# wget https://raw.githubusercontent.com/Mobulos/multi-install/master/multi-install.sh
	echo "$reset"
	read -t0.5
	chmod +x multi-install.sh
fi
touch "$(date +%Y-%m-%d)"
./multi-install.sh
