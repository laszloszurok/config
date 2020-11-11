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

$HOME/scripts/misc/setwallpaper &
setxkbmap -layout us,hu -option 'grp:alt_space_toggle' -option 'caps:swapescape'
picom &
numlockx &
lxpolkit &
$HOME/scripts/misc/inactivity &
$HOME/scripts/status/helper_scripts/reload_newsboat &
dwmblocks &
exec dwm
