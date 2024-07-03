---
dev_to_id: 1188292
title: "How to make vertically scrollable in CSS"
description: "In order for the scroll to appear, you need to limit its height by adding height or max-height..."
created_at: "2022-09-08T21:16:07Z"
edited_at: "2024-06-27T15:53:21Z"
draft: false
tags: ["css", "html", "webdev"]
canonical_url: "https://jetthoughts.com/blog/how-make-vertically-scrollable-in-css-html/"
cover_image: "https://media.dev.to/cdn-cgi/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fy1r3jjguhgxpz0mp1i0s.jpeg"
slug: "how-make-vertically-scrollable-in-css-html"
---
In order for the scroll to appear, you need to limit its `height` by adding height or `max-height` properties.

```css
.scroll-area {
  overflow-y: auto;
  max-height: 400px;
}
```

If you do not add this, your block will stretch to the entire height.


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/9uxdd7z2ccnh9belnkua.png)


