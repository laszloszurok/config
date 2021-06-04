#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

# Source aliases
source $HOME/.config/shellconfig/aliases

# Starship Prompt
eval "$(starship init bash)"
