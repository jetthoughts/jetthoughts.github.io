---
remote_url: https://dev.to/jetthoughts/vertical-align-with-a-full-screen-across-tailwind-css-1jdi
source: dev_to
remote_id: 1093446
dev_to_id: 1093446
dev_to_url: https://dev.to/jetthoughts/vertical-align-with-a-full-screen-across-tailwind-css-1jdi
title: Vertical align with a full screen across Tailwind CSS
description: How can vertically align an element with Tailwind CSS by Flex?           Justify-Center and...
date: 2022-05-23
created_at: '2022-05-23T12:58:44Z'
edited_at: '2024-11-25T15:41:37Z'
draft: false
tags:
- jetthoughts
- css
- tilewind
- webdev
canonical_url: https://jetthoughts.com/blog/vertical-align-with-full-screen-across-tailwind-css-jetthoughts/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/vertical-align-with-full-screen-across-tailwind-css-jetthoughts/cover.jpg
metatags:
  image: cover.jpg
slug: vertical-align-with-full-screen-across-tailwind-css-jetthoughts
---
How can vertically align an element with Tailwind CSS by Flex?

## Justify-Center and Items-Center

- `flex` : To use a flex-div as a container.
- `h-screen` : To size the container height to the viewport height.
- `justify-center` : To justify center (horizontal center).
- `items-center` : To align the items to the center (vertical center).

```html
<div class="flex h-screen items-center justify-center">
  <h1>Title</h1>
</div>
```

![Image description](file_0.png)

This is already pretty well documented in the [Tailwind CSS](https://tailwindcss.com/docs/align-items#center) docs.

## Another way to use Flex for to align items

In this case need to set `margin: auto` to wrapper of children element.

```html
<div class="flex h-screen">
  <div class="m-auto">
    <h1>Title</h1>
  </div>
</div>
```
