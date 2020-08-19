alias vf=vifmrun # vifmrun is a custom script for vifm with image preview (~/scripts/misc/vifmrun)
alias nv=nvim
alias ll="ls -lhF"
alias la="ls -lahF"
alias ls="ls --color=auto"
alias cfg='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME' # alias for managing files in the home folder with git
alias ..='cd ..' 
alias ...='cd ../..'
alias grep='grep --color=auto'
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
alias zcfg="cwd=$(pwd) && cd ~/.config/zsh/ && nvim . && source ~/.config/zsh/.zshrc && cd $cwd"
alias ncfg="cwd=$(pwd) && cd ~/.config/nvim/ && nvim . && cd $cwd"
