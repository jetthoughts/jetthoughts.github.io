---
dev_to_id: 1877581
title: "Heroku Reviews Apps prevent delivering bugs on production"
description: "Are you afraid to deploy a master branch to the production? Do you still mess with staging..."
created_at: "2024-06-05T06:16:42Z"
edited_at: "2024-11-01T13:27:16Z"
draft: false
tags: ["ci", "startup", "github", "development"]
canonical_url: "https://jetthoughts.com/blog/heroku-reviews-apps-prevent-delivering-bugs-on-production-ci-startup/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fraw.githubusercontent.com%2Fjetthoughts%2Fjetthoughts.github.io%2Fmaster%2Fstatic%2Fassets%2Fimg%2Fblog%2Fheroku-reviews-apps-prevent-delivering-bugs-on-production-ci-startup%2Ffile_0.jpeg"
slug: "heroku-reviews-apps-prevent-delivering-bugs-on-production-ci-startup"
metatags:
  image: cover.jpeg
---

> # Are you afraid to deploy a master branch to the production? Do you still mess with staging servers? Do you spend a lot of time to find out which [Pull Request](https://help.github.com/articles/about-pull-requests/) (PR) has introduced a bug?

![Photo by [Terrah Holly](https://unsplash.com/photos/nJjvUZYuLOA?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)](file_0.jpeg)

One of the principles of agile is that the master **branch should always be potentially shippable. That means it should always be of production quality. In order to achieve it, there are some practices like [GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html) and [Code Review](https://github.com/features/code-review/). But still we are not confident!

There is very effective practice to reduce risks and make master stable: **run [Functional Verification](https://en.wikipedia.org/wiki/Functional_verification) of requested changes on each PR**. You could add this practice as a part of Code Review but it’s also OK to run it as a dedicated step in order to involve QA Team or Product Owner.

![Photo by [rawpixel](https://unsplash.com/photos/aX6YUeCtds8?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/search/photos/testing?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)](file_1.jpeg)

Ideally, you should be able to have a shareable live environment with only changes related to the PR. I came up with a name for such environments — *Isolated Testing Environment*.

This practice is well known, but development team might have some objections to add it: setup a new staging instance or build and deploy is very time consuming procedure or cause a mess during the process.

I would agree with them in case there are some real issues to implement it. But, nowadays, we have a lot of tools, like [Kubernetes](https://jtway.co/tagged/kubernetes) and [Docker](https://jtway.co/tagged/docker), which reduce the complexity of isolated testing environment creation. And it’s time to clean up a technical debt in both delivery and development process as it is crucially important.

## Here comes Heroku Review Apps
> # [If a human operator needs to touch your system during normal operations, you have a bug.](https://landing.google.com/sre/book/chapters/eliminating-toil.html)
> # [Carla Geisser, Google Site Reliability Engineering](https://landing.google.com/sre/book/chapters/eliminating-toil.html)

To create *Isolated Testing Environment* per each PR you could use the local scripts or automatize such routine with tools like *Continuous Integration*.

For Web Applications, there is a “[*Reviews Apps](https://devcenter.heroku.com/articles/github-integration-review-apps)” feature *by Heroku.
>  *Review Apps* run the code in any [GitHub](https://github.com) PR in a complete, disposable [Heroku](https://heroku.com) application. *Review Apps* each have a unique URL you can share. It’s then super easy for anyone to try the new code.

## How to start?

On Heroku, there is [a guide on how to setup the Review Apps](https://devcenter.heroku.com/articles/github-integration-review-apps#setup) feature.

We have some extra changes in order to obtain a better experience. This is an example for *Ruby on Rails *but could be adopted for other web frameworks.

## Update configuration

Our secret sauce in app.json is environment variables which we require to be set for *Heroku Review Apps* instances. It allows to detect environment and reduce the build time.

Heroku Review Apps configuration

## Sample Data

We require testing sample data to be populated on each deploy. For this purposes, Heroku provides us with a [custom release phase](https://devcenter.heroku.com/articles/release-phase#specifying-release-phase-tasks) and this is our solution

## Summary

PR Functional Verification with Heroku Reviews Apps provides a safety net while working on critical code and infrastructure.

* Safer master;

* Faster feedback from Product Owner or Clients;

* Good for Asynchronous Development Process;

* Reduced on-boarding time and skill requirements for QA Team or Product Owners;

* Non-technical team members or clients are able to easily review and approve changes to an application;

* No manual routine involved with support of *Isolated Testing Environment*;

* Removed conflicts for server usage.

Now your team can focus on perfecting the user experience as well as finding and fixing bugs much earlier in the development process, leading to more frequent and higher quality releases.

And finally we got improved customers’ and clients’ satisfaction and appreciation.

## Useful Links

* [“Eliminating Toil” from Google’s “Site Reliability Engineering” Book](https://landing.google.com/sre/book/chapters/eliminating-toil.html)

* [“Simplicity” from Google’s “Site Reliability Engineering” Book](https://landing.google.com/sre/book/chapters/simplicity.html)

* [Review Apps Guide](https://devcenter.heroku.com/articles/github-integration-review-apps)

* [The simplest way to automate delivery of your React Native Application](https://jtway.co/the-simplest-way-to-automate-delivery-of-your-react-native-application-f37f2c71eb1d)

**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
>  If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).
