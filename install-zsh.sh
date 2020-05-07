# !/bin/bash
clear
apps="git zsh curl" #add here your application 
if [ $(dpkg-query -W -f='${Status}' $apps 2>/dev/null  | grep -c "ok installed") -eq 0 ];
then
  echo "Install $apps"
  sudo apt install $apps -y;

fi
homedir=${HOME}/
cd $homedir
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp $homedir/.zshrc $homedir/.zshrc.orig
sed -i 's/robbyrussell/bira/g' $homedir/.zshrc
