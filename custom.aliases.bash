# Git shortcuts
gitdone() { git add -A; git commit -S -v -m "$1"; git push; }

# Use ssht to open tmux automatically for ssh sessions
function ssht(){
  ssh $* -t 'tmux a || tmux || /bin/bash'
}

# Dave's custom aliases
alias sudo="sudo "
alias yum='$HOME/.local/bin/ibm-yum.sh'
