---
dev_to_id: 1156418
title: "How to make truncate text in CSS"
description: "&lt;p&gt;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt..."
created_at: "2022-08-01T09:19:46Z"
edited_at: ""
draft: false
tags: ["css", "html", "webdev"]
canonical_url: "https://jtway.co/how-to-make-truncate-text-in-css-67c42e264680"
slug: "how-make-truncate-text-in-css-html"
---
```html
<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/f39ym2tu9nfjpyfqzlw6.png)

There is no native CSS property for truncating text. However, you can use the ellipsis character to display truncated text.
```css
p {
  max-width: 800px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/9h9q84z0x7a8b1blwosz.png)

Note we have given the element a fixed width. This is made because the element needs a certain width. 