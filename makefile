.PHONY: uninstall
.PHONY: install

build_dir := ./src/
target_dir := /etc/lunaris/motion/

install:
	install -Dm755 "$(build_dir)/lunaris-motion" 								"/usr/bin/lunaris-motion"
	install -Dm755 "$(build_dir)/etc/lunaris-motion-daemon.sh" 	"$(target_dir)/lunaris-motion-daemon.sh"
	install -Dm644 "$(build_dir)/etc/lunaris-motion-list.rasi" 	"$(target_dir)/lunaris-motion-list.rasi"
	install -Dm644 "$(build_dir)/etc/lunaris-motion-grid.rasi" 	"$(target_dir)/lunaris-motion-grid.rasi"
	install -Dm644 "$(build_dir)/etc/mpv.conf" 									"$(target_dir)/mpv.conf"

uninstall:
	rm -rf "/usr/bin/lunaris-motion"
	rm -rf "$(target_dir)"
