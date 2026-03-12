#!/usr/bin/bash

PKG="spotify-client"

if grep -q "install $PKG" /var/log/dpkg.log || grep -q "upgrade $PKG" /var/log/dpkg.log; then
    /usr/local/bin/spotify-debfixes
    #echo "Spotify DEB Fixes installed!"
fi