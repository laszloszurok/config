#!/bin/sh

#        -lf/nf/cf color
#            Defines the foreground color for low, normal and critical notifications respectively.
#
#        -lb/nb/cb color
#            Defines the background color for low, normal and critical notifications respectively.
#
#        -lfr/nfr/cfr color
#            Defines the frame color for low, normal and critical notifications respectively.

[ -f "$HOME/.cache/wal/colors.sh" ] && . "$HOME/.cache/wal/colors.sh"

pidof dunst && killall dunst

dunst -conf "$HOME/.config/dunst/dunstrc" \
      -lf  "${color15:-}" \
      -lb  "${color0:-}" \
      -lfr "${color7:-}" \
      -nf  "${color15:-}" \
      -nb  "${color0:-}" \
      -nfr "${color7:-}" \
      -cf  "${color15:-}" \
      -cb  "${color0:-}" \
      -cfr "${color7:-}" > /dev/null 2>&1 &
