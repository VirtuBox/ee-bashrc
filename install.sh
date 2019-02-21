#!/bin/bash

[ "$(id -u)" = "0" ] && {

    [ -z "$(command -v sudo)" ] && {
        apt-get update && apt-get install sudo -y
    }
    [ -z "$(command -v git)" ] && {
        apt-get update && apt-get install -y git
    }

    [ ! -d $HOME/.ssh ] && {
        mkdir $HOME/.ssh
    }

    [ -z "$(command -v cht.sh)" ] && {
        sudo curl https://cht.sh/:cht.sh >/usr/bin/cht.sh || sudo wget -O /usr/bin/cht.sh https://cht.sh/:cht.sh
        sudo chmod +x /usr/bin/cht.sh
    }
}

if [ ! -d $HOME/.vbashrc ]; then
    git clone https://github.com/VirtuBox/vbashrc.git $HOME/.vbashrc
    chmod +x $HOME/.vbashrc/bin/vbash
    cp $HOME/.vbashrc/vbash.rc /etc/bash_completion.d/vbash.rc
else
    git -C $HOME/.vbashrc pull origin master
    cp $HOME/.vbashrc/vbash.rc /etc/bash_completion.d/vbash.rc
fi
if [ -f $HOME/.bashrc ]; then
    check_vbashrc=$(grep "vbash" $HOME/.bashrc)
    [ -z "$check_vbashrc" ] && {
        echo ". $HOME/.vbashrc/vbash" >>$HOME/.bashrc
    }
else
    wget -O $HOME/.profile https://raw.githubusercontent.com/VirtuBox/ubuntu-nginx-web-server/master/var/www/.profile
    wget -O $HOME/.bashrc https://raw.githubusercontent.com/VirtuBox/ubuntu-nginx-web-server/master/var/www/.bashrc
    echo ". $HOME/.vbashrc/vbash" >>$HOME/.bashrc
fi
