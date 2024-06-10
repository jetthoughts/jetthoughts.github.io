---
dev_to_id: 1853621
title: "How to have a clean CSS structure with RSCSS/ITCSS"
description: "Writing the CSS code is relatively simple. Learning a language is not a big problem and doesn’t take..."
created_at: "2024-05-15T07:45:28Z"
edited_at: "2024-06-10T15:46:00Z"
draft: false
tags: ["css", "rscss", "frontend", "tutorial"]
canonical_url: "https://jetthoughts.com/blog/how-have-clean-css-structure-with-rscssitcss-rscss"
slug: "how-have-clean-css-structure-with-rscssitcss-rscss"
---
Writing the CSS code is relatively simple. Learning a language is not a big problem and doesn’t take a lot of effort. Making three lines of CSS code to style a DOM-element won’t take you more than two minutes, but let’s open our eyes to the bigger picture…

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/how-have-clean-css-structure-with-rscssitcss-rscss/file_0.jpeg)

What if the application grows faster than expected at the beginning of the project?

Is it easy to maintain its code? What should one consider to write more extensible and supported CSS code?

Let’s look at two technical solutions — [RSCSS](https://rscss.io/)/[ITCSS](https://itcss.io/). This is indeed a perfect combination of instruments which we use in our projects built on [React](https://reactjs.org/) and [Ruby on Rails](https://rubyonrails.org/).

## What is RSCSS?

RSCSS is an alternative to BEM, which still allows keeping the sanity you won’t get in BEM.

Any CSS greater than 1000 lines will get cumbersome and obscure. You’ll eventually run into these common pitfalls:

* What does this class mean?

* Is this class still being used?

* If I make a new class green, will there be a collision?

RSCSS is an attempt to organize and solve all of the above. However, it is not a framework, as you might have thought about it at the beginning. It is just a set of ideas to guide and build your process of growing maintainable CSS code for any modern website or application.

Instead of creating a .massive-class-separated — like this, you can create simple classes without fear to spoil styling, e.g. .button, .icon, etc. due to the advantage of direct selectors >.

## Intelligent, scalable, manageable architecture

ITCSS stands for Inverted Triangle CSS, and it helps you organize your project CSS files the way you can better deal with (not always easy-to-deal-with though). It’s about CSS specifics like a global namespace, cascade, and selectors specificity.

ITCSS can be used with preprocessors or without them and compatible with CSS methodologies like [BEM](https://en.bem.info/), [SMACSS](http://smacss.com/) or [OOCSS](http://oocss.org/).

One of the critical principles of ITCSS is that it separates your CSS codebase into several sections (called layers), which take the form of the inverted triangle:

![The inverted triangle model](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/how-have-clean-css-structure-with-rscssitcss-rscss/file_1.jpeg)

From top to bottom:

* **Settings:** variables. Font, colors, definitions, etc. No output.

* **Tools:** mixins and functions. No output.

* **Generic:** reset and/or normalize styles.

* **Elements:** bare HTML elements (like H1, A, etc.).

* **Objects:** class selectors which define undecorated design patterns, like the media object from OOCSS.

* **Components:** specific UI components. Most of the code.

* **Trumps:** utilities and helper classes with the ability to override anything.

## Integration ITCSS practices to React/Rails

As an example, let’s take the [Bootstrap](https://getbootstrap.com/) framework and try to go with ITCSS structure in it.

In app/javascript/stylesheets/ directory of your project you’d need to create main.scss

```css
// Settings
// This is where all the global and brand variables stored
@import "settings";

// Tools
// This is where all the mixins and functions housed
@import "tools";

// Generic
// Ground Zero styles like Normalize.css, global box-sizing rules, go here
@import "generic";

// Elements
// Unclassed HTML elements (type selectors) go here
@import "elements";

// Objects
// Cosmetic-free design patterns.
// Objects can range from something as simple as a .wrapper element to layout systems.
@import "objects";

// Components
// Designed components, chunks of UI, go here
@import "components";

// This is the only place where !important declarations will be accepted.
// This is the highest specificity layer includes the most explicit types of rules.
@import "utilities";
```

Now, we can import scss File from Bootstrap. Let’s create _tools.scss and import mixins:

```css
@import "~bootstrap/scss/mixins";
@import "~bootstrap/scss/root";
```

It is also good to create _components.scss with our custom components:

```css
@import 'components/components.search-bar';
```
So, as you can see, it’s pretty easy.

## Correct use of RSCSS

We can talk a lot about the methodology, but let’s take a better look at real examples and practice:

Look at this simple SCSS code:

```css
.search-form {
  position: relative;
  .field {
    box-shadow: none;
  }
  .button {
    font-size: 22px;
    line-height: 34px;
    width: 22px;
    top: 1px;
    bottom: 1px;
    right: 1px;
    cursor: pointer;
    position: absolute;
    transition: opacity .3s;
    &:hover {
      opacity: .8;
    }
  }
  .search-result {
    overflow: hidden;
    font-size: 0;
    line-height: 0;
    &.less {
      max-height: 210px;
    }
    &.more {
      max-height: 100%;
    }
  }
}
```

It doesn’t look clear and straightforward, right? But once we use RSCSS methodology, our code will look like this:

```css
.search-form {
  position: relative;

  > .field {
    font-size: 22px;
    line-height: 34px;
    width: 120px;
  }

  > .button {
    font-size: 22px;
    line-height: 34px;
    width: 22px;
    &:hover {
      opacity: .8;
    }
  }
}

.search-result {
  overflow: hidden;

  &.-less {
    max-height: 210px;
  }

  &.-more {
    max-height: 100%;
  }
}
```

Isn’t it beautiful? I think it’s quite pretty and way more readable!

If you want to know more about [RSCSS](https://rscss.io), you can check out the documentation and elegant guide from [Willian Justen](https://willianjusten.com.br/falando-sobre-rscss/) about the methodology itself.

## Setup stylelint-rscss

stylelint-rscss makes the developer’s life easier to learn and integrate. It helps you to follow coding and formatting standards, without constantly thinking about it.

In this example, we will use [Yarn](https://yarnpkg.com/en/), but you can use another package manager to your taste.

As a first step, let’s add stylelint and stylelint-rscss to dependentsyarn add — dev stylelint stylelint-rscss

In the second step, we should create the .stylelintrc file in your project:
```
    {
      “extends”: [
        “stylelint-rscss/config”
      ]
    }
```
And the last action is to add a script to your package.json:
```
    {
      “scripts”: {
        "lint:css": "stylelint path/to/css/**/*"
      }
    }
```
That’s all, now let’s just run it:
```
yarn lint
```
## You cannot go wrong with ITCSS and RSCSS

I liked the RSCSS approach very much since it ends up changing a lot — not only in styling but also in the way of scaling components and making them powerful.

ITCSS doesn’t force you to use certain naming conventions. It doesn’t force you to use all layers. Use a layer structure that works best for you while maintaining the ITCSS principles — generic to explicit, low to high specificity and far-reaching to localized.

Thank you for reading my article, and let’s make something pretty using it.

**Andriy Parashchuk **is a Software Engineer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/andriy-parashchuk-3aa56468/) or [GitHub](https://github.com/andriyParashchuk).
>  If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).
