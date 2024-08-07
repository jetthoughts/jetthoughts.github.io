---
dev_to_id: 1109046
title: "How to style a checkbox using CSS"
description: "In this post I’l show you exactly how to make awesome checkboxes with just CSS.    &lt;div&gt;  ..."
created_at: "2022-06-09T09:02:15Z"
edited_at: "2024-07-03T12:21:35Z"
draft: false
tags: ["css", "html", "webdev", "jetthoughts"]
canonical_url: "https://jetthoughts.com/blog/how-style-checkbox-using-css-html/"
cover_image: "https://media.dev.to/cdn-cgi/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fr52osy8dx8pfwh7iz2hw.jpg"
slug: "how-style-checkbox-using-css-html"
---
In this post I’l show you exactly how to make awesome checkboxes with just CSS.
```html
<div>
  <input id="first_name" type="checkbox" checked="checked">
  <label for="first_name">First Name</label>
</div>
```
Let’s take a few simple steps:

- Hide the browser’s default checkbox.
- Create a custom checkbox. We will use a pseudo-element `:before` for the substrate.
- On mouse-over, add a darkly on 10% background color.
- Style the checkmark/indicator, by pseudo-element `:after`
- Show or hide the checkmark when checked.

## Hide the browser’s default checkbox
```css
input {
  position: absolute;
  opacity: 0;
  height: 0;
  width: 0;
}
```

## Create a custom checkbox
```css
label {
  position: relative;
  display: block;
  padding-left: 30px;
  cursor: pointer;
}
label:before {
  content: '';
  position: absolute;
  top: 50%;
  margin-top: -10px;
  left: 0;
  display: block;
  height: 20px;
  width: 20px;
  background-color: #50CDBE;
  border-radius: 3px;
}
```

## On mouse-over, add a darkly on 10% background color
```css
label:hover:before {
  background-color: #1AE6E6;
}
```

## Style the checkmark/indicator
```css
label:after {
  content: '';
  position: absolute;
  left: 7px;
  top: 1px;
  width: 5px;
  height: 10px;
  border: solid #333;
  border-width: 0 3px 3px 0;
  transform: rotate(45deg);
  opacity: 0;
}
```

## Show or hide the checkmark when checked
```css
input:checked + label:after {
  opacity: 1;
}
```
