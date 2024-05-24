---
dev_to_id: 1148536
title: "How to create triangles in CSS"
description: "In this post, we are going to see a simple method to draw a triangle in CSS using borders.    &lt;div..."
created_at: "2022-07-22T08:32:10Z"
edited_at: ""
sync_date: "2024-05-24T16:04:34Z"
draft: false
tags: ["css", "html", "webdev"]
canonical_url: "https://jtway.co/how-to-create-triangles-in-css-20c70d46857b"
slug: "how-create-triangles-in-css-html"
---
In this post, we are going to see a simple method to draw a triangle in CSS using borders.
```html
<div class="triangle-up"></div>
<div class="triangle-down"></div>
<div class="triangle-left"></div>
<div class="triangle-right"></div>
```

## Triangle Up
Triangle is one of the simplest shapes in geometry. It can be drawn with just three straight lines and a couple of angles.

1. Set a width and height of 0.
2. Set the border color to transparent.
3. Set the top border to 0.
4. Set the side borders to half the width.
5. Set the bottom border to have the full height.
6. Set a color for the bottom border.

```css
.triangle-up {
  width: 0; 
  height: 0; 
  border-left: 15px solid transparent;
  border-right: 15px solid transparent; 
  border-bottom: 15px solid red;
}
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/c6v74y7hiq0oihmawh34.png)

## Triangle Down
```css
.triangle-down {
  width: 0; 
  height: 0; 
  border-left: 15px solid transparent;
  border-right: 15px solid transparent;
  border-top: 15px solid blue;
}
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/x5n0u28q42i8yff4wtnf.png)

## Triangle Left
```css
.triangle-left {
  width: 0; 
  height: 0; 
  border-top: 15px solid transparent;
  border-bottom: 15px solid transparent; 
  border-right: 15px solid yellow; 
}
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/kp73luwplu4mvylnhyl4.png)

## Triangle Right
```css
.triangle-right {
  width: 0; 
  height: 0; 
  border-top: 15px solid transparent;
  border-bottom: 15px solid transparent;
  border-left: 15px solid green;
}
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/36ul4s884a4bazx4y1la.png)
 

