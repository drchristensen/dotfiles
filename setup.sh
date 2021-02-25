#!/bin/bash

params="-sf"

while getopts "vib" args; do
    case $args in
        v)
            params="$params -v"
            ;;
        i)
            params="$params -i"
            ;;
        b)
            params="$params -b"
            ;;
    esac
done

# Store where the script was called from so we can reference it later
SCRIPT_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update bash-it if it's already installed or download it if it's not
echo "Installing/updating bash-it..."
if [ -d $HOME/.bash_it ]; then
  cd $HOME/.bash_it
  git pull
else
  git clone --depth=1 https://github.com/Bash-it/bash-it.git $HOME/.bash_it
fi

# Add our custom aliases to bash-it
ln $params $SCRIPT_HOME/custom.aliases.bash $HOME/.bash_it/aliases/custom.aliases.bash

# Add our custom libraries to bash-it
ln $params $SCRIPT_HOME/custom.bash $HOME/.bash_it/lib/custom.bash

# Symlink all of our dotfiles to the home directory
for i in .vimrc .dircolors .bashrc .bash_profile .bash_darwin .tmux.conf .gdbinit .gitconfig;
do
  [ -e $HOME/$i ] && mv $HOME/$i $HOME/$i.backup
  ln $params $SCRIPT_HOME/$i $HOME/$i
done
