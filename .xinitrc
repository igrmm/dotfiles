#!/usr/bin/env sh

# -- Starting up some programs
xwallpaper --zoom "$XDG_DATA_HOME"/wall.png
setxkbmap -option altwin:swap_alt_win
picom &
setlaptoptrackpad
dunst &
birdtray &
steam -silent &
telegram-desktop -startintray &
~/projects/dwmbar/dwmbar & exec dwm
