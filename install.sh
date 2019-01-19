#!/bin/bash

[ "$(id -u)" = "0" ] && {

    [ ! -x /usr/bin/sudo ] && {
        apt update && apt install sudo -y
    }
    [ ! -x /usr/bin/git ] && {
        sudo apt update && apt install -y git
    }

    [ ! -d $HOME/.ssh ] && {
        mkdir $HOME/.ssh
    }

    [ ! -x /usr/bin/cht.sh ] && {
        sudo curl https://cht.sh/:cht.sh >/usr/bin/cht.sh || sudo wget -O /usr/bin/cht.sh https://cht.sh/:cht.sh
        sudo chmod +x /usr/bin/cht.sh
    }
}

if [ ! -d $HOME/.wo-bashrc ]; then
    git clone https://github.com/VirtuBox/wo-bashrc.git $HOME/.wo-bashrc
    chmod +x $HOME/.wo-bashrc/bin/wo-bashrc
    cp $HOME/.wo-bashrc/wo-bashrc.rc /etc/bash_completion.d/wo-bashrc.rc
else
    git -C $HOME/.wo-bashrc pull origin master
    cp $HOME/.wo-bashrc/wo-bashrc.rc /etc/bash_completion.d/wo-bashrc.rc
fi
if [ -f $HOME/.bashrc ]; then
    check_wobashrc=$(grep "wo-bashrc" $HOME/.bashrc)
    [ -z "$check_wobashrc" ] && {
        echo ". $HOME/.wo-bashrc/wo-bashrc" >>$HOME/.bashrc
    }
else
    wget -O $HOME/.profile https://raw.githubusercontent.com/VirtuBox/ubuntu-nginx-web-server/master/docs/files/var/www/.profile
    wget -O $HOME/.bashrc https://raw.githubusercontent.com/VirtuBox/ubuntu-nginx-web-server/master/docs/files/var/www/.bashrc
    echo ". $HOME/.wo-bashrc/wo-bashrc" >>$HOME/.bashrc
fi
