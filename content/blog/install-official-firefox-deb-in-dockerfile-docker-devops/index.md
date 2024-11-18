---
dev_to_id: 1740002
dev_to_url: https://dev.to/jetthoughts/install-official-firefox-deb-in-dockerfile-12pb
title: Install Official Firefox .deb in Dockerfile
description: Mozilla announced its dedicated APT repo for Debian-based distros, including Ubuntu, containing new...
created_at: '2024-01-24T10:58:06Z'
edited_at: '2024-11-25T15:39:36Z'
draft: false
tags:
- docker
- devops
- tooling
canonical_url: https://jetthoughts.com/blog/install-official-firefox-deb-in-dockerfile-docker-devops/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/install-official-firefox-deb-in-dockerfile-docker-devops/cover.jpeg
slug: install-official-firefox-deb-in-dockerfile-docker-devops
metatags:
  image: cover.jpeg
---
Mozilla announced its dedicated APT repo for Debian-based distros, including Ubuntu, containing new stable releases of Firefox as a DEB package with the release of Firefox 122 in January 2023.

Mozilla recommends this way because it ensures Firefox and all the required libraries are installed and configured optimally for your distribution.

To install from a Dockerfile, follow these steps:


```dockerfile
# Install Firefox from Mozilla
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    --mount=type=tmpfs,target=/var/log \
    # Create a directory to store APT repository keys, repository lists, and preferences if they don't exist
    install -d -m 0755 /etc/apt/keyrings /etc/apt/preferences.d /etc/apt/sources.list.d > /dev/null && \

    # Import the Mozilla APT repository signing key
    curl -fsSL https://packages.mozilla.org/apt/repo-signing-key.gpg |  \
    gpg --dearmor --no-tty -o /etc/apt/keyrings/packages.mozilla.org.gpg > /dev/null && \

    # Add the Mozilla APT repository to the APT sources list
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/packages.mozilla.org.gpg] https://packages.mozilla.org/apt mozilla main" |  \
    tee /etc/apt/sources.list.d/packages.mozilla.org.list > /dev/null && \

    # Configure APT to prioritize packages from the Mozilla repository
    echo "Package: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000\n\n" | tee /etc/apt/preferences.d/mozilla > /dev/null && \

    # Update your package list and install the Firefox .deb package
    apt-get update -qq > /dev/null && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qq firefox > /dev/null
```