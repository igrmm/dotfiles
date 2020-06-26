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

#start dwmbar
[ -d /tmp/dwmbar.lock ] && rm -rf /tmp/dwmbar.lock
[ -f /tmp/dwmbarlog ] && rm -rf /tmp/dwmbarlog
exec ~/projects/dwmbar/dwmbar FETCHALL &
exec ~/projects/dwmbar/dwmbar &

exec dwm
