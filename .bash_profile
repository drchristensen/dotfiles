if [[ $OSTYPE == darwin* ]]; then
  . ~/.bash_darwin
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Source any local files
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi

# User specific environment and startup programs
PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
