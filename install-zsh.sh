# !/bin/bash
clear
######here  all the variables#######################################################################################
apps="git curl" #add here your application
####################################################################################################################

#this is the auto-install routine
if ! dpkg -s $apps >/dev/null 2>&1; then
  sudo apt-get install $apps -y
fi

homedir=${HOME}/
cd $homedir
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp $homedir/.zshrc $homedir/.zshrc.orig
sed -i 's/robbyrussell/bira/g' $homedir/.zshrc
