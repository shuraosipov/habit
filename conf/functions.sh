#!/bin/bash
# script name : functions.sh
# purpose : store functions
# Load config
source conf/config.sh

# Define functions

# Function 1. check_root
# Check root privileges before starting script execution
function check_root() {
  local user_id
  user_id="$(id -u)"
  if [[ "$user_id" -ne '0' ]]
  then
    printf "%b" "You must be root to start this tool\n"
    exit 987
  fi
}


# Function 2. show_menfu
# Display user menu
# show menu options
function show_menu() {
  clear
  printf "%b" "====================================\n"
  printf "%b" "HABIT Main Menu\n"
  printf "%b" "====================================\n"
  printf "%b" "1. Show filesystem information\n"
  printf "%b" "2. Show block device information\n"
  printf "%b" "3. List of directories under '/' and their size\n"
  printf "%b" "4. Show disk space usage\n"
  printf "%b" "5. Show top memory & cpu eating process\n"
  printf "%b" "6. Show network config and stats\n"
  printf "%b" "7. Show operating system information\n"
  printf "%b" "8. Show users activity\n"
  printf "%b" "q for Exit\n"
  printf "%b" "\n"
  printf "%b" "s. Start HABIT service\n"
  printf "%b" "d. Stop HABIT service\n"
  printf "%b" "\n"
  read -rp "Select menu option: " answer
}


# Function 3. pause
# Keep command output in variable, display it and prompt user for next steps
function pause() {
  local message
  message="$@"
  printf "%b" "$message\n"
  read -rp "Press [Enter] to continue..."
}

# Function 4. start background service

function start_habitd() {
  if [[ -s "/etc/cron.d/habitd_service" ]];
  then
    echo "Service already started..."
    read -rp "Press [Enter] to continue..."
  else
    echo "0 7 * * * root /opt/habit/check.sh" > /etc/cron.d/habitd_service && echo "HABIT service started"
    read -rp "Press [Enter] to continue..."
  fi
}

# Function 5. stop_habitd
function stop_habitd() {
  if [[ -e "/etc/cron.d/habitd_service" ]];
  then
    rm -f /etc/cron.d/habitd_service && echo "HABIT service stopped"
    read -rp "Press [Enter] to continue..."
  else
    echo "HABIT service not started..."
    read -rp "Press [Enter] to continue..."
  fi
}