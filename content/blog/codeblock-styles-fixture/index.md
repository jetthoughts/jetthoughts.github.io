---
title: Code Block Styles Fixture
description: Test-only fixture post exercising every fenced-code rendering path (recognized lexers, bare fences, indented blocks) for the visual regression suite.
draft: true
date: 2020-01-01
tags: []
slug: codeblock-styles-fixture
---
Test-only fixture. Each section below exercises one code-block rendering
path so the visual suite can lock their styles. Kept `draft: true` so it
never ships to production; test builds run with `--buildDrafts`.

## text

```text
GET /health HTTP/1.1
Host: example.com
status: ok
```

## md

```md
# Heading

Some *emphasis* and a [link](https://example.com).

- item one
- item two
```

## ruby

```ruby
class Greeter
  def initialize(name)
    @name = name
  end

  def hello
    "Hello, #{@name}!"
  end
end
```

## python

```python
def fib(n):
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return a
```

## js

```js
const debounce = (fn, ms) => {
  let t;
  return (...args) => {
    clearTimeout(t);
    t = setTimeout(() => fn(...args), ms);
  };
};
```

## html

```html
<article class="card">
  <h2>Title</h2>
  <p>Body copy with a <a href="/blog/">link</a>.</p>
</article>
```

## bare (no language)

```
rake db:migrate
rake db:seed
```

## indented (4-space block)

    $ bin/hugo-build
    $ bin/rake test:critical
