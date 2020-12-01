#!/usr/bin/env bash
#=============================================================
# https://github.com/xd003/clone
# File Name: setup.sh
# Author: xd003
# Description: Installing prerequisites for clone script
# System Supported: Arch , Ubuntu/Debian , Fedora & Termux
#=============================================================

version=v0.4.1
arch="$(uname -m)"
ehome="$(echo $HOME)"
epac="$(which pacman)"
eapt="$(which apt)"
ednf="$(which dnf)"

if [ "$ehome" == "/data/data/com.termux/files/home" ]; then
    echo "Termux detected" && \
    pkg install -y openssh sshpass git
elif [ "$epac" == "/usr/bin/pacman" ]; then
    echo "Arch based OS detected" && \
    sudo pacman --noconfirm -S openssh sshpass git
elif [ "$eapt" == "/usr/bin/apt" ]; then 
    echo "Ubuntu based OS detected" && \
    sudo apt install -y openssh-server sshpass git
elif [ "$ednf" == "/usr/bin/dnf" ]; then
    echo "Fedora based OS detected"
    sudo dnf install -y openssh sshpass git
fi
}

if [ "$arch" == "arm64" ] || [ "$arch" == "aarch64" ] ; then
  arch=arm64
elif [ "$arch" == "x86_64" ] ; then
  arch=amd64
fi

dl=https://github.com/mawaya/rclone/releases/download/fclone-$version/fclone-$version-linux-$arch.zip

mkdir $HOME/easyclone
mkdir $HOME/.easyclone
git clone https://github.com/xd003/easyclone $HOME/easyclone
mv $HOME/easyclone/clone $HOME/.easyclone
chmod u+x $HOME/.easyclone/clone

if [ -f "$HOME/.bashrc" ]; then
    echo 'export PATH="$PATH:$HOME/.easyclone"' >> $HOME/.bashrc && \
    source ~/.bashrc
elif [ -f "$HOME/.zshrc" ]; then
    echo 'export PATH="$PATH:$HOME/.easyclone"' >> $HOME/.zshrc && \
    source ~/.zshrc
else
    touch $HOME/.bashrc && \
    echo 'export PATH="$PATH:$HOME/.easyclone"' >> $HOME/.bashrc && \
    source ~/.bashrc
fi
