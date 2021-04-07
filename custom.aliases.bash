# Git shortcuts
gitdone() {
  git add -A
  git commit -S -v -m "$1"
  git push
}

function gitl() {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
}

# Use ssht to open tmux automatically for ssh sessions
function ssht() {
  ssh $* -t 'tmux a || tmux || /bin/bash'
}

# Dave's custom aliases
# alias sudo="sudo "
# alias yum='FTP3USER=$FTP3USER FTP3PASS=$FTP3PASS $HOME/.local/bin/ibm-yum.sh'
alias hg="history | grep -i "

# DPDK aliases
alias rte=_rte $@
alias bld=_bld $@
alias dbld=_dbld $@

# Microk8s aliases
alias mkctl="microk8s kubectl"

# Enable color support of ls and other apps
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Colorize GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
