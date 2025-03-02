---
remote_url: https://dev.to/jetthoughts/how-to-start-an-open-source-project-building-reso-api-js-client-3p25
source: dev_to
remote_id: 1852618
dev_to_id: 1852618
dev_to_url: https://dev.to/jetthoughts/how-to-start-an-open-source-project-building-reso-api-js-client-3p25
title: How to start an Open Source project. Building RESO API JS client
description: Would you like to understand how to start your new Open Source project in a week? How to build a...
created_at: '2024-05-14T12:29:45Z'
edited_at: '2024-11-26T16:05:36Z'
draft: false
tags:
- javascript
- opensource
- npm
- management
canonical_url: https://jetthoughts.com/blog/how-start-an-open-source-project-building-reso-api-js-client-javascript-opensource/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/how-start-an-open-source-project-building-reso-api-js-client-javascript-opensource/cover.jpeg
metatags:
  image: cover.jpeg
slug: how-start-an-open-source-project-building-reso-api-js-client-javascript-opensource
---
Would you like to understand how to start your new Open Source project in a week? How to build a rapid development process and bootstrap your ideas faster?

In this post, you will understand the [JetThoughts](https://www.jetthoughts.com/) way of prototyping and testing of new ideas.

![Photo by [Aaron Burden](https://unsplash.com/@aaronburden?utm_source=medium&utm_medium=referral) on [Unsplash](https://unsplash.com?utm_source=medium&utm_medium=referral)](file_0.jpeg)

## Kickoff

Before starting the project, you need to discuss all the possible details with colleagues. You need to set a goal, form a plan, split the work, and prepare the project delivery. After the discussion, you’d understand what you want to get in a week.

Our goal was to deliver an Open Source project. And that’s how we did it:

* Kickoff

* Setup

* Work decomposition

* Documentation and Testing

* Publishing

## Set up the process visibility

First of all, you would need to set up an Agile board to track your project progress. It will give you a big picture of the development process and will help to remove bottlenecks.

![](file_1.png)

![](file_2.png)

Discuss which tech stack you and your team will use, and add cards to the Backlog list with description, adding this technology in your project. In our case, it is [Mocha](https://mochajs.org/) and [Nock](https://github.com/nock/nock) for testing and [Axios](https://github.com/axios/axios) for making API calls.

## Work decomposition

After setting up basic dependencies you need to think of creating the tasks for the project itself. Each task should be self-descriptive, like here:

![](file_3.png)

Come up with a good title, so that the person who works on the task would have a basic understanding of what is needed to be done. Task description which tells about the details and usage examples or expected results (it may be text, image or gif file) is always highly appreciated.

## Documentation and Testing

To easily use your project and onboard new developers, you need to provide the instruction of installation and further usage. Each feature that you intend to merge needs to have at least two things — Documentation and Tests.

![](file_4.png)

 1. Documentation — we just wrote specifications to the README file, like here:

![](file_5.png)

2. Tests which cover this feature functionality (at least unit ones):

![](file_6.png)

We stick to a customized test system by creating our own solution.

![](file_7.png)

We have a test folder with all tests and mocks in it.
We have a *test.js* file which runs our tests and *specs/index.js* file which matches each spec.

Each test set is called *specs* — represents tests for specific purposes like retrieving data. Each spec represents unit tests for a specific method like a *get.spec.js* file.

## Publishing

Once a basic version of our RESO API client is created, we have decided to publish it to npm. All code is available here: [https://www.npmjs.com/package/reso_webapi_js](https://www.npmjs.com/package/reso_webapi_js)

**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
>  *If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).*
