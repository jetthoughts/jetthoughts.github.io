---
dev_to_id: 1852940
title: "Pitfalls of using metaprogramming in Ruby on Rails application"
description: "Do you know that metaprogramming is easy to add but hard to support? Developers underestimated risks..."
created_at: "2024-05-14T16:45:46Z"
edited_at: ""
sync_date: "2024-05-24T15:39:18Z"
draft: false
tags: ["rails", "ruby", "development", "bestpractices"]
canonical_url: "https://jtway.co/pitfalls-of-using-metaprogramming-in-ruby-on-rails-application-966cf0fc9635"
slug: "pitfalls-of-using-metaprogramming-in-ruby-on-rails-application"
---
Do you know that metaprogramming is easy to add but hard to support? Developers underestimated risks related to using metaprogramming in the code, which causes development slowdowns and business financial problems.

![](https://cdn-images-1.medium.com/max/4440/1*oj9mktdoDCfoxsM2y2NaXA.png)
>  TL;DR: Cryptic code and indirect dependencies make development unstable and slow

Appearances can be deceptive. Metaprogramming and dynamically generated code look like neat solutions which dramatically compress code, but there is a shadow part to it.

I assembled the most common problems, which were missing from the consideration, and were reasons for the stressful weeks for the whole team.

### Here is a list of them:

* Hard to find what causes bugs

* Hard to add new changes

* Easier to add unintentional bugs

## Hard to find what causes bugs

![Where is the method?](https://cdn-images-1.medium.com/max/7336/1*5nE0Vl65z-6TOh4Nxtq7pg.png)

In my experience, most of the unexpected and hard-to-reproduce bugs were caused by the dynamically generated code. We cannot rely on obvious evidence of how code should work.

## Hard to add new changes

Metaprogramming allows us to add new code quickly, but it will add extra problems like support dependencies and understanding.

### Hard to detect is it related to recent changes.

It has tight coupling with other codes but is hidden and not apparent in some cases. As usual, developers even do not expect that there is such coupling at all.

And even if we found some unexpected coupling, it's hard to find it. We cannot use IDE and other Editors to find it straightforward. *See the cover screen as an example.*

### Harder to understand the logic

![Do you see what we are going to invoke?](https://cdn-images-1.medium.com/max/7472/1*hKq1J1lD95_PpVKYhY03zw.png)

We are limited. We can only consider a few things at a time. So you will require a lot of effort to recompile and store all variations in your head, especially if there are many variables and dependencies.

To change logic need to extend the current complexity even more. And make sure not to break the previous scenario.

## Easier to add unintentional bugs

![Small typo in the method name!](https://cdn-images-1.medium.com/max/2928/1*gmxnyR8d5HGMF7xoGpxQUQ.png)

It is elementary to add typo errors and miss them. There is no one solution to help to validate all cases and pre-test our dynamic code.

Good test coverage should help you handle those cases, but today is hard to find developers who would like to onboard testing ;(.

### Easier to add security whole in the code

We can easily miss security problems.

![An example of the Ruby code injection opens a security "breach" for hackers.](https://cdn-images-1.medium.com/max/5416/1*wtWfmQ_5H_O33UgrZgpEuQ.png)

## Summary

Before accepting code with metaprogramming, you need to be sure that:

 1. There is enough test coverage for all possible cases;

 2. All team members understand the price required to pay to support the metaprogramming: increased time to add and verify new changes;

 3. One of the toil: you need to invest a lot of time in the code review stage to make sure that there are no unexpected behaviors;

 4. You are required to hire more experienced developers who will be aware of metaprogramming's risks and could spot related problems faster.

**Paul Keen** is a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
>  *If you enjoyed this story, we recommend reading our[ latest tech stories](https://jtway.co/latest) and trending [tech stories](https://jtway.co/trending).*
