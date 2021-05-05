#!/bin/sh

Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

ACTION="$1"

BREW_PREFIX=$(brew --prefix)

if [ "$ACTION" == "httpd" ]; then
  code $BREW_PREFIX/etc/httpd/httpd.conf
elif [ "$ACTION" == "vhosts" ]; then
  code $BREW_PREFIX/etc/httpd/extra/httpd-vhosts.conf
fi