---
remote_url: https://dev.to/jetthoughts/how-to-use-linear-gradient-in-css-bi1
source: dev_to
remote_id: 1125937
dev_to_id: 1125937
dev_to_url: https://dev.to/jetthoughts/how-to-use-linear-gradient-in-css-bi1
title: How to use Linear-Gradient in CSS
description: The CSS linear-gradient function creates an image that consists of a progressive transition between...
created_at: '2022-06-27T21:31:18Z'
edited_at: '2024-11-25T15:41:05Z'
draft: false
date: 2022-06-27
tags:
- html
- css
- webdev
canonical_url: https://jetthoughts.com/blog/how-use-linear-gradient-in-css-html/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/how-use-linear-gradient-in-css-html/cover.jpg
metatags:
  image: cover.jpg
slug: how-use-linear-gradient-in-css-html
---
The CSS `linear-gradient` function creates an image that consists of a progressive transition between two or more colors along a straight line. The result is a data type object `gradient`, which is a special type `image`.

## Top to Bottom

In this example shows a linear gradient that starts at the top. It starts blue, transitioning green:

```css
background-image: linear-gradient(to bottom, blue, green);
```

![Image description](file_0.png)

## Left to Right

In this example shows a linear gradient that begins on the left. It starts blue, transitioning yellow:

```css
background-image: linear-gradient(to right, blue, green);
```

![Image description](file_1.png)

## Diagonal

You can make a gradient diagonally by specifying the horizontal and vertical starting position.

In this example shows a linear gradient that starts at the top left (and goes to the bottom right). It starts blue, transitioning yellow:

```css
background-image: linear-gradient(to bottom right, blue, green);
```

![Image description](file_2.png)

If you want to control the direction of the gradient more, you can define the angle instead of predefined directions (bottom, up, right, left, bottom right, etc.). A value of `0deg` is equivalent to to top. A value of `90deg` is equivalent `to right`. A value of `180deg` is equivalent `to bottom`.

```css
background-image: linear-gradient(135deg, blue, green);
```

## Multiple Color

In this example shows a linear gradient (from top to bottom) with multiple color stops:

```css
background-image: linear-gradient(to bottom, blue, yellow, green);
```

![Image description](file_3.png)
