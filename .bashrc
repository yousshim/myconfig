# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
function prepend_path() {
    local PATH_ELEMENT=$1
    if ! [[ "$PATH" =~ "$PATH_ELEMENT:" ]]; then
        PATH="$PATH_ELEMENT:$PATH"
    fi
}

prepend_path "$HOME/.local/bin"
prepend_path "/usr/local/go/bin"
prepend_path "$HOME/.local/share/go/bin"
prepend_path "$HOME/.cache/.bun/bin"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

alias config='/usr/bin/git --git-dir=$HOME/.home --work-tree=$HOME'
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export HISTFILE="$XDG_STATE_HOME/bash/history"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

export MOZ_ENABLE_WAYLAND=1

export SDKMAN_DIR="$XDG_DATA_HOME/sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
