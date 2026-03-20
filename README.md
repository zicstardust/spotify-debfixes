# Spotify Linux Client .DEB fixes


This script includes enhancements and fixes to Spotify official .DEB:
- Built-in FFMPEG libraries for playing local files
- Persistent flags configuration file
- Persistent environment variables configuration file

## Tested on:
- Debian (official .deb package)
- Ubuntu (official .deb package)

## Dependencies
- spotify-client (official .deb)
- curl
- bash
- tar
- grep

## Install
```sh
curl https://raw.githubusercontent.com/zicstardust/spotify-debfixes/main/install.sh > /tmp/spotify-debfixes.sh; sudo bash /tmp/spotify-debfixes.sh
```

After installation, Spotify is already fixed.

Whenever the `spotify-client` package is updated, a hook will be automatically triggered to apply the fixes.

## Uninstall
It will remove all the fixes.

```sh
spotify-debfixes --uninstall
```

## Usage

### Making flags persistent

Flag file `~/.config/spotify/spotify-flags.conf`

Below is an example spotify-flags.conf file that defines the flags --force-device-scale-factor:
```conf

~/.config/spotify/spotify-flags.conf

# This line will be ignored.
--force-device-scale-factor=1.5
```

### Making environment variables persistent

Flag file `~/.config/spotify/spotify.env`

Below is an example spotify.env file that defines the environment variables WAYLAND_DISPLAY
```conf

~/.config/spotify/spotify.env

# This line will be ignored.
WAYLAND_DISPLAY=
```
