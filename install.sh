#!/bin/zsh
echo "Macintosh Apache MariaDB PHP installation by Phong Black"
if test $(which git); then
  ./scripts/1.brew.sh
  ./scripts/2.apache.sh
  ./scripts/3.php.sh
  ./scripts/4.mariadb.sh
  ./scripts/5.required-apps.sh
  ./scripts/6.font-terminal.sh
  ./scripts/7.ohmyzsh.sh
  
else
  echo "Please complete the Command Line Tools installation first by running this command in Terminal: git"
fi
