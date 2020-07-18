#!/bin/bash
wal -R -o "$HOME/.config/dunst/dunst_with_pywal.sh"
setxkbmap -layout us,hu -option 'grp:alt_space_toggle'
numlockx &
wmname LG3D
lxpolkit &
light-locker --lock-after-screensaver=120 &
$HOME/scripts/misc/suspend_after_screensaver &
dwmblocks
