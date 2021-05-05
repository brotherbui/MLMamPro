#!/bin/sh
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

echo "1. Brew installation"

ARCH=$(arch)
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  if [ "$ARCH" == "arm64" ]; then #this is for M1
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  brew doctor
else
  echo "$Red"
  echo "Homebrew is already installed! Exit now! $Color_Off"
  exit 1
fi


