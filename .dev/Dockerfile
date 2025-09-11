# Multi-stage Dockerfile for JetThoughts test environment
ARG RUBY_VERSION=3.4

#=============================================================================
# Stage 1: Node.js dependencies
#=============================================================================
FROM oven/bun:1-alpine AS node-deps
WORKDIR /temp/dev
RUN --mount=type=cache,target=/var/cache/apk apk add --no-cache build-base python3 pkgconfig vips-dev
COPY package.json bun.lockb ./
# Use cache mount for faster builds
RUN --mount=type=cache,target=/root/.bun \
    bun install --frozen-lockfile

#=============================================================================
# Stage 2: Ruby dependencies
#=============================================================================
FROM ruby:$RUBY_VERSION-alpine AS ruby-deps
# Use cache mount for apk packages
RUN --mount=type=cache,target=/var/cache/apk \
    apk update && apk upgrade && \
    apk add --no-cache build-base make g++ git libjpeg-turbo-dev vips-dev

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./

# Use cache mount for gem downloads
RUN --mount=type=cache,target=/usr/local/bundle/cache \
    echo "gem: --no-document" > /root/.gemrc && \
    bundle install --jobs 4 --retry 3 --path /opt/bundle

#=============================================================================
# Stage 3: Final runtime image
#=============================================================================
FROM ruby:$RUBY_VERSION-alpine

# Copy Bun binary for Node.js package management
COPY --from=node-deps /usr/local/bin/bun /usr/local/bin/

# Environment variables (organized by category)
ENV \
    # Bundle configuration
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_PATH=/opt/bundle \
    # Application settings
    DEBUG_COLORS=true \
    DOCKER=true \
    ENABLE_SELENIUM_FIXES=true \
    LANG=C.UTF-8 \
    NODE_ENV=production \
    PATH="/app/bin:/opt/bundle/bin:/usr/local/bin/:$PATH" \
    PRECOMPILED_ASSETS=true \
    RUBY_YJIT_ENABLE=1 \
    # Test environment
    TEST_SERVER_PORT=1314 \
    DISPLAY=:99 \
    # Hugo configuration
    HUGO_CACHEDIR=/tmp/hugo_cache \
    HUGO_NUMWORKERSMULTIPLIER=4 \
    # Memory optimization (tuned values)
    MALLOC_ARENA_MAX=2 \
    RUBY_GC_HEAP_INIT_SLOTS=800000 \
    RUBY_GC_HEAP_FREE_SLOTS=800000 \
    RUBY_GC_HEAP_GROWTH_FACTOR=1.1 \
    RUBY_GC_HEAP_GROWTH_MAX_SLOTS=400000

# Install runtime system dependencies
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
        nss freetype ttf-freefont font-noto

# Set up application directory with proper permissions
RUN mkdir -p /app /tmp/hugo_cache  /app/resources
WORKDIR /app

# Copy dependencies from build stages with proper ownership
COPY --from=ruby-deps /opt/bundle /opt/bundle
COPY --from=node-deps /temp/dev/node_modules ./node_modules

# Git configuration for safe directory access
RUN git config --system --add safe.directory /app

# Copy and set up entrypoint script with security hardening
COPY .dev/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Health check for container monitoring
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD pgrep -f "ruby\|bun" > /dev/null || exit 1

# Set entrypoint and default command
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bin/test"]
