# Show git branch in right prompt if inside a git dir
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}[on branch:%F{3}-%F{5}%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}[on branch%F{3} %F{5}%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  else
    echo "  %{$fg[green]%}%m%{$reset_color%}    %{$fg[green]%}%n%{$reset_color%}"
  fi
}

RPROMPT=$'$(vcs_info_wrapper)'
PS1="%{$fg[green]%}cwd: %~"$'\n'"%{$reset_color%} "
# RPS1="  %m    %n"
