#!/bin/sh
current_user="$(whoami)"

Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow



echo "2. Dnsmasq and Apache installation"
if test $(which brew); then
  if [ ! -f $HOMEBREW_PREFIX/sbin/dnsmasq ]; then
    echo "$Green"
    echo "Install Dnsmasq to auto resolve to localhost$Color_Off"
    brew install dnsmasq
    echo 'address=/.test/127.0.0.1' > $HOMEBREW_PREFIX/etc/dnsmasq.conf
  fi
  
  if [ ! -f $HOMEBREW_PREFIX/bin/httpd ]; then
    echo "$Green" 
    echo "Install apache and process config files$Color_Off"
    sudo apachectl stop
    sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null

    brew install httpd

    if [ ! -f /etc/resolver/test ]; then
      sudo mkdir -p /etc/resolver
      sudo brew services start dnsmasq
      sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
    fi
    
    sudo brew services start httpd

    mv $HOMEBREW_PREFIX/etc/httpd/httpd.conf $HOMEBREW_PREFIX/etc/httpd/httpd.conf.bak
    mv $HOMEBREW_PREFIX/etc/httpd/extra/httpd-vhosts.conf $HOMEBREW_PREFIX/etc/httpd/extra/httpd-vhosts.conf.bak

    cp -rf ~/mampro/config/httpd/httpd.conf $HOMEBREW_PREFIX/etc/httpd/httpd.conf
    cp -rf ~/mampro/config/httpd/httpd-vhosts.conf $HOMEBREW_PREFIX/etc/httpd/extra/httpd-vhosts.conf

    sed -i '' "s/currentuser/$current_user/g" $HOMEBREW_PREFIX/etc/httpd/httpd.conf
    sed -i '' "s#brew_prefix#$HOMEBREW_PREFIX#g" $HOMEBREW_PREFIX/etc/httpd/httpd.conf

     sed -i '' "s/currentuser/$current_user/g" $HOMEBREW_PREFIX/etc/httpd/extra/httpd-vhosts.conf

  fi

  echo "$Green"
  echo "If permission warning occurred we need to run the following commands: $Color_Off"
  echo "$Red"
  echo "sudo chown -R $(whoami) $HOMEBREW_PREFIX/share/man/man8"
  echo "chmod u+w $HOMEBREW_PREFIX/share/man/man8"
  echo "$Color_Off"
else
  echo "$Red"
  echo "Homebrew is NOT installed! Exit now. $Color_Off"
  exit 1
fi

