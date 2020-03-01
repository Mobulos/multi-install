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
update=${1:-"update"}
menue=${2:-"menue"}
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
curl --progress-bar https://raw.githubusercontent.com/Mobulos/multi-install/master/log4bash.sh --output log4bash.sh
chmod +x log4bash.sh
source log4bash.sh
clear

# ROOT CHECK
FILE="/tmp/out.$$"
GREP="/bin/grep"
if [ "$(id -u)" != "0" ]; then
	echo "Das Script muss als root gestartet werden." 1>&2
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
	clear
	apt-get install curl -y
	clear
	apt-get install wget -y
	clear
	apt-get install sudo -y
	clear
fi

# UPDATE DAS SCRIPT

$1:

# CHECK, OB DAS SCRIPT HEUTE UPGEDATED WURDE
if [ -f $(date +%Y-%m-%d) ]; then
	# WENN HEUTE NICHT UPGEDATED GEHE WEITER
	clear
elif [[ * ]]; then
	# WENN HEUTE BEREITS UPGEDATED GEHE ZUM MENÜ
	jumpto menue
fi
# LÖSCHE "ZULETZT UPGEDATED" DATEI
rm 20*
touch $(date +%Y-%m-%d)
clear
echo "$red Die neuste Version wird heruntergeladen"
echo "$reset"
rm multi-install.sh
echo "$red"
curl --progress-bar https://raw.githubusercontent.com/Mobulos/multi-install/master/multi-install.sh --output multi-install.sh
echo "$reset"
chmod +x multi-install.sh
./multi-install.sh
exit

# DAS MENÜ

menue:
log_success "test"
echo hi
exit
