#!/usr/bin/bash

PKG="spotify-client"

if grep -q "install $PKG" /var/log/dpkg.log || grep -q "upgrade $PKG" /var/log/dpkg.log; then
    /usr/local/bin/spotify-debfixes
    #echo "Spotify DEB Fixes installed!"
#elif grep -q "remove $PKG" /var/log/dpkg.log || grep -q "purge $PKG" /var/log/dpkg.log; then
#    /usr/local/bin/spotify-debfixes --uninstall
    #echo "Spotify DEB Fixes uninstalled!"
fi