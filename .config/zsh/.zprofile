# Default programs:
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"

# Path:
export JAVA_HOME=/usr/lib/jvm/java-14-openjdk
export ANDROID_HOME=/home/pulzar/Android/Sdk
PATH="$PATH:$JAVA_HOME/bin"
PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
PATH="$PATH:$HOME/scripts/misc"
PATH="$PATH:$HOME/flutter/bin"
PATH="$PATH:$HOME/.emacs.d/bin"
PATH="$PATH:$HOME/.dotnet/tools"
export PATH

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs. Breaks slock systemd service
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export ANDROID_AVD_HOME="$XDG_DATA_HOME/android/"
export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME/android/"
export ADB_VENDOR_KEY="$XDG_CONFIG_HOME/android"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export _Z_DATA="$XDG_DATA_HOME/z/zdata"

# j as jump
export _Z_CMD="j"

# disable dotnet core telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1
