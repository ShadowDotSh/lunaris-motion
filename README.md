# lunaris-motion
Play video as desktop wallpaper on i3wm.

## Showcase
[![Showcase](https://img.youtube.com/vi/UA0ZBt4SfOs/0.jpg)](https://www.youtube.com/watch?v=UA0ZBt4SfOs)   

## Disclaimer
Lunaris-motion is tested on Arch Linux using i3 and Xlibre; it doesn't work on Wayland and may have bugs on other window managers and distributions with older packages (e.g., the recursive file browser was only added on rofi version [1.7.6](https://github.com/davatorium/rofi/releases#release-1.7.6)).

## Dependencies
ffmpegthumbnailer mpv rofi socat xwinwrap

## Installation
``` bash
git clone https://github.com/ShadowDotSh/lunaris-motion.git
cd lunaris-motion
sudo make install
```

## Usage
| Command | Action |
|---------|--------|
| lunaris-motion -w | Select video from workshop |
| lunaris-motion -v | Select video file |
| lunaris-motion -r | Restore cached wallpaper with daemon |
| lunaris-motion -k | Kill player |
| lunaris-motion --play | Resume player |
| lunaris-motion --pause | Pause player |
| lunaris-motion --frame | Extract player frame |
| lunaris-motion ---daemonless | Restore cached wallpaper without daemon |
| lunaris-motion -h | Display help message |

## i3 configuration example
Add to `~/.config/i3/config`

``` i3config
exec --no-startup-id nice -n 19 ionice -c 3 lunaris-motion --restore
```
