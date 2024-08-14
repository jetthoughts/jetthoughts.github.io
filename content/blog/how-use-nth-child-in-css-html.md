---
dev_to_id: 1113061
title: "How to use :nth-child in CSS"
description: "The :nth-child pseudo-class allows to select one and more elements based on their source..."
created_at: "2022-06-13T14:53:23Z"
edited_at: "2024-07-03T12:21:40Z"
draft: false
tags: ["css", "html", "webdev", "jetthoughts"]
canonical_url: "https://jetthoughts.com/blog/how-use-nth-child-in-css-html/"
cover_image: "https://media.dev.to/cdn-cgi/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fe9rve6b255r7off0ugz2.png"
slug: "how-use-nth-child-in-css-html"
---
The `:nth-child` pseudo-class allows to select one and more elements based on their source order.
```html
<ul>
  <li>One</li>
  <li>Two</li>
  <li>Three</li>
  <li>Four</li>
  <li>Five</li>
</ul>
```
Let’s look at simple examples for how this can be do:

## Select the first list item
```css
li:nth-child(1) {
  color: red;
}
```
Also, you can use `first-child` pseudo-class for this
```css
li:first-child {
  color: red;
}
```
![Image description](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/how-use-nth-child-in-css-html/file_0.png)

## Select the 5th list item
```css
li:nth-child(5) {
  color: red;
}
```
![Image description](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/how-use-nth-child-in-css-html/file_1.png)


## Select every child elements whose index is odd
```css
li:nth-child(odd) {
  color: red;
}
```
![Image description](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/how-use-nth-child-in-css-html/file_2.png)

## Select every child elements whose index is even
```css
li:nth-child(even) {
  color: red;
}
```
![Image description](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/how-use-nth-child-in-css-html/file_3.png)

## Select every 3rd list item starting with first
```css
li:nth-child(3n — 2) {
  color: red;
}
```
![Image description](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/how-use-nth-child-in-css-html/file_4.png)

## Select every 3rd list item starting with 2nd
```css
li:nth-child(3n — 1) {
  color: red;
}
```
![Image description](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/how-use-nth-child-in-css-html/file_5.png)
  
## Select every 3rd child item
```css
li:nth-child(3n) {
  color: red;
}
```
![Image description](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/how-use-nth-child-in-css-html/file_6.png)

## Select the first three items of the list
```css
li:nth-child(-n+3) {
  color: red;
}
```
![Image description](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/how-use-nth-child-in-css-html/file_7.png)
      
## Select the last element of the list
```css
li:last-child {
  color: red;
}
```
![Image description](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/how-use-nth-child-in-css-html/file_8.png)
 