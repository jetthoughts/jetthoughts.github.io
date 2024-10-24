---
dev_to_id: 1116924
title: "How to use background-size in CSS"
description: "The CSS background-size property sets the size of the background image of the element. Images can be..."
created_at: "2022-06-17T10:49:34Z"
edited_at: "2024-10-21T20:07:26Z"
draft: false
tags: ["css", "html", "webdev", "jetthoughts"]
canonical_url: "https://jetthoughts.com/blog/how-use-background-size-in-css-html/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fmedia.dev.to%2Fcdn-cgi%2Fimage%2Fwidth%3D1000%2Cheight%3D420%2Cfit%3Dcover%2Cgravity%3Dauto%2Cformat%3Dauto%2Fhttps%253A%252F%252Fdev-to-uploads.s3.amazonaws.com%252Fuploads%252Farticles%252Fbi4ip13evru2plxrxplb.png"
slug: "how-use-background-size-in-css-html"
metatags:
  image: cover.png
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
  
