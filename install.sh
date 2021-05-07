#!/bin/bash
if test $(which git); then
  cd ~
  git clone https://github.com/phongblack/mlmampro.git
  cd mlmampro/install
  pwd
  sh 1.brew.sh
  sh 2.apache.sh
  sh 3.php.sh
  sh 4.mariadb.sh
  
else
  echo "Please complete the Command Line Tools installation first by running this command in Terminal: git"
fi
