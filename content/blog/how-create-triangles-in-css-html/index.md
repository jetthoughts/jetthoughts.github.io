---
remote_url: https://dev.to/jetthoughts/how-to-create-triangles-in-css-2a6k
source: dev_to
remote_id: 1148536
dev_to_id: 1148536
dev_to_url: https://dev.to/jetthoughts/how-to-create-triangles-in-css-2a6k
title: How to create triangles in CSS
description: In this post, we are going to see a simple method to draw a triangle in CSS using borders.    &lt;div...
created_at: '2022-07-22T08:32:10Z'
edited_at: '2024-11-25T15:40:57Z'
draft: false
tags:
- css
- html
- webdev
canonical_url: https://jetthoughts.com/blog/how-create-triangles-in-css-html/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/how-create-triangles-in-css-html/cover.png
metatags:
  image: cover.png
slug: how-create-triangles-in-css-html
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
![Image description](file_0.png)

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
![Image description](file_1.png)

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
![Image description](file_2.png)

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
![Image description](file_3.png)
 

