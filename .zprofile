#!/bin/sh

#XDG DIRs
source ~/.config/user-dirs.dirs
export XDG_DESKTOP_DIR
export XDG_DOWNLOAD_DIR
export XDG_CONFIG_HOME
export XDG_DATA_HOME
export XDG_CACHE_HOME

#PREFERENCES
export TERMINAL=wezterm
export BROWSER=firefox
export EDITOR=nvim
export GDRIVE_PATH="$HOME"/gdrive
export DOTFILES="$HOME"/repositories/dotfiles
export SCRIPTS="$HOME"/repositories/scripts
export BSPWMSCRIPTS="$SCRIPTS"/bspwm
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

#PATH
export PATH=$SCRIPTS/wrappers:$PATH:$SCRIPTS/bin

#CONFIG FILES
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc-2.0
export LESSHISTFILE="-"
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

#JAVA
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export _JAVA_AWT_WM_NONREPARENTING=1
export ANDROID_SDK_ROOT=/opt/android-sdk
export ANDROID_SDK_HOME="$XDG_DATA_HOME"/android
export ANDROID_HOME="$ANDROID_SDK_ROOT"
export ANDROID_NDK_HOME="$ANDROID_SDK_ROOT"/ndk

#FIX QT HIDPI BUG
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_QPA_PLATFORMTHEME=gtk2

[ "$(tty)" = "/dev/tty1" ] && exec startx "$DOTFILES"/.xinitrc
