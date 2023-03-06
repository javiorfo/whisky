##!/usr/bin/env bash
# Author: Javier Orfo

echo -e "\033[0;37m"
echo -e " _   _            _        "
echo -e "| \ | |_   _  ___| |_ __ _ "
echo -e "|  \| | | | |/ __| __/ _` |"
echo -e "| |\  | |_| | (__| || (_| |"
echo -e "|_| \_|\__, |\___|\__\__,_|"
echo -e "       |___/               "
echo -e "\033[0m"

# Required
echo "nycta ==> Checking packages needed..."
sudo pacman -S --needed dmenu pamixer pulseaudio-alsa feh alacritty ttf-ubuntu-mono-nerd polybar
yay -S --needed leftwm lux

# Function to copy Leftwm
copy_leftwm() {
    echo "nycta ==> Checking and copying Leftwm folders..."

    rm -drf ~/.config/leftwm
    cp -dr leftwm ~/.config

    echo "nycta ==> Done! Log out and start Leftwm!"
}

# Keyboard LATAM config
if [ ! -e /etc/X11/xorg.conf.d/00-keyboard.conf ]; then
    while true; do
        echo -e "nycta ==> Do you want to set 00-keyboard.conf LATAM configuration? [y/n]"
        read
        case $REPLY in 
            [Yy] ) echo "nycta ==> Copying keyboard LATAM configuration...";
                   sudo cp xorg/00-keyboard.conf /etc/X11/xorg.conf.d/;
                   echo "nycta ==> 00-keyboard.conf copied!";
                break;;
            [Nn] ) 
                        break;;
            * ) echo -e "\033[0;31mleft ==> Invalid response. Please, try again\033[0m";;
        esac
    done
fi

# Validate existing Leftwm configuration
if [ -d ~/.config/leftwm ]; then
        while true; do
            echo -e "\033[0;33mnycta ==> Leftwm configuration already exists in your home directory. "
            echo -e "\033[0;33mnycta ==> This action will delete it. Do you want to continue? [y/n]\033[0m"
            read

            case $REPLY in 
                [Yy] ) copy_leftwm;
                    break;;
                [Nn] ) echo "nycta ==> process canceled!";
                    exit;;
                * ) echo -e "\033[0;31mnycta ==> Invalid response. Please, try again\033[0m";;
            esac
        done
    else
        copy_lefwm
fi
