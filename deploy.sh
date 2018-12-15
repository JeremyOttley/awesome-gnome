#!/usr/bin/env bash

set -Eeuxo pipefail

IFS=$'\n\t'

trap 'echo Error at about $LINENO' ERR

cat <<"EOS">~/.xsession
exec ck-launch-session gnome-session --session awesome "$@" 
EOS

sudo chmod +x .xsession
ln -s ~/.xsession ~/.xinitrc

mkdir -p  ~/.config/gnome-session/sessions/

cat <<"EOS"> ~/.config/gnome-session/sessions/awesome.session
[GNOME Session]
Name=Awesome session
RequiredComponents=gnome-settings-daemon;
RequiredProviders=windowmanager;notifications;
DefaultProvider-windowmanager=awesome
DefaultProvider-notifications=notification-daemon
EOS

mkdir -p ~/.local/share/applications

cat <<"EOS"> ~/.local/share/applications/awesome.desktop
[Desktop Entry] 
Encoding=UTF-8
Name=awesome
Type=Application
Comment=Highly configurable framework window manager
TryExec=awesome
Exec=awesome
NoDisplay=true
X-GNOME-WMName=Awesome
X-GNOME-Autostart-Phase=WindowManager
X-GNOME-Provides=windowmanager
X-GNOME-Autostart-Notify=false
EOS

#sudo mv -vf /usr/share/xsessions/xsession.desktop /usr/share/xsessions/xsession.desktop.before

cat <<"EOS"|sudo tee -a /usr/share/xsessions/xsession.desktop
[Desktop Entry]
Name=Xsession
Comment=This just runs ~/.xsession
Exec=/etc/X11/Xsession
EOS

git clone https://github.com/jeremyottley/awm.git ~/.config/awesome/
