---
dev_to_id: 1113061
title: "How to use :nth-child in CSS"
description: "The :nth-child pseudo-class allows to select one and more elements based on their source..."
created_at: "2022-06-13T14:53:23Z"
edited_at: "2024-05-10T19:48:21Z"
sync_date: "2024-05-24T15:34:23Z"
draft: false
tags: ["css", "html", "webdev", "jetthoughts"]
canonical_url: "https://jtway.co/how-to-use-nth-child-in-css-83c9feab3092"
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
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/e9rve6b255r7off0ugz2.png)

## Select the 5th list item
```css
li:nth-child(5) {
  color: red;
}
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/3pcymakl62wpodupa6ha.png)


## Select every child elements whose index is odd
```css
li:nth-child(odd) {
  color: red;
}
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/07myqk5nxrv4ift045gg.png)

## Select every child elements whose index is even
```css
li:nth-child(even) {
  color: red;
}
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/er45co5nrbwfsi71oosn.png)

## Select every 3rd list item starting with first
```css
li:nth-child(3n — 2) {
  color: red;
}
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/g39qoeqmkxuh86uxnvtm.png)

## Select every 3rd list item starting with 2nd
```css
li:nth-child(3n — 1) {
  color: red;
}
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/4pax0i1343r08awa8ipe.png)
  
## Select every 3rd child item
```css
li:nth-child(3n) {
  color: red;
}
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/rxfyxxwzs4pbfs8vdire.png)

## Select the first three items of the list
```css
li:nth-child(-n+3) {
  color: red;
}
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/r4d8g0treln69h6l7xwe.png)
      
## Select the last element of the list
```css
li:last-child {
  color: red;
}
```
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/d450kwaasyex3j2z1grz.png)
 