#!/bin/sh

# Comply with https://wiki.archlinux.org/title/Xinit and make sure the scripts
# in /etc/X11/xinit/xinitrc.d are sourced.
xinitdir="/etc/X11/xinit"
if [ -d "$xinitdir"/xinitrc.d ] ; then
	for f in "$xinitdir/xinitrc.d"/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# -- Starting up some programs
xwallpaper --zoom "$XDG_DATA_HOME"/wall.png
setxkbmap -option altwin:swap_alt_win
picom &
dunst &
birdtray &
steam -silent &
Telegram -startintray &
sxhkd &
keepassxc &
joplin &
xsetroot -cursor_name left_ptr &
polybar -r bar &
flameshot &
ferdium &

exec bspwm
