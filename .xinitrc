#!/usr/bin/env sh

# -- Starting up some programs
xwallpaper --zoom ~/wall.png
setxkbmap -option altwin:swap_alt_win
picom &
setlaptoptrackpad
dunst -config ~/dotfiles/.config/dunst/dunstrc &
birdtray &
steam &
exec dwm
