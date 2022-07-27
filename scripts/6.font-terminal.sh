#!/bin/sh

Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow



echo "6. Jetbrains Font and Terminal profile installation"
if test $(which brew); then
  if [ ! -d "$HOMEBREW_PREFIX/Caskroom/font-jetbrains-mono-nerd-font" ]; then
    brew tap homebrew/cask-fonts
    brew install font-jetbrains-mono-nerd-font
    #brew untap homebrew/cask-fonts #this will fail because we have installed font
  else
    echo "$Red"
    echo "Jetbrains Mono font is ALREADY INSTALLED! Exit now. $Color_Off"
    exit 1
  fi

  echo "$Green"
  echo "--------------------------------------------------------$Color_Off"
  echo "$Yellow"
  echo "Go to Terminal > Preferences -> Profiles"
  echo "Click ... icon and import Dracula.terminal from /Volumes/Data/macos/config/Dracula.terminal"
  echo "Select the Dracula as Default"
  echo "Change the Font to Jetbrains Mono Regular Nerd Font"
  echo "Switch to General tab and select Dracula as default profile on Statup$Color_Off"
  echo "$Green"
  echo "-------------------------------------------------------- $Color_Off"

else
  echo "$Red"
  echo "Homebrew is NOT installed! Exit now. $Color_Off"
  exit 1
fi



