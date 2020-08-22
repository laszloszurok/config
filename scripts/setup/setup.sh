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
pacman -S pcmanfm-gtk3 firefox qbittorrent gvfs gvfs-mtp ntfs-3g zip unzip xarchiver zathura zathura-pdf-poppler gimp lxappearance qt5ct neovim zsh zsh-syntax-highlighting ttf-font-awesome ttf-dejavu feh python-pywal scrot numlockx xclip arc-gtk-theme arc-icon-theme powertop lxsession mpv dunst discord alsa-utils playerctl sxiv libreoffice-still texlive-most ffmpeg ffmpegthumbnailer cups usbutils ufw vifm ueberzug newsboat picom xautolock virt-manager qemu dnsmaq

# installing yay
sudo -u $current_user git clone https://aur.archlinux.org/yay.git
cd /home/$current_user/yay
sudo -u $current_user makepkg -si

cd /home/$current_user

# installing softwer from the AUR
sudo -u $current_user yay -S spotify
sudo -u $current_user yay -S spicetify-cli
sudo -u $current_user yay -S windscribe-cli
sudo -u $current_user yay -S hugo
sudo -u $current_user yay -S vscodium-bin
sudo -u $current_user yay -S jmptfs

# enabling services
sh -c "echo -e '[Unit]\nDescription=PowerTop\n\n[Service]\nType=oneshot\nRemainAfterExit=true\nExecStart=/usr/bin/powertop --auto-tune\n\n[Install]\nWantedBy=multi-user.target\n' > /etc/systemd/system/powertop.service"
systemctl enable --now powertop
systemctl enable org.cups.cupsd.socket
ufw default deny incoming
ufw default allow outgoing
ufw enable

# service to launch slock on suspend
echo "[Unit]
Description=Lock X session using slock for user %i
Before=sleep.target
Before=suspend.target

[Service]
User=%i
Type=simple
Environment=DISPLAY=:0
ExecStartPre=/usr/bin/xset dpms force suspend
ExecStart=/usr/local/bin/slock
TimeoutSec=infinity

[Install]
WantedBy=sleep.target
WantedBy=suspend.target" > /etc/systemd/system/slock@.service

systemctl enable slock@$current_user.service

# disable tty swithcing when X is running, so the lockscreen cannot be bypassed
echo "Section \"ServerFlags\"
    Option \"DontVTSwitch\" \"True\"
EndSection" > /etc/X11/xorg.conf.d/xorg.conf

# cloning my configs from my github and setting up a bare repository for config file management
sudo -u $current_user git clone --separate-git-dir=/home/$current_user/.myconf https://github.com/laszloszurok/suckless-arch.git /home/$current_user/myconf-tmp
sudo -u $current_user rm -r /home/$current_user/.config
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
cd ../slock
make install

cd /home/$current_user

# spotify wm
sudo -u $current_user git clone https://github.com/dasJ/spotifywm.git
cd /home/$current_user/spotifywm
sudo -u $current_user make
sudo -u $current_user echo "LD_PRELOAD=/usr/lib/libcurl.so.4:/home/pulzar/spotifywm/spotifywm.so /usr/bin/spotify" > /usr/local/bin/spotify

cd /home/$current_user

# changing the default shell to zsh
sudo -u $current_user mkdir /home/$current_user/.cache/zsh
echo "ZDOTDIR=\$HOME/.config/zsh" > /etc/zsh/zshenv
sudo -u $current_user chsh -s /usr/bin/zsh

# zdata cache directory
sudo -u $current_user mkdir /home/$current_user/.cache/z

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
