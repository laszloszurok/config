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

# check internet connection
systemctl enable --now NetworkManager
ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null && echo "internet connection ok" || `echo "no internet connection"; exit 1`

# sync mirrors, update the system
pacman -Syyu

# fixing wireless driver, connecting to wifi
pacman -S dkms git
sudo -u $current_user git clone https://github.com/lwfinger/rtw88.git /home/$current_user/.config/rtw88
cd /home/$current_user/.config/rtw88
sudo -u $current_user make
make install
cd /home/$current_user
dkms add ./.config/rtw88
dkms install rtlwifi-new/0.6
nmtui

# x related
pacman -S xf86-video-intel xf86-video-amdgpu xorg xorg-xinit

# installing my most used software

# graphical file explorer
pacman -S pcmanfm-gtk3 gvfs gvfs-mtp ntfs-3g

# archiving tools
pacman -S zip unzip xarchiver

# pdf reader
pacman -S zathura zathura-pdf-poppler

# themeing tools and themes
pacman -S lxappearance qt5ct arc-gtk-theme arc-icon-theme python-pywal feh picom

# shell
pacman -S zsh zsh-syntax-highlighting

# other x tools
pacman -S numlockx xclip xautolock

# virt-manager
pacman -S virt-manager qemu ebtables dnsmasq
usermod -aG libvirt $current_user
systemctl enable --now libvirtd
virsh net-autostart default

# fonts
pacman -S ttf-font-awesome ttf-dejavu

# browsers
pacman -S firefox qutebrowser

# multimedia
pacman -S mpv alsa-utils playerctl ffmpeg

# vifm
pacman -S vifm ffmpegthumbnailer ueberzug

# printing service
pacman -S cups
systemctl enable org.cups.cupsd.socket

# firewall
pacman -S ufw
ufw default deny incoming
ufw default allow outgoing
ufw enable

# power saving
pacman -S powertop
sh -c "echo -e '[Unit]\nDescription=PowerTop\n\n[Service]\nType=oneshot\nRemainAfterExit=true\nExecStart=/usr/bin/powertop --auto-tune\n\n[Install]\nWantedBy=multi-user.target\n' > /etc/systemd/system/powertop.service"
systemctl enable --now powertop

# neovim
pacman -S nodejs npm python-pip neovim
sudo -u $current_user python3 -m pip install --user --upgrade pynvim

# misc
pacman -S qbittorrent gimp scrot lxsession dunst sxiv texlive-most usbutils newsboat pass translate-shell galculator gnu-netcat

# installing yay
sudo -u $current_user git clone https://aur.archlinux.org/yay.git
cd /home/$current_user/yay
sudo -u $current_user makepkg -si

cd /home/$current_user

# installing softwer from the AUR
sudo -u $current_user yay -S spotify
sudo -u $current_user yay -S spicetify-cli
sudo -u $current_user yay -S protonvpn-cli-ng
sudo -u $current_user yay -S windscribe-cli
sudo -u $current_user yay -S hugo
sudo -u $current_user yay -S vscodium-bin
sudo -u $current_user yay -S ripcord
sudo -u $current_user yay -S brave-bin
sudo -u $current_user yay -S onlyoffice-bin
sudo -u $current_user yay -S scrcpy

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

# cloning my configs from gitlab and setting up a bare repository for config file management
sudo -u $current_user git clone --separate-git-dir=/home/$current_user/.myconf https://gitlab.com/laszloszurok/suckless-arch.git /home/$current_user/myconf-tmp
sudo -u $current_user cp -rf /home/$current_user/myconf-tmp/scripts /home/$current_user/myconf-tmp/suckless-builds /home/$current_user
sudo -u $current_user cp -rf /home/$current_user/myconf-tmp/.config/* /home/$current_user/.config
sudo -u $current_user cp -f /home/$current_user/myconf-tmp/.xinitrc /home/$current_user
sudo -u $current_user rm -rf /home/$current_user/myconf-tmp/
sudo -u $current_user /usr/bin/git --git-dir=/home/$current_user/.myconf/ --work-tree=/home/$current_user config status.showUntrackedFiles no

# cloning my wallpaper repo
sudo -u $current_user git clone https://gitlab.com/laszloszurok/Wallpapers /home/$current_user/pictures/wallpapers

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
sudo -u $current_user git clone https://github.com/dasJ/spotifywm.git /home/$current_user/.config/spotifywm
cd /home/$current_user/.config/spotifywm
sudo -u $current_user make
sudo -u $current_user echo "LD_PRELOAD=/usr/lib/libcurl.so.4:/home/$current_user/.config/spotifywm/spotifywm.so /usr/bin/spotify" > /usr/local/bin/spotify
chmod +x /usr/local/spotify

cd /home/$current_user

# changing the default shell to zsh
sudo -u $current_user mkdir /home/$current_user/.cache/zsh
echo "ZDOTDIR=\$HOME/.config/zsh" > /etc/zsh/zshenv
sudo -u $current_user chsh -s /usr/bin/zsh

# zdata history directory
sudo -u $current_user mkdir /home/$current_user/.local/share/z

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
echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment

sudo -u $current_user echo "
Finished
Please reboot your computer"
