##!/usr/bin/env bash
# Author: Javier Orfo

echo -e "\033[0;33m"
echo -e "  _   _            _     __        ____  __ "
echo -e " | \ | |_   _  ___| |_ __\ \      / /  \/  |"
echo -e " |  \| | | | |/ __| __/ _ \ \ /\ / /| |\/| |"
echo -e " | |\  | |_| | (__| || (_) \ V  V / | |  | |"
echo -e " |_| \_|\__, |\___|\__\___/ \_/\_/  |_|  |_|"
echo -e "        |___/                               "
echo -e "\033[0m"

# Required
echo "nyctowm ==> Checking packages needed..."
sudo pacman -S --needed dmenu pamixer pulseaudio-alsa feh alacritty ttf-ubuntu-mono-nerd polybar
yay -S --needed leftwm lux

# Function to copy Leftwm
copy_leftwm() {
    echo "nyctowm ==> Checking and copying Leftwm folders..."

    rm -drf ~/.config/leftwm
    cp -dr leftwm ~/.config

    echo "nyctowm ==> Done! Log out and start NyctoWM!"
}

# Keyboard LATAM config
if [ ! -e /etc/X11/xorg.conf.d/00-keyboard.conf ]; then
    while true; do
        echo -e "nyctowm ==> Do you want to set 00-keyboard.conf LATAM configuration? [y/n]"
        read
        case $REPLY in 
            [Yy] ) echo "nyctowm ==> Copying keyboard LATAM configuration...";
                   sudo cp xorg/00-keyboard.conf /etc/X11/xorg.conf.d/;
                   echo "nyctowm ==> 00-keyboard.conf copied!";
                break;;
            [Nn] ) 
                        break;;
            * ) echo -e "\033[0;31mnyctowm ==> Invalid response. Please, try again\033[0m";;
        esac
    done
fi

# Validate existing Leftwm configuration
if [ -d ~/.config/leftwm ]; then
        while true; do
            echo -e "\033[0;33mnyctowm ==> Leftwm configuration already exists in your home directory. "
            echo -e "\033[0;33mnyctowm ==> This action will delete it. Do you want to continue? [y/n]\033[0m"
            read

            case $REPLY in 
                [Yy] ) copy_leftwm;
                    break;;
                [Nn] ) echo "nyctowm ==> process canceled!";
                    exit;;
                * ) echo -e "\033[0;31mnyctowm ==> Invalid response. Please, try again\033[0m";;
            esac
        done
    else
        copy_lefwm
fi
