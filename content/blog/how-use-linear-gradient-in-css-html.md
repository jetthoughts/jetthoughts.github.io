---
dev_to_id: 1125937
title: "How to use Linear-Gradient in CSS"
description: "The CSS linear-gradient function creates an image that consists of a progressive transition between..."
created_at: "2022-06-27T21:31:18Z"
edited_at: "2024-07-03T12:21:38Z"
draft: false
tags: ["html", "css", "webdev"]
canonical_url: "https://jetthoughts.com/blog/how-use-linear-gradient-in-css-html/"
cover_image: "https://media.dev.to/cdn-cgi/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F9bikt97gjbmyefav7q4r.jpg"
slug: "how-use-linear-gradient-in-css-html"
---
The CSS `linear-gradient` function creates an image that consists of a progressive transition between two or more colors along a straight line. The result is a data type object `gradient`, which is a special type `image`.

## Top to Bottom
In this example shows a linear gradient that starts at the top. It starts blue, transitioning green:

```css
background-image: linear-gradient(to bottom, blue, green);
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/peojlhke1mxezd9zhaxn.png)
 
## Left to Right
In this example shows a linear gradient that begins on the left. It starts blue, transitioning yellow:

```css
background-image: linear-gradient(to right, blue, green);
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ofv8leikwgra8jbsapl5.png)
 

## Diagonal
You can make a gradient diagonally by specifying the horizontal and vertical starting position.

In this example shows a linear gradient that starts at the top left (and goes to the bottom right). It starts blue, transitioning yellow:

```css
background-image: linear-gradient(to bottom right, blue, green);
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/bd89zj7fds8ztshv6aak.png)
 
If you want to control the direction of the gradient more, you can define the angle instead of predefined directions (bottom, up, right, left, bottom right, etc.). A value of `0deg` is equivalent to to top. A value of `90deg` is equivalent `to right`. A value of `180deg` is equivalent `to bottom`.

```css
background-image: linear-gradient(135deg, blue, green);
```

## Multiple Color
In this example shows a linear gradient (from top to bottom) with multiple color stops:

```css
background-image: linear-gradient(to bottom, blue, yellow, green);
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/yqmbg7soofy5t6ufj8yk.png)
 