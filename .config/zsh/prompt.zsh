PROMPT_PREFIX="%F{141}$(whoami)%f %F{69}%Bat%b%f %F{141}$(hostname)%f %F{69}%Bin%b%f "

CWD="%~ "
CWD_COLOR="%F{141}"

PROMPT_SYMBOL="%B%b "
PROMPT_SYMBOL_COLOR="%F{141}"

GIT_BRANCH_PREFIX="%Bon%b "
GIT_BRANCH_PREFIX_COLOR="%F{69}"

GIT_BRANCH_SYMBOL=" "
GIT_BRANCH_SYMBOL_COLOR="%F{141}"

# enabling precmd 
autoload -Uz add-zsh-hook

# if cwd=$HOME --> display /home/username, else display ~/current/path 
# usage: %v in PROMPT
# print_cwd () {
#     cwd=$(pwd)
#     [[ "$cwd" == "$HOME/"* ]] && cwd="~${$(pwd)#$HOME} " # somewhere in $HOME/*, replace $HOME with ~
#     psvar[1]="$cwd"
# }

# I am using a bare git repository for managing my config files. This function checks
# if there are staged or unstaged changes in the bare repo, and sets some indicator
# icons in psvar variables, which I display in the right side prompt (%v2 and %v3).
check_config_status () {
    # checking for any changes
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME update-index --refresh > /dev/null # otherwise a timestamp difference would count as a change
    changes=$(/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME diff-index HEAD --) 

    # checking for commits that are not pushed yet
    not_pushed=$(/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME log origin/master..HEAD)

    # ! -> unstaged changes, + -> staged changes
    if [ -n "$changes" ] && [ -n "$not_pushed" ]; then
        psvar[2]=" "
        psvar[3]=" "
    elif [ -n "$not_pushed" ]; then
        psvar[2]=""
        psvar[3]=" "
    elif [ -n "$changes" ]; then
        psvar[2]=""
        psvar[3]=" "
    else
        psvar[2]=""
        psvar[3]=""
    fi
}

# registering precmd functions (executes every time before the prompt is drawn)
# add-zsh-hook precmd print_cwd
add-zsh-hook precmd check_config_status

# Show git branch in git directories

setopt prompt_subst
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{172}%B!%f'
zstyle ':vcs_info:*' stagedstr '%F{172}%B+%f'

zstyle ':vcs_info:*' actionformats \
   '%F{141}%b%f %u %c (%a)'

zstyle ':vcs_info:*' formats \
   '%F{141}%b%f %u %c'

vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "$GIT_BRANCH_PREFIX_COLOR$GIT_BRANCH_PREFIX%f$GIT_BRANCH_SYMBOL_COLOR$GIT_BRANCH_SYMBOL%f${vcs_info_msg_0_}%f$del"
  fi
}

PROMPT="$PROMPT_PREFIX$CWD_COLOR$CWD"$'$(vcs_info_wrapper)'$'\n'"%f$PROMPT_SYMBOL_COLOR$PROMPT_SYMBOL%f"
# RPROMPT="%F{141}  %m    %n%f"
RPROMPT="%F{172}%2v %3v%f"
