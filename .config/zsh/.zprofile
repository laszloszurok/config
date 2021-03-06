# Default programs:
export EDITOR="nvr -s"
export TERMINAL="st"
export BROWSER="brave"
export READER="zathura"
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=always'"

# Custom askpass script for sudo -A
export SUDO_ASKPASS="$HOME/source/scripts/utils/dmenu_askpass"

# needed by gpg-agent
export GPG_TTY=$(tty)

# Path:
export JAVA_HOME=/usr/lib/jvm/default
export ANDROID_HOME="$HOME/Android/Sdk"
PATH="$HOME/source/scripts/utils:$PATH"
PATH="$PATH:$JAVA_HOME/bin"
PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.local/flutter/bin"
PATH="$PATH:$HOME/.emacs.d/bin"
PATH="$PATH:$HOME/.dotnet/tools"
export PATH

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export ANDROID_AVD_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/android/"
export ANDROID_EMULATOR_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/android/"
export ADB_VENDOR_KEY="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export GRADLE_USER_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/gradle"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"
export UNISON="${XDG_DATA_HOME:-$HOME/.local/share}/unison"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export WEECHAT_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/weechat"
export MBSYNCRC="${XDG_CONFIG_HOME:-$HOME/.config}/mailsync/mbsyncrc"

# disable dotnet core telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# fzf settings
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!{node_modules,.cargo,.git,.cfg,.themes}'"
export FZF_DEFAULT_OPTS="--color=bg+:-1 -m --reverse --inline-info --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
