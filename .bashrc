# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# dircolors
if [ -e ~/.dircolors ]; then
  eval `dircolors -b ~/.dircolors`
fi

# Useful credentials
if [ -f $HOME/.credentials ]; then
  . $HOME/.credentials
fi

# Lock and Load a custom theme file
# location ~/.bash_it/themes/
export BASH_IT_THEME='powerline'
export POWERLINE_PROMPT="hostname user_info scm python_venv ruby cwd"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Tab complete sudo commands
complete -cf sudo

# Load Bash It
export BASH_IT="$HOME/.bash_it"

if [ -e $BASH_IT/bash_it.sh ]; then
  source $BASH_IT/bash_it.sh
fi

# Fix vim colors inside tmux
if [ -n $TMUX ]; then
  alias vim="TERM=screen-256color vim"
fi

# Put bash in vim mode
set -o vi

# Set default editor to vim
export EDITOR=vim
