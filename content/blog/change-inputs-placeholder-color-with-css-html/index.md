---
dev_to_id: 1099690
title: Change input’s placeholder color with CSS
description: 'Most modern browsers support the simple pseudo-element:    ::placeholder {   color: #9400d3; }       ...'
created_at: '2022-05-30T10:04:54Z'
edited_at: '2024-11-01T21:06:55Z'
draft: false
tags:
- css
- html
- webdev
- jetthoughts
canonical_url: https://jetthoughts.com/blog/change-inputs-placeholder-color-with-css-html/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/change-inputs-placeholder-color-with-css-html/cover.jpg
slug: change-inputs-placeholder-color-with-css-html
metatags:
  image: cover.jpg
---
Most modern browsers support the simple pseudo-element:
```css
::placeholder {
  color: #9400d3;
}
```
but what if you need to apply color to a placeholder in older browsers?

## WebKit, Blink, and Edge
WebKit, Blink (Safari, Google Chrome, Opera 15+), and Microsoft Edge are using a pseudo-element `::-webkit-input-placeholder`
```css
::-webkit-input-placeholder {
  color: #9400d3;
}
```

## Mozilla Firefox 4 to 18
Using a pseudo-class: `:-moz-placeholder`
```css
:-moz-placeholder {
  color: #9400d3;
  opacity: 1;
}
```
Firefox’s placeholder appears to be defaulting with reduced opacity, so needs to use `opacity: 1` here.

## Mozilla Firefox 19+
Using a pseudo-element: `::-moz-placeholder`, but the old selector will still work for a while.
```css
::-moz-placeholder {
  color: #9400d3;
  opacity: 1;
}
```

## Internet Explorer 10-11
Using a pseudo-class: `:-ms-input-placeholder`
```css
:-ms-input-placeholder {
  color: #9400d3;
}
```
