# Enable colors and change prompt:
autoload -U colors && colors

# Loading pywal colors
# (cat ~/.cache/wal/sequences &)

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt HIST_IGNORE_ALL_DUPS

export _Z_DATA="$HOME/.cache/z/zdata"        # Use the z command to cd into
source $HOME/.config/zsh/z.sh # frequently visited directories faster
source $HOME/.config/zsh/prompt.zsh
source $HOME/.config/zsh/aliases.zsh
source $HOME/.config/zsh/extract.zsh # function to extract archives
source $HOME/.config/zsh/vimode.zsh # use modes like in vim
source $HOME/.config/zsh/autocomplete.zsh

# Set the default texteditor to neovim
export EDITOR=nvim

export CARGO_HOME=~/.config/cargo
export GRADLE_USER_HOME=~/.config/gradle
export GNUPGHOME=~/.config/gnupg
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot=~/.config/java
export LESSHISTFILE=-

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Managing environmental variables
export JAVA_HOME=/usr/lib/jvm/java-14-openjdk
export ANDROID_HOME=/home/pulzar/Android/Sdk
PATH="$JAVA_HOME/bin:$PATH"
PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"
PATH="$PATH:$HOME/scripts/misc"
PATH="$PATH:$HOME/flutter/bin"
export PATH="$PATH:$HOME/.emacs.d/bin"

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
