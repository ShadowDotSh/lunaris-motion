#!/usr/bin/env bash
# vim:foldmethod=marker

# Process {{{

# Cleanup on exit
cleanup() {
  # Play the video if the daemon is killed
  lunaris-motion --play
}

trap cleanup EXIT
# }}}

# Player Status {{{

player_status() {
  # Pause video on focus
  if [[ "$pause_player" != "$last_status" ]]; then
    if [[ "$pause_player" = "yes" ]]; then
      lunaris-motion --pause
    else
      lunaris-motion --play
    fi

    # Save last status
    last_status="$pause_player"
  fi
}
# }}}

# Window Monitor {{{

window_monitor() {
  local window_id

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
}
# }}}

# Don't start the daemon immediately
sleep 5

# Start daemon
window_monitor