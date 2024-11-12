---
dev_to_id: 1852561
title: What activities are expected from a remote developer for effective collaboration
description: In order to build trust relationships with remote non-technical founders, we designed the...
created_at: '2024-05-14T11:22:54Z'
edited_at: '2024-11-01T21:05:52Z'
draft: false
tags:
- development
- process
- remote
- tips
canonical_url: https://jetthoughts.com/blog/what-activities-are-expected-from-remote-developer-for-effective-collaboration-development-process/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/what-activities-are-expected-from-remote-developer-for-effective-collaboration-development-process/cover.jpeg
slug: what-activities-are-expected-from-remote-developer-for-effective-collaboration-development-process
metatags:
  image: cover.jpeg
---
### In order to build trust relationships with remote non-technical founders, we designed the easiest and effective routine for remote developers to provide.

![Photo by [Roman Synkevych](https://unsplash.com/@synkevych?utm_source=medium&utm_medium=referral) on [Unsplash](https://unsplash.com?utm_source=medium&utm_medium=referral)](file_0.jpeg)

In [JetThoughts](https://www.jetthoughts.com/), the usual working environment contains the GitHub repository with the Kanban board and some rules described in the article [“Delivery Flow for Distributed Remote Teams”](https://jtway.co/delivery-flow-for-distributed-remote-teams-5218828b0d1a).

Here are three main stages of working with the issue:

### 1. Preparation stage or start working on an issue

According to the prioritization, the developer should start investigating the top ticket from the list defined for the current sprint.

* **Check the Acceptance Criteria**. *They must be present, explicit, and achievable within two days (otherwise, such an issue should be split into several parts).*

* **Update the issue status**. If there are no questions and blockers, the ticket with an issue should be moved to the *In Progress*** **column.

* **Create and push a new branch.** The developer creates the new branch with the name that starts with the issue’s id, makes the first change, and pushes it to the remote repository.

* **Link the branch and PR.** After the remote branch is created, the issue must be converted into the pull request (PR) (see [“Convert GitHub Issue to Pull request”](https://jtway.co/convert-github-issue-to-pull-request-c624834835d8) article).

### 2. Coding stage or provide the interim results

* **Commit every two hours.** The developer makes a commit with the small successful solutions and pushes it to the remote repository. One of the ways to achieve this — the TDD methodology. Besides the rest of the advantages, it helps to have frequent commits — one commit with a test, another commit with implementation.

* **Provide a comment on the channel**. If two hours have passed, but there is nothing left to commit the developer should provide a comment on the channel with the client. It should contain the current problem description and the reasons that impede its solving. Also, he could ask help or indicate the steps that he is going to take.

* **Provide daily snapshots.** *Report at the next meeting about blocks that occurred during execution, provide explicit information and indicate the next steps if the problem has not yet been resolved.* This message must be duplicated in the GitHub PR if the problems were not resolved within two days.

### 3. Polishing stage

How to prepare the PR we discussed in [“Prepare the Pull Request before asking to Review”](https://jtway.co/prepare-the-pull-request-before-asking-to-review-bc95fc39eb11). Here are the key points:

* **All automated checks passed**

* **Self-review** (imagine that you are a reviewer and you see someone else’s PR)

* **Test in the staging environment **(check the presence of explicit instruction about how to test the issue and it should be understandable for the non-technical reviewer)

### 4. Final stage or turn in work

* **Ask for review**

* **Provide fixes and comments replies**

* **Merge / Deploy **(check deployment in Production)
>  *This is the full cycle of actions that are expected from the developer, especially working remotely. Compliance with these rules will help to build trust with the customer, and also to avoid questions about what the employee is doing from management.*

**Sergey Sviridov** is a Software Engineer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/sergey-sviridov-83007199) or [GitHub](https://github.com/SviridovSV).
>  *If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).*
