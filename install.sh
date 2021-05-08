#!/bin/zsh
if test $(which git); then
  cd ~
  git clone https://github.com/phongblack/mlmampro.git ~/mlmampro
  cd ~/mlmampro/install
  ./1.brew.sh
  ./2.apache.sh
  ./3.php.sh
  ./4.mariadb.sh
  ./5.ohmyzsh.sh
  
  
else
  echo "Please complete the Command Line Tools installation first by running this command in Terminal: git"
fi
