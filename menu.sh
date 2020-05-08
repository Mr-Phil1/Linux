#!/bin/bash
######here  all the variables#######################################################################################
apps="git curl dialog" #add here your application
ohmyzsh="https://raw.githubusercontent.com/Mr-Phil1/Linux/master/install-zsh.sh" #path to my zsh install script
zshconfig="" #path to my .zshrc config
####################################################################################################################

#this is the auto-install routine
if [ $(dpkg-query -W -f='${Status}' $apps 2>/dev/null  | grep -c "ok installed") -eq 0 ];
then
  echo "Install $apps"
  sudo apt install $apps -y;
fi

#dont touch this#
cmd=(dialog --separate-output --checklist "Select options:" 22 75 13)
options=(
    1 "System Update" on
    2 "Install Oh-my-Zsh" off
    3 "Install Neofetch" off
    4 "Remove ZSH + Oh-my-Zsh" off
    5 "Make my .zshrc conf" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
          echo "sys update"
      			sudo apt-get update -y && sudo apt-get upgrade -y
          clear
            ;;
        2)
          echo "Oh-my-ZSH"
    		  	sh -c "$(curl -fsSL $ohmyzsh)"
            ;;
        3)
          echo "Neofetch"
    		  	sudo apt install neofetch -y
            ;;
        4)
          echo "Remove Zsh + Oh-my-Zsh"
            sudo apt purge zsh
            sudo rm -r ${HOME}/.oh-my-zsh
            ;;
        5)
          echo "conf"
            sh -c "$(curl -fsSL $zshconfig)"
          ;;

    esac
done
