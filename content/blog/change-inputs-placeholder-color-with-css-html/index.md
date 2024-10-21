---
dev_to_id: 1099690
title: "Change input’s placeholder color with CSS"
description: "Most modern browsers support the simple pseudo-element:    ::placeholder {   color: #9400d3; }       ..."
created_at: "2022-05-30T10:04:54Z"
edited_at: "2024-10-21T15:48:37Z"
draft: false
tags: ["css", "html", "webdev", "jetthoughts"]
canonical_url: "https://jetthoughts.com/blog/change-inputs-placeholder-color-with-css-html/"
cover_image: "https://media.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fmedia.dev.to%2Fcdn-cgi%2Fimage%2Fwidth%3D1000%2Cheight%3D420%2Cfit%3Dcover%2Cgravity%3Dauto%2Cformat%3Dauto%2Fhttps%253A%252F%252Fdev-to-uploads.s3.amazonaws.com%252Fuploads%252Farticles%252Fu2j7g01o71d7bkoojn45.jpg"
slug: "change-inputs-placeholder-color-with-css-html"
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
