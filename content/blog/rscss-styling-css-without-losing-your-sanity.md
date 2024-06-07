---
dev_to_id: 1852739
title: "RSCSS. Styling CSS without losing your sanity"
description: "Thinking of a beautiful and grammatically correct CSS code over and over again but still wiped out..."
created_at: "2024-05-14T14:03:11Z"
edited_at: "2024-06-06T07:39:52Z"
draft: false
tags: ["css", "rscss", "html", "scss"]
canonical_url: "https://jetthoughts.com/blog/rscss-styling-css-without-losing-your-sanity"
slug: "rscss-styling-css-without-losing-your-sanity"
---
Thinking of a beautiful and grammatically correct CSS code over and over again but still wiped out with the methodology? Decided to use RSCSS but don’t know how to start?

Then this article is just for you. We will not go through the theory but move on to practice right away.

![](https://cdn-images-1.medium.com/max/NaN/0*rhj89G6kz3tseDdP.)

## What we will use?

### **Components**

In RSCSS you should think of UI like small parts, breaking it into several smaller pieces, which are the components. These components must have a class of two or more words separated by a dash -. For example ‘my-component’.

### **Elements**

Hence come the elements within your component, the children. These should have only one word. For example, element. If you need more than one word, put it all together as one.

A first selection insight becomes convenient now. It’s preferable to use the child selector > to refer to the elements. In addition to being more performative, they are less likely to have side effects.

Oh, I do not even have to tell you to always give preference to the classes rather than the tags in your selections, do I?

## Let's start

For example, we take the prepared HTML code:

 <iframe src="https://medium.com/media/f9cc1010245ba100f3610cd76a31dfc7" frameborder=0></iframe>

and CSS:

 <iframe src="https://medium.com/media/4f8e6bd8f11384ca2d3e5d43f76c38dc" frameborder=0></iframe>

As you can see, this class naming doesn’t go by the RSCSS recommendation about components and elements structure.

### **Improve naming**

Let’s rename some elements then:

vacation-list-item =>item

vacation-card-image => image

vacation-card-info => card-info

vacation-card-eyebrow => eyebrow

vacation-card-title => title

vacation-card-price => price

and vacation-card-info__orange => -orange

 <iframe src="https://medium.com/media/8453a83389b09bbe4a9b475cfce70806" frameborder=0></iframe>

It’s much better now.

### Clean up the style

We will use the child selector > to reference the elements. Don’t forget to add spaces between selectors.

 <iframe src="https://medium.com/media/8ec22405312a1148aaf7534a965716ae" frameborder=0></iframe>

Done!

After light improvements are done, we got a very nice and clear code which follows the RSCSS methodology.

### Structure

The only advice here is to try to insert only one component per file. Other than that, no rigor related to the structure.

Here is the full practical example of applying the methodology:

 <iframe src="https://medium.com/media/6c0e5f85caff38fa1e790100a2159cd7" frameborder=0></iframe>

## Final considerations

As you see, its superficial example of the methodology premises and ways how to visualize it. If you find it interesting, you can go deeper into [Willian Justen’s](https://willianjusten.com.br/falando-sobre-rscss/) articles or even official documentation.

So that you have a foundation to decide whether it’s worth studying and adopting in your day-to-day programming life.

Good luck to everyone!

**Andriy Parashchuk **is a Software Engineer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/andriy-parashchuk-3aa56468/) or [GitHub](https://github.com/andriyParashchuk).
>  If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).
