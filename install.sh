#!/bin/zsh
if test $(which git); then
  cd ~
  git clone https://github.com/phongblack/mlmampro.git ~/mlmampro
  
  /bin/zsh ~/mlmampro/install/1.brew.sh
  /bin/zsh ~/mlmampro/install/2.apache.sh
  /bin/zsh ~/mlmampro/install/3.php.sh
  /bin/zsh ~/mlmampro/install/4.mariadb.sh
  /bin/zsh ~/mlmampro/install/5.ohmyzsh.sh
  compaudit | xargs chmod g-w
  
else
  echo "Please complete the Command Line Tools installation first by running this command in Terminal: git"
fi
