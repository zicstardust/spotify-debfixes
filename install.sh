#!/usr/bin/env bash

option=$1

set -e
: "${BRANCH:=main}"

#Check root
if [ "$(whoami)" != "root" ]; then
    echo "Please, run as root"
    exit 2
fi

if [ $"$option" == "--uninstall" ]; then
    rm -Rf /usr/share/spotifyffmpeg
    rm -f /usr/local/bin/spotify-debfixes
    rm -f /usr/share/spotifydebfixes-hook.sh
    rm -f /etc/apt/apt.conf.d/99spotify-debfixes
    rm -f /usr/bin/spotify
    ln -s /usr/share/spotify/spotify /usr/bin/spotify
    chmod +x /usr/bin/spotify
    echo "Spotify DEB Fixes uninstalled!"
    exit 0
elif [ $"$option" != "" ]; then
    echo "Unknown option: $option"
    echo "Usage: $0 [--uninstall]"
    exit 1
fi


#Install spotify-debfixes
mkdir -p /usr/local/bin
curl https://raw.githubusercontent.com/zicstardust/spotify-debfixes/refs/heads/${BRANCH}/install.sh > /usr/local/bin/spotify-debfixes
chmod +x /usr/local/bin/spotify-debfixes



#Install ffmpeg libs
if [ -d /usr/share/spotifyffmpeg ]; then
    rm -Rf /usr/share/spotifyffmpeg
fi
mkdir -p /usr/share/spotifyffmpeg
curl -fSL "https://github.com/zicstardust/spotify-debfixes/releases/download/1.0/spotify_ffmpeg_libs_linux_x86_64.tar.gz" -o spotify_ffmpeg_libs_linux_x86_64.tar.gz &> /dev/null
tar -xzf spotify_ffmpeg_libs_linux_x86_64.tar.gz -C /usr/share/spotifyffmpeg/ &> /dev/null
rm -f spotify_ffmpeg_libs_linux_x86_64.tar.gz
chmod -R +x /usr/share/spotifyffmpeg/*


#Install spotify-bin
if [ -f /usr/bin/spotify ]; then
    rm -f /usr/bin/spotify
fi

curl https://raw.githubusercontent.com/zicstardust/spotify-debfixes/refs/heads/${BRANCH}/src/spotify-bin.sh > /usr/bin/spotify
chmod +x /usr/bin/spotify


#Install script hook
curl https://raw.githubusercontent.com/zicstardust/spotify-debfixes/refs/heads/${BRANCH}/src/spotifydebfixes-hook.sh > /usr/share/spotifydebfixes-hook.sh
chmod +x /usr/share/spotifydebfixes-hook.sh


# Install apt hook
mkdir -p /etc/apt/apt.conf.d
curl https://raw.githubusercontent.com/zicstardust/spotify-debfixes/refs/heads/${BRANCH}/src/99spotify-debfixes > /etc/apt/apt.conf.d/99spotify-debfixes



echo "Spotify DEB Fixes installed!"
