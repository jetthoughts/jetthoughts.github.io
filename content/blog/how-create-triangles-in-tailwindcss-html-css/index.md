---
remote_url: https://dev.to/jetthoughts/how-to-create-triangles-in-tailwindcss-2in
source: dev_to
remote_id: 1222970
dev_to_id: 1222970
dev_to_url: https://dev.to/jetthoughts/how-to-create-triangles-in-tailwindcss-2in
title: 4 Ways to Create a Triangle in Tailwind CSS
description: Learn 4 methods to create CSS triangles in Tailwind CSS using borders - up, down, left, and right. Copy-paste utility classes with live examples.
created_at: '2022-10-18T10:46:16Z'
edited_at: '2024-11-25T15:40:21Z'
date: 2022-10-18
draft: false
tags:
- html
- css
- webdev
- tailwindcss
canonical_url: https://jetthoughts.com/blog/how-create-triangles-in-tailwindcss-html-css/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/how-create-triangles-in-tailwindcss-html-css/cover.jpeg
metatags:
  image: cover.jpeg
slug: how-create-triangles-in-tailwindcss-html-css
---
In this post, we are going to see four examples of how to draw a triangle in TailwindCSS using borders.

## Triangle Down

Triangle is one of the simplest shapes in geometry. You can draw it with three straight lines and a couple of angles.

1. Set a width and height of 0 by: `w-0` and `h-0`
2. Set the top border to have the full height and color by: `border-t-[75px] border-t-red-500`
3. Set the side borders to half the width with the color transparent by: `border-l-[50px] border-l-transparent` and `border-r-[50px] border-r-transparent`

```html
<div class="w-0 h-0 
  border-l-[50px] border-l-transparent
  border-t-[75px] border-t-red-500
  border-r-[50px] border-r-transparent">
</div>
```

![Image description](file_0.png)

## Triangle Left

```html
<div class="w-0 h-0 
  border-t-[50px] border-t-transparent
  border-r-[75px] border-r-blue-500
  border-b-[50px] border-b-transparent">
</div>
```

![Image description](file_1.png)

## Triangle Up

```html
<div class="w-0 h-0 
  border-l-[50px] border-l-transparent
  border-b-[75px] border-b-yellow-500
  border-r-[50px] border-r-transparent">
</div>
```

![Image description](file_2.png)

## Triangle Right

```html
<div class="w-0 h-0 
  border-t-[50px] border-t-transparent
  border-l-[75px] border-l-green-500
  border-b-[50px] border-b-transparent">
</div>
```

![Image description](file_3.png)

In this post, we showed examples of a simple equilateral triangle. If you need a triangle with different sides, you can play with the width of the border `[*px]`.

If you inherited a frontend where developers reach for custom CSS triangles instead of using an icon library, that gap between effort and result is worth investigating. Our [code quality evaluation guide](/blog/code-quality-evaluation-non-technical-founders/) walks you through the questions that surface these kinds of shortcuts.

For more Tailwind techniques, see our guides on [CSS triangles without Tailwind](/blog/how-create-triangles-in-css-html/) and [full-screen vertical centering](/blog/vertical-align-with-full-screen-across-tailwind-css-jetthoughts/).
