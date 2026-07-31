# Multi-stage Dockerfile for JetThoughts test environment.
#
# Debian (glibc) base, NOT Alpine: this image records the canonical
# test/fixtures/screenshots/linux/ baselines, and the old Alpine/musl
# rendering diverged 3-28% from every glibc Linux (developer machines,
# agent containers, CI runners) - see .okf/build/ci-gates.md. Chrome for
# Testing is glibc-only, which also rules Alpine out.
#
# Rendering stack pins (change together, then re-record linux baselines
# via FORCE_SCREENSHOT_UPDATE=true bin/dtest):
#   - Chrome for Testing + matching chromedriver: .dev/cft-version
#   - fontconfig: .dev/fonts.conf
#   - fonts: fonts-noto-core, fonts-freefont-ttf, fonts-dejavu-core
# bin/setup-test-env installs the identical stack on bare-metal Linux.
ARG RUBY_VERSION=4.0

#=============================================================================
# Stage 1: Node.js dependencies
#=============================================================================
FROM oven/bun:1 AS node-deps
WORKDIR /temp/dev
COPY package.json bun.lockb ./
RUN --mount=type=cache,target=/root/.bun,sharing=locked \
    bun install --frozen-lockfile

#=============================================================================
# Stage 2: Final runtime image
#=============================================================================
FROM ruby:$RUBY_VERSION-slim AS runtime

ENV \
    BUNDLE_JOBS=4 \
    BUNDLE_PATH=/opt/bundle \
    BUNDLE_RETRY=3 \
    CHROME_BIN=/opt/cft/chrome-linux64/chrome \
    CHROMEDRIVER_PATH=/opt/cft/chromedriver-linux64/chromedriver \
    DEBUG_COLORS=true \
    DISPLAY=:99 \
    DOCKER=true \
    ENABLE_SELENIUM_FIXES=true \
    HUGO_CACHEDIR=/tmp/hugo_cache \
    HUGO_ENABLEGITINFO=false \
    HUGO_NUMWORKERMULTIPLIER=4 \
    LANG=C.UTF-8 \
    MALLOC_ARENA_MAX=2 \
    NODE_ENV=production \
    PATH="/app/bin:/app/node_modules/.bin:/opt/bundle/bin:/usr/local/bin/:$PATH" \
    PRECOMPILED_ASSETS=true \
    RUBY_GC_HEAP_FREE_SLOTS=1000000 \
    RUBY_GC_HEAP_GROWTH_FACTOR=1.2 \
    RUBY_GC_HEAP_GROWTH_MAX_SLOTS=500000 \
    RUBY_GC_HEAP_INIT_SLOTS=1000000 \
    RUBY_GC_MALLOC_LIMIT=16777216 \
    RUBY_GC_OLDMALLOC_LIMIT=67108864 \
    RUBY_YJIT_ENABLE=1 \
    TEST_SERVER_PORT=1314

RUN apt-get update && apt-get install -y --no-install-recommends \
        bash \
        build-essential git pkg-config curl ca-certificates unzip \
        libjpeg62-turbo libvips42 \
        xvfb \
        fonts-noto-core fonts-freefont-ttf fonts-dejavu-core fontconfig \
    # Chrome for Testing runtime libs. Debian's 64-bit time_t transition
    # renamed several of these with a t64 suffix; resolve whichever name
    # the base image's release actually ships.
    && deps="" \
    && for p in libasound2t64 libasound2 libatk-bridge2.0-0t64 libatk-bridge2.0-0 \
                libatk1.0-0t64 libatk1.0-0 libcairo2 libcups2t64 libcups2 \
                libdbus-1-3 libdrm2 libgbm1 libglib2.0-0t64 libglib2.0-0 \
                libnspr4 libnss3 libpango-1.0-0 libx11-6 libxcb1 \
                libxcomposite1 libxdamage1 libxext6 libxfixes3 \
                libxkbcommon0 libxrandr2; do \
          apt-cache show "$p" >/dev/null 2>&1 && deps="$deps $p"; \
        done \
    && apt-get install -y --no-install-recommends $deps \
    && rm -rf /var/lib/apt/lists/*

# Pinned Chrome for Testing + matching chromedriver (the rendering pin that
# makes linux/ baselines reproducible - version in .dev/cft-version).
COPY .dev/cft-version /tmp/cft-version
RUN CFT=$(tr -d '[:space:]' < /tmp/cft-version) && mkdir -p /opt/cft && cd /opt/cft && \
    curl -sSLO "https://storage.googleapis.com/chrome-for-testing-public/${CFT}/linux64/chrome-linux64.zip" && \
    curl -sSLO "https://storage.googleapis.com/chrome-for-testing-public/${CFT}/linux64/chromedriver-linux64.zip" && \
    unzip -q chrome-linux64.zip && unzip -q chromedriver-linux64.zip && \
    rm chrome-linux64.zip chromedriver-linux64.zip && \
    "$CHROME_BIN" --version && "$CHROMEDRIVER_PATH" --version

# Deterministic font rendering (see .dev/fonts.conf header).
COPY .dev/fonts.conf /etc/fonts/local.conf
RUN fc-cache -f

# Bun binary for Node.js package management
COPY --from=node-deps /usr/local/bin/bun /usr/local/bin/

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN --mount=type=cache,target=/usr/local/bundle/cache,sharing=locked \
    --mount=type=cache,target=/root/.bundle \
    echo "gem: --no-document" > /root/.gemrc && \
    bundle config set --local deployment false && \
    bundle config set --local path /opt/bundle && \
    bundle config set --local jobs 4 && \
    bundle config set --local retry 3 && \
    bundle config set --local without development:assets && \
    bundle install

VOLUME /app/node_modules
VOLUME /opt/bundle

COPY --from=node-deps /temp/dev/node_modules ./node_modules

COPY .dev/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+r+x /docker-entrypoint.sh && git config --system --add safe.directory /app

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bin/test"]
