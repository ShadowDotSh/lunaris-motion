#!/usr/bin/env bash
# vim:foldmethod=marker

# Variables {{{

# Install directory
user_dir="$HOME/.config/lunaris-motion"
system_dir="/etc/xdg/lunaris-motion"

# List dependencies
dependencies=(
	ffmpegthumbnailer
	mpv
	rofi
	socat
	xwinwrap
)

# Xwinwrap
build_dir="/tmp/lunaris-motion-build"
xwinwrap_repo="https://github.com/LunarisDotSh/xwinwrap"
# }}}

# Functions {{{

# Log {{{

log() {
	echo "[$(date +'%Y-%m-%d %H:%M:%S')]: $*" >&2
}
# }}}

# Install & Uninstall {{{

install_lunaris-motion() {
	# Check for dependencies
	for pkg in "${dependencies[@]}"; do
		if [[ ! "$(command -v "$pkg")" ]]; then
			log "[ERROR]: Missing necessary dependency: $pkg"
			exit 1
		fi
	done

	# Install lunaris-motion files
	sudo install -Dm755 "./src/lunaris-motion" "/usr/bin/lunaris-motion"
	sudo install -Dm755 "./src/etc/lunaris-motion-daemon.sh" "$system_dir/lunaris-motion-daemon.sh"
	sudo install -Dm644 "./src/etc/lunaris-motion-list.rasi" "$system_dir/lunaris-motion-list.rasi"
	sudo install -Dm644 "./src/etc/lunaris-motion-grid.rasi" "$system_dir/lunaris-motion-grid.rasi"
	sudo install -Dm644 "./src/etc/mpv.conf" "$system_dir/mpv.conf"
	install -Dm644 "./src/etc/config.example" "$user_dir/config.example"
}

uninstall_lunaris-motion() {
	# Uninstall lunaris-motion files
	sudo rm -rf "/usr/bin/lunaris-motion"
	sudo rm -rf "$system_dir"
	rm -rfi "$user_dir"
}
# }}}

# dependencies {{{

install-dependencies() {
	# Check os
	# shellcheck disable=SC1091
	source "/etc/os-release"
	if [[ "$ID" != "arch" ]]; then
		log "[ERROR]: This script is designed for Arch Linux only"
	fi

	# Install dependencies
	sudo pacman -S ffmpegthumbnailer mpv rofi socat --needed
}

uninstall-dependencies() {
	# Check os
	# shellcheck disable=SC1091
	source "/etc/os-release"
	if [[ "$ID" != "arch" ]]; then
		log "[ERROR]: This script is designed for Arch Linux only"
	fi

	# Uninstall dependencies
	sudo pacman -Rns ffmpegthumbnailer mpv rofi socat
}
# }}}

# Xwinwrap {{{

install-xwinwrap() {
	# Clone and compile xwinwrap
	rm -rf "$build_dir"
	mkdir -p "$build_dir" && cd "$build_dir" || exit
	git clone "$xwinwrap_repo" && cd "./xwinwrap" || exit
	make && sudo install -Dm755 "./xwinwrap" "/usr/bin/xwinwrap"
}

uninstall-xwinwrap() {
	# Uninstall xwinwrap
	sudo rm -rf "/usr/bin/xwinwrap"
}
# }}}

# }}}

# Master {{{

case "$1" in
install)
	install_lunaris-motion
	log "[INFO]: Installed successfully"
	;;

uninstall)
	uninstall_lunaris-motion
	log "[INFO]: Uninstalled successfully"
	;;

install-dependencies)
	install-dependencies
	;;

uninstall-dependencies)
	uninstall-dependencies
	;;

install-xwinwrap)
	install-xwinwrap
	;;

uninstall-xwinwrap)
	uninstall-xwinwrap
	;;

*)
	echo "Usage: $0 {install|uninstall|install-dependencies|uninstall-dependencies|install-xwinwrap|uninstall-xwinwrap}"
	;;
esac
# }}}
