# Multi-stage Dockerfile for JetThoughts test environment
ARG RUBY_VERSION=3.4

#=============================================================================
# Stage 1: Base image with common dependencies (parallel stage)
#=============================================================================
FROM ruby:$RUBY_VERSION-alpine AS base
RUN --mount=type=cache,target=/var/cache/apk \
    apk update && apk upgrade && \
    apk add --no-cache \
        build-base make g++ git \
        libjpeg-turbo-dev vips-dev \
        python3 pkgconfig

#=============================================================================
# Stage 2: Node.js dependencies (parallel with ruby-deps)
#=============================================================================
FROM oven/bun:1-alpine AS node-deps
WORKDIR /temp/dev
RUN --mount=type=cache,target=/var/cache/apk \
    apk add --no-cache build-base python3 pkgconfig vips-dev
COPY package.json bun.lockb ./
# Enhanced cache mount with retry logic for network issues
RUN --mount=type=cache,target=/root/.bun,sharing=locked \
    bun install --frozen-lockfile --verbose

#=============================================================================
# Stage 3: Ruby dependencies (parallel with node-deps)
#=============================================================================
FROM base AS ruby-deps
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./

# Enhanced bundle install with optimized settings
RUN --mount=type=cache,target=/usr/local/bundle/cache,sharing=locked \
    --mount=type=cache,target=/root/.bundle \
    echo "gem: --no-document" > /root/.gemrc && \
    bundle config set --local deployment false && \
    bundle config set --local path /opt/bundle && \
    bundle config set --local jobs 4 && \
    bundle config set --local retry 3 && \
    bundle config set --local without development:assets && \
    bundle install

#=============================================================================
# Stage 4: Final runtime image (optimized)
#=============================================================================
FROM ruby:$RUBY_VERSION-alpine AS runtime

# Install all runtime dependencies in single layer with cache
RUN --mount=type=cache,target=/var/cache/apk \
    apk update && apk upgrade && \
    apk add --no-cache \
        git \
        libjpeg-turbo vips \
        chromium chromium-chromedriver \
        xvfb \
        nss freetype ttf-freefont font-noto

# Copy Bun binary for Node.js package management
COPY --from=node-deps /usr/local/bin/bun /usr/local/bin/

# Environment variables (optimized for performance)
ENV \
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
    # Hugo configuration (optimized for speed)
    HUGO_CACHEDIR=/tmp/hugo_cache \
    HUGO_NUMWORKERMULTIPLIER=4 \
    HUGO_ENABLEGITINFO=false \
    # Memory optimization (aggressive tuning)
    MALLOC_ARENA_MAX=2 \
    RUBY_GC_HEAP_INIT_SLOTS=1000000 \
    RUBY_GC_HEAP_FREE_SLOTS=1000000 \
    RUBY_GC_HEAP_GROWTH_FACTOR=1.2 \
    RUBY_GC_HEAP_GROWTH_MAX_SLOTS=500000 \
    RUBY_GC_MALLOC_LIMIT=16777216 \
    RUBY_GC_OLDMALLOC_LIMIT=67108864

# Set up application directory structure
RUN mkdir -p /app /tmp/hugo_cache /tmp/build_output/public-dtest /app/resources && \
    git config --system --add safe.directory /app

WORKDIR /app

# Copy dependencies from build stages (optimized order)
COPY --from=ruby-deps --chown=root:root /opt/bundle /opt/bundle
COPY --from=node-deps --chown=root:root /temp/dev/node_modules ./node_modules

# Copy and set up entrypoint script
COPY .dev/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Optimized health check
HEALTHCHECK --interval=15s --timeout=2s --start-period=3s --retries=2 \
    CMD test -f /app/bin/test || exit 1

# Set entrypoint and default command
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bin/test"]
