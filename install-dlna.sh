#!/bin/bash
clear
######here  all the variables#######################################################################################
apps="dialog" #add here your application
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
vi_editor=${EDITOR-nano}

# trap and delete temp files
trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM

#
# Purpose - display output using msgbox
#  $1 -> set msgbox height
#  $2 -> set msgbox width
#  $3 -> set msgbox title
#
function display_output(){
	local h=${1-20}			# box height default 10
	local w=${2-41} 		# box width default 41
	local t=${3-Output} 	# box title
	dialog --backtitle "Linux Shell Script Tutorial" --title "${t}" --clear --msgbox "$(<$OUTPUT)" ${h} ${w}
}

function menu_install() {
  sudo apt install minidlna -y
}
function menu_edit() {
  sudo nano /etc/minidlna.conf
}
function menu_rescan() {
  sudo systemctl restart minidlna
}

#
# set infinite loop
#
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Mr. Phil Install Menu" \
--title "[ M A 1 N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key.
Choose the TASK" 15 50 4 \
Install "Install the miniDLNA Service" \
Edit "Edit the miniDLNA config" \
Rescan "Rescan the miniDLNA service" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
  Install) menu_install;;
  Edit) menu_edit;;
  Rescan) menu_rescan;;
	Exit)   break;;
esac

done

# if temp files found, delete em
[ -f $OUTPUT ] && rm $OUTPUT
[ -f $INPUT ] && rm $INPUT
