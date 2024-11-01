---
dev_to_id: 1852739
title: RSCSS. Styling CSS without losing your sanity
description: Thinking of a beautiful and grammatically correct CSS code over and over again but still wiped out...
created_at: '2024-05-14T14:03:11Z'
edited_at: '2024-10-21T19:05:56Z'
draft: false
tags:
- css
- rscss
- html
- scss
canonical_url: https://jetthoughts.com/blog/rscss-styling-css-without-losing-your-sanity/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/rscss-styling-css-without-losing-your-sanity/cover.png
slug: rscss-styling-css-without-losing-your-sanity
metatags:
  image: cover.png
---
Thinking of a beautiful and grammatically correct CSS code over and over again but still wiped out with the methodology? Decided to use RSCSS but don’t know how to start?

Then this article is just for you. We will not go through the theory but move on to practice right away.


![Image description](file_0.png)

## What we will use?

### **Components**

In RSCSS you should think of UI like small parts, breaking it into several smaller pieces, which are the components. These components must have a class of two or more words separated by a dash -. For example ‘my-component’.

### **Elements**

Hence come the elements within your component, the children. These should have only one word. For example, element. If you need more than one word, put it all together as one.

A first selection insight becomes convenient now. It’s preferable to use the child selector > to refer to the elements. In addition to being more performative, they are less likely to have side effects.

Oh, I do not even have to tell you to always give preference to the classes rather than the tags in your selections, do I?

## Let's start

For example, we take the prepared HTML code:

```html
<ul class="vacation-list">
  <li class="vacation-list-item">
    <div class="vacation-card">
      <img class="vacation-card-image" src="https://img.theculturetrip.com/768x432/wp-content/uploads/2017/02/coconut-palm-on-caribbean-beach-cancun-mexico.jpg" alt="Beach in Cancun">
      <div class="vacation-card-info">
        <div class="vacation-card-eyebrow">Private Villa</div>
        <a class="vacation-card-title" href="#">Relaxing All-Inclusive Resort in Cancun</a>
        <div class="vacation-card-price">$99 USD per night</div>
      </div>
    </div>
  </li>
  <li class="vacation-list-item">
    <div class="vacation-card">
      <img class="vacation-card-image" src="https://img.theculturetrip.com/768x432/wp-content/uploads/2017/02/coconut-palm-on-caribbean-beach-cancun-mexico.jpg" alt="Beach in Cancun">
      <div class="vacation-card-info__orange">
        <div class="vacation-card-eyebrow">Private Villa</div>
        <a class="vacation-card-title" href="#">Relaxing All-Inclusive Resort in Cancun</a>
        <div class="vacation-card-price">$99 USD per night</div>
      </div>
    </div>
  </li>
</ul>
```

and CSS:

```css
.vacation-list {
  margin: 0;
  padding: 0;
  list-style: none;
  text-align: center;
}

.vacation-list-item {
  display: inline-block;
  vertical-align: top;
  text-align: left;
}

.vacation-card {
  margin: 0 auto;
  width: 275px;
  border-radius: 10px;
  overflow: hidden;
  font-family: sans-serif;
  border: 1px solid #cbd5e0;
}

.vacation-card-image {
  max-width: 100%;
  height: auto;
}

.vacation-card-info {
  padding: 10px;
  color: #718096;
}

.vacation-card-info__orange {
  padding: 10px;
  background: orange;
  color: white;
}

.vacation-card-eyebrow {
  text-transform: uppercase;
  font-size: 12px;
  margin-bottom: 5px;
}

.vacation-card-title {
  font-size: 16px;
  font-weight: 700;
  color: inherit;
  text-decoration: none;
}

.vacation-card-price {
  padding-top: 5px;
  font-size: 12px;
}
```

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

```html

<ul class="vacation-list">
  <li class="item">
    <div class="vacation-card">
      <img class="image" src="https://img.theculturetrip.com/768x432/wp-content/uploads/2017/02/coconut-palm-on-caribbean-beach-cancun-mexico.jpg" alt="Beach in Cancun">
      <div class="card-info">
        <div class="eyebrow">Private Villa</div>
        <a class="title" href="#">Relaxing All-Inclusive Resort in Cancun</a>
        <div class="price">$99 USD per night</div>
      </div>
    </div>
  </li>
  <li class="item">
    <div class="vacation-card">
      <img class="image" src="https://img.theculturetrip.com/768x432/wp-content/uploads/2017/02/coconut-palm-on-caribbean-beach-cancun-mexico.jpg" alt="Beach in Cancun">
      <div class="card-info -orange">
        <div class="eyebrow">Private Villa</div>
        <a class="title" href="#">Relaxing All-Inclusive Resort in Cancun</a>
        <div class="price">$99 USD per night</div>
      </div>
    </div>
  </li>
</ul>
```

It’s much better now.

### Clean up the style

We will use the child selector > to reference the elements. Don’t forget to add spaces between selectors.

```css
.vacation-list {
  margin: 0;
  padding: 0;
  list-style: none;
  text-align: center;
  
  > .item {
    display: inline-block;
    vertical-align: top;
    text-align: left;
  }
}

.vacation-card {
  margin: 0 auto;
  width: 275px;
  border-radius: 10px;
  overflow: hidden;
  font-family: sans-serif;
  border: 1px solid #cbd5e0;

  > .image {
    max-width: 100%;
    height: auto;
    display: block;
  }
}

.card-info {
  padding: 10px;
  color: #718096;
  
  &.-orange {
    background: orange;
    color: white;
  }

  > .eyebrow {
    text-transform: uppercase;
    font-size: 12px;
    margin-bottom: 5px;
  }

  > .title {
    color: inherit;
    font-size: 16px;
    font-weight: 700;
    text-decoration: none;
  }

  > .price {
    padding-top: 5px;
    font-size: 12px;
  }
}
```

Done!

After light improvements are done, we got a very nice and clear code which follows the RSCSS methodology.

### Structure

The only advice here is to try to insert only one component per file. Other than that, no rigor related to the structure.

Here is the full practical example of applying the methodology:

https://codepen.io/andriyparashchuk/pen/WqrrWK?editors=1100

## Final considerations

As you see, its superficial example of the methodology premises and ways how to visualize it. If you find it interesting, you can go deeper into [Willian Justen’s](https://willianjusten.com.br/falando-sobre-rscss/) articles or even official documentation.

So that you have a foundation to decide whether it’s worth studying and adopting in your day-to-day programming life.

Good luck to everyone!

**Andriy Parashchuk** is a Software Engineer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/andriy-parashchuk-3aa56468/) or [GitHub](https://github.com/andriyParashchuk).
>  If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).
