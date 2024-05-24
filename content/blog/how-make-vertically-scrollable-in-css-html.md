---
dev_to_id: 1188292
title: "How to make vertically scrollable in CSS"
description: "In order for the scroll to appear, you need to limit its height by adding height or max-height..."
created_at: "2022-09-08T21:16:07Z"
edited_at: "2024-05-10T19:39:58Z"
sync_date: "2024-05-24T15:39:24Z"
draft: false
tags: ["css", "html", "webdev"]
canonical_url: "https://jtway.co/how-to-make-vertically-scrollable-in-css-330669dfde84"
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


