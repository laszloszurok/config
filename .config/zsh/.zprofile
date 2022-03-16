# Default programs:
export EDITOR="nvr -s"
export TERMINAL="st"
export BROWSER="qutebrowser"
export READER="zathura"
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=always'"

# Custom askpass script for sudo -A
export SUDO_ASKPASS="$HOME/source/scripts/utils/dmenu_askpass"

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

export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export ANDROID_AVD_HOME="$XDG_DATA_HOME/android/"
export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME/android/"
export ADB_VENDOR_KEY="$XDG_CONFIG_HOME/android"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/shellconfig/inputrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export KODI_DATA="$XDG_DATA_HOME/kodi"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export UNISON="$XDG_DATA_HOME/unison"
export HISTFILE="$XDG_DATA_HOME/history"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export MBSYNCRC="$XDG_CONFIG_HOME/mailsync/mbsyncrc"

# disable dotnet core telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# fzf settings
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!{node_modules,.cargo,.git,.cfg,.themes}'"
export FZF_DEFAULT_OPTS="--color=bg+:-1 -m --reverse --inline-info --preview 'bat --color=always --style=numbers --line-range=:500 {}' --bind 'ctrl-alt-j:preview-down,ctrl-alt-k:preview-up'"

# vifm config/data files
export VIFM="$XDG_DATA_HOME/vifm"
export MYVIFMRC="$XDG_CONFIG_HOME/vifm/vifmrc"
