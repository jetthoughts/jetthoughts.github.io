---
dev_to_id: 1101579
title: "How to horizontally center an element without Flex"
description: "Centered elements with Flex it is very easy to style, what about not use Flex?    &lt;div..."
created_at: "2022-06-01T08:10:19Z"
edited_at: "2024-11-01T17:09:59Z"
draft: false
tags: ["css", "html", "webdev", "jetthoughts"]
canonical_url: "https://jetthoughts.com/blog/how-horizontally-center-an-element-without-flex-css-html/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fmedia.dev.to%2Fcdn-cgi%2Fimage%2Fwidth%3D1000%2Cheight%3D420%2Cfit%3Dcover%2Cgravity%3Dauto%2Cformat%3Dauto%2Fhttps%253A%252F%252Fdev-to-uploads.s3.amazonaws.com%252Fuploads%252Farticles%252F3vzzzu55opkdcn9g1k9q.jpg"
slug: "how-horizontally-center-an-element-without-flex-css-html"
metatags:
  image: cover.jpg
---
Centered elements with Flex it is very easy to style, what about not use Flex?
```html
<div class="wrapper">
  <div class="inner">Centered</div>
</div>
```

## Table
It will make the inner element center horizontally and it works without setting a specific width.
```css
.wrapper {
  display: table;
  margin: 0 auto;
}
```

## Fixed width
Need to apply this CSS to the inner. You should set any width less than the containing wrapper will work. The `margin: 0` auto is what does the actual centering.
```css
.inner {
  max-width: 25%;
  margin: 0 auto;
}
```

## Display: Inline-Block
`display: inline-block` makes the inner element into an inline element that can be centered with `text-align: center`
```css
.wrapper {
  text-align: center;
}

.inner {
  display: inline-block;
}
```
