shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

bind "set completion-ignore-case on"

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_STATE_HOME="$HOME/.local/state"

export HISTFILE="$XDG_STATE_HOME/bash/history"
export HISTCONTROL=ignoreboth
export HISTSIZE=1000
export HISTFILESIZE=2000

export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

export EDITOR="nvim"

function prepend_path() {
    local PATH_ELEMENT=$1
    if ! [[ "$PATH" =~ "$PATH_ELEMENT:" ]]; then
        PATH="$PATH_ELEMENT:$PATH"
    fi
}

prepend_path "$XDG_BIN_HOME"
prepend_path "$XDG_DATA_HOME/mise/shims"
export PATH

alias gcl="git clone"
alias gc="git commit"
alias gs="git status -s"

alias oc="opencode"
alias occ="opencode $HOME/git/myconfig"
alias v="nvim"
alias cc="claude"

eval $(ssh-agent)
