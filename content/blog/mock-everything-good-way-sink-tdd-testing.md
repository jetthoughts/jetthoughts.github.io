---
dev_to_id: 1877556
title: "Mock Everything Is a Good Way to Sink"
description: "Have you found a lot of code with mocks and stubs? But how do you feel about it? When I see..."
created_at: "2024-06-05T05:52:47Z"
edited_at: "2024-07-03T12:22:19Z"
draft: false
tags: ["tdd", "testing", "development"]
canonical_url: "https://jetthoughts.com/blog/mock-everything-good-way-sink-tdd-testing/"
cover_image: "https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/mock-everything-good-way-sink-tdd-testing/cover.jpeg"
slug: "mock-everything-good-way-sink-tdd-testing"
---
***Have you found a lot of code with mocks and stubs? But how do you feel about it? When I see mocks/stubs, I am always looking for the way to remove them.***

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/mock-everything-good-way-sink-tdd-testing/file_0.jpeg)

## Application lifecycle with mocking everything strategy:

 1. Everything starts from a happy developer and a clean architecture with fastest tests.

 2. And one day in the middle of development we have changed the core application business logic.

 3. We have changed our code base according to new requirements, and now we expect to have failed tests …. oops, most of expected tests pass successfully instead of failing.

 4. We found mocks in the code, updated them.

 5. And now we have a hunch, that tests are cheating on us, so we should find all similar mocks and update them to correspond the last requirements.

 6. And even after reviewing all tests, we still have considerable misgivings.

## What has just happened:

With mocks, we cannot rely on implemented architecture because using mocks/stubs we built a fake application from small chunks. And placed them in different parts of test suites. As it turns out, changes to application architecture will not make our tests fail. So we should look for all our chunks and update them ourselves. And that’s duplication, baby!

## Mocking/Stubbing Principles:

Mocks and Stubs are powerful tools and should be put to a good use. Here are my principles when to use them:

* Stub/mock only the stuff that is impossible to setup/simulate like remote services responses, time and etc.

* Stubs/Mocks only specifications, which will not be changed at all: external applications, libraries.

In other cases when I have a desire to mock something, then this is the first sign of a poor design. And I understand if I cannot add tests for simple application behavior on initial stages, then how I will support it when it will become a whale of an application? Mocked behavior is a sort of our technical debts which we should fix as soon as possible.

## Summary:

Do not overuse mocks and stubs ;) Most popular alternatives to mocks and stubs are fakes, which have some advantages of mocks, but are much easier to support.

Here are some useful links about mocking/stubbing:

* [Is TDD dead?](https://www.youtube.com/watch?v=z9quxZsLcfo&feature=youtu.be&t=21m00s)

* [Mocks Aren’t Stubs](http://martinfowler.com/articles/mocksArentStubs.html)

* [Mockists Are Dead. Long Live Classicists.](http://www.thoughtworks.com/insights/blog/mockists-are-dead-long-live-classicists)

* [Rules for good testing](https://gist.github.com/Integralist/7944948)

* [The Magic Tricks of Testing by Sandi Metz](https://www.youtube.com/watch?v=URSWYvyc42M)
