#!/usr/bin/env sh

# -- Starting up some programs
xwallpaper --zoom ~/wall.png
setxkbmap -option altwin:swap_alt_win
picom &
gdrive pull &

# -- Start window manager
exec dwm
