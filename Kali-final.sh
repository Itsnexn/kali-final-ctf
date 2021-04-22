#!/bin/bash
#
# This script is made only for KaliLinux
# 
# Shout-out to @_superhero1 # I copy pase some of code from him :) 
# Copyright (c) 2021 (@itsnexn contact me in [instagram, twitter, mail, github])
################################################################################

clear
# Change This
UNAME="itsnexn"

RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

echo -e "${RED}This script should always run as root${NOCOLOR}"
echo -e "
${RED} _ _                             
(_) |_ ___ _ __   _____  ___ __  
| | __/ __| '_ \ / _ \ \/ / '_ \ 
| | |_\__ \ | | |  __/>  <| | | |
|_|\__|___/_| |_|\___/_/\_\_| |_|
${NOCOLOR}"

# Edit sudoers
echo -e "${GREEN}Configure sudoers...${NOCOLOR}"
echo
echo "# Allow user use sudo without passwd" | sudo tee -a /etc/sudoers
echo "${UNAME} ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

# Update pakages
echo -e "${GREEN}Updating package lists...${NOCOLOR}"
echo
apt-get update -qq > /dev/null

# Install kali-everything
echo -e "${GREEN}Installing kali-everything packages... ${NOCOLOR}"
echo
apt-get install -qq -y kali-everything > /dev/null
apt-get install -qq -y jq > /dev/null
apt-get install -qq -y steghide > /dev/null
apt-get install -qq -y stegseek > /dev/null
apt-get install -qq -y stegcracker > /dev/null
apt-get install -qq -y exif > /dev/null
apt-get install -qq -y exiftool > /dev/null


# Install sublime text
echo -e "${GREEN}Installing SublimeText... ${NOCOLOR}"
echo
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
apt-get install -qq -y apt-transport-https > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt-get update -qq > /dev/null
apt-get install -qq -y sublime-text > /dev/null

# Install seclists
echo -e "${GREEN}Installing SecLists... ${NOCOLOR}"
echo
apt install -qq -y seclists > /dev/null

# Install Ffuf
echo -e "${GREEN}Installing Ffuf... ${NOCOLOR}"
echo
apt install -qq -y ffuf > /dev/null

# Install oh-my-zsh
echo -e "${GREEN}Configure oh-my-zsh... ${NOCOLOR}"
echo
mkdir /opt/github 
git clone -q https://github.com/Itsnexn/itsnexn-settings.git /opt/github
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp /opt/github/itsnexn-settings/zsh/R3verse.zsh-theme ~/.oh-my-zsh/themes 
cat /opt/github/itsnexn-settings/zsh/R3verse.zsh-theme > ~/.zshrc

# Configure vim theme
echo -e "${GREEN}Configure Vim theme... ${NOCOLOR}"
echo
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone -q https://github.com/dracula/vim.git dracula
touch ~/.vimrc
echo 'packadd! dracula' > ~/.vimrc
echo 'syntax enable' > ~/.vimrc
echo 'colorscheme dracula' > ~/.vimrc

# Add some git settings
echo -e "${GREEN}Adding Git cache...${NOCOLOR}"
echo
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

# Configure tmux config
echo -e "${GREEN}Configure Tmux... ${NOCOLOR}"
echo
git clone -q https://github.com/Itsnexn/itsnexn-settings.git /opt/github
cp /opt/github/itsnexn-settings/tmux/.tmux.conf ~/

# Grep some usful scripts
echo -e "${GREEN}Grabbing useful scripts... ${NOCOLOR}"
echo
cd /opt/
git clone -q https://github.com/internetwache/GitTools.git 
git clone -q https://github.com/DominicBreuker/pspy.git
git clone -q https://github.com/pentestmonkey/php-reverse-shell.git
git clone -q https://github.com/Datalux/Osintgram.git
git clone -q https://github.com/rebootuser/LinEnum.git
git clone -q https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git
git clone -q https://github.com/suljot/shellphish.git
git clone -q https://github.com/openwall/john.git
mv john johnTheRipper
wget http://www.caesum.com/handbook/Stegsolve.jar -O stegsolve.jar
chmod +x stegsolve.jar

# Add useful links to /opt
echo -e "${GREEN}Add useful links to /opt/... ${NOCOLOR}"
echo
ln -s /usr/share/wordlists /opt/
ln -s /usr/share/seclists /opt/
ln -s /usr/share/webshells/php /opt/

# Final words
echo
echo
echo -e "${GREEN}Done! :)${NOCOLOR}"
echo
echo -e "To upgrade existing packages run (optional): ${RED}apt upgrade${NOCOLOR}"
#gsettings set org.gnome.desktop.interface gtk-theme 
#gsettings set org.gnome.desktop.wm.preferences theme 

