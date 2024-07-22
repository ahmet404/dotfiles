#!/usr/bin/env sh

# export SSH_AUTH_SOCK

## Executed by startx (run your window manager from here)
xrdb -load ~/.Xresources
xset +fp /usr/share/fonts/local
xset fp rehash

if [ -d /etc/X11/xinit/xinitrc.d  ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f"  ] && . "$f"
  done
  unset f
fi

# Load .xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# set cursor
xsetroot -cursor_name left_ptr

exec i3
