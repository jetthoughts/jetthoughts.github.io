---
dev_to_id: 1877561
title: "How To Memoize False and Nil Values"
description: "TL;DR: if method can return false or nil, and you want to memoize it, use defined?(@_result)..."
created_at: "2024-06-05T05:55:50Z"
edited_at: "2024-06-10T15:46:38Z"
draft: false
tags: ["ruby", "rails", "tutorial", "development"]
canonical_url: "https://jetthoughts.com/blog/how-memoize-false-nil-values-ruby-rails"
slug: "how-memoize-false-nil-values-ruby-rails"
---

![Unsplash Photo: [Mike Petrucci](https://unsplash.com/@mikepetrucci)](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/how-memoize-false-nil-values-ruby-rails/file_0.jpeg)

**TL;DR: if method can return false or nil, and you want to memoize it, use defined?(@_result) instead of ||=.**

Memoization is a useful technique which helps to achieve cleaner and more efficient code. When some expensive method of an object is called, we save its value to an instance variable, so that we don’t have to do those heavy calculations again.
```ruby
class Book
  def word_count
    @_word_count ||= sections.sum do |section|
      section.paragraphs.map(&:text).sum { |para| para.scan(/\w+/).size }
    end
  end 
end
```
The ||= is a conditional assignment operator which translates as: *“if left side is truthy (not *false *and not *nil*), then stop right there; otherwise assign right side to the left side”*. And since in Ruby the last statement gets returned by a method, in one case it returns result of sections.sum, and in other case the previously assigned instance variable @_word_count.

This idiom is so simple that it’s easy to start using it everywhere without much thinking. But there are cases where it won’t work. We talk about *falsey* values. Consider the following methods, one of which tells if the book is referenced from any other book, and other finds the last book that referenced this one:

```ruby
class Book
  def referenced_elsewhere?
    @_referenced_elsewhere ||= Book.where(some_complex_and_expensive_query).exists?
  end 
  
  def last_referenced_from 
    @_last_referenced_from ||= Book.where(some_complex_and_expensive_query).first
  end 
end
```

If the book was referenced by any other book, these methods will work as expected. Otherwise they will work too, but the memoization won’t ever kick in, and the complex and expensive query will be executed every time the method is called. That is because false or nil on the left side make the conditional assignment ||= always proceed to the assignment part.

So if a method can return false, the memoization should take it into account, like this for instance:

```ruby

  def referenced_elsewhere?
    return @_referenced_elsewhere unless @_referenced_elsewhere.nil?
    @_referenced_elsewhere = Book.where(some_complex_and_expensive_query).exists?
  end
```

This looks not so laconically as the previous one, but it works for boolean results.

A careful reader would have noticed though, that this way we ignore nil values when nil is a potential result. ActiveRecord’s exists? can’t possibly return nil, so we’re safe there, but .first can, and so the some_complex_and_expensive_query will hit the database on each call to last_referenced_from. There’s got to be a better way! And there is!

```ruby
  def last_referenced_from 
    return @_last_referenced_from if defined?(@_last_referenced_from)
    @_last_referenced_from = Book.where(some_complex_and_expensive_query).first
  end 
```

defined? is Ruby’s reserved word to check if expression is currently defined. Once we assign anything, including nil, to @_last_referenced_from, defined?(@_last_referenced_from) returns String value "instance-variable", which is truthy. It will work for all kinds of values, including also false.

To sum up, ||= is too good to forget about it, but when doing memoization, just think if the result may be boolean or nil, and if yes, use defined?.

***Paul Keen **is a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [](https://twitter.com/ChrisKeathley)[*LinkedIn](https://www.linkedin.com/in/paul-keen/) *or [GitHub](https://github.com/pftg).*
>  If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).
