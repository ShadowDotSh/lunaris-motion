# lunaris-motion
Play a video as desktop wallpaper on i3wm.

## Disclaimer
Lunaris-motion is only tested on Arch Linux using i3 and Xlibre. Wayland, other window managers, or distributions with older packages (e.g., rofi < 1.7.6) are not supported.

## Features
- Supports Wallpaper Engine workshop on Steam, Steam Flatpak, or custom directory set on the config.
- A daemon to pause the player when a window is open.
- Additional features can be added via interacting with the mpv socket.
- Extracts the current video frame as a static wallpaper on exit.
- Custom mpv menu on right-click.

## Dependencies
| Package | Why |
|---------|--------|
| ffmpegthumbnailer | Video Thumbnails |
| mpv | Player |
| rofi | Selection |
| socat | Communicates with the mpv socket |
| xwinwrap | Embed player into background |
| xwallpaper | Apply static wallpaper |

## Installation
``` bash
git clone https://github.com/ShadowDotSh/lunaris-motion.git
cd lunaris-motion
sudo make install
```

## Usage
See options on a rofi menu:
``` bash
lunaris-motion --menu
```

See options on a terminal:
``` bash
lunaris-motion --help
```

Generate configuration:
``` bash
lunaris-motion --gen-config
```

## i3 configuration example
Add to `~/.config/i3/config`

``` i3config
exec --no-startup-id nice -n 19 ionice -c 3 lunaris-motion --restore
```
