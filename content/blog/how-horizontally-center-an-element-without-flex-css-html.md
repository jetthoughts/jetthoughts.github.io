---
dev_to_id: 1101579
title: "How to horizontally center an element without Flex"
description: "Centered elements with Flex it is very easy to style, what about not use Flex?    &lt;div..."
created_at: "2022-06-01T08:10:19Z"
edited_at: "2024-05-10T19:49:48Z"
draft: false
tags: ["css", "html", "webdev", "jetthoughts"]
canonical_url: "https://jtway.co/how-to-horizontally-center-an-element-without-flex-13af946c88bf"
slug: "how-horizontally-center-an-element-without-flex-css-html"
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