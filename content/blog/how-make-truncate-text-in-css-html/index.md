---
dev_to_id: 1156418
title: "How to make truncate text in CSS"
description: "&lt;p&gt;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt..."
created_at: "2022-08-01T09:19:46Z"
edited_at: "2024-10-21T20:07:18Z"
draft: false
tags: ["css", "html", "webdev"]
canonical_url: "https://jetthoughts.com/blog/how-make-truncate-text-in-css-html/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fmedia.dev.to%2Fcdn-cgi%2Fimage%2Fwidth%3D1000%2Cheight%3D420%2Cfit%3Dcover%2Cgravity%3Dauto%2Cformat%3Dauto%2Fhttps%253A%252F%252Fdev-to-uploads.s3.amazonaws.com%252Fuploads%252Farticles%252Fl5cdcrq6rev0cozjlvm5.png"
slug: "how-make-truncate-text-in-css-html"
metatags:
  image: cover.png
---
```html
<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
```
![Image description](file_0.png)

There is no native CSS property for truncating text. However, you can use the ellipsis character to display truncated text.
```css
p {
  max-width: 800px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
```
![Image description](file_1.png)

Note we have given the element a fixed width. This is made because the element needs a certain width. 