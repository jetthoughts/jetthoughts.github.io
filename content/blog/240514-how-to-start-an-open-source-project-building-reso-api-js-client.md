+++
title = "How to start an Open Source project. Building RESO API JS client"
description = "Would you like to understand how to start your new Open Source project in a week? How to build a..."
created_at = "2024-05-14T12:29:45Z"
edited_at = "2024-05-14T12:31:08Z"
sync_date = "2024-05-23T09:03:50Z"
draft = false
tags = ["javascript", "opensource", "npm", "management"]
canonical_url = "https://jtway.co/how-to-start-an-open-source-project-building-reso-api-js-client-cee7a4cfc951"
slug = "240514-how-to-start-an-open-source-project-building-reso-api-js-client"
+++
Would you like to understand how to start your new Open Source project in a week? How to build a rapid development process and bootstrap your ideas faster?

In this post, you will understand the [JetThoughts](https://www.jetthoughts.com/) way of prototyping and testing of new ideas.

![Photo by [Aaron Burden](https://unsplash.com/@aaronburden?utm_source=medium&utm_medium=referral) on [Unsplash](https://unsplash.com?utm_source=medium&utm_medium=referral)](https://cdn-images-1.medium.com/max/9184/0*Ks3HSuemzHYlLJ4P)

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

![](https://cdn-images-1.medium.com/max/2000/1*uaPECnQn6q8TNwKOC0YHkw.png)

![](https://cdn-images-1.medium.com/max/2258/1*dnD3Px2kMMI_R7cnKnxu8w.png)

Discuss which tech stack you and your team will use, and add cards to the Backlog list with description, adding this technology in your project. In our case, it is [Mocha](https://mochajs.org/) and [Nock](https://github.com/nock/nock) for testing and [Axios](https://github.com/axios/axios) for making API calls.

## Work decomposition

After setting up basic dependencies you need to think of creating the tasks for the project itself. Each task should be self-descriptive, like here:

![](https://cdn-images-1.medium.com/max/2000/1*Xo1UOVTebm6yN2Z_SUzISg.png)

Come up with a good title, so that the person who works on the task would have a basic understanding of what is needed to be done. Task description which tells about the details and usage examples or expected results (it may be text, image or gif file) is always highly appreciated.

## Documentation and Testing

To easily use your project and onboard new developers, you need to provide the instruction of installation and further usage. Each feature that you intend to merge needs to have at least two things — Documentation and Tests.

![](https://cdn-images-1.medium.com/max/2000/1*KwpLfCXgF4v_nkJT2H2YZw.png)

 1. Documentation — we just wrote specifications to the README file, like here:

![](https://cdn-images-1.medium.com/max/2000/1*uzIL83Lrtfx4DYDLt91ZFw.png)

2. Tests which cover this feature functionality (at least unit ones):

![](https://cdn-images-1.medium.com/max/2000/1*V-CKJkqqklIqRPujxJzDLg.png)

We stick to a customized test system by creating our own solution.

![](https://cdn-images-1.medium.com/max/2000/1*bXCXaeaW8w0d7bWvltnjKw.png)

We have a test folder with all tests and mocks in it.
We have a *test.js* file which runs our tests and *specs/index.js* file which matches each spec.

Each test set is called *specs* — represents tests for specific purposes like retrieving data. Each spec represents unit tests for a specific method like a *get.spec.js* file.

## Publishing

Once a basic version of our RESO API client is created, we have decided to publish it to npm. All code is available here: [https://www.npmjs.com/package/reso_webapi_js](https://www.npmjs.com/package/reso_webapi_js)

**Paul Keen **is a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com/). Follow him on[ ](https://twitter.com/ChrisKeathley)[LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
>  *If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).*
