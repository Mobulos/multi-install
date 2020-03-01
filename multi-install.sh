#!/usr/bin/env bash

# LADE DAS LOG FEATURE
curl --progress-bar https://raw.githubusercontent.com/Mobulos/multi-install/master/log4bash.sh --output log4bash.sh
chmod +x log4bash.sh
source log4bash.sh
clear

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
if [ -f $(date +%Y*) ]; then
  # WENN NICHT ERSTER START:
  jumpto update
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
  jumpto update
fi

# UPDATE DAS SCRIPT
update:
# CHECK, OB DAS SCRIPT HEUTE UPGEDATED WURDE
if [ -f $(date +%Y-%m-%d) ]; then
  # WENN HEUTE BEREITS UPGEDATED GEHE ZUM MENÜ
  jumpto menue
elif [[ * ]]; then
  # WENN HEUTE NICHT UPGEDATED GEHE WEITER
  clear
fi
read -t 2 -n 1
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
read -t 1
chmod +x multi-install.sh
./multi-install.sh
exit

# DAS MENÜ
menue:
log_success test
exit
