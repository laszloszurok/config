# Basic auto/tab complete:

autoload -Uz compinit

for dump in ~/.cache/zcompdump-$ZSH_VERSION(N.mh+24); do
    compinit -C -d ~/.cache/zcompdump-$ZSH_VERSION
done

zstyle ':completion:*' menu select
compinit -C -d ~/.cache/zcompdump-$ZSH_VERSION
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^M' .accept-line
bindkey -M menuselect '\e' accept-search

# Fix backspace bug when switching modes
bindkey -v '^?' backward-delete-char
