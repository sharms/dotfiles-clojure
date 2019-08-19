#!/bin/bash

# Directories
mkdir -p $HOME/{src,bin,opt,lib}

# Atom Editor
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt-get update
sudo apt-get install atom
apm install chlorine ink

# Shell Utils
sudo apt-get install zsh git curl build-essential vim emacs
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i 's/^ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc
zsh -c 'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'
sed -i 's/^plugins=(\(.*\))/plugins=(zsh-autosuggestions \1)/' ~/.zshrc

# Powerline Fonts
cd $HOME/src
mkdir -p github.com/powerline
cd github.com/powerline
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh

# Java development environment
sudo apt install openjdk-12-jdk

# Clojure
curl -O https://download.clojure.org/install/linux-install-1.10.1.466.sh
chmod +x linux-install-1.10.1.466.sh
sudo ./linux-install-1.10.1.466.sh

