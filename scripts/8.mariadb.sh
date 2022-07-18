#!/bin/sh
current_user="$(whoami)"

Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

BREW_PREFIX=$(brew --prefix)



echo "8. Install MariaDB"
if test $(which brew); then
  if [ ! -f $BREW_PREFIX/bin/mariadb ]; then
    brew install mariadb
    brew services start mariadb

    sudo $BREW_PREFIX/bin/mariadb-secure-installation
  fi
  
  echo "$Yellow"
  echo "Reset root password in case of any error$Color_Off"
  echo "$Red"
  echo "brew services stop mariadb"
  echo "mysqld --skip-grant-tables --user=mysql &"
  echo "$Color_Off"
  echo "$Yellow"
  echo "Now open another Terminal windows and connect to mariadb$Color_Off"
  echo "$Red"
  echo "mysql"
  echo "> FLUSH PRIVILEGES;"
  echo "> ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';" # Change password to 'root'
  echo "> exit"
  echo "brew services restart mariadb" 
  echo "$Color_Off"

  echo "$Yellow"
  echo "Run the following commands to fix default root password$Color_Off"
  echo "$Red"
  echo "brew services start mariadb"
  echo "sudo mariadb -u root -p'CURRENT_PASS'" # We need current pass if the password has been changed
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';" # Change password to 'root'
  echo "$Color_Off"

  echo "$Yellow"
  echo "Run the following commands to allow remote access$Color_Off"
  echo "$Red"
  echo "mariadb -u root -proot"
  echo "> grant all privileges on *.* to 'root'@'%' identified by 'root' with grant option; "
  echo "> FLUSH PRIVILEGES;"
  echo "> exit"
  echo "brew services restart mariadb"

  if [ ! -d "/Applications/Sequel Ace.app" ]; then
    brew install sequel-ace
  fi
else
  echo "$Red"
  echo "Homebrew is NOT installed! Exit now. $Color_Off"
  exit 1
fi

