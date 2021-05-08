#!/bin/bash
if test $(which git); then
  cd ~
  git clone https://github.com/phongblack/mlmampro.git ~/mlmampro
  
  zsh ~/mlmampro/install/1.brew.sh
  zsh ~/mlmampro/install/2.apache.sh
  zsh ~/mlmampro/install/3.php.sh
  zsh ~/mlmampro/install/4.mariadb.sh
  zsh ~/mlmampro/install/5.ohmyzsh.sh
  compaudit | xargs chmod g-w
  
else
  echo "Please complete the Command Line Tools installation first by running this command in Terminal: git"
fi
