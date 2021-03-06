#!/bin/sh
onlyone="7.4"

Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow



VERSION="$1"
COMPOSER="no"

install_mongo()
{
  PHP_VER=$1
  PHP_DETAILED_VER=$(brew info php@$PHP_VER | grep -Eo "$HOMEBREW_PREFIX/Cellar/php@$PHP_VER/[0-9.]*" | awk -F/ '{print $(NF)}')
  
  brew install pcre2
  PCRE_VER=$(brew info pcre2 | grep -Eo "$HOMEBREW_PREFIX/Cellar/pcre2/[0-9.]*" | awk -F/ '{print $(NF)}')

  PHP_PATH=php@$PHP_VER/$PHP_DETAILED_VER

  ln -s $HOMEBREW_PREFIX/Cellar/pcre2/$PCRE_VER/include/pcre2.h $HOMEBREW_PREFIX/Cellar/$PHP_PATH/include/php/ext/pcre/pcre2.h

  pecl install mongodb
}

echo "7. Install Composer, PHP, N98-Magerun, xDebug and process config files"
if test $(which brew); then
  COMPOSER="yes"
  brew install php@"$onlyone"
  cp $HOMEBREW_PREFIX/etc/php/"$onlyone"/php.ini $HOMEBREW_PREFIX/etc/php/"$onlyone"/php.ini.bak
    brew link php@"$onlyone"
      
  pecl install xdebug
  cp -rf ~/mampro/config/ext-xdebug.ini $HOMEBREW_PREFIX/etc/php/"$onlyone"/conf.d/

  install_mongo $onlyone
  cp -rf ~/mampro/config/ext-mongodb.ini $HOMEBREW_PREFIX/etc/php/"$onlyone"/conf.d/

  pecl install redis
  cp -rf ~/mampro/config/ext-redis.ini $HOMEBREW_PREFIX/etc/php/"$onlyone"/conf.d/

  sed -i '' -e '/extension="redis.so"/d' $HOMEBREW_PREFIX/etc/php/"$onlyone"/php.ini
  sed -i '' -e '/extension="mongodb.so"/d' $HOMEBREW_PREFIX/etc/php/"$onlyone"/php.ini
  sed -i '' -e '/zend_extension="xdebug.so"/d' $HOMEBREW_PREFIX/etc/php/"$onlyone"/php.ini

  sed -i '' 's/max_execution_time = 30/max_execution_time = 0/g' $HOMEBREW_PREFIX/etc/php/"$onlyone"/php.ini
  sed -i '' 's/max_input_time = 60/max_input_time = 0/g' $HOMEBREW_PREFIX/etc/php/"$onlyone"/php.ini
  sed -i '' 's/memory_limit = 128M/memory_limit = 512M/g' $HOMEBREW_PREFIX/etc/php/"$onlyone"/php.ini
  sed -i '' 's/post_max_size = 8M/post_max_size = 128M/g' $HOMEBREW_PREFIX/etc/php/"$onlyone"/php.ini
  sed -i '' 's/upload_max_filesize = 2M/upload_max_filesize = 128M/g' $HOMEBREW_PREFIX/etc/php/"$onlyone"/php.ini
  sed -i '' 's/;max_input_vars = 1000/max_input_vars = 10000/g' $HOMEBREW_PREFIX/etc/php/"$onlyone"/php.ini


  if [ ! -f $HOMEBREW_PREFIX/bin/composer ] && [ "$COMPOSER" == "yes" ]; then
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    mv composer.phar $HOMEBREW_PREFIX/bin/composer
  fi

else
  echo "$Red"
  echo "Homebrew is NOT installed! Exit now. $Color_Off"
  exit 1
fi