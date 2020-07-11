#!/bin/bash

sudo pacman -Syyu

sudo pacman -S dkms git

git clone https://github.com/lwfinger/rtw88.git ~/rtw88
cd ~/rtw88
make
sudo make install

sudo dkms add ~/rtw88
sudo dkms install rtlwifi-new/0.6

nmtui
