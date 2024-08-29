---
dev_to_id: 1852617
title: "Prepare the Pull Request before asking to Review"
description: "How to avoid being the victim of an open loop trying to get your Pull Request verified while working..."
created_at: "2024-05-14T12:27:37Z"
edited_at: "2024-08-29T13:37:15Z"
draft: false
tags: ["git", "pullrequest", "review", "workflow"]
canonical_url: "https://jetthoughts.com/blog/prepare-pull-request-before-asking-review-git-pullrequest/"
cover_image: "https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/prepare-pull-request-before-asking-review-git-pullrequest/cover.png"
slug: "prepare-pull-request-before-asking-review-git-pullrequest"
---
How to avoid being the victim of an open loop trying to get your Pull Request verified while working asynchronously? In [JetThoughts](https://www.jetthoughts.com/), we set some rules. They help optimize the process of verifying Pull Requests for the remote team.

![github activity history per pull request](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/prepare-pull-request-before-asking-review-git-pullrequest/file_0.png)

## The author is the first reviewer for his code

Then imagine that you are a reviewer and you see someone else’s Pull Request. Try to look at the code as critically as possible.

> When all changes have been made, it is better to pause and be distracted for 15 minutes.

List of requirements before verification:

 1. **Perfect code.** Be sure to read the code, don’t just skim it, and apply thought to both the code and its style

 2. **Acceptance test.** Try, run, and check the functional tests on staging. All acceptance tests should be passed

 3. **Clean Git History.** Read the commit message — it should be understandable, not cause the desire to call the author for help

 4. **Functional on Staging.** The link on staging must always be available, work properly, and should not require any special skills to view it

 5. **Resolved comments.** All comments for your Pull Request must be answered. All proposals must be confirmed that they are applied, or the reason why not

 6. **Call to action.** Make sure there is an explicit request for the review

 7. **Assign others.** Make people you need a review from aware of that not only by mentioning them but also assigning the ticket.

## Deliver the solution to be available online

For better testing, use the real environment without disrupting the current product. We recommend an [isolated staging environment](https://jetthoughts.com/blog/heroku-reviews-apps-prevent-delivering-bugs-on-production-ci-startup/).

Provide the reviewer with a link to the solution's server.

Ensure the result matches your issue's description. To speed up verification, include a link to the staging feature in the pull request's description.

## Without an online solution

If (for some reason), it is not possible to deliver the feature to the staging — screenshots and screencasts come to the aid. It’s always good to have some preview materials handy before the reviewer takes further steps.

## The final commit message as a description

> Before asking for the verification — all redundant commits should be squashed with an informative message.

It should be focused on pointing out the reasons you made the changes in this Pull Request. The main conventions for a commit message are well-described in [an article by Chris Beams](https://chris.beams.io/posts/git-commit/).

All changes in the `master` must be in the current branch. In JetThoughts we prefer to [rebase](https://git-scm.com/docs/git-rebase) over [merge](https://git-scm.com/docs/git-merge) and there are some reasons:

- _rebase_ generates a clean history (no _merge_ commits)
- all changes come from a specific and entitled commit (no hidden changes in _merge_ commits)

## Help the reviewer to get your solution

An author must provide reviewers with all necessary information.This includes screenshots, screencasts, and online documentation. Such resources are vital for newcomers and new team members.

They are also crucial for teams working in different time zones. This support ensures everyone stays aligned, even when schedules don't match.

## The green light is a sign to move on

Check for the green lights from all the external services. All tools used for your project (for example, Continuous Integration (CI), tests coverage, etc.) should have the ‘success’ status.

## Use call to action

To speed up verification, authors should lead their pull requests. Use clear calls to action like "Please review" or "Please verify," instead of "Done." Route requests to the reviewer for personal attention. Use preferred communication channels to echo your request. 

> Also, check the review's progress and remind the reviewer if needed.

## The motivation to do the best

This checklist helps coworkers avoid bad code and mistakes, saving time during reviews. Issues caught by reviewers lower team productivity. Honest feedback motivates us to improve our code.

---

**Sergey Sviridov** works as a software engineer at [JetThoughts](https://www.jetthoughts.com/). You can connect with him on [LinkedIn](https://www.linkedin.com/in/sergey-sviridov-83007199) or [GitHub](https://github.com/SviridovSV).

**Andriy Parashchuk** is also a software engineer at [JetThoughts](https://www.jetthoughts.com/). You can find him on [LinkedIn](https://www.linkedin.com/in/andriy-parashchuk-3aa56468/) or [GitHub](https://github.com/andriyParashchuk).

> *If you liked this story, we recommend our [latest tech stories](https://www.jetthoughts.com/blog/)*
