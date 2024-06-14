---
dev_to_id: 1852617
title: "Prepare the Pull Request before asking to Review"
description: "How to avoid being the victim of an open-loop trying to get your Pull Request verified..."
created_at: "2024-05-14T12:27:37Z"
edited_at: "2024-06-14T08:01:07Z"
draft: false
tags: ["git", "pullrequest", "review", "workflow"]
canonical_url: "https://jetthoughts.com/blog/prepare-pull-request-before-asking-review-git-pullrequest/"
slug: "prepare-pull-request-before-asking-review-git-pullrequest"
---
### How to avoid being the victim of an open-loop trying to get your Pull Request verified working asynchronously? In [JetThoughts](https://www.jetthoughts.com/), we distinguished some rules, which help to optimize the process of verifying the Pull Requests by the remote team members.

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/prepare-pull-request-before-asking-review-git-pullrequest/file_0.png)

## The author is the first reviewer for his code

When all changes have been made, it is better to pause and be distracted for 15 minutes. Then imagine that you are a reviewer and you see someone else’s Pull Request. Try to look at the code as critically as possible.

**List of requirements before verification:**

 1. **Perfect code**. Be sure to read the code, don’t just skim it, and apply thought to both the code and its style

 2. **Acceptance test**. Try, run, and check the functional tests on staging. All acceptance tests should be passed

 3. **Clean Git History**. Read the commit message — it should be understandable, not cause the desire to call the author for help

 4. **Functional on Staging**. The link on staging must always be available, work properly, and should not require any special skills to view it

 5. **Resolved comments. **All comments for your Pull Request must be answered. All proposals must be confirmed that they are applied, or the reason why not

 6. **Call to action**. ****Make sure there is an explicit request for the review

 7. **Assign others. **Make people you need a review from aware of that not only by mentioning them but also assigning the ticket.

## Deliver the solution to be available online

For better testing, your solution should be implemented with the real environment, but at the same time, it should not break the product, which is already in use. For such purposes, we suggest using the [isolated staging environment](https://medium.com/p/make-master-stable-again-b15c9ff3b129). The link with the solution needs to be provided to the reviewer. Make sure the result is the same as it’s described in the description of your issue. To accelerate the verification, it is very important to add a link to the feature on the staging within the description of the Pull Request, which the reviewer will be able to check on.

## Without an online solution

If (for some reason), it is not possible to deliver the feature to the staging — screenshots and screencasts come to the aid. It’s always good to have some preview materials handy before the reviewer takes further steps.

## The final commit message as a description

Before asking for the verification — all commits should be squashed into one with an informative message. It should be focused on pointing out the reasons you made the changes in this Pull Request. The main conventions for a commit message are well-described in [an article by Chris Beams](https://chris.beams.io/posts/git-commit/).
All changes in the *master *must be in the current branch. In JetThoughts we prefer to [*rebase](https://git-scm.com/docs/git-rebase)* over [*merge](https://git-scm.com/docs/git-merge) *and there are some reasons:

* *rebase* generates a clean history (no *merge* commits)

* all changes come from a specific and entitled commit (no hidden changes in *merge* commits)

## Help the reviewer to get your solution

One of the responsibilities of the author is to provide enough information for a reviewer. All screenshots, screencasts, online documentation which reviewer should have in order to understand the task, should be provided explicitly. It becomes especially helpful for the newbies and those members who have just joined the project. Also, it is essential for teams that are working asynchronously primarily when author’s and reviewer’s work schedules could not be matched or overlapped.

## The green light is a sign to move on

Check for the green lights from all the external services. All tools used for your project (for example, Continuous Integration (CI), tests coverage, etc.) should have the ‘success’ status.

## Use call to action

In order to reach successful verification as fast as possible, you, as the author, should be responsible for your Pull Requests and their promotion. Use an explicit call to action when you’re asking for a review. “Please review” or “Please verify” are better than just “Done.” Address your request, identify, and name the person who will be responsible for the review. Use preferred channels for communication with your team members to duplicate the call to action. Check the progress of reviewing and remind the reviewer to check if there were no reaction.

## The motivation to do the best

This checklist will help your co-workers to avoid spending their time reading the bad code or going through other sloppy mistakes. Prevent the waste of time at the verification stage. Every issue that could be caught by us, but was caught by the reviewer instead — decreases the team productivity. Knowing that we get frank feedback should be a motivation for writing the perfect code.

**Sergey Sviridov** is a Software Engineer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/sergey-sviridov-83007199) or [GitHub](https://github.com/SviridovSV).

**Andriy Parashchuk** is a Software Engineer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/andriy-parashchuk-3aa56468/) or [GitHub](https://github.com/andriyParashchuk).
>  *If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).*
