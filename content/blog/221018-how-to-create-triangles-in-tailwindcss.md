+++
title = "How to create triangles in TailwindCSS"
description = "In this post, we are going to see four examples to draw a triangle in TailwindCSS using borders.    ..."
created_at = "2022-10-18T10:46:16Z"
edited_at = "2024-05-15T13:22:04Z"
sync_date = "2024-05-23T09:04:09Z"
draft = false
tags = ["html", "css", "webdev", "tailwindcss"]
canonical_url = "https://jtway.co/how-to-create-triangles-in-tailwindcss-9c80006d7987"
slug = "221018-how-to-create-triangles-in-tailwindcss"
+++
In this post, we are going to see four examples to draw a triangle in TailwindCSS using borders.

## Triangle Down

Triangle is one of the simplest shapes in geometry. It can be drawn with just three straight lines and a couple of angles.

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
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/lty9myydv862xrzdplm8.png)

## Triangle Left
```html
<div class="w-0 h-0 
  border-t-[50px] border-t-transparent
  border-r-[75px] border-r-blue-500
  border-b-[50px] border-b-transparent">
</div>
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/5wkf825qmrkth0swawxe.png)

## Triangle Up
```html
<div class="w-0 h-0 
  border-l-[50px] border-l-transparent
  border-b-[75px] border-b-yellow-500
  border-r-[50px] border-r-transparent">
</div>
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/hvchko8w2mi3nnvx9l4r.png)

## Triangle Right
```html
<div class="w-0 h-0 
  border-t-[50px] border-t-transparent
  border-l-[75px] border-l-green-500
  border-b-[50px] border-b-transparent">
</div>
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/9x7x2twgrj9a2hsqjh9k.png)

In this post, we showed examples of a simple equilateral triangle. If you need a triangle with different sides, you can play with the width of the border `[*px]`.







