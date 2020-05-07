#!/bin/bash
if [ $(dpkg-query -W -f='${Status}' dialog 2>/dev/null  | grep -c "ok installed") -eq 0 ];
then
  echo "Install Dialog"
  sudo apt install dialog -y;
    if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null  | grep -c "ok installed") -eq 0 ];
    then
      echi "Install curl "
      sudo sudo apt-get install curl -y;
        if [ $(dpkg-query -W -f='${Status}' git 2>/dev/null  | grep -c "ok installed") -eq 0 ];
        then
          echi "Install git "
          sudo sudo apt-get install git -y;
fi
cmd=(dialog --separate-output --checklist "Select options:" 22 75 13)
options=(1 "System Update" on    # any option can be set to default to "on"
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
			sudo apt-get update -y
			sudo apt-get upgrade -y
      clear
            ;;
        2)
            echo "Oh-my-ZSH"
            if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null  | grep -c "ok installed") -eq 0 ];
            then
              echo "Install curl"
              sudo apt install curl -y;
            fi
		  	sh -c "$(curl -fsSL https://raw.githubusercontent.com/Mr-Phil1/Linux/install-script/install-zsh.sh)"
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

            if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null  | grep -c "ok installed") -eq 0 ];
            then
              echo "Install curl"
              sudo apt install curl -y;
            fi
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Mr-Phil1/Linux/install-script/zsh-conf.sh)"
                  ;;

    esac
done
