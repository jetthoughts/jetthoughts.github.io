#!/bin/sh

bundle install
bun install

# Start virtual display for browser testing
Xvfb :99 -screen 0 1920x1080x24 -ac +extension GLX +render -noreset &

# Handle shell commands properly
if [ "$1" = "sh" ] && [ "$2" = "-c" ]; then
    shift 2
    exec sh -c "$*"
else
    exec "$@"
fi
