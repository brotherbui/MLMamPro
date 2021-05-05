#!/bin/sh
Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

app="$(basename "$0")"
phpversion="7.4"
action="$1"
BREW_PREFIX=$(brew --prefix)

xdebug_conf_path="$BREW_PREFIX/etc/php/$phpversion/conf.d"
xdebug_conf_file="ext-xdebug.ini"
xdebug_conf=$xdebug_conf_path/$xdebug_conf_file


RESTART="no"
SHOWHELP="yes"
STATUS="enabled"
DIR="$BREW_PREFIX/opt/php@$phpversion"


if [ ! -f "$xdebug_conf" ] && [ ! -f "$xdebug_conf.disabled" ]; then
  echo ""
  echo "The ini file for Xdebug was not found at '$xdebug_conf_path'"
  echo "Did you install Xdebug via Homebrew?"
  echo ""
  exit 1
else
  if [ -f "$xdebug_conf" ] && [ -f "$xdebug_conf.disabled" ]; then
    echo ""
    echo "Detected both enabled and disabled Xdebug ini files. Deleting the disabled one."
    echo ""

    rm -rf "$xdebug_conf.disabled"
    STATUS="enabled"
  elif [ -f "$xdebug_conf.disabled" ]; then
    STATUS="disabled"
  fi

  if [ $# -ge 1 ]; then
    if [ "$action" == "on" ] || [ "$action" == "s" ] || [ "$action" == "e" ]; then
      mv "$xdebug_conf.disabled" "$xdebug_conf" 2> /dev/null
      STATUS="enabled"
      RESTART="yes"
      SHOWHELP="no"
    elif [ "$action" == "off" ] || [ "$action" == "o" ] || [ "$action" == "d" ]; then
      mv "$xdebug_conf" "$xdebug_conf.disabled" 2> /dev/null
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
    echo "Xdebug has been $STATUS, restarting server"
    sudo apachectl -k restart
  fi

  echo ""
  echo "You are running PHP v$phpversion with Xdebug is $STATUS"
  echo ""
fi
