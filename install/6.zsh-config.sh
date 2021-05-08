#!/bin/sh
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

CURRENT_USER="$(whoami)"

echo "6. Oh-My-Zsh config and plugins installation"
if [ -f ~/.oh-my-zsh/README.md ]; then
  echo "$Green"
  echo "Updating zsh config...$Color_Off"

  if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]; then
    echo "$Green"
    echo "Installing zsh-completions...$Color_Off"
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
  fi

  if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    echo "$Green"
    echo "Installing zsh-autosuggestions$Color_Off"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  fi

  if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    echo "$Green"
    echo "Installing zsh-syntax-highlighting$Color_Off"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  fi

  CHECKFILE=/Users/$CURRENT_USER/mlmampro/config/develop.zsh

  if [ -f "$CHECKFILE" ]; then
    if [ ! -f ~/.oh-my-zsh/custom/develop.zsh ]; then
      echo "$Green"
      echo "Linking config...$Color_Off"
      cp -rfv ~/mlmampro/config/develop.zsh ~/mlmampro/config/develop.zsh.bak
      sed -i '' "s|current_user|$CURRENT_USER|g" ~/mlmampro/config/develop.zsh
      mv -v ~/mlmampro/config/develop.zsh ~/.oh-my-zsh/custom/develop.zsh
      mv -v ~/mlmampro/config/develop.zsh.bak ~/mlmampro/config/develop.zsh
    fi
  else
    echo "$Red"
    echo "~/mlmampro/config/develop.zsh is NOT FOUND! $Color_Off"
  fi

else
  echo "$Red"
  echo "Oh-My-Zsh is NOT INSTALLED! Exit now. $Color_Off"
  exit 1
fi

