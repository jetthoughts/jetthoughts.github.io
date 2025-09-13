#!/bin/bash
set -euo pipefail

# Start Xvfb for browser tests in background
echo "Starting Xvfb display server..."
Xvfb :99 -screen 0 1920x1080x24 -ac +extension GLX +render -noreset &
XVFB_PID=$!

# Function to cleanup processes on exit
cleanup() {
    echo "Cleaning up processes..."
    kill $XVFB_PID 2>/dev/null || true
}
trap cleanup EXIT

# Execute the main command
exec "$@"
