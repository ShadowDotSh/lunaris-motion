.PHONY: uninstall
.PHONY: install

build_dir := ./src
target_dir := /etc/lunaris/motion

install:
	install -Dm755 "$(build_dir)/lunaris-motion"									"$(DESTDIR)/usr/bin/lunaris-motion"
	install -Dm755 "$(build_dir)/etc/addons/daemon.sh"						"$(DESTDIR)/$(target_dir)/addons/daemon.sh"
	install -Dm755 "$(build_dir)/etc/config/config.sh"						"$(DESTDIR)/$(target_dir)/config/config.sh"
	install -Dm644 "$(build_dir)/etc/config/lunaris-motion.rasi"	"$(DESTDIR)/$(target_dir)/config/lunaris-motion.rasi"
	install -Dm644 "$(build_dir)/etc/mpv/mpv.conf"								"$(DESTDIR)/$(target_dir)/mpv/mpv.conf"
	install -Dm644 "$(build_dir)/etc/mpv/lunaris-motion.lua"			"$(DESTDIR)/$(target_dir)/mpv/lunaris-motion.lua"

uninstall:
	rm -rf "/usr/bin/lunaris-motion"
	rm -rf "$(target_dir)"
