---
dev_to_id: 1168677
title: "How to create circles in CSS"
description: "Let's look at a few tricks in CSS able to create basic shapes like circles.    &lt;div..."
created_at: "2022-08-16T12:14:22Z"
edited_at: "2024-10-21T15:46:13Z"
draft: false
tags: ["css", "html", "devops"]
canonical_url: "https://jetthoughts.com/blog/how-create-circles-in-css-html/"
cover_image: "https://media.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fmedia.dev.to%2Fcdn-cgi%2Fimage%2Fwidth%3D1000%2Cheight%3D420%2Cfit%3Dcover%2Cgravity%3Dauto%2Cformat%3Dauto%2Fhttps%253A%252F%252Fdev-to-uploads.s3.amazonaws.com%252Fuploads%252Farticles%252F7xzg60il1ng1f5og0gqo.png"
slug: "how-create-circles-in-css-html"
metatags:
  image: cover.png
---
Let's look at a few tricks in CSS able to create basic shapes like circles.
```html
<div class="circle"></div>
```

## Border-Radius
For this case need to use the border-radius property and set the value to 50%. Then combine the height and width properties with a matching value.
```css
.circle {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  background: lightgreen;
}
```
![Image description](file_0.png)

## Circle()
In this, the circle is created using the shape-outside property. You must also apply a clip-path with the appropriate property to make the circle appear.
```css
.circle {
  width: 100px;
  height: 100px;
  clip-path: circle();
  shape-outside: circle();
  background: yellow; 
}
```
![Image description](file_1.png)
  