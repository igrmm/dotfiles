#!/bin/sh

# -- Starting up some programs
xwallpaper --zoom "$XDG_DATA_HOME"/wall.png
setxkbmap -option altwin:swap_alt_win
picom &
dunst &
birdtray &
steam -silent &
telegram-desktop -startintray &
sxhkd &
xsetroot -cursor_name left_ptr &
polybar -r bar &

exec bspwm
