---
dev_to_id: 1188292
title: "How to make vertically scrollable in CSS"
description: "In order for the scroll to appear, you need to limit its height by adding height or max-height..."
created_at: "2022-09-08T21:16:07Z"
edited_at: "2024-06-10T15:43:09Z"
draft: false
tags: ["css", "html", "webdev"]
canonical_url: "https://jetthoughts.com/blog/how-make-vertically-scrollable-in-css-html"
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


