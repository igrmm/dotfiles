#!/bin/sh

source ~/.config/user-dirs.dirs

export PATH=$PATH:/usr/lib/jvm/java-8-openjdk/bin:~/scripts/bin
export TERMINAL=st
export BROWSER=firefox
export EDITOR=nvim
export _JAVA_AWT_WM_NONREPARENTING=1
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export ANDROID_HOME=~/.android/Sdk
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

[ "$(tty)" = "/dev/tty1" ] && exec startx ~/dotfiles/.xinitrc
