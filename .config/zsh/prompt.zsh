PROMPT_PREFIX="%Bcwd:%b "
PROMPT_PREFIX_COLOR="%F{40}"

CWD_COLOR="%F{5}"

PROMPT_SYMBOL="%B%b "
PROMPT_SYMBOL_COLOR="%F{40}"

GIT_BRANCH_PREFIX="%Bon%b "
GIT_BRANCH_PREFIX_COLOR="%F{40}"

GIT_BRANCH_SYMBOL=" "
GIT_BRANCH_SYMBOL_COLOR="%F{5}"

# registering precmd function (executes every time before the prompt is drawn)
# if cwd=$HOME --> display /home/username, else display ~/current/path 
# usage: %v in PROMPT
autoload -Uz add-zsh-hook
print_cwd () {
    if [ "$(pwd)" = "$HOME" ]; then
        psvar[1]="$(pwd)"
    else
        psvar[1]="$(echo '~')${$(pwd)#$HOME} "
    fi
}
add-zsh-hook precmd print_cwd

# Show git branch in git directories

setopt prompt_subst
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{172}✚%f'
zstyle ':vcs_info:*' unstagedstr '%F{172}●%f'

zstyle ':vcs_info:*' actionformats \
   '%F{5}%F{5}%b%F{5}%f %u %c (%a)'

zstyle ':vcs_info:*' formats \
   '%F{5}%F{5}%b%F{5}%f %u %c'

vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "$GIT_BRANCH_PREFIX_COLOR$GIT_BRANCH_PREFIX%f$GIT_BRANCH_SYMBOL_COLOR$GIT_BRANCH_SYMBOL%f${vcs_info_msg_0_}%f$del"
  fi
}

# RPROMPT=$'$(vcs_info_wrapper)'
PROMPT="$PROMPT_PREFIX_COLOR$PROMPT_PREFIX$CWD_COLOR%v"$'$(vcs_info_wrapper)'$'\n'"%f$PROMPT_SYMBOL_COLOR$PROMPT_SYMBOL%f"
# RPS1="  %m    %n"
