---
dev_to_id: 1853649
title: "Cheap tests with Ghost Inspector"
description: "What do you do when a legacy project has no tests and adding them is difficult? Before making new..."
created_at: "2024-05-15T08:05:56Z"
edited_at: "2024-06-14T11:02:12Z"
draft: false
tags: ["webdev", "legacy", "tools", "development"]
canonical_url: "https://jetthoughts.com/blog/cheap-tests-with-ghost-inspector-webdev-legacy/"
slug: "cheap-tests-with-ghost-inspector-webdev-legacy"
---
What do you do when a legacy project has no tests and adding them is difficult? Before making new changes, the developer wants to ensure the old code works as expected.

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/cheap-tests-with-ghost-inspector-webdev-legacy/file_0.png)

In [JetThoughts](https://www.jetthoughts.com/), we resolved such an issue by using [Ghost Inspector](https://ghostinspector.com/) to simulate a user's actions and check for expected screenshots.

### What is Ghost Inspector?

[Ghost Inspector](https://ghostinspector.com/) is a testing service for monitoring key site functionality. All tests are stored in the cloud and run continuously, and you are notified if an error or variance is detected.

**Basic Records**

In the table below, you can see simple test step actions that were enough to solve our problem:

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/cheap-tests-with-ghost-inspector-webdev-legacy/file_1.jpeg)

Here is a simple test case that shows how straightforward it is to test a feature like **Search**:

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/cheap-tests-with-ghost-inspector-webdev-legacy/file_2.jpeg)

You can group tests by **Suites** and schedule them to run whenever you want!

**Screenshot as Lame Asserts**

After completing all the test steps, it will receive a screenshot. If Ghost Inspector detects that the screenshot has changed by more than 10% (by default), it will be marked as a failure and will notify you:

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/cheap-tests-with-ghost-inspector-webdev-legacy/file_3.jpeg)

There is an “Accept New Screenshot as Baseline” button above any screenshot failures. This button allows you to set a new baseline (essentially telling the system, “It’s okay; this is what the screenshot is supposed to look like now.”).

**Browser Extension**

Ghost Inspector includes a free browser extension for recording actions in your browser and turning them into a reproducible test:

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/cheap-tests-with-ghost-inspector-webdev-legacy/file_4.jpeg)

The extension works by recording your actions in the browser, such as clicking and filling in forms to compile those actions into a test. The exact sequence can then be re-run from the Ghost Inspector service.

### Benefits for the legacy code

This service allowed us to cover the most critical public cases. It took less time than writing new tests for old code from scratch, which was enough to ensure that new changes would not break the old features.

---

**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).