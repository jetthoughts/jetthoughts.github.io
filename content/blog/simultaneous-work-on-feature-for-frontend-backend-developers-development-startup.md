---
dev_to_id: 1877642
title: "Simultaneous work on the feature for frontend and backend developers"
description: "Simultaneous work on the feature for frontend and backend developers   How do split features..."
created_at: "2024-06-05T06:43:35Z"
edited_at: "2024-06-14T07:59:32Z"
draft: false
tags: ["development", "startup", "continousdelivery"]
canonical_url: "https://jetthoughts.com/blog/simultaneous-work-on-feature-for-frontend-backend-developers-development-startup/"
slug: "simultaneous-work-on-feature-for-frontend-backend-developers-development-startup"
---

## Simultaneous work on the feature for frontend and backend developers

How do split features on static and backend for 2 developers to prevent blockers? What no-time solution we could use for small projects?

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/simultaneous-work-on-feature-for-frontend-backend-developers-development-startup/file_0.png)

## Tiny Feature-flag Solution

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/simultaneous-work-on-feature-for-frontend-backend-developers-development-startup/file_1.png)

For simplicity, we agreed to set a convention:
> # if there is a param preview in the URL, you should activate all hidden features on the page.

### When to use it:

 1. No need to have custom feature flags’ param per each feature, preview will be reused for all of them.

 2. We need to use it only to see updates on the existed pages, and not for new pages.

 3. New pages and screens will use an unpublished path as a feature flag.

## Introduction to our Dilemma

The development of a new product or big feature requires the frontend and backend to work together. Here are some constraints from our pipeline:

 1. We can work only on one part of the solution: backend or frontend. We do not know when we will be able to deliver any part.

 2. All merges will require code to be ready for production.

 3. One other requirement from *Continuous Delivery*, [new changes should be pre-verified before merging into the trunk](https://jtway.co/make-master-stable-again-b15c9ff3b129).

If we will merge only static code, then the customers will get no working *UI*.

If we will merge the backend first, then will get a broken *UX*.

![Photo by [Moses Londo](https://unsplash.com/@moseslondo?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/dilemma?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/simultaneous-work-on-feature-for-frontend-backend-developers-development-startup/file_2.jpeg)

## Overview alternative solution
> # No, no, no! Stop long-lived feature branches usage!

I believe you will propose *long-lived feature branches* as a solution.

In our *Continuous Delivery* implementation, we use a lot of rebases to sync codebase, but this works only for single-owned branches. And could lose code to allow to work several persons with it.

Alternative to long-lived branches is *Feature Flags*. But we need some tiny/limited versions of it, prefer to use conventions for internal use instead of complex *UI* to manage it and support flexibilities, what features to show, and to whom.

**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
>  *If you enjoyed this story, we recommend reading our[ latest tech stories](https://jtway.co/latest) and trending [tech stories](https://jtway.co/trending).*
