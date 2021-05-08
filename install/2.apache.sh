#!/bin/sh
CURRENT_USER="$(whoami)"

Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

BREW_PREFIX=$(brew --prefix)
mkdir -p /Users/$CURRENT_USER/PHPProjects

echo "2. Dnsmasq and Apache installation"
if test $(which brew); then
  if [ ! -d "/Applications/Visual Studio Code.app" ]; then
    brew install visual-studio-code
  fi
  if [ ! -f $BREW_PREFIX/sbin/dnsmasq ]; then
    echo "$Green"
    echo "Install Dnsmasq to auto resolve to localhost$Color_Off"
    brew install dnsmasq
    echo 'address=/.test/127.0.0.1' > $BREW_PREFIX/etc/dnsmasq.conf
  fi
  
  if [ ! -f $BREW_PREFIX/bin/httpd ]; then
    echo "$Green" 
    echo "Install apache and process config files$Color_Off"
    sudo apachectl stop
    sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null

    brew install httpd

    sudo mkdir -v /etc/resolver
    sudo brew services start dnsmasq
    sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
    

    sudo brew services start httpd

    mv $BREW_PREFIX/etc/httpd/httpd.conf $BREW_PREFIX/etc/httpd/httpd.conf.bak
    mv $BREW_PREFIX/etc/httpd/extra/httpd-vhosts.conf $BREW_PREFIX/etc/httpd/extra/httpd-vhosts.conf.bak

    cp -rf ~/mlmampro/config/httpd.conf $BREW_PREFIX/etc/httpd/httpd.conf
    cp -rf ~/mlmampro/config/httpd-vhosts.conf $BREW_PREFIX/etc/httpd/extra/httpd-vhosts.conf

    sed -i '' "s|current_user|$CURRENT_USER|g" $BREW_PREFIX/etc/httpd/httpd.conf
    sed -i '' "s|brew_prefix|$BREW_PREFIX|g" $BREW_PREFIX/etc/httpd/httpd.conf
    sed -i '' "s|current_user|$CURRENT_USER|g" $BREW_PREFIX/etc/httpd/extra/httpd-vhosts.conf

  fi

  echo "$Green"
  echo "If permission warning occurred we need to run the following commands: $Color_Off"
  echo "$Red"
  echo "sudo chown -R $CURRENT_USER $BREW_PREFIX/share/man/man8"
  echo "chmod u+w $BREW_PREFIX/share/man/man8"
  echo "$Color_Off"
else
  echo "$Red"
  echo "Homebrew is NOT installed! Exit now. $Color_Off"
  exit 1
fi
