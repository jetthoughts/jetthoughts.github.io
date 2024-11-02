# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.3.4

FROM ruby:$RUBY_VERSION-alpine

# Upgrade system
RUN apk update --no-cache && apk upgrade --no-cache

# Install system dependencies
RUN apk -v add --no-cache \
      build-base \
      git \
      libjpeg-turbo-dev \
      vips-dev \
      chromium \
      chromium-chromedriver \
      xvfb

# Upgrade RubyGems
RUN echo "gem: --no-document" > ~/.gemrc

# Create a directory for the app code
RUN mkdir -p /app
WORKDIR /app

# Add an exception for /app
RUN git config --global --add safe.directory /app

# To run browser tests need to run Xvfb
RUN	printf '#!/bin/sh\nbundle check || bundle install\nXvfb :99 -screen 0 1920x1080x24 &\nexec "$@"\n' > /docker-entrypoint.sh && \
	chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

ENV \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_PATH=/app/vendor/bundle \
    DEBUG_COLORS=true \
    LANG=C.UTF-8 \
    NODE_ENV=production \
    OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES \
    PATH="/app/bin:$PATH" \
    PRECOMPILED_ASSETS=true \
    RUBY_YJIT_ENABLE=1 \
    TEST_SERVER_PORT=1314

# Install bundle from Gemfile
COPY ../Gemfile ../Gemfile.lock ./
RUN bundle check || bundle install

# Use Bash as the default command
CMD ["bin/test"]
