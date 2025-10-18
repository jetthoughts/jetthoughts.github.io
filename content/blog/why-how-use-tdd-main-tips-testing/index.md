---
remote_url: https://dev.to/jetthoughts/why-and-how-to-use-tdd-main-tips-4mcc
source: dev_to
remote_id: 539418
dev_to_id: 539418
dev_to_url: https://dev.to/jetthoughts/why-and-how-to-use-tdd-main-tips-4mcc
title: Why and how to use TDD. Main tips
description: Master Test-Driven Development for better code architecture. Learn TDD workflow, avoid common mistakes, and build maintainable software. Developer guide with examples ✓
created_at: '2020-12-11T12:02:25Z'
edited_at: '2024-11-25T15:41:46Z'
date: 2020-12-11
draft: false
tags:
- tdd
- testing
- programming
- development
canonical_url: https://jetthoughts.com/blog/why-how-use-tdd-main-tips-testing/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/why-how-use-tdd-main-tips-testing/cover.jpg
metatags:
  image: cover.jpg
slug: why-how-use-tdd-main-tips-testing
---

*How do I start developing the component from scratch? How do I know what architecture it should have? What parameters should the component accept? Could the TDD usage help find the answers?*

### What is TDD, and what are its basic steps?

TDD, or Test-Driven Development in full, is a way to be sure your code coverage is 100% and your system actually meets the requirements defined for it. In this approach to software development, designers create test cases to define and verify what the code will do. TDD is a cycle of several steps:

1. Add a test.

2. Run all tests and see if the new test fails.

3. Write enough code necessary to pass that failing test.

4. Run all tests and see if they pass.

5. Refactor the code if possible.

6. Repeat

### Why use TDD?

* **It is easier to find bugs.**
The developer writes a few lines of code to pass the failing test. This is not complicated to debug.

* **Code becomes cleaner and easier to extend.**
Writing tests before code helps to better understand the code's behavior and relation to other parts of the code. The developer can write smaller code with a single responsibility. The code becomes easier to maintain.

* **It is easier to refactor.**
Changes to existing code become safer. The developer can see the errors in the early stages.

* **The onboarding of the new developer is becoming easier.**
He needs to write the tests based on user requirements and put in place the logic in the code.

* **The total time spent on development decreases.**
At first, TDD seems to take more time. But it saves time in debugging, error-hunting, refactoring, and understanding code.

### Some tips for TDD users

1. In the case when you develop the logic from zero, write the first simple test. Imagine that you have an ideal interface; do not pay attention to the details for the future.
2. When adding new logic to a class (component), first refactor it. This readies the component for new functions. It ensures that new additions need minimal code and don't change existing code. Then, ensure all tests pass. Finally, write a test for the new logic.
3. It is preferable to move with small steps. You can make bigger steps if the component stays stable. All abstractions must be clear, the tests successful, and you must be sure of the next step. If you are stuck with the next steps, go back to the smaller iteration when it is unclear what abstraction to separate and some tests have failed.
4. Stop refactoring when you feel that the next steps will add complexity.
5. Do not think about component architecture. Accomplishing required tasks paves the way for test success, yielding sound architecture.

> *"Break steps into manageable chunks, then refine them to ideal proportions. If you only take larger steps, you’ll never know if smaller steps are appropriate.”* **(Kent Beck)**

### Summary

TDD usage leads to 100% test coverage. It reduces stress in development. It makes code support easier. And, it helps create cleaner, more efficient code architecture.
