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
sudo apt-get install zsh git curl build-essential vim emacs tmux
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i 's/^ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc
zsh -c 'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'
sed -i 's/^plugins=(\(.*\))/plugins=(zsh-autosuggestions \1)/' ~/.zshrc

# Git
git config --global user.name "Steve Harms"
git config --global user.email "sharms@snowfoundry.com"

# Powerline Fonts
cd $HOME/src
mkdir -p github.com/powerline
cd github.com/powerline
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh

# Set default monospace font for powerline
gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro for Powerline Regular 12'

# Java development environment
sudo apt install openjdk-12-jdk

# Clojure
curl -O https://download.clojure.org/install/linux-install-1.10.1.466.sh
chmod +x linux-install-1.10.1.466.sh
sudo ./linux-install-1.10.1.466.sh

mkdir -p ~/.clojure
cat << EOF > ~/.clojure/deps.edn
{
  :aliases
  {:new {:extra-deps {seancorfield/clj-new
                       {:mvn/version "0.7.7"}}
         :main-opts ["-m" "clj-new.create"]}
    :rebl {:extra-deps {
                org.clojure/clojure {:mvn/version "1.10.0"}
                org.clojure/core.async {:mvn/version "0.4.490"}
                ;; deps for file datafication (0.9.149 or later)
                org.clojure/data.csv {:mvn/version "0.1.4"}
                org.clojure/data.json {:mvn/version "0.2.3"}
                org.yaml/snakeyaml {:mvn/version "1.23"}
                org.openjfx/javafx-fxml     {:mvn/version "11.0.1"}
                org.openjfx/javafx-controls {:mvn/version "11.0.1"}
                org.openjfx/javafx-graphics {:mvn/version "11.0.1"}
                org.openjfx/javafx-media    {:mvn/version "11.0.1"}
                org.openjfx/javafx-swing    {:mvn/version "11.0.1"}
                org.openjfx/javafx-base     {:mvn/version "11.0.1"}
                org.openjfx/javafx-web      {:mvn/version "11.0.1"}
                com.cognitect/rebl {:local/root "/home/sharms/local/opt/REBL-0.9.218.jar"}}
           :main-opts ["-m" "cognitect.rebl"]}
    :socket {:jvm-opts ["-Dclojure.server.repl={:port,50505,:accept,clojure.core.server/repl}"]}
    :comp {:extra-deps {compliment {:mvn/version "RELEASE"}}}
  }
}
EOF

mkdir -p ~/.atom
cat << EOF > ~/.atom/keymap.cson
'atom-text-editor[data-grammar="source clojure"]':
  'ctrl-, y':       'chlorine:connect-clojure-socket-repl'
  'ctrl-, e':       'chlorine:disconnect'
  'ctrl-, k':       'chlorine:clear-console'
  'ctrl-, f':       'chlorine:load-file'
  'ctrl-, b':       'chlorine:evaluate-block'
  'ctrl-, B':       'chlorine:evaluate-top-block'
  'ctrl-, i':       'chlorine:inspect-block'
  'ctrl-, I':       'chlorine:inspect-top-block'
  'ctrl-, s':       'chlorine:evaluate-selection'
  'ctrl-, c':       'chlorine:break-evaluation'
  'ctrl-, C':       'chlorine:source-for-var'
  'ctrl-, d':       'chlorine:doc-for-var'
  'ctrl-, x':       'chlorine:run-tests-in-ns'
  'ctrl-, t':       'chlorine:run-test-for-var'
EOF
