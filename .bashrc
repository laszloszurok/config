#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

alias nv="nvim"
alias ll="ls -lhF --group-directories-first"
alias la="ls -lAhF --group-directories-first"
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
alias startx="startx $XDG_CONFIG_HOME/X11/xinitrc"

# Starship Prompt
eval "$(starship init bash)"
