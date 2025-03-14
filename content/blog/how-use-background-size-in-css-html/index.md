---
remote_url: https://dev.to/jetthoughts/how-to-use-background-size-in-css-3pj
source: dev_to
remote_id: 1116924
dev_to_id: 1116924
dev_to_url: https://dev.to/jetthoughts/how-to-use-background-size-in-css-3pj
title: How to use background-size in CSS
description: The CSS background-size property sets the size of the background image of the element. Images can be...
created_at: '2022-06-17T10:49:34Z'
edited_at: '2024-11-25T15:41:07Z'
draft: false
tags:
- css
- html
- webdev
- jetthoughts
canonical_url: https://jetthoughts.com/blog/how-use-background-size-in-css-html/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/how-use-background-size-in-css-html/cover.png
metatags:
  image: cover.png
slug: how-use-background-size-in-css-html
---
The CSS background-size property sets the size of the background image of the element. Images can be left to full size, stretched or limited to fit the available space.
```css
background-image: url('some-example-image.jpg');
```

## Cover
```css
background-size: cover;
```
![Image description](file_0.png)


## Size in pixels or percentage
```css
background-size: 300px;
```
![Image description](file_1.png)

```css
background-size: 15%;
```
![Image description](file_2.png)


## Contain
```css
background-size: contain;
```
![Image description](file_3.png)


## Background-Repeat
If the container is larger than the image, this will mosaic the image if the background-repeat property is not set to `no-repeat`.
```css
background-repeat: no-repeat;
```
![Image description](file_4.png)


## Background-Position
The `background-position` CSS property sets the initial position for each background image. 
```css
background-position: center;
```
![Image description](file_5.png)


## Background-Color
Spaces not covered by the background image are filled with the `background-color` property, and the background color will be visible on background images that have transparency.
```css
background-color: lightgreen;
```
![Image description](file_6.png)
  
