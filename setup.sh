#!/usr/bin/env bash
target="/etc/xdg/lunaris-motion"

case "$1" in
  install)
    sudo install -Dm755 "./src/lunaris-motion"                "/usr/bin/lunaris-motion"
    sudo install -Dm644 "./src/etc/lunaris-motion-list.rasi"  "$target/lunaris-motion-list.rasi"
    sudo install -Dm644 "./src/etc/lunaris-motion-grid.rasi"  "$target/lunaris-motion-grid.rasi"
    sudo install -Dm644 "./src/etc/mpv.conf"  "$target/mpv.conf"
  ;;

  uninstall)
    sudo rm -rf "/usr/bin/lunaris-motion"
    sudo rm -rf "$target"
  ;;

  *)
    echo "Usage: $0 {install|uninstall}"
  ;;
esac
