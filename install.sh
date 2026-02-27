#!/usr/bin/env bash

option=$1
current_dir=$(pwd)

#Check root
if [ "$(whoami)" != "root" ]; then
    echo "Please, run as root"
    exit 2
fi

if [ $"$option" == "--uninstall" ]; then
    rm -Rf /usr/share/spotifyffmpeg
    rm -f /usr/local/bin/spotify-ffmpegfix #Remove old version
    rm -f /usr/local/bin/spotify-debfixes
    rm -f /usr/bin/spotify
    ln -s /usr/share/spotify/spotify /usr/bin/spotify
    chmod +x /usr/bin/spotify
    echo "Spotify DEB Fixes uninstalled!"
    exit 0
fi

rm -f /usr/local/bin/spotify-ffmpegfix #Remove old version

mkdir -p /usr/local/bin
curl https://raw.githubusercontent.com/zicstardust/spotify-debfixes/main/install.sh > /usr/local/bin/spotify-debfixes
chmod +x /usr/local/bin/spotify-debfixes

rm -Rf /usr/share/spotifyffmpeg
mkdir -p /usr/share/spotifyffmpeg
cd /usr/share/spotifyffmpeg
curl -fSL "https://github.com/zicstardust/spotify-debfixes/releases/download/1.0/spotify_ffmpeg_libs_linux_x86_64.tar.gz" -o spotify_ffmpeg_libs_linux_x86_64.tar.gz &> /dev/null
tar -xf spotify_ffmpeg_libs_linux_x86_64.tar.gz &> /dev/null
rm -f spotify_ffmpeg_libs_linux_x86_64.tar.gz
chmod -R +x *


rm -f /usr/bin/spotify
cat > /usr/bin/spotify <<"EXEC"
#!/usr/bin/bash
export LD_LIBRARY_PATH="/usr/share/spotifyffmpeg${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

if [ ! -f ${HOME}/.config/spotify/spotify-flags.conf ]; then
    touch "${HOME}/.config/spotify/spotify-flags.conf" &> /dev/null
fi

if [ ! -f ${HOME}/.config/spotify/spotify.env ]; then
    touch "${HOME}/.config/spotify/spotify.env" &> /dev/null
fi

mapfile -t FLAGS <<< "$(grep -v -E '^\s*$|^#' "${HOME}/.config/spotify/spotify-flags.conf")"
mapfile -t ENVS <<< "$(grep -v -E '^\s*$|^#' "${HOME}/.config/spotify/spotify.env")"

if [[ -z \${ENVS[0]} ]]; then
    exec /usr/share/spotify/spotify \\
        "\${FLAGS[@]}" \\
        "\$@"
else
    exec env "\${ENVS[@]}" \\
        /usr/share/spotify/spotify \\
        "\${FLAGS[@]}" \\
        "\$@"
fi

EXEC
chmod +x /usr/bin/spotify

cd $current_dir

echo "Spotify DEB Fixes installed!"