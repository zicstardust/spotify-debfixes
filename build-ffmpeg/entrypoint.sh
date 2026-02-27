#!/usr/bin/env bash

set -e

: "${PUID:=1000}"
: "${PGID:=1000}"

if ! getent group ffmpeg >/dev/null; then
    groupadd -g "$PGID" ffmpeg
fi

if ! id -u ffmpeg >/dev/null 2>&1; then
    useradd -m -u "$PUID" -g "$PGID" -s /sbin/nologin ffmpeg
fi

mkdir -p /data /home/ffmpeg /app /build

chown -R ffmpeg:ffmpeg /app /data /build /home/ffmpeg

exec gosu ffmpeg "$@"