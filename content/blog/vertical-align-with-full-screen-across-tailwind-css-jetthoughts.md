---
dev_to_id: 1093446
title: "Vertical align with a full screen across Tailwind CSS"
description: "How can vertically align an element with Tailwind CSS by Flex?           Justify-Center and..."
created_at: "2022-05-23T12:58:44Z"
edited_at: "2024-07-03T12:23:43Z"
draft: false
tags: ["jetthoughts", "css", "tilewind", "webdev"]
canonical_url: "https://jetthoughts.com/blog/vertical-align-with-full-screen-across-tailwind-css-jetthoughts/"
cover_image: "https://media.dev.to/cdn-cgi/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fmkmajozvz75tmicefoba.jpg"
slug: "vertical-align-with-full-screen-across-tailwind-css-jetthoughts"
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

![Image description](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/vertical-align-with-full-screen-across-tailwind-css-jetthoughts/file_0.png)
 
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




