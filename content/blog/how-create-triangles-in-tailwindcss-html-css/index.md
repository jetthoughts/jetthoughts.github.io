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
Need a CSS triangle in a Tailwind project without dropping into custom CSS? Use a zero-size box and color one border. Four directions, four snippets - copy, paste, ship.

## Triangle Down

Set width and height to `0`, then color one border solid and the two adjacent borders transparent. The browser draws the angled edges between them as a filled triangle.

1. `w-0 h-0` collapses the box.
2. `border-t-[75px] border-t-red-500` paints the top border full height and color.
3. `border-l-[50px] border-l-transparent` and `border-r-[50px] border-r-transparent` set the side borders to half the width with the color transparent.

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

All four examples produce a roughly equilateral triangle. To change the proportions, adjust the border widths in the `[*px]` brackets - the colored border controls the height (or width, for left/right variants), and the two transparent borders control the opposite dimension.

For more Tailwind techniques, see our guides on [CSS triangles without Tailwind](/blog/how-create-triangles-in-css-html/) and [full-screen vertical centering](/blog/vertical-align-with-full-screen-across-tailwind-css-jetthoughts/).

If you inherited a frontend where developers hand-roll CSS triangles instead of using an icon library, that gap between effort and result is worth a closer look. Our [code quality evaluation guide](/blog/code-quality-evaluation-non-technical-founders/) walks through the questions that surface these shortcuts.

[Talk to our team about a frontend audit](/contact/){.cta-link}
