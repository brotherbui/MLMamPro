#!/bin/sh
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

app="$(basename "$0")"
phpversion="7.4"
action="$1"

BREW_PREFIX=$(brew --prefix)

opcache_conf_path="$BREW_PREFIX/etc/php/$phpversion/conf.d"
opcache_conf_file="ext-opcache.ini"
opcache_conf=$opcache_conf_path/$opcache_conf_file

STATUS="enabled"
RESTART="no"
SHOWHELP="yes"
DIR="$BREW_PREFIX/opt/php@$phpversion"

if [ -f "$opcache_conf" ] && [ -f "$opcache_conf.disabled" ]; then
  echo ""
  echo "Detected both enabled and disabled opcache ini files. Deleting the disabled one."
  echo ""
  rm -rf "$opcache_conf.disabled"
  STATUS="enabled"
elif [ -f "$opcache_conf.disabled" ]; then
  STATUS="disabled"
fi

if [ $# -ge 1 ]; then
  if [ "$action" == "on" ] || [ "$action" == "s" ] || [ "$action" == "e" ]; then
    mv "$opcache_conf.disabled" "$opcache_conf" 2> /dev/null
    STATUS="enabled"
    RESTART="yes"
    SHOWHELP="no"
  elif [ "$action" == "off" ] || [ "$action" == "o" ] || [ "$action" == "d" ]; then
    mv "$opcache_conf" "$opcache_conf.disabled" 2> /dev/null
    STATUS="disabled"
    RESTART="yes"
    SHOWHELP="no"
  fi
fi

if [ "$SHOWHELP" == "yes" ]; then
  echo ""
  echo "Usage: ${app} <on/s/e | off/o/d>"
fi

if [ "$RESTART" == "yes" ]; then
  echo ""
  echo "Opcache has been $STATUS, restarting server"
  sudo apachectl -k restart
fi

echo ""
echo "You are running PHP v$phpversion with Opcache is $STATUS"
echo ""


fi