#!/bin/bash
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
	local h=${1-20}			# box height default 10
	local w=${2-41} 		# box width default 41
	local t=${3-Output} 	# box title
	dialog --backtitle "Linux Shell Script Tutorial" --title "${t}" --clear --msgbox "$(<$OUTPUT)" ${h} ${w}
}
#
# Purpose - display current system date & time
#
function show_date(){
  clear
	sudo reboot now
}
#
# Purpose - display a calendar
#
function show_calendar(){
	sudo mv /home/pi/.config/lxsession/LXDE-pi/autostart /home/pi/.config/lxsession/LXDE-pi/old/autostart_`date +"%d-%m-%Y_%H.%M"`.old
  sudo rm /home/pi/.config/lxsession/LXDE-pi/autostart
}

function show_editor() {
  sudo nano /home/pi/.config/lxsession/LXDE-pi/autostart
}

#function show_old() {
#    ls /home/pi/.config/lxsession/LXDE-pi/old
#}
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
Reboot "Reboot the system" \
Remove "Remove autostart" \
Editor "Edit the autostart" \
#Old "View the old version"
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	Reboot) show_date;;
	Remove) show_calendar;;
	Editor) show_editor;;
#  Old) show_old;;
	Exit) echo "Bye"; break;;
esac

done

# if temp files found, delete em
[ -f $OUTPUT ] && rm $OUTPUT
[ -f $INPUT ] && rm $INPUT
