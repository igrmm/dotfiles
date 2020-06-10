#!/usr/bin/env sh

setxkbmap -option altwin:swap_alt_win
picom & exec dwm
