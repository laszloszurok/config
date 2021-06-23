# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS

# do not highlight pasted text
zle_highlight=('paste:none')

# access frequently visited directories faster
eval "$(zoxide init zsh --cmd j)" 

# source $HOME/.config/zsh/prompt.zsh
eval "$(starship init zsh)"

source $HOME/.config/shellconfig/aliases
source $HOME/.config/zsh/vimode.zsh # use modes like in vim
source $HOME/.config/zsh/autocomplete.zsh

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
