###############################
# basic settings
###############################

HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
zle_highlight=('paste:none')

export DOCKER_HOST=unix:///run/user/1000/docker.sock

# function that caches the output of eval to make it faster
export ZSH_EVALCACHE_DIR="$HOME/.cache/zsh-evalcache"
function _evalcache () {
  local cacheFile="$ZSH_EVALCACHE_DIR/init-${1##*/}.sh"

  if [ "$ZSH_EVALCACHE_DISABLE" = "true" ]; then
    eval "$("$@")"
  elif [ -s "$cacheFile" ]; then
    source "$cacheFile"
  else
    if type "$1" > /dev/null; then
      (>&2 echo "$1 initialization not cached, caching output of: $*")
      mkdir -p "$ZSH_EVALCACHE_DIR"
      "$@" > "$cacheFile"
      source "$cacheFile"
    else
      echo "evalcache ERROR: $1 is not installed or in PATH"
    fi
  fi
}

_evalcache zoxide init zsh
_evalcache starship init zsh # shell prompt

###############################
# aliases
###############################

alias nv="nvim"
alias ll="ls -lhF --group-directories-first"
alias la="ls -lAhF --group-directories-first"
alias ls="ls --color=auto --group-directories-first"
alias lh="ls -d .* --group-directories-first"
alias llh="ls -ld .* --group-directories-first"
alias cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias cd="z"
alias cdi="zi"
alias ..="cd .."
alias ...="cd ../.."
alias grep="grep --color=auto"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias x="xtract"
alias startx="startx $XDG_CONFIG_HOME/X11/xinitrc"

###############################
# vi mode
###############################

bindkey -v # enable vi keybindings
bindkey -M viins '^?' backward-delete-char # make backspace work as expected
export KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    echo -ne "\e[5 q"
}

zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


###############################
# autocompletion
###############################

autoload -Uz compinit

if [[ -n ~/.cache/zcompdump(#qN.mh+24) ]]; then
    compinit -d ~/.cache/zcompdump
else
    compinit -C -d ~/.cache/zcompdump;
fi;

zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '\e' accept-search

##############################################
# load zsh-syntax-highlighting; should be last
##############################################
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

