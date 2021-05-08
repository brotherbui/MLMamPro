#!/bin/zsh
if test $(which git); then
  cd ~
  git clone https://github.com/phongblack/mlmampro.git ~/mlmampro
  
  sh ~/mlmampro/install/1.brew.sh
  sh ~/mlmampro/install/2.apache.sh
  sh ~/mlmampro/install/3.php.sh
  sh ~/mlmampro/install/4.mariadb.sh
  sh ~/mlmampro/install/5.ohmyzsh.sh
  
  
else
  echo "Please complete the Command Line Tools installation first by running this command in Terminal: git"
fi
