---
dev_to_id: 1116924
title: "How to use background-size in CSS"
description: "The CSS background-size property sets the size of the background image of the element. Images can be..."
created_at: "2022-06-17T10:49:34Z"
edited_at: "2022-06-17T14:53:45Z"
draft: false
tags: ["css", "html", "webdev", "jetthoughts"]
canonical_url: "https://jtway.co/how-to-use-background-size-in-css-7b3dcdc941d5"
slug: "how-use-background-size-in-css-html"
---
The CSS background-size property sets the size of the background image of the element. Images can be left to full size, stretched or limited to fit the available space.
```css
background-image: url('some-example-image.jpg');
```

## Cover
```css
background-size: cover;
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/9tp2oo2eh7x79k9i2q6t.png)


## Size in pixels or percentage
```css
background-size: 300px;
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/zoedgqjpigh1n1vgbebb.png)

```css
background-size: 15%;
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/mdv5e1u4lyaz98gcu5j9.png)


## Contain
```css
background-size: contain;
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/88nmgv0d07t1yef3t1v7.png)


## Background-Repeat
If the container is larger than the image, this will mosaic the image if the background-repeat property is not set to `no-repeat`.
```css
background-repeat: no-repeat;
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/o4fhm79iozsmjugpge53.png)


## Background-Position
The `background-position` CSS property sets the initial position for each background image. 
```css
background-position: center;
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/gz5e2wt308q4te7w2dr8.png)


## Background-Color
Spaces not covered by the background image are filled with the `background-color` property, and the background color will be visible on background images that have transparency.
```css
background-color: lightgreen;
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/vkbfnnhywj1ub9yji02m.png)
  
