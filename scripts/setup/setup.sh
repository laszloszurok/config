#!/bin/bash

# Run this script with sudo
# -------------------------

# exit if not using sudo
if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

# checking who is the current user
if [ $SUDO_USER ]; then
    current_user=$SUDO_USER
else
    current_user=$(whoami)
fi

# sync mirrors, update the system
pacman -Syyu

# x related
pacman -S xf86-video-intel xf86-video-amdgpu xorg xorg-xinit
sudo -u $current_user echo "#!/bin/sh

userresources=\$HOME/.Xresources
usermodmap=\$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f \$sysresources ]; then
    xrdb -merge \$sysresources
fi

if [ -f \$sysmodmap ]; then
    xmodmap \$sysmodmap
fi

if [ -f "\$userresources" ]; then
    xrdb -merge "\$userresources"
fi

if [ -f "\$usermodmap" ]; then
    xmodmap "\$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "\$f" ] && . "\$f"
 done
 unset f
fi

exec dwm" > /home/$current_user/.xinitrc

# installing my most used software
pacman -S pcmanfm-gtk3 firefox qbittorrent gvfs gvfs-mtp ntfs-3g zip unzip xarchiver zathura zathura-pdf-poppler gimp lxappearance kvantum-qt5 neovim zsh zsh-syntax-highlighting ttf-font-awesome ttf-dejavu feh python-pywal scrot numlockx xclip arc-gtk-theme arc-icon-theme powertop lxsession mpv dunst light-locker discord lightdm alsa-utils playerctl sxiv libreoffice-still texlive-most ffmpeg ffmpegthumbnailer cups usbutils ufw

# installing yay
sudo -u $current_user git clone https://aur.archlinux.org/yay.git
cd /home/$current_user/yay
sudo -u $current_user makepkg -si

cd /home/$current_user

# installing softwer from the AUR
sudo -u $current_user yay -S spotify
sudo -u $current_user yay -S spicetify-cli
sudo -u $current_user yay -S windscribe-cli
sudo -u $current_user yay -S lightdm-slick-greeter
sudo -u $current_user yay -S lightdm-settings
sudo -u $current_user yay -S hugo
sudo -u $current_user yay -S vscodium-bin

# enabling services
sh -c "echo -e '[Unit]\nDescription=PowerTop\n\n[Service]\nType=oneshot\nRemainAfterExit=true\nExecStart=/usr/bin/powertop --auto-tune\n\n[Install]\nWantedBy=multi-user.target\n' > /etc/systemd/system/powertop.service"
systemctl enable --now powertop
systemctl enable lightdm
systemctl enable org.cups.cupsd.socket
ufw default deny incoming
ufw default allow outgoing
ufw enable

# cloning my configs from my github and setting up a bare repository for config file management
sudo -u $current_user git clone --separate-git-dir=/home/$current_user/.myconf https://github.com/laszloszurok/suckless-arch.git /home/$current_user/myconf-tmp
sudo -u $current_user mv /home/$current_user/myconf-tmp/* /home/$current_user/myconf-tmp/.[!.]* /home/$current_user
sudo -u $current_user rm -rf /home/$current_user/myconf-tmp/ /home/$current_user/.git
sudo -u $current_user /usr/bin/git --git-dir=/home/$current_user/.myconf/ --work-tree=/home/$current_user config status.showUntrackedFiles no

# cloning my wallpaper repo
sudo -u $current_user git clone https://github.com/laszloszurok/Wallpapers

# installing my suckless builds
cd /home/$current_user/suckless-builds/dwm
make install
cd ../dmenu
make install
cd ../dwmblocks
make install
cd ../st
make install
cd ../wmname
make install

cd /home/$current_user

# spotify wm
sudo -u $current_user git clone https://github.com/dasJ/spotifywm.git
cd /home/$current_user/spotifywm
sudo -u $current_user make
echo "LD_PRELOAD=/usr/lib/libcurl.so.4:/home/pulzar/spotifywm/spotifywm.so /usr/bin/spotify" > /usr/local/bin/spotify

cd /home/$current_user

# changing the default shell to zsh
sudo -u $current_user mkdir /home/$current_user/.cache/zsh
echo "ZDOTDIR=\$HOME/.config/zsh" > /etc/zsh/zshenv
sudo -u $current_user chsh -s /usr/bin/zsh

# lightdm settings
echo "#
# General configuration
#
# start-default-seat = True to always start one seat if none are defined in the configuration
# greeter-user = User to run greeter as
# minimum-display-number = Minimum display number to use for X servers
# minimum-vt = First VT to run displays on
# lock-memory = True to prevent memory from being paged to disk
# user-authority-in-system-dir = True if session authority should be in the system location
# guest-account-script = Script to be run to setup guest account
# logind-check-graphical = True to on start seats that are marked as graphical by logind
# log-directory = Directory to log information to
# run-directory = Directory to put running state in
# cache-directory = Directory to cache to
# sessions-directory = Directory to find sessions
# remote-sessions-directory = Directory to find remote sessions
# greeters-directory = Directory to find greeters
# backup-logs = True to move add a .old suffix to old log files when opening new ones
# dbus-service = True if LightDM provides a D-Bus service to control it
#
[LightDM]
#start-default-seat=true
#greeter-user=lightdm
#minimum-display-number=0
#minimum-vt=7 # Setting this to a value < 7 implies security issues, see FS#46799
#lock-memory=true
#user-authority-in-system-dir=false
#guest-account-script=guest-account
#logind-check-graphical=false
#log-directory=/var/log/lightdm
run-directory=/run/lightdm
#cache-directory=/var/cache/lightdm
sessions-directory=/usr/share/lightdm/sessions:/usr/share/xsessions:/usr/share/wayland-sessions
#remote-sessions-directory=/usr/share/lightdm/remote-sessions
#greeters-directory=\$XDG_DATA_DIRS/lightdm/greeters:\$XDG_DATA_DIRS/xgreeters
#backup-logs=true
#dbus-service=true

#
# Seat configuration
#
# Seat configuration is matched against the seat name glob in the section, for example:
# [Seat:*] matches all seats and is applied first.
# [Seat:seat0] matches the seat named "seat0".
# [Seat:seat-thin-client*] matches all seats that have names that start with "seat-thin-client".
#
# type = Seat type (local, xremote)
# pam-service = PAM service to use for login
# pam-autologin-service = PAM service to use for autologin
# pam-greeter-service = PAM service to use for greeters
# xserver-command = X server command to run (can also contain arguments e.g. X -special-option)
# xmir-command = Xmir server command to run (can also contain arguments e.g. Xmir -special-option)
# xserver-config = Config file to pass to X server
# xserver-layout = Layout to pass to X server
# xserver-allow-tcp = True if TCP/IP connections are allowed to this X server
# xserver-share = True if the X server is shared for both greeter and session
# xserver-hostname = Hostname of X server (only for type=xremote)
# xserver-display-number = Display number of X server (only for type=xremote)
# xdmcp-manager = XDMCP manager to connect to (implies xserver-allow-tcp=true)
# xdmcp-port = XDMCP UDP/IP port to communicate on
# xdmcp-key = Authentication key to use for XDM-AUTHENTICATION-1 (stored in keys.conf)
# greeter-session = Session to load for greeter
# greeter-hide-users = True to hide the user list
# greeter-allow-guest = True if the greeter should show a guest login option
# greeter-show-manual-login = True if the greeter should offer a manual login option
# greeter-show-remote-login = True if the greeter should offer a remote login option
# user-session = Session to load for users
# allow-user-switching = True if allowed to switch users
# allow-guest = True if guest login is allowed
# guest-session = Session to load for guests (overrides user-session)
# session-wrapper = Wrapper script to run session with
# greeter-wrapper = Wrapper script to run greeter with
# guest-wrapper = Wrapper script to run guest sessions with
# display-setup-script = Script to run when starting a greeter session (runs as root)
# display-stopped-script = Script to run after stopping the display server (runs as root)
# greeter-setup-script = Script to run when starting a greeter (runs as root)
# session-setup-script = Script to run when starting a user session (runs as root)
# session-cleanup-script = Script to run when quitting a user session (runs as root)
# autologin-guest = True to log in as guest by default
# autologin-user = User to log in with by default (overrides autologin-guest)
# autologin-user-timeout = Number of seconds to wait before loading default user
# autologin-session = Session to load for automatic login (overrides user-session)
# autologin-in-background = True if autologin session should not be immediately activated
# exit-on-failure = True if the daemon should exit if this seat fails
#
[Seat:*]
#type=local
#pam-service=lightdm
#pam-autologin-service=lightdm-autologin
#pam-greeter-service=lightdm-greeter
#xserver-command=X
#xmir-command=Xmir
#xserver-config=
#xserver-layout=
#xserver-allow-tcp=false
#xserver-share=true
#xserver-hostname=
#xserver-display-number=
#xdmcp-manager=
#xdmcp-port=177
#xdmcp-key=
greeter-session=lightdm-slick-greeter
#greeter-hide-users=false
#greeter-allow-guest=true
#greeter-show-manual-login=false
#greeter-show-remote-login=true
user-session=dwm
#allow-user-switching=true
#allow-guest=true
#guest-session=
session-wrapper=/etc/lightdm/Xsession
#greeter-wrapper=
#guest-wrapper=
#display-setup-script=
#display-stopped-script=
#greeter-setup-script=
#session-setup-script=
#session-cleanup-script=
#autologin-guest=false
#autologin-user=
#autologin-user-timeout=0
#autologin-in-background=false
#autologin-session=
#exit-on-failure=false

#
# XDMCP Server configuration
#
# enabled = True if XDMCP connections should be allowed
# port = UDP/IP port to listen for connections on
# listen-address = Host/address to listen for XDMCP connections (use all addresses if not present)
# key = Authentication key to use for XDM-AUTHENTICATION-1 or blank to not use authentication (stored in keys.conf)
# hostname = Hostname to report to XDMCP clients (defaults to system hostname if unset)
#
# The authentication key is a 56 bit DES key specified in hex as 0xnnnnnnnnnnnnnn.  Alternatively
# it can be a word and the first 7 characters are used as the key.
#
[XDMCPServer]
#enabled=false
#port=177
#listen-address=
#key=
#hostname=

#
# VNC Server configuration
#
# enabled = True if VNC connections should be allowed
# command = Command to run Xvnc server with
# port = TCP/IP port to listen for connections on
# listen-address = Host/address to listen for VNC connections (use all addresses if not present)
# width = Width of display to use
# height = Height of display to use
# depth = Color depth of display to use
#
[VNCServer]
#enabled=false
#command=Xvnc
#port=5900
#listen-address=
#width=1024
#height=768
#depth=8" > /etc/lightdm/lightdm.conf

mkdir /usr/share/xsessions
echo "[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic Window Manager
Exec=/usr/local/bin/dwm
Type=Application" > /usr/share/xsessions/dwm.desktop

# touchpad settings
echo "Section \"InputClass\"
    Identifier \"touchpad\"
    Driver \"libinput\"
    MatchIsTouchpad \"on\"
    Option \"Tapping\" \"on\"
    Option \"NaturalScrolling\" \"true\"
EndSection" > /etc/X11/xorg.conf.d/30-touchpad.conf

# theme settings
echo "GTK_THEME=Arc-Dark
QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment

sudo -u $current_user echo "
Finished
Please reboot your computer"
