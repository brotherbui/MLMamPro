#!/bin/bash
if test $(which git); then
  cd ~
  git clone https://github.com/phongblack/mlmampro.git
  cd mlmampro/install
  pwd
  sh 1.brew.sh
  sh 2.ohmyzsh.sh
  sh 3.zsh-config.sh
  sh 4.apache.sh
  sh 5.php.sh
  sh 6.mariadb.sh
else
  echo "Please complete the Command Line Tools installation first by running this command in Terminal: git"
fi