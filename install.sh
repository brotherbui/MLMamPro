#!/bin/zsh
if test $(which git); then
  cd ~
  git clone https://github.com/phongblack/mlmampro.git ~/mlmampro
  chmod +x ~/mlmampro/install/*
  ~/mlmampro/install/1.brew.sh
  ~/mlmampro/install/2.apache.sh
  ~/mlmampro/install/3.php.sh
  ~/mlmampro/install/4.mariadb.sh
  ~/mlmampro/install/5.ohmyzsh.sh
  /usr/bin/zsh compaudit | xargs chmod g-w
  
else
  echo "Please complete the Command Line Tools installation first by running this command in Terminal: git"
fi
