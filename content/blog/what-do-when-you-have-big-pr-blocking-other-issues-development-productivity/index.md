---
dev_to_id: 1997076
title: "What to Do When You Have a Big PR Blocking Other Issues"
description: "Sometimes, despite your best efforts, you end up with a large pull request (PR) that blocks other..."
created_at: "2024-09-11T16:24:29Z"
edited_at: "2024-10-22T17:17:33Z"
draft: false
tags: ["development", "productivity", "programming", "devops"]
canonical_url: "https://jetthoughts.com/blog/what-do-when-you-have-big-pr-blocking-other-issues-development-productivity/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F900seyzwxmi7fjnaecua.jpeg"
slug: "what-do-when-you-have-big-pr-blocking-other-issues-development-productivity"
metatags:
  image: cover.jpeg
---
Sometimes, despite your best efforts, you end up with a large pull request (PR) that blocks other tasks. It can slow down the whole team and cause frustration. So, how do you handle it? Here's a simple guide to managing a big PR without causing chaos.

![Image description](file_0.jpeg)

Realize the PR is Too Big
=============================

The hardest step is seeing that your PR is too large. It's tempting to keep adding changes, but that can cause more problems. The toughest choice is to stop and admit the PR has become too big.

But closing a large PR isn't a failure. It's a learning process, similar to running a **spike**. As Kent Beck said:

*"A spike is a quick, simple experiment aimed at exploring the problem space. It doesn't have to be perfect, it just needs to give enough information to make a decision."*

In this case, you've learned a lot from the big PR. You know what works and what doesn't. Now, you can **rewrite from scratch** with more clarity. By closing the PR, you free yourself from its complexity and can start fresh, using what you've learned.

Slice the PR into Smaller Parts
===================================

After deciding to close the PR, break it into smaller, focused pieces. Slicing means pulling out parts of the code that can be handled on their own. This lets different parts of the work move forward without blocking each other.

How to slice it:
--------------------

-   **Find natural breakpoints** in the code. Split features or bug fixes where it makes sense.
-   **Prioritize critical parts**. Pull out the most urgent pieces holding up other tasks and merge them first.
-   **Keep each slice focused**. Each new PR should handle one task to make reviewing easier.

Ask for Help
================

If the PR feels too big, ask for help. Your team can help you slice the PR or review different parts. Working together will speed things up and prevent delays.

Keep the Team Updated
=========================

Make sure your team knows what's happening. Explain why the PR is being sliced into smaller pieces. This will keep everyone in sync and reduce frustration because they'll see that progress is happening.

Learn for Next Time
=======================

Think about why the PR got so big. Could you have split it earlier? Did you try to do too many things at once? Use this experience to keep future PRs smaller. Keeping them focused helps your workflow and avoids delays.

Clear Next Steps
================

When you spot these signs, take action. **Admit the PR is too big** and stop working on it. **Schedule time to slice it into smaller PRs**. Each smaller PR should handle only one task and be merged separately. This speeds up reviews, reduces errors, and makes testing easier.

---

Keeping PRs small and focused allows your team to work faster and with fewer issues. Watch for the signs and take action to avoid significant PR bottlenecks.