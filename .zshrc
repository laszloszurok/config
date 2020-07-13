# Enable colors and change prompt:
autoload -U colors && colors

# Show git branch in right prompt
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}

RPROMPT=$'$(vcs_info_wrapper)'
PS1="%{$fg[green]%}cwd: %{$fg[yellow]%}%~"$'\n'"%{$reset_color%}%{$reset_color%} "
#RPS1="  %m    %n"

# Loading pywal colors
(cat ~/.cache/wal/sequences &)

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt HIST_IGNORE_ALL_DUPS

# aliases
alias vf=vifmrun # vifmrun is a custom script for vifm with image preview (~/scripts/misc/vifmrun)
alias vim=nvim
alias ll="ls -lhF"
alias la="ls -lahF"
alias ls="ls --color=auto"
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME' # alias for managing files in the home folder with git

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# function to extract archives
extract () {
	local remove_archive
	local success
	local file_name
	local extract_dir
	if (( $# == 0 ))
	then
		echo "Usage: extract [-option] [file ...]"
		echo
		echo Options:
		echo "    -r, --remove    Remove archive."
		echo
		echo "Report bugs to <sorin.ionescu@gmail.com>."
	fi
	remove_archive=1 
	if [[ "$1" = "-r" ]] || [[ "$1" = "--remove" ]]
	then
		remove_archive=0 
		shift
	fi
	while (( $# > 0 ))
	do
		if [[ ! -f "$1" ]]
		then
			echo "extract: '$1' is not a valid file" >&2
			shift
			continue
		fi
		success=0 
		file_name="$( basename "$1" )" 
		extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )" 
		case "$1" in
			(*.tar.gz|*.tgz) tar xvzf "$1" ;;
			(*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
			(*.tar.xz|*.txz) tar --xz --help &> /dev/null && tar --xz -xvf "$1" || xzcat "$1" | tar xvf - ;;
			(*.tar.zma|*.tlz) tar --lzma --help &> /dev/null && tar --lzma -xvf "$1" || lzcat "$1" | tar xvf - ;;
			(*.tar) tar xvf "$1" ;;
			(*.gz) gunzip "$1" ;;
			(*.bz2) bunzip2 "$1" ;;
			(*.xz) unxz "$1" ;;
			(*.lzma) unlzma "$1" ;;
			(*.Z) uncompress "$1" ;;
			(*.zip|*.war|*.jar) unzip "$1" -d $extract_dir ;;
			(*.rar) unrar x -ad "$1" ;;
			(*.7z) 7za x "$1" ;;
			(*.deb) mkdir -p "$extract_dir/control"
				mkdir -p "$extract_dir/data"
				cd "$extract_dir"
				ar vx "../${1}" > /dev/null
				cd control
				tar xzvf ../control.tar.gz
				cd ../data
				tar xzvf ../data.tar.gz
				cd ..
				rm *.tar.gz debian-binary
				cd .. ;;
			(*) echo "extract: '$1' cannot be extracted" >&2
				success=1  ;;
		esac
		(( success = $success > 0 ? $success : $? ))
		(( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
		shift
	done
}

# vi mode
bindkey -v
export KEYTIMEOUT=5

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Use the z command to cd into frequently visited directories faster
export _Z_DATA="$HOME/.cache/z/zdata"
. /$HOME/z/z.sh

# Set the default texteditor to neovim
export EDITOR=nvim

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Managing the PATH variable
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk/
export PATH="$PATH:/home/pulzar/.local/bin"
export PATH="$PATH:/home/pulzar/scripts/misc"
export PATH="$PATH:/home/pulzar/flutter/bin"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$PATH:/home/pulzar/.emacs.d/bin"

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
