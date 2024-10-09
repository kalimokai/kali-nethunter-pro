#!/bin/sh

DEBIAN_SUITE=$1
SUITE=$2
CONTRIB=$3
NONFREE=$4

COMPONENTS="main"
[ "$CONTRIB" = "true" ] && COMPONENTS="$COMPONENTS contrib"
[ "$NONFREE" = "true" ] && COMPONENTS="$COMPONENTS non-free non-free-firmware"

# Add source repo
if [ "$DEBIAN_SUITE" = "kali-rolling" ]; then
    echo "#deb-src http://http.kali.org/kali kali-rolling $COMPONENTS" >> /etc/apt/sources.list
fi

# Set the proper suite in our sources.list
sed -i "s/@@SUITE@@/${SUITE}/" /etc/apt/sources.list.d/mobian.list

cat > /etc/apt/preferences.d/00-kali-priority << EOF
Package: *
Pin: release o=Kali
Pin-Priority: 600
EOF

cat > /etc/apt/preferences.d/10-mobian-priority << EOF
Package: u-boot-menu*
Pin: release o=Mobian
Pin-Priority: 700

Package: alsa-ucm-conf
Pin: release o=Mobian
Pin-Priority: 700

Package: libqrtr1
Pin: release o=Mobian
Pin-Priority: 700

Package: protection-domain-mapper
Pin: release o=Mobian
Pin-Priority: 700

Package: qrtr-tools
Pin: release o=Mobian
Pin-Priority: 700
EOF