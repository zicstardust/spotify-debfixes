#!/usr/bin/bash

BACKGROUND_YELLOW='\033[43m'
NOCOLOR='\033[0m'

PKG="spotify-client"

LAST_LINE=$(grep "$PKG" /var/log/dpkg.log | tail -n1)

#if echo "$LAST_LINE" | grep -q "upgrade $PKG\|install $PKG"; then
if echo "$LAST_LINE" | grep -q "status installed $PKG"; then
    #/usr/local/bin/spotify-debfixes
    #echo "Spotify DEB Fixes installed!"
    echo -e "${BACKGROUND_YELLOW}spotify-client upgrade/install detected. Please run \"spotify-debfixes\" to apply the necessary fixes.${NOCOLOR}"
#elif echo "$LAST_LINE" | grep -q "remove $PKG\|purge $PKG"; then
elif echo "$LAST_LINE" | grep -q "status not-installed $PKG"; then
    #/usr/local/bin/spotify-debfixes --uninstall
    #echo "Spotify DEB Fixes uninstalled!"
    echo -e "${BACKGROUND_YELLOW}spotify-client remove/purge detected. Please run \"spotify-debfixes --uninstall\" to remove the necessary fixes.${NOCOLOR}"
fi
