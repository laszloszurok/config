#!/bin/bash

cd ~

sudo pacman -Syyu pcmanfm-gtk3 firefox qbittorrent gvfs gvfs-ntp ntfs-3g zip unzip xarchiver zathura zathura-pdf-poppler gimp lxappearance kvantum-qt5 neovim zsh zsh-syntax-highlighting ttf-font-awesome ttf-dejavu feh python-pywal vscodium scrot numlockx xclip arc-gtk-theme arc-icon-theme powertop lxsession mpv dunst light-locker discord lightdm alsa-utils

# installing yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

cd ~

yay -Sy spotify spicetify-cli windscribe-cli lightdm-slick-greeter lightdm-settings hugo android-studio

# gaining read and write permissions over spotify files
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

# enabling spotify dev-tools
spicetify backup apply enable-devtool

# applying custom css theme for spotify
spicetify update

# installing lyrics fetching app for spotify
cd "$(dirname "$(spicetify -c)")/CustomApps"
git clone https://github.com/khanhas/genius-spicetify
mv "genius-spicetify" genius
spicetify config custom_apps genius
spicetify apply

# eabling services
sudo sh -c "echo -e '[Unit]\nDescription=PowerTop\n\n[Service]\nType=oneshot\nRemainAfterExit=true\nExecStart=/usr/bin/powertop --auto-tune\n\n[Install]\nWantedBy=multi-user.target\n' > /etc/systemd/system/powertop.service"
sudo systemctl enable --now powertop
sudo systemctl enable --now lxsession
sudo systemctl enable lightdm
