---
dev_to_id: 1093446
title: "Vertical align with a full screen across Tailwind CSS"
description: "How can vertically align an element with Tailwind CSS by Flex?           Justify-Center and..."
created_at: "2022-05-23T12:58:44Z"
edited_at: "2022-06-01T08:11:56Z"
sync_date: "2024-05-24T11:41:21Z"
draft: false
tags: ["jetthoughts", "css", "tilewind", "webdev"]
canonical_url: "https://jtway.co/vertical-align-with-a-full-screen-across-tailwind-css-5c6ad91c3e4f"
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

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/g8oeati6etcsm4r4fytf.png)
 
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




