#!/bin/sh
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow


MAC_MODEL=$(sysctl hw.model | cut -f2- -d:)
echo "5. Required applications installation"
if test $(which brew); then
  if [ ! -d "/Applications/Visual Studio Code.app" ]; then
    echo "$Green"
    echo "Installing Visual Studio Code... $Color_Off" 
    brew install visual-studio-code
  fi
  if [ ! -d "/Applications/iStat Menus.app" ]; then
    echo "$Green"
    echo "Installing iStat Menus... $Color_Off" 
     brew install istat-menus
  fi
  
  if [ ! -d "/Applications/OpenKey.app" ]; then
    echo "$Green"
    echo "Installing Openkey... $Color_Off" 
    brew install openkey
  fi
  echo "$Green"
  echo "----------------------------"
  echo "iStart Menu activation info: "
  echo "Email: 982092332@qq.com"
  echo "Serial: GAWAE-FCWQ3-P8NYB-C7GF7-NEDRT-Q5DTB-MFZG6-6NEQC-CRMUD-8MZ2K-66SRB-SU8EW-EDLZ9-TGH3S-8SGA"
  echo "----------------------------"
  echo "$Color_Off"

else
  echo "$Red"
  echo "Homebrew is NOT installed! $Color_Off"
fi