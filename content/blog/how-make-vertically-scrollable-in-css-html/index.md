---
dev_to_id: 1188292
title: "How to make vertically scrollable in CSS"
description: "In order for the scroll to appear, you need to limit its height by adding height or max-height..."
created_at: "2022-09-08T21:16:07Z"
edited_at: "2024-11-01T17:09:32Z"
draft: false
tags: ["css", "html", "webdev"]
canonical_url: "https://jetthoughts.com/blog/how-make-vertically-scrollable-in-css-html/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fmedia.dev.to%2Fcdn-cgi%2Fimage%2Fwidth%3D1000%2Cheight%3D420%2Cfit%3Dcover%2Cgravity%3Dauto%2Cformat%3Dauto%2Fhttps%253A%252F%252Fdev-to-uploads.s3.amazonaws.com%252Fuploads%252Farticles%252Fy1r3jjguhgxpz0mp1i0s.jpeg"
slug: "how-make-vertically-scrollable-in-css-html"
metatags:
  image: cover.jpeg
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


