#!/bin/sh
set -e
#
#echo "=== Docker Entrypoint Start ==="
#
## Function to cleanup processes on exit
#cleanup() {
#    echo "Cleaning up processes..."
#    kill $XVFB_PID 2>/dev/null || true
#}
#trap cleanup EXIT
#
## Run dependency checks in parallel for faster startup
#echo "Checking dependencies..."
#{
#    echo "  - Checking Ruby dependencies..."
#    bundle check || bundle install
#} &
#RUBY_PID=$!
#
#{
#    echo "  - Checking Node.js dependencies..."
#    if [ ! -d "/app/node_modules" ] || [ -z "$(ls -A /app/node_modules 2>/dev/null)" ]; then
#        echo "    Installing Node.js dependencies..."
#        bun install
#    else
#        echo "    Node.js dependencies already installed"
#    fi
#} &
#NODE_PID=$!
#
## Wait for both dependency checks to complete
#wait $RUBY_PID $NODE_PID
#echo "Dependencies ready!"

# Start Xvfb for browser tests
echo "Starting Xvfb display server..."
Xvfb :99 -screen 0 1920x1080x24 -ac +extension GLX +render -noreset &

#XVFB_PID=$!
#sleep 2

#echo "=== Docker Entrypoint Complete ==="
#echo "Executing command: $*"

# Execute the main command
exec "$@"
