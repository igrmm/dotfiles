#!/bin/sh

export PATH=$PATH:/usr/lib/jvm/java-8-openjdk/bin:$HOME/scripts/bin
export TERMINAL=st
export BROWSER=firefox
export EDITOR=nvim
export _JAVA_AWT_WM_NONREPARENTING=1
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export ANDROID_HOME=$HOME/.android/Sdk

[ "$(tty)" = "/dev/tty1" ] && exec startx $HOME/dotfiles/.xinitrc
