# Enable colors and change prompt:
autoload -U colors && colors

# Loading pywal colors
(cat ~/.cache/wal/sequences &)

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt HIST_IGNORE_ALL_DUPS

source $HOME/.config/zsh/customizations/prompt.zsh
source $HOME/.config/zsh/customizations/aliases.zsh
source $HOME/.config/zsh/customizations/extract.zsh # function to extract archives
source $HOME/.config/zsh/customizations/vimode.zsh # use modes like in vim
source $HOME/.config/zsh/customizations/autocomplete.zsh

# Use the z command to cd into frequently visited directories faster
export _Z_DATA="$HOME/.cache/z/zdata"
. /$HOME/z/z.sh

# Set the default texteditor to neovim
export EDITOR=nvim

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Managing environmental variables
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk/
PATH="$JAVA_HOME/bin:$PATH"
PATH="$PATH:/home/pulzar/scripts/misc"
PATH="$PATH:/home/pulzar/flutter/bin"
export PATH="$PATH:/home/pulzar/.emacs.d/bin"

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
