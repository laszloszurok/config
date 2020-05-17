#!/bin/bash
wal -R -o '/home/pulzar/.config/dunst/dunst_with_pywal.sh'
setxkbmap -layout hu,us -option 'grp:alt_space_toggle'
numlockx &
wmname LG3D
lxpolkit &
light-locker --lock-after-screensaver=120 &
/home/pulzar/bin/suspend_after_screensaver &
dwmblocks
