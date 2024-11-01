---
dev_to_id: 1103884
title: How to vertically center an element without Flex
description: How vertically center with Flex you can view Vertical align with a full screen across Tailwind...
created_at: '2022-06-03T12:58:50Z'
edited_at: '2024-10-21T21:06:30Z'
draft: false
tags:
- css
- html
- webdev
- jetthoughts
canonical_url: https://jetthoughts.com/blog/how-vertically-center-an-element-without-flex-css-html/
cover_image:
slug: how-vertically-center-an-element-without-flex-css-html
---
How vertically center with Flex you can view [Vertical align with a full screen across Tailwind CSS](https://jtway.co/vertical-align-with-a-full-screen-across-tailwind-css-5c6ad91c3e4f)
```html
<div class="outer">
  <div class="inner">Centered</div>
</div>
```

## Transform Translate
It’s possible to center it by nudging it up half of it’s height after bumping it down halfway:

```css
.outer {
  position: relative;
  height: 100vh;
}
.inner {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
}
```

## Display: Table-Cell
Outer element to be displayed as a `table` and the inner element to be displayed as a `table-cell` which can then be vertically centered.

```css
.outer {
  display: table;
  height: 100vh;
}
.inner {
  display: table-cell;
  vertical-align: middle;
}
```

## Fixed Height
Set `margin-top: -yy` where `yy` is half the height of the inner container to offset the item up.
```css
.outer {
  position: relative;
  height: 100vh;
}
.inner {
  position: absolute;
  height: 100px;
  margin-top: -50px;
  top: 50%;
}
```