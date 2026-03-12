#!/usr/bin/bash

PKG="spotify-client"

if tail -n 50 /var/log/dpkg.log | grep -q "upgrade $PKG\|install $PKG"; then
    /usr/local/bin/spotify-debfixes
    #echo "Spotify DEB Fixes installed!"
#elif tail -n 50 /var/log/dpkg.log | grep -q "remove $PKG\|purge $PKG"; then
#    /usr/local/bin/spotify-debfixes --uninstall
    #echo "Spotify DEB Fixes uninstalled!"
fi