---
dev_to_id: 1877637
title: "React + Ruby on Rails without any gems"
description: "React + Ruby on Rails without any gems   How to start using React components written in..."
created_at: "2024-06-05T06:32:51Z"
edited_at: "2024-07-03T12:34:03Z"
draft: false
tags: ["react", "typescript", "development"]
canonical_url: "https://jetthoughts.com/blog/react-ruby-on-rails-without-any-gems-typescript/"
cover_image: "https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/react-ruby-on-rails-without-any-gems-typescript/cover.jpeg"
slug: "react-ruby-on-rails-without-any-gems-typescript"
metatags:
  image: cover.jpeg
---

## React + Ruby on Rails without any gems

How to start using [React](https://reactjs.org/) components written in [TypeScript](https://www.typescriptlang.org/) using [Ruby on Rails](https://rubyonrails.org/) as a server with only built-in Rails features? There are a couple of ways we can achieve it with.

![Photo by [Gene Devine](https://unsplash.com/@devine_images?utm_source=medium&utm_medium=referral) on [Unsplash](https://unsplash.com?utm_source=medium&utm_medium=referral)](file_0.jpeg)

One is to add a gem: [react-rails](https://github.com/reactjs/react-rails) or [react_on_rails](https://github.com/shakacode/react_on_rails) for example. But there is a way to have a simple integration without using these gems.

## Setup

We will use [Webpacker](https://github.com/rails/webpacker) or JavaScript compiler and assets management. By following the [webpacker installation guid](https://github.com/rails/webpacker#installation)e, let’s add Webpacker and React to our application.

Now, create a new Rails application with a --webpack=reactoption:
```
    rails new myapp --webpack=react
```
For existing project add gem 'webpacker' to Gemfile and run the following commands:
```
    bundle exec rails webpacker:install
    bundle exec rails webpacker:install:react
```
Next step is to [install typescript](https://github.com/rails/webpacker/blob/master/docs/typescript.md#typescript-with-react) by running typescript installer:
```
    bundle exec rails webpacker:install:typescript
    yarn add @types/react @types/react-dom
```
Finally, convert file generated by rails hello_react.jsx to hello_react.tsx and voila — we have everything we need to build our application.

## Render component

Let's build a simple component which alerts a message when we are clicking on it.
```
    function Welcome(props) (
      <button onClick={() => alert(props.message)}>
        Click on me!
      </button>
    )
```
Here’s what we get at the beginning. This code shows how to append your React component to the DOM after its initialization.
```
    document.addEventListener('DOMContentLoaded', () => {
      ReactDOM.render(
        <Hello name="React" />,
        document.body.appendChild(document.createElement('div'))
      )
    })
```
Let's just copy and slightly adjust it to our needs. Instead of appending to the div tag to the body, we will mount the component to the needed node.
```
    document.addEventListener('DOMContentLoaded', () => {
      ReactDOM.render(
        <Welcome message="Hello, kind user!" />,
        document.getElementById('welcome-button')
      )
    })
```
The only missing part is the actual mount node on the page.
```
    <div id="welcome-button"></div>
```
Looks like everything is good and our small component should be rendered and welcome us, but we forgot something. JavaScript file with the component is not being loaded, so nothing really happens when the page loading. In the javascript/packs/application.js we will add a line which will require a file with the Welcome component:
```
    import 'containers/Welcome'
```
Let's see on the page and voila — our component is locked and loaded. Actually, if you are using [bin/webpacker-dev-server](https://github.com/rails/webpacker/blob/master/docs/webpack-dev-server.md) you don't need to reload anything, it will do it for yourself.

What if we want to have our Welcome component only on the page we are using? Well, you can just add a new pack with only the Welcome component required and add a javascript tag javascript_pack_tag 'welcome' inside a view. What is pack anyway? This is [Webpacker](https://github.com/rails/webpacker/blob/master/docs/folder-structure.md) name for [Webpack entry point concept](https://webpack.js.org/concepts/entry-points).

## Pass props

What if we need to pass data to our component? I.e. pass some props. The answer is data attributes. We will add a custom message as a data attribute to our mounted node:
```
    <div id="welcome-button" data-message="Hello from rails view!"></div>
```
And use this data to render the component:
```
    const mountNode = document.getElementById('welcome-button');
    const message = mountNode.getAttribute('data-message');

    document.addEventListener('DOMContentLoaded', () => {
      ReactDOM.render(
        <Welcome message={message} />,
        mountNode
      )
    })
```
## Don’t forget about type annotations

Hey, we are actually using typescript, so let's throw in some type annotations sparkles. Here is a complete hello_react.tsx file:
```
    import React from 'react'
    import ReactDOM from 'react-dom'

    interface WelcomeProps {
      message: string
    }

    export const Welcome: React.FC<WelcomeProps> = ({ message }) => (
      <button onClick={() => alert(message)}>
        Click on me!
      </button>
    )

    const mountNode = document.getElementById('welcome-button');
    const message = mountNode.getAttribute('data-message');
    document.addEventListener('DOMContentLoaded', () => {
      ReactDOM.render(
        <Welcome message={message} />,
        mountNode
      )
    })
```
## Can we do it better?

First of all, we will make a general helper method to render mounted nodes inside ApplicationHelper file:
```
    def react_component(name, props)
      content_tag(:div, { id: name, data: { react_props: props } }) do
      end
    end
```
And use it inside of a view:
```
    <%= react_component('welcome-button', message: 'Hello from rails view!') %>
```
Inside the JavaScript, we will also make a general function for mounting a component:
```
    function mount(Component, mountNodeId) {
      document.addEventListener('DOMContentLoaded', () => {
        const mountNode = document.getElementById(mountNodeId);
        const propsJSON = mountNode.getAttribute('data-react-props');
        const props = JSON.parse(propsJSON);
    
        ReactDOM.render(<Component {...props} />, mountNode);
      })
    }
```
Using these two helper functions will reduce the amount of boilerplate code and have a simple and flexible abstraction over the rendering of React components.

## Wrapping up

You can find the full project here: [https://github.com/jetthoughts/react-typescript-rails-simple-integration](https://github.com/jetthoughts/react-typescript-rails-simple-integration)

With this approach, we can easily mix Rails views and React components, or use React components as a replacement for the Rails views.

Webpacker might be confusing for the first time, especially if you don't have any experience with Webpack, but Rails team made an awesome job to hide complex stuff from you and provide an out-of-box tool. Hot reloading, ES6/typescript features, code splitting and the ocean of npm packages without any extra hassle will make your development experience more productive.

And the most important advantage, in my opinion, is lack of any dependency but Rails itself.

**Dmitriy Savin ***is a Software Engineer at [JetThoughts](https://www.jetthoughts.com). Follow him on [*LinkedIn](https://www.linkedin.com/in/dmitriy-savin-b63783bb/) *or [GitHub](https://github.com/askel4dd).*
>  If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).