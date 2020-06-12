#!/bin/bash

######here  all the variables#######################################################################################
apps="git curl dialog" #add here your application
ohmyzsh="https://raw.githubusercontent.com/Mr-Phil1/Linux/master/install-zsh.sh" #path to my zsh install script
zshconfig="" #path to my .zshrc config
####################################################################################################################

#this is the auto-install routine
if ! dpkg -s $apps >/dev/null 2>&1; then
  sudo apt-get install $apps -y
fi
# utilitymenu.sh - A sample shell script to display menus on screen
# Store menu options selected by the user
INPUT=/tmp/menu.sh.$$

# Storage file for displaying cal and date command output
OUTPUT=/tmp/output.sh.$$

# get text editor or fall back to vi_editor
vi_editor=${EDITOR-nano /home/pi/.config/lxsession/LXDE-pi/autostart}

# trap and delete temp files
trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM

#
# Purpose - display output using msgbox
#  $1 -> set msgbox height
#  $2 -> set msgbox width
#  $3 -> set msgbox title
#
function display_output(){
	local h=${1-25}			# box height default 10
	local w=${2-41} 		# box width default 41
	local t=${3-Output} 	# box title
	dialog --backtitle "Linux Shell Script Tutorial" --title "${t}" --clear --msgbox "$(<$OUTPUT)" ${h} ${w}
}
#
# Purpose - display current system date & time
#
function show_update() {
    echo "System update"
    sudo apt-get update -y && sudo apt-get upgrade -y
    clear
}

function show_zsh() {
      echo "Install Oh-my-ZSH"
      sh -c "$(curl -fsSL $ohmyzsh)"
}

function show_neofetch() {
    echo "Install Neofetch"
    sudo sudo apt install neofetch -y
}

function show_remove() {
      sudo apt purge zsh
      sudo rm -r ${HOME}/.oh-my-zsh
}

function show_config() {
  echo "show .zshrc"
  cat  ${HOME}/.zshrc
}

function show_edit() {
    echo "show .zshrc"
    nano ${HOME}/.zshrc
}
#
# set infinite loop
#
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Linux Shell Script Tutorial" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 15 50 4 \
Update "Reboot the system" \
Oh-My-ZSH "Remove autostart" \
Neofetch "Edit the autostart" \
Remove "View the old version" \
Config "Get my .zshrc Config" \
Edit "Edit my .zshrc Config"
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	Update) show_update;;
	Oh-My-ZSH) show_zsh;;
	Neofetch) show_neofetch;;
  Remove) show_remove;;
  Config) show_config;;
  Edit) show_edit;;
	Exit) echo "Bye"; break;;
esac

done

# if temp files found, delete em
[ -f $OUTPUT ] && rm $OUTPUT
[ -f $INPUT ] && rm $INPUT
