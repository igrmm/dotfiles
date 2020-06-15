#!/bin/sh

# export xdg user directories
source ~/.config/user-dirs.dirs
export XDG_DESKTOP_DIR
export XDG_DOWNLOAD_DIR
export XDG_CONFIG_HOME
export XDG_DATA_HOME
export XDG_CACHE_HOME

export PATH=$PATH:~/scripts/bin
export TERMINAL=st
export BROWSER=firefox
export EDITOR=nvim
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

#JAVA
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}"
export ANDROID_SDK_ROOT="${XDG_CONFIG_HOME}/android/sdk"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android"

[ "$(tty)" = "/dev/tty1" ] && exec startx ~/dotfiles/.xinitrc
