#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the process have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config.pulybar/config
polybar desktop &

echo "Polybar launched..."
