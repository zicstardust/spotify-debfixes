#!/usr/bin/bash
export LD_LIBRARY_PATH="/usr/share/spotifyffmpeg${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

if [ ! -f ${HOME}/.config/spotify/spotify-flags.conf ]; then
    touch "${HOME}/.config/spotify/spotify-flags.conf" &> /dev/null
fi

if [ ! -f ${HOME}/.config/spotify/spotify.env ]; then
    touch "${HOME}/.config/spotify/spotify.env" &> /dev/null
fi

mapfile -t FLAGS <<< "$(grep -v -E '^\s*$|^#' "${HOME}/.config/spotify/spotify-flags.conf")"
mapfile -t ENVS <<< "$(grep -v -E '^\s*$|^#|^[^=]*$' "${HOME}/.config/spotify/spotify.env")"

if [[ -z ${ENVS[0]} ]]; then
    exec /usr/share/spotify/spotify \
        "${FLAGS[@]}" \
        "$@"
else
    exec env "${ENVS[@]}" \
        /usr/share/spotify/spotify \
        "${FLAGS[@]}" \
        "$@"
fi