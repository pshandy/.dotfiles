#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

setxkbmap -layout 'us,ru' -option 'grp:alt_shift_toggle,grp_led:scroll' &
bash ~/.config/polybar/launch.sh --docky & 
# (xdo id -m -N Polybar && polybar-msg cmd toggle; bspc config bottom_padding +0) &
picom -b --config ~/.config/picom/picom.conf & 
nitrogen --restore &
xsetroot -cursor_name left_ptr &
polybar-msg cmd toggle &
wmname "LG3D" &
#picom -f &
exec bspwm
