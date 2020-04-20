#!/bin/bash
# Init

# root check
FILE="/tmp/out.$$"
GREP="/bin/grep"
if [ "$(id -u)" != "0" ]; then
  echo "Das Script muss als root gestartet werden." 1>&2
  exit 1
fi

apt-get install sudo || :
sudo apt-get install curl
clear
curl --progress-bar https://raw.githubusercontent.com/Mobulos/multi-install/master/multi-install.sh --output multi-install.sh
read -t 1
chmod +x multi-install.sh
clear
./multi-install.sh