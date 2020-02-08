#!/usr/bin/env sh

# -- Starting up some programs
setxkbmap -option altwin:swap_alt_win
picom &

# -- Start window manager
exec dwm
