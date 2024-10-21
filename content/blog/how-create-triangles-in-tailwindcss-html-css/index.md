---
dev_to_id: 1222970
title: "How to create triangles in TailwindCSS"
description: "In this post, we are going to see four examples of how to draw a triangle in TailwindCSS using..."
created_at: "2022-10-18T10:46:16Z"
edited_at: "2024-10-21T17:43:04Z"
draft: false
tags: ["html", "css", "webdev", "tailwindcss"]
canonical_url: "https://jetthoughts.com/blog/how-create-triangles-in-tailwindcss-html-css/"
cover_image: "https://media.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fmedia.dev.to%2Fcdn-cgi%2Fimage%2Fwidth%3D1000%2Cheight%3D420%2Cfit%3Dcover%2Cgravity%3Dauto%2Cformat%3Dauto%2Fhttps%253A%252F%252Fdev-to-uploads.s3.amazonaws.com%252Fuploads%252Farticles%252Fostd933jdk97j8ifwm3e.jpeg"
slug: "how-create-triangles-in-tailwindcss-html-css"
metatags:
  image: cover.jpeg
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







