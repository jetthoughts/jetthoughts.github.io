---
dev_to_id: 1997095
title: "Red Flags to Watch for in a Big PR: When to Stop, Split, or Rework"
description: "Big pull requests (PRs) can cause delays and block progress. As a developer, it's important to spot..."
created_at: "2024-09-11T16:47:44Z"
edited_at: "2024-09-11T16:56:56Z"
draft: false
tags: ["development", "productivity", "programming", "devops"]
canonical_url: "https://jetthoughts.com/blog/red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity/"
cover_image: "https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity/cover.png"
slug: "red-flags-watch-for-in-big-pr-when-stop-split-or-rework-development-productivity"
metatags:
  image: cover.png
---
Big pull requests (PRs) can [cause delays and block progress](https://jetthoughts.com/blog/how-small-pr-improves-team-productivity-development/). As a developer, it's important to spot the signs that a PR is too large and needs to be split or reworked. Here are the key red flags to look out for and what to do about them.

![cartoon ant rolling a blue ball](file_0.png)


## Too Many Lines of Changes

A PR with more than 500 lines of code is often too big for an efficient review. Large PRs are also harder to understand, review, and test, increasing the risk of missing bugs or issues.

### Example:

A PR with over 500 lines of changes touches many parts of the codebase. It's hard for reviewers to catch all potential bugs in a large chunk of code. A reviewer starts but can't finish in one session, passing it to another, causing delays. Instead, split the PR into smaller, focused parts. This way, it's easier for reviewers to provide feedback and for QA to test each part.

## Multiple Issues in One PR

A PR that tries to close more than one issue can lack focus. It's hard to review and test a PR that mixes unrelated tasks. Each PR should solve one specific problem.

### Example:

You submit a PR that fixes bugs, adds a feature, and refactors old code. These tasks are unrelated and should be in separate PRs. By splitting them, reviewers can focus on one area at a time, reducing confusion.

## PR Requires Changes from Another Member

If your PR depends on changes made by another team member, and you're stuck waiting for their work, it's a sign the PR should be split. This dependency can slow the whole process, especially if their PR is large or delayed.

### Example:

Your PR needs changes from another team member's PR that hasn't been merged yet. This blocks progress on your PR and delays reviews and testing. Instead, split your PR into smaller parts that don't depend on others. This way, some portions can be reviewed and merged while you wait for the other work to be done.

## Merge Conflicts or Blocking Other Work

If your PR keeps running into merge conflicts or if other team members can't merge their work because of it, that's a sign it's too large. Big PRs often block other tasks and cause delays.

### Example:

Your large PR touches multiple files; while waiting to be merged, other team members' PRs create conflicts, which slow everyone down. Splitting the PR into smaller parts reduces the chance of conflicts and helps the team move faster.

## Difficult to Explain or Test

If you can't easily describe what your PR does, or if it's too complex to test, it's probably too large. A well-scoped PR should be easy to explain and focus on one area of change.

### Example:

Your PR touches too many project parts, from new features to bug fixes and refactoring. Reviewers struggle to understand its purpose, and testing becomes too complex. Splitting the PR into smaller parts makes it easier to explain, review, and test.

## Actionable Steps

When you identify these red flags, the first step is to **acknowledge the problem**. Decide to **stop working on the current PR**. Then, **schedule time to break the PR into smaller, more focused ones**.  
Each smaller PR should handle only one issue or change and be merged separately. This approach speeds up reviews, reduces errors, and makes testing easier. More we shared in [What to Do When You Have a Big PR Blocking Other Issues](https://jetthoughts.com/blog/what-do-when-you-have-big-pr-blocking-other-issues-development-productivity/).

---

Keeping PRs small and focused, your team can work faster and more efficiently. Remember to watch for these red flags to avoid delays and confusion.