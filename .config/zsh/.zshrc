###############################
# basic settings
###############################

HISTSIZE=10000
SAVEHIST=10000
setopt histignorealldups
setopt incappendhistory
setopt nobanghist

zle_highlight=('paste:none')

# Elevates the last run command using sudo
function elevate_last_command() {
    sudo $(fc -ln -1)
}

# display the name of the currently running process in the terminal window title
autoload -Uz add-zsh-hook

function term_title_precmd () {
    print -Pn -- '\e]2;simple terminal\a'
    [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function term_title_preexec () {
    print -Pn -- '\e]2;' && print -n -- "${(q)1}\a"
    [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

add-zsh-hook -Uz precmd term_title_precmd
add-zsh-hook -Uz preexec term_title_preexec

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

_evalcache zoxide init zsh # fast cd
_evalcache starship init zsh # shell prompt

###############################
# aliases
###############################

alias ll="ls -lhF --group-directories-first"
alias la="LC_ALL=C ls -lAhF --group-directories-first"
alias ls="ls --color=auto --group-directories-first"
alias lh="ls -d .* --group-directories-first"
alias llh="ls -ld .* --group-directories-first"
alias cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias ..="cd .."
alias ...="cd ../.."
alias grep="grep --color=auto"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias x="xtract"
alias startx="ssh-agent startx $XDG_CONFIG_HOME/X11/xinitrc"
alias qbtui="qbittorrentui --config_file $HOME/.config/qbittorrentui/config.ini"
alias nvr="nvr --servername=/tmp/nvr-socket --remote -s"
alias vpnc="wg-quick up ~/pivpn/lenovo.conf"
alias vpnd="wg-quick down ~/pivpn/lenovo.conf"
alias please=elevate_last_command

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

# Synchronize vi-mode copy-paste with the system clipboard
function x11-clip-wrap-widgets() {
    local copy_or_paste=$1
    shift

    for widget in $@; do
        if [[ $copy_or_paste == "copy" ]]; then
            eval "
            function _x11-clip-wrapped-$widget() {
                zle .$widget
                xclip -in -selection clipboard <<<\$CUTBUFFER
            }"
        else
            eval "
            function _x11-clip-wrapped-$widget() {
                CUTBUFFER=\$(xclip -out -selection clipboard)
                zle .$widget
            }"
        fi
        zle -N $widget _x11-clip-wrapped-$widget
    done
}

local copy_widgets=(vi-yank vi-yank-eol vi-delete vi-backward-kill-word vi-change-whole-line)
local paste_widgets=(vi-put-{before,after})

x11-clip-wrap-widgets copy $copy_widgets
x11-clip-wrap-widgets paste  $paste_widgets

###############################
# autocompletion
###############################

autoload -Uz compinit edit-command-line
zle -N edit-command-line

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
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
