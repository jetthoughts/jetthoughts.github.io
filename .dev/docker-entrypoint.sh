#!/bin/sh

Xvfb :99 -screen 0 1920x1080x24 -ac +extension GLX +render -noreset &
exec "$@"
