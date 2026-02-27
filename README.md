# Spotify Linux Client .DEB fixes


This script includes enhancements and fixes to official .DEB:
- Built-in FFMPEG libraries for playing local files
- Persistent flags configuration file
- Persistent environment variables configuration file

## Tested on:
- Debian (official .deb package)
- Ubuntu (official .deb package)

## Install

### Dependecies
- curl
- bash
- tar
- grep

### Install
```sh
curl https://raw.githubusercontent.com/zicstardust/spotify-debfixes/main/install.sh > /tmp/spotify-debfixes.sh; sudo bash /tmp/spotify-debfixes.sh
```

## Usage
After installation, Spotify is already fixed.
Whenever the spotify package updates, it will be necessary to run the command:
```sh
spotify-debfixes
```

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


### Uninstall
```sh
spotify-debfixes --uninstall
```