#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f $userresources ]; then
    xrdb -merge $userresources
fi

if [ -f $usermodmap ]; then
    xmodmap $usermodmap
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x $f ] && . $f
 done
 unset f
fi

setwallpaper &

# use 'localectl list-x11-keymap-options | grep grp' to get toggleing options
setxkbmap hu -option 'caps:swapescape'

# Bind the right alt key to Mod4 (the Windows key)
# Use 'xmodmap -pke | grep Alt_R' to get the appropriate keycode
xmodmap -e "keycode 108 = Super_L"
xmodmap -e "remove mod1 = Super_L"

unclutter --timeout 15 --ignore-scrolling --jitter 50 &
picom &
numlockx &
lxpolkit &
inactivity &
dwmblocks &
exec dwm
