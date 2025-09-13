---
remote_url: https://dev.to/jetthoughts/how-to-make-vertically-scrollable-in-css-57od
source: dev_to
remote_id: 1188292
dev_to_id: 1188292
dev_to_url: https://dev.to/jetthoughts/how-to-make-vertically-scrollable-in-css-57od
title: How to make vertically scrollable in CSS
description: In order for the scroll to appear, you need to limit its height by adding height or max-height...
created_at: '2022-09-08T21:16:07Z'
edited_at: '2024-11-25T15:40:34Z'
draft: false
tags:
- css
- html
- webdev
canonical_url: https://jetthoughts.com/blog/how-make-vertically-scrollable-in-css-html/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/how-make-vertically-scrollable-in-css-html/cover.jpeg
metatags:
  image: cover.jpeg
slug: how-make-vertically-scrollable-in-css-html
---
In order for the scroll to appear, you need to limit its `height` by adding height or `max-height` properties.

```css
.scroll-area {
  overflow-y: auto;
  max-height: 400px;
}
```

If you do not add this, your block will stretch to the entire height.

![Image description](file_0.png)
