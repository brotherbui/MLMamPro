#!/bin/zsh
echo "Macintosh Apache MariaDB PHP installation by Phong Black"
if test $(which git); then
  ./scripts/1.brew.sh
  ./scripts/2.ohmyzsh.sh
  ./scripts/3.font-terminal.sh
  ./scripts/4.zsh-config.sh
  ./scripts/5.required-apps.sh
  ./scripts/6.apache.sh
  ./scripts/7.php.sh
  ./scripts/8.mariadb.sh
  
else
  echo "Please complete the Command Line Tools installation first by running this command in Terminal: git"
fi