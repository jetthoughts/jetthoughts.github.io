# Multi-stage Dockerfile for JetThoughts test environment
ARG RUBY_VERSION=3.4

#=============================================================================
# Stage 1: Base image with common dependencies (parallel stage)
#=============================================================================
FROM ruby:$RUBY_VERSION-alpine AS base
RUN apk update && apk upgrade && \
    apk add --no-cache \
        build-base make g++ git \
        libjpeg-turbo-dev vips-dev \
        python3 pkgconfig

#=============================================================================
# Stage 2: Node.js dependencies (parallel with ruby-deps)
#=============================================================================
FROM oven/bun:1-alpine AS node-deps
WORKDIR /temp/dev
RUN apk add --no-cache build-base python3 pkgconfig vips-dev
COPY package.json bun.lockb ./
# Enhanced cache mount with retry logic for network issues
RUN --mount=type=cache,target=/root/.bun,sharing=locked \
    bun install --frozen-lockfile --verbose

#=============================================================================
# Stage 4: Final runtime image (optimized)
#=============================================================================
FROM ruby:$RUBY_VERSION-alpine AS runtime

ENV \
    BUNDLE_JOBS=4 \
    BUNDLE_PATH=/opt/bundle \
    BUNDLE_RETRY=3 \
    DEBUG_COLORS=true \
    DISPLAY=:99 \
    DOCKER=true \
    HUGO_CACHEDIR=/tmp/hugo_cache \
    HUGO_ENABLEGITINFO=false \
    HUGO_NUMWORKERMULTIPLIER=4 \
    LANG=C.UTF-8 \
    MALLOC_ARENA_MAX=2 \
    NODE_ENV=production \
    PATH="/app/bin:/app/node_modules/.bin:/opt/bundle/bin:/usr/local/bin/:$PATH" \
    RUBY_GC_HEAP_GROWTH_FACTOR=1.2 \
    RUBY_GC_HEAP_GROWTH_MAX_SLOTS=500000 \
    RUBY_GC_HEAP_INIT_SLOTS=1000000 \
    RUBY_GC_MALLOC_LIMIT=16777216 \
    RUBY_GC_OLDMALLOC_LIMIT=67108864 \
    RUBY_YJIT_ENABLE=1

# Install all runtime dependencies in single layer with cache
RUN apk update && apk upgrade && \
    apk add --no-cache \
        git \
        libjpeg-turbo vips \
        chromium chromium-chromedriver \
        xvfb \
        nss freetype ttf-freefont font-noto \
        build-base libxml2-dev libxslt-dev \
        make g++ git \
        libjpeg-turbo-dev vips-dev \
        python3 pkgconfig


# Copy Bun binary for Node.js package management
COPY --from=node-deps /usr/local/bin/bun /usr/local/bin/


# Set up application directory structure
WORKDIR /app

COPY Gemfile Gemfile.lock ./

# Enhanced bundle install with optimized settings
RUN --mount=type=cache,target=/usr/local/bundle/cache,sharing=locked \
    --mount=type=cache,target=/root/.bundle \
    echo "gem: --no-document" > /root/.gemrc && \
    bundle config set --local deployment false && \
    bundle config set --local without development:assets && \
    bundle install
#COPY --from=ruby-deps /opt/bundle /opt/bundle

# Copy dependencies from build stages (optimized order)
COPY --from=node-deps /temp/dev/node_modules ./node_modules

COPY .dev/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+r+x /docker-entrypoint.sh && git config --system --add safe.directory /app

# Set entrypoint and default command
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bin/test"]
