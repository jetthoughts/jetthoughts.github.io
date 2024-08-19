---
dev_to_id: 539418
title: "Why and how to use TDD. Main tips"
description: "How to start developing the component from scratch? How to know what architecture it should have? Wha..."
created_at: "2020-12-11T12:02:25Z"
edited_at: "2024-07-03T12:24:09Z"
draft: false
tags: ["tdd", "testing", "programming", "development"]
canonical_url: "https://jetthoughts.com/blog/why-how-use-tdd-main-tips-testing/"
cover_image: "https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/why-how-use-tdd-main-tips-testing/cover.jpg"
slug: "why-how-use-tdd-main-tips-testing"
---
*How to start developing the component from scratch? How to know what architecture it should have? What parameters should the component accept? The TDD usage could help to find the answers.*

### What is TDD and its basic steps
TDD, or Test-Driven Development in full, is a way to be sure your code coverage is 100% and your system actually meets the requirements defined for it. This is an approach to software development in which test cases are designed to define and verify what the code will do.
The TDD is a cycle of several steps:
1. Add a test
2. Run all tests and see if the new test fails
3. Write just enough code needed to pass that failing test
4. Run all tests and see if they all pass
5. Refactor code if possible
6. Repeat

### Why use TDD
- **It is easier to find bugs**

The developer writes a few lines of code to pass the failing test. This is not complicated to debug.
- **Code become cleaner and easier to extend**

Writing tests before code helps to better understand the code behavior and relation to other parts of the code. The developer can write smaller code having a single responsibility. The code becomes easier to maintain.
- **It is easier to refactor**

Changes to existing code become safe. The developer can see the error in the early stage.
- **The onboarding of the new developer becomes easier**

He needs to write the tests based on user requirements and implement logic in the code.
- **The total time spent on development decreases**

At first sight using TDD increases the time spent on development. But more often if you count the time spent on debugging, looking for the errors, refactoring, understanding the code you will understand how much time TDD saved.

### Some tips for TDD users
1. In the case when you develop the logic from zero write the first simple test. Imagine that you have an ideal interface, do not pay attention to the details for the future.
2. In the case when you add an additional logic to the existing class(component) first of all make refactoring to prepare the component for the expansion of functionality (adding new should be a small code addition without changing the existing code). All existing tests should be successful. And then write a test for the new logic.
3. It is preferable to move with small steps. You can do steps bigger if the component stays stable, all abstractions are clear, the tests are successful and you are absolutely sure in the next step. Back to the smaller iteration if you stuck with the next steps, it is not clear what abstraction should be separated, some tests are failed. 

>*“If you can make steps too small, you can certainly make steps the right size. If you only take larger steps, you’ll never know if smaller steps are appropriate.”* ***(Kent Beck)***

4. Stop refactoring when you feel that the next steps will add the additional complexity.
5. Do not think about component architecture. Solving the required tasks for passing tests successfully will build the necessary architecture.

### Summary
TDD usage leads to 100% test coverage. It removes stress from the development process, makes code supporting easier, and helps to get code architecture cleaner and more efficient.
