---
dev_to_id: 1115250
title: "Pitfalls of using metaprogramming in Ruby on Rails application"
description: "Do you know that metaprogramming is easy to add but hard to support? Developers underestimated risks..."
created_at: "2022-06-15T17:32:52Z"
edited_at: "2024-07-03T12:22:39Z"
draft: false
tags: ["ruby", "programming", "beginners"]
canonical_url: "https://jetthoughts.com/blog/pitfalls-of-using-metaprogramming-in-ruby-on-rails-application-programming/"
cover_image: "https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/pitfalls-of-using-metaprogramming-in-ruby-on-rails-application-programming/cover.png"
slug: "pitfalls-of-using-metaprogramming-in-ruby-on-rails-application-programming"
---
Do you know that metaprogramming is easy to add but hard to support? Developers underestimated risks related to using metaprogramming in the code, which causes development slowdowns and business financial problems.

> _TL;DR: Cryptic code and indirect dependencies make development unstable and slow_

Appearances can be deceptive. Metaprogramming and dynamically generated code look like neat solutions which dramatically compress code, but there is a shadow part to it.

I assembled the most common problems, which were missing from the consideration, and were reasons for the stressful weeks for the whole team.

### Here is a list of them:
* Hard to find what causes bugs
* Hard to add new changes
* Easier to add unintentional bugs

## Hard to find what causes bugs
![Where is the method?](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/pitfalls-of-using-metaprogramming-in-ruby-on-rails-application-programming/file_0.png)

In my experience, most of the unexpected and hard-to-reproduce bugs were caused by the dynamically generated code. We cannot rely on obvious evidence of how code should work.

## Hard to add new changes

Metaprogramming allows us to add new code quickly, but it will add extra problems like support dependencies and understanding.

### Hard to detect is it related to recent changes.
It has tight coupling with other codes but is hidden and not apparent in some cases. As usual, developers even do not expect that there is such coupling at all.

And even if we found some unexpected coupling, it's hard to find it. We cannot use IDE and other Editors to find it straightforward. See the cover screen as an example.

### Harder to understand the logic
![Do you see what we are going to invoke?](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/pitfalls-of-using-metaprogramming-in-ruby-on-rails-application-programming/file_1.png) 
We are limited. We can only consider a few things at a time. So you will require a lot of effort to recompile and store all variations in your head, especially if there are many variables and dependencies.

To change logic need to extend the current complexity even more. And make sure not to break the previous scenario.

## Easier to add unintentional bugs
![Small typo in the method name!](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/pitfalls-of-using-metaprogramming-in-ruby-on-rails-application-programming/file_2.png)

It is elementary to add typo errors and miss them. There is no one solution to help to validate all cases and pre-test our dynamic code.

Good test coverage should help you handle those cases, but today is hard to find developers who would like to onboard testing ;(.

### Easier to add security whole in the code
![An example of the Ruby code injection opens a security "breach" for hackers.](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/pitfalls-of-using-metaprogramming-in-ruby-on-rails-application-programming/file_3.png)

We can easily miss security problems.

## Summary
Before accepting code with metaprogramming, you need to be sure that:
* There is enough test coverage for all possible cases;
* All team members understand the price required to pay to support the metaprogramming: increased time to add and verify new changes;
* One of the toil: you need to invest a lot of time in the code review stage to make sure that there are no unexpected behaviors;
* You are required to hire more experienced developers who will be aware of metaprogramming's risks and could spot related problems faster.

---

**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
> _If you enjoyed this story, we recommend reading our latest tech stories and trending tech stories._