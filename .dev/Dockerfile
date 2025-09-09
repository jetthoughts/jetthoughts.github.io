ARG RUBY_VERSION=3.4

# use the official Bun image
# see all versions at https://hub.docker.com/r/oven/bun/tags
FROM oven/bun:1 AS base
WORKDIR /usr/src/app

# install dependencies into temp directory
# this will cache them and speed up future builds
FROM base AS install
WORKDIR /temp/dev
COPY package.json bun.lockb ./
# Use cache mount for faster builds
RUN --mount=type=cache,target=/root/.bun \
    bun install --frozen-lockfile

# Install Ruby dependencies in a separate stage
FROM ruby:$RUBY_VERSION-alpine AS ruby-gems
# Use cache mount for apk packages
RUN --mount=type=cache,target=/var/cache/apk \
    apk update && apk upgrade && \
    apk add build-base make g++ git libjpeg-turbo-dev vips-dev
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
# Use cache mount for gem downloads
RUN --mount=type=cache,target=/usr/local/bundle/cache \
    bundle install --jobs $(nproc) --retry 3 --path /opt/bundle

FROM ruby:$RUBY_VERSION-alpine
COPY --from=base /usr/local/bin/bun /usr/local/bin/

ENV \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_PATH=/opt/bundle \
    DEBUG_COLORS=true \
    DOCKER=true \
    ENABLE_SELENIUM_FIXES=true \
    LANG=C.UTF-8 \
    NODE_ENV=production \
    OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES \
    PATH="/app/bin:/opt/bundle/bin:/usr/local/bin/:$PATH" \
    PRECOMPILED_ASSETS=true \
    RUBY_YJIT_ENABLE=1 \
    TEST_SERVER_PORT=1314 \
    DISPLAY=:99 \
    HUGO_CACHEDIR=/tmp/hugo_cache \
    HUGO_NUMWORKERSMULTIPLIER=4,
    MALLOC_ARENA_MAX=2,
    RUBY_GC_HEAP_INIT_SLOTS=600000,
    RUBY_GC_HEAP_FREE_SLOTS=600000,
    RUBY_GC_HEAP_GROWTH_FACTOR=1.25,
    RUBY_GC_HEAP_GROWTH_MAX_SLOTS=300000

# Install system dependencies with cache mount
RUN --mount=type=cache,target=/var/cache/apk \
    apk update && apk upgrade && \
    apk add --no-cache \
      git \
      libjpeg-turbo \
      vips \
      chromium \
      chromium-chromedriver \
      xvfb \
      htop \
      iotop

# Upgrade RubyGems
RUN echo "gem: --no-document" > ~/.gemrc

# Create a directory for the app code
RUN mkdir -p /app
WORKDIR /app

# Copy installed Ruby gems from the ruby-gems stage
COPY --from=ruby-gems /opt/bundle /opt/bundle

# Copy pre-built node_modules from the 'install' stage
COPY --from=install /temp/dev/node_modules ./node_modules

# Add an exception for /app
RUN git config --global --add safe.directory /app

# Optimized entrypoint with parallel checks
RUN printf '#!/bin/sh\nset -e\n\n# Run checks in parallel\n{\n  echo "Checking Ruby dependencies..." && bundle check || bundle install\n} &\nPID1=$!\n\n{\n  echo "Checking Node.js dependencies..."\n  if [ ! -d "/app/node_modules" ] || [ -z "$(ls -A /app/node_modules 2>/dev/null)" ]; then\n    echo "Installing Node.js dependencies..."\n    bun install\n  fi\n} &\nPID2=$!\n\n# Wait for parallel checks\nwait $PID1 $PID2\n\n# Start Xvfb\necho "Starting Xvfb..."\nXvfb :99 -screen 0 1920x1080x24 -ac +extension GLX +render -noreset &\nXVFB_PID=$!\nsleep 1\n\necho "Executing: $@"\nexec "$@"\n\nkill $XVFB_PID 2>/dev/null || true\n' > /docker-entrypoint.sh && \
	chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
# Use Bash as the default command
CMD ["bin/test"]
