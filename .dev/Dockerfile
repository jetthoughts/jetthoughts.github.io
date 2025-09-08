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
RUN bun install

# Install Ruby dependencies in a separate stage
FROM ruby:$RUBY_VERSION-alpine AS ruby-gems
RUN apk update --no-cache && apk upgrade --no-cache
RUN apk add --no-cache build-base make g++ git libjpeg-turbo-dev vips-dev
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs $(nproc) --retry 3 --path /opt/bundle

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
    DISPLAY=:99

# Upgrade system
RUN apk update --no-cache && apk upgrade --no-cache

# Install system dependencies (runtime focused)
RUN apk -v add --no-cache \
      git \
      libjpeg-turbo \
      vips \
      chromium \
      chromium-chromedriver \
      xvfb

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

# To run browser tests need to run Xvfb
RUN	printf '#!/bin/sh\nset -e\necho "Running bundle check..."\nbundle check || bundle install\necho "Checking node_modules..."\nif [ ! -d "/app/node_modules" ] || [ -z "$(ls -A /app/node_modules)" ]; then\n  echo "Installing Node.js dependencies..."\n  bun install\nfi\necho "Starting Xvfb..."\nXvfb :99 -screen 0 1920x1080x24 &\nXVFB_PID=$!\necho "Executing command: $@"...\nexec "$@"\nkill $XVFB_PID\n' > /docker-entrypoint.sh && \
	chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
# Use Bash as the default command
CMD ["bin/test"]
