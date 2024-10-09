#!/bin/sh

# Setup hostname
echo "$1" > /etc/hostname

# Change plymouth default theme
plymouth-set-default-theme kali

# Enable phog greeter if package is installed
if [ -f "`which phog`" ]; then
    systemctl enable greetd
elif [ -f "`which phosh-session`" ]; then
    systemctl enable phosh
fi

# Enable essential services
systemctl enable bluetooth.service
systemctl enable ssh.service

# systemd-firstboot requires user input, which isn't possible
# on mobile devices
systemctl disable systemd-firstboot.service
systemctl mask systemd-firstboot.service
