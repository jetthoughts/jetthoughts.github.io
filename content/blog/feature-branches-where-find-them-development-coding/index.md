---
dev_to_id: 1853571
title: "Feature Branches and Where to Find Them"
description: "Here we want to go through the feature branch process, show what downsides this approach..."
created_at: "2024-05-15T07:17:21Z"
edited_at: "2024-11-01T17:07:46Z"
draft: false
tags: ["development", "coding", "github", "git"]
canonical_url: "https://jetthoughts.com/blog/feature-branches-where-find-them-development-coding/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fraw.githubusercontent.com%2Fjetthoughts%2Fjetthoughts.github.io%2Fmaster%2Fstatic%2Fassets%2Fimg%2Fblog%2Ffeature-branches-where-find-them-development-coding%2Ffile_0.jpeg"
slug: "feature-branches-where-find-them-development-coding"
metatags:
  image: cover.jpeg
---
> # Here we want to go through the feature branch process, show what downsides this approach may have and share why it causes us pain.

![Photo by [Yancy Min](https://unsplash.com/@yancymin?utm_source=medium&utm_medium=referral) on [Unsplash](https://unsplash.com?utm_source=medium&utm_medium=referral)](file_0.jpeg)

How to develop a new fancy application feature and ship it to the production? One popular way is to use the long-lived feature branch flow. It means that one or few developers fully code the feature in a separate independent branch and only then make Pull Request to the master branch. They can still do small incremental changes there but it’s isolated from the master.

### Long-live feature-branches scenario

Let’s follow the feature branch process by adding a new feature to GitHub.

A `5460-project-columns-feature` branch was created and the team started working on it. Since the feature is too big to be delivered in one pull-request, the team decided to split it up into smaller independent tasks.

So every team member can now work with smaller features and contribute to the big one. The smaller code pieces are finished and now merged into our `5460-project-columns-feature` branch. Let’s take a look at this pull request made to the master branch in the middle of the feature development progress:

*+1200, -400* code lines and you still have another half to go, but the number of changes is already bothering you. Afterwhile the new feature is done and well tested. Your job here is finished, it’s about time to ship this thing to production and happily end this story.

But let’s take look at the branch status:

*+2400, -800* lines of code, that’s quite a number of changes and conflicts with the master, because bugs are still being fixed meanwhile. And that’s when you start getting problems.

### Painful rebase

This is not a rule, but almost for sure, the feature branch will have conflicts with the master branch. If your pull-request have multiple commits done by multiple developers you will have to rebase each of them and hope that it won’t break code of your team member.

Hope you have tests for your code, because if not — that will be a disaster. But even if you do, you still cannot be 100% sure that everything is working fine after that, because semantic conflicts won’t raise any conflicts during the rebase and event tests won’t tell you. And that’s where the dragons live.

### Fear of the big scary merge

The team wants to make sure that everything is working after the rebase and your changes won’t break anything else in the application.

So you have to be very confident in that huge number of changes to merge them into the master branch and not to break something. Code reviews for such pull-requests are very difficult. Minor mistakes are ignored, cause need to deliver a new feature!

Split this pull-request into several parts very hard at this stage — need to test and review each part again. The client will not praise you for this.

### Requirements change

During feature development, requirements can be changed multiple times. You can be ready for that by splitting one big scary feature into smaller ones, so no problem — you will just review new demands, review the current feature version, and create new issues.

Worst case scenario: you should have to refactor the current code and continue working. But meanwhile, your branch becomes more and more outdated and obsolete. You are feeling guilty that so much work was put into this feature.

It becomes literally painful to work on this branch as well as expensive because you have to work more in order to ship it. Or drop it at all and start working on more important issues, as this pull request rusts and just sits over a month as an opened pull request. And no one wants to touch and so the other day you would just close it and delete the branch.

### So, then what?

Delivering big changes is always stressful. We work hard to avoid it and [make small pull requests](https://opensource.com/article/18/6/anatomy-perfect-pull-request).

Here in [JetThoughts](https://www.jetthoughts.com/) our approach is to break down one big feature on small deliverables. And this skill is an art on its own.

We use Continuous Integration. Of course, it means that each Pull Request should contain a fully-functional, production-ready small feature. It’s hard to divide work in that way but in many cases it’s possible!

We won’t suggest you abandon the feature branches approach. But we encourage you to try to look at this problem from another perspective. And convince your business stakeholders also to think in small incremental changes.

**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
>  *If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).*
