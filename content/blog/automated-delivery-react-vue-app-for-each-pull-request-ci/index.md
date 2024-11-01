---
dev_to_id: 1852564
title: "Automated delivery React / Vue app for each Pull Request."
description: "Would you like to speed up the development process of your React / Vue application? Make it more..."
created_at: "2024-05-14T11:29:22Z"
edited_at: "2024-11-01T20:06:44Z"
draft: false
tags: ["ci", "react", "vue", "deployment"]
canonical_url: "https://jetthoughts.com/blog/automated-delivery-react-vue-app-for-each-pull-request-ci/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fraw.githubusercontent.com%2Fjetthoughts%2Fjetthoughts.github.io%2Fmaster%2Fstatic%2Fassets%2Fimg%2Fblog%2Fautomated-delivery-react-vue-app-for-each-pull-request-ci%2Ffile_0.jpeg"
slug: "automated-delivery-react-vue-app-for-each-pull-request-ci"
metatags:
  image: cover.jpeg
---
Would you like to speed up the development process of your React / Vue application? Make it more predictable and transparent for clients and teammates? Well, continue reading. In this article, I want to describe a set of tools that will make your life easier.

![Photo by [jesse ramirez](https://unsplash.com/@jesseramirezla?utm_source=medium&utm_medium=referral) on [Unsplash](https://unsplash.com?utm_source=medium&utm_medium=referral)](file_0.jpeg)

## Online “snapshot” for Pull Request

**Continuous Integration** (CI) is a practice when developers merge their changes to the main branch as often as possible. Every developer commits daily to a shared repository. Every commit creates a build and runs automated tests.

**Continuous Deployment** (CD) is an extension of CI. It means that besides the automated tests you also have an automated release process and you can deploy your application at any time point.

It’s needed for 2 reasons: everyone who makes code review can easily check implementation **without pulling branch and testing locally**; the client can see **progress at any time** at any feature, and test it manually, without waiting for a production release, so it’s really useful.

There are ready-made SaaS solutions, such as [Heroku Review Apps](https://devcenter.heroku.com/articles/github-integration-review-apps), but not all of them are always suitable. We saw a lot of examples where default SaaS platforms are very complicated and doing a lot of stuff that you don’t need at all. So, We want to show you how we can integrate CI with a custom CD.

![Thanks, [https://gergely.imreh.net](https://gergely.imreh.net/) for the picture](file_1.png)

It will give you a possibility to find and solve problems faster, release more stable and higher quality products. Here we will use [CircleCI](https://circleci.com/), but you can use whatever you need ([Jenkins](https://jenkins.io/), [Travis CI](https://travis-ci.org/), [GitLab CI](https://about.gitlab.com/product/continuous-integration/)).

## Custom deployment JavaScript app

Let’s assume you have set up on CI with installing dependencies, running tests and linting code. Here is an example of our configuration for [ReactXP](https://microsoft.github.io/reactxp/).

 <iframe src="https://medium.com/media/a2cc7fefa1979060749a33791d4bb229" frameborder=0></iframe>

## Build & Deploy

We add the delivery stage after passing tests and linter checks. To deploy an app, we need to build it for the production environment first.

 <iframe src="https://medium.com/media/29806c815eff123d49b55f59525cee6f" frameborder=0></iframe>

We need to have a unique name per each PR to differentiate the builds. In order to release an app with a unique name, we are using PR number from CircleCI and deploy it via [Surge](https://surge.sh/) service.

## Posting review link to GitHub

Here is how to make notification in GitHub. We publish a comment with a link inside:

 <iframe src="https://medium.com/media/73ead03ffa15c7cd912381713409e875" frameborder=0></iframe>

## Conclusion

In this article, we have discovered how to create our own JS app Delivery without using a SaaS solution that can not fit your requirements. And you can verify it wasn’t so hard. Using auto-deployments, we have reduced bugs appearing up to 50% because of easier functional testing, and the price is just a small script!

**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
>  *If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).*
