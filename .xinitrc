#!/usr/bin/env sh

# -- Starting up some programs
xwallpaper --zoom "$XDG_DATA_HOME"/wall.png
setxkbmap -option altwin:swap_alt_win
picom &
setlaptoptrackpad
dunst -config ~/dotfiles/.config/dunst/dunstrc &
birdtray &
steam -silent &
exec dwm
