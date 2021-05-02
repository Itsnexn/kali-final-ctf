#!/bin/bash
#
# This script is made only for KaliLinux
# I use this to make my vm setup easyer for ctf or some pentest stuff...
# because i use this personaly you may want to change some settings feel 
# free to add your tools =)
# 
# Shout-out to @_superhero1 # I copy pase some of code from him :) 
# Copyright (c) 2021 (@itsnexn contact me in [instagram, twitter, github])
################################################################################

clear
# Change This
UNAME="itsnexn"

RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

echo -e "${RED}Please Change username before running script${NOCOLOR}"
sleep 5
echo -e "${RED}This script should always run as root${NOCOLOR}"
echo -e "
${RED} _ _                             
(_) |_ ___ _ __   _____  ___ __  
| | __/ __| '_ \ / _ \ \/ / '_ \ 
| | |_\__ \ | | |  __/>  <| | | |
|_|\__|___/_| |_|\___/_/\_\_| |_|
${NOCOLOR}"

# Check for the root
if [[ "$USER" == "root" ]]; then
    echo -n "${YELLOW}starting the script${NOCOLOR}"
    sleep 0.3
    echo -n "."
    sleep 0.3
    echo -n "."
    sleep 0.3 
    echo -e -n ". \n\n\n\n""
else 
  echo "${RED}You are not root${NOCOLOR}"
fi
# Edit sudoers
echo -e "${GREEN}Configure sudoers...${NOCOLOR}"
echo
echo "${UNAME} ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

# Update pakages
echo -e "${GREEN}Updating package lists...${NOCOLOR}"
echo
apt-get update > /dev/null

# Install kali-everything
echo -e "${GREEN}Installing kali-everything packages... ${NOCOLOR}"
echo

# Get and install all of the kali tools and update all tools
apt-get install -qq -y kali-linux-everything > /dev/null
 
apt-get install -qq -y jq > /dev/null

# Tool for steganography
apt-get install -qq -y steghide > /dev/null
apt-get install -qq -y stegcracker > /dev/null
gem install zsteg > /dev/null
# tool for check exif data from image
apt-get install -qq -y exif > /dev/null
apt-get install -qq -y exiftool > /dev/null
apt-get install -qq -y bsdgames > /dev/null

# Install sublime text
echo -e "${GREEN}Installing SublimeText... ${NOCOLOR}"
echo
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
apt-get install -qq -y apt-transport-https > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt-get update -qq > /dev/null
apt-get install -qq -y sublime-text > /dev/null

# Install seclists
# sec lists is a wordlist for security
# https://github.com/danielmiessler/SecLists
echo -e "${GREEN}Installing SecLists... ${NOCOLOR}"
echo
apt install -qq -y seclists > /dev/null

# Install Ffuf
# ffuf is a great web fuzzer
# https://github.com/ffuf/ffuf
echo -e "${GREEN}Installing Ffuf... ${NOCOLOR}"
echo
apt install -qq -y ffuf > /dev/null

# Install oh-my-zsh
# make a shell better
# https://github.com/ohmyzsh/ohmyzsh
echo -e "${GREEN}Configure oh-my-zsh... ${NOCOLOR}"
echo
mkdir /opt/github 
git clone -q https://github.com/Itsnexn/itsnexn-settings.git /opt/github
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp /opt/github/itsnexn-settings/zsh/R3verse.zsh-theme ~/.oh-my-zsh/themes 
cat /opt/github/itsnexn-settings/zsh/R3verse.zsh-theme > ~/.zshrc

# Configure vim theme
# it works well for me
echo -e "${GREEN}Configure Vim theme... ${NOCOLOR}"
echo
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone -q https://github.com/dracula/vim.git dracula
touch ~/.vimrc
echo -e 'packadd! dracula\n' >> ~/.vimrc
echo -e 'syntax enable\n' >> ~/.vimrc
echo -e 'colorscheme dracula' >> ~/.vimrc

# Add some git settings
# enable git cache
echo -e "${GREEN}Adding Git cache...${NOCOLOR}"
echo
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

# Configure tmux config
# Add keyboard shortcuts and some settings
echo -e "${GREEN}Configure Tmux... ${NOCOLOR}"
echo
git clone -q https://github.com/Itsnexn/itsnexn-settings.git /opt/github
cp /opt/github/itsnexn-settings/tmux/.tmux.conf ~/

# Grep some usful scripts
echo -e "${GREEN}Grabbing useful scripts... ${NOCOLOR}"
echo
cd /opt/

# Git research tool
git clone -q https://github.com/internetwache/GitTools.git 

# Unprivileged Linux process snooping
git clone -q https://github.com/DominicBreuker/pspy.git

# PentestMonkey PHP R3verse shell
git clone -q https://github.com/pentestmonkey/php-reverse-shell.git

# OSINT tool on Instagram to collect, analyze, and run reconnaissance.
git clone -q https://github.com/Datalux/Osintgram.git

# Linux Enumeration & Privilege Escalation Checks
git clone -q https://github.com/rebootuser/LinEnum.git

# PEAS sound familiar right???
git clone -q https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git

# Phishing tool
# git clone -q https://github.com/suljot/shellphish.git

# John the ripper
git clone -q https://github.com/openwall/john.git
mv john johnTheRipper

# A java steganography tool
wget http://www.caesum.com/handbook/Stegsolve.jar -O stegsolve.jar
chmod +x stegsolve.jar

# Pwncat shell staiblizer
git clone https://github.com/calebstewart/pwncat.git
cd pwncat
python3 setup.py install

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

