#!/bin/bash
wal -R -o "$HOME/.config/dunst/dunst_with_pywal.sh"
setxkbmap -layout us,hu -option 'grp:alt_space_toggle' -option 'caps:swapescape'
picom &
numlockx &
wmname LG3D
lxpolkit &
$HOME/scripts/misc/inactivity &
$HOME/scripts/status/helper_scripts/reload_newsboat &
dwmblocks
