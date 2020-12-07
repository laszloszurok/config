# Enable colors and change prompt:
autoload -U colors && colors

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS

source $HOME/.config/zsh/z.sh # access frequently visited directories faster
source $HOME/.config/zsh/prompt.zsh
source $HOME/.config/zsh/aliases.zsh
source $HOME/.config/zsh/extract.zsh # function to extract archives
source $HOME/.config/zsh/vimode.zsh # use modes like in vim
source $HOME/.config/zsh/autocomplete.zsh

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
