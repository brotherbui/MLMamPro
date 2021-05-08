#!/bin/sh
current_user="$(whoami)"
php_array=("7.4")

Color_Off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

BREW_PREFIX=$(brew --prefix)

echo "3. Install Composer, PHP, xDebug and process config files"
if test $(which brew); then
  if [ ! -f $BREW_PREFIX/bin/composer ]; then
    brew install composer
  fi
  
  for i in ${php_array[@]}
	do
    if [ ! -f $BREW_PREFIX/bin/php ]; then
      NODOT=${i/./}
      brew install php@"$i"

      brew link --force --overwrite php@"$i"

      cp $BREW_PREFIX/etc/php/"$i"/php.ini $BREW_PREFIX/etc/php/"$i"/php.ini.bak
      cp -rf ~/mlmampro/config/ext-xdebug.ini $BREW_PREFIX/etc/php/"$i"/conf.d/

      pecl install xdebug
      
      sed -i '' 's/zend_extension=/;zend_extension=/g' $BREW_PREFIX/etc/php/"$i"/php.ini
      sed -i '' 's/extension=/;extension=/g' $BREW_PREFIX/etc/php/"$i"/php.ini
      sed -i '' 's/max_execution_time = 30/max_execution_time = 30000/g' $BREW_PREFIX/etc/php/"$i"/php.ini
      sed -i '' 's/max_input_time = 60/max_input_time = 60000/g' $BREW_PREFIX/etc/php/"$i"/php.ini
      sed -i '' 's/memory_limit = 128M/memory_limit = 512M/g' $BREW_PREFIX/etc/php/"$i"/php.ini
      sed -i '' 's/post_max_size = 8M/post_max_size = 128M/g' $BREW_PREFIX/etc/php/"$i"/php.ini
      sed -i '' 's/upload_max_filesize = 2M/upload_max_filesize = 128M/g' $BREW_PREFIX/etc/php/"$i"/php.ini
    fi
		
  done  
else
  echo "$Red"
  echo "Homebrew is NOT installed! Exit now. $Color_Off"
  exit 1
fi

