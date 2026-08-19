#!/usr/bin/env bash
# vim:foldmethod=marker

# Start empty
last_status=""

# Player Status {{{

player_status() {
	# Send signal to master pause player
	if [[ "$pause_player" != "$last_status" ]]; then
		if [[ "$pause_player" = "yes" ]]; then
			lunaris-motion --pause
		else
			lunaris-motion --play
		fi

		# Store last status
		last_status="$pause_player"
	fi
}
# }}}

# Window monitor {{{

# Detect if a window is open
while IFS= read -r window_id; do
	if [[ "$window_id" == *0x0* ]]; then
		pause_player="no"
	else
		pause_player="yes"
	fi

	# Set status
	player_status

done < <(xprop -spy -root _NET_ACTIVE_WINDOW)
# }}}
