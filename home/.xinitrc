if [ -f ~/.Xresources ]; then
    xrdb -merge ~/.Xresources
fi;
if [ -d /usr/share/fonts/local ]; then
    xset +fp /usr/share/fonts/local
fi;
xset fp rehash
xset -b
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
exec dbus-launch --exit-with-session openbox-session
