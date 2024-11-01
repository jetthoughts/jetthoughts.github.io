---
dev_to_id: 1853472
title: Services and tools to automatize development for the remote teams
description: We save a lot of time on development and create better products due to well-formed...
created_at: '2024-05-15T06:02:44Z'
edited_at: '2024-10-21T19:05:42Z'
draft: false
tags:
- workflow
- automation
- agile
- development
canonical_url: https://jetthoughts.com/blog/services-tools-automatize-development-for-remote-teams-workflow-automation/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/services-tools-automatize-development-for-remote-teams-workflow-automation/cover.jpeg
slug: services-tools-automatize-development-for-remote-teams-workflow-automation
metatags:
  image: cover.jpeg
---
> ### We save a lot of time on development and create better products due to well-formed workflow. Tools and services that help us to implement the workflow we will describe below.

![Photo by [Frederic Köberl](https://unsplash.com/@internetztube?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)](file_0.jpeg)

## Delivery

### Version Control by GitHub

To effectively work on a project, we need a service that allows us to store code, connect various services to automate the development process, and provides a convenient environment for project management. **GitHub** is the most suitable for us.

Creating and viewing pull requests, review code, viewing the history of changes; all this greatly enhances the convenience of team development.

To generate pull request from the issue we use the **Hub** command-line utility: [Convert GitHub Issue to Pull request](https://jtway.co/convert-github-issue-to-pull-request-c624834835d8)

![Photo by [airfocus](https://unsplash.com/@airfocus?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/kanban-board?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)](file_1.jpeg)

### Kanban board by GitHub Projects

To provide a “flexible” approach to software development, we follow the Agile methodology. To monitor the current progress and see the tasks for the near future, we have chosen the implementation of the Kanban board inside the GitHub (**GitHub Projects**). [Delivery Flow for Distributed Remote Teams](https://jtway.co/delivery-flow-for-distributed-remote-teams-5218828b0d1a).

### Continuous Integration by CircleCI

To avoid bugs on production, and ensure the code compliance with the requirements set in our team, we use the **CircleCI**. It allows us to set up verification and code deploying flexibly.

Due to close integration with GitHub, we can see the results of the tasks right on the Pull Request page. See more: [Deploying Jekyll to GitHub Pages with CircleCI 2.0](https://jtway.co/deploying-jekyll-to-github-pages-with-circleci-2-0-3eb69324bc6e)

### Infrastructure by Heroku

From hosting, we wanted to get: simple environment setup, integration with GitHub, the ability to install libraries that are used in gems quickly, the ability to scale.

**Heroku** meets all our requirements: [How to Setup a Project That Can Host Up to 1000 Users for Free.](https://jtway.co/how-to-setup-a-project-that-can-host-up-to-1000-users-for-free-ab59ad3edaf1)

Using Heroku, we also solve the problem of isolated verification. It is essential to be able to test the functionality before it gets to production. Heroku uses the **Heroku App Review** for these purposes. Read here: [Heroku Reviews Apps prevent delivering bugs on production.](https://jtway.co/make-master-stable-again-b15c9ff3b129)

## Monitoring code quality

![Photo by [Stephen Dawson](https://unsplash.com/@srd844?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/monitoring?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)](file_2.jpeg)

### Tests coverage by Codecov

Following our workflow, we forbid the merging code that is not covered by tests. To automate these checks, we use **Codecov**. For each branch, it measures test coverage, and if the percentage of code covered has decreased, then the branch will not be merged.

The Сodecov also generates reports on which we can see the most vulnerable parts of the system for changes. It allows measure even JavaScript code coverage: [Collecting JavaScript code coverage with Capybara in Ruby on Rails application](https://jtway.co/collecting-javascript-code-coverage-with-capybara-in-ruby-on-rails-application-d0cb83a86a90).

### Updating 3rd party dependencies by **Dependabot**

To save developers from routine tasks, such as updating libraries to recent versions, we use **Dependabot**.

This tool allows you to update libraries automatically and thus keep the application secure since new versions of libraries often contain security patches.

The update looks like a regular Pull Request. The developer is only required to accept the Pull Request or reject it if the tests failed.

### Static code analysis by Pronto

Another routine task that we automate is static code analysis. **Pronto** helps us with this. This tool allows you to connect various linters and ensure that all the code is written according to the rules set in the company.

**Rubocop** is the most popular linter we use in conjunction with Pronto. Out of the box, it enforces many of the guidelines outlined in the community [Ruby Style Guide](https://rubystyle.guide/).

## Collaboration

![Photo by [Dylan Gillis](https://unsplash.com/@dylandgillis?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/collaboration?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)](file_3.jpeg)

### Team chat by Discord

Since our team is remote, we need a chat with configurable channels, and there are no restrictions for storing message history. For this purpose, we have chosen **Discord**. It also supports group calls, which we use for meetings and retrospectives.

### Optional for Video-calls by Whereby

Sometimes there are situations when you need videoconference, but there is no access to the Discord, or this is a one-time call, for the sake of which there is no sense in adding a person to the Discord.

For these cases, we use **Whereby**. Registration is necessary only to the creator of the conference. Other participants can go to the meeting by reference. The free version supports up to 4 participants.

### Providing feedback by Loom

If you want to share any knowledge between the team, but it is not possible to gather everyone for a conference, you can record a screencast. Sometimes it is easier to record a screencast to describe a task or annotate code.

The most convenient screencast tool for us is **Loom**. We also use it to show the client all the new features at the end of the sprint.

## Setup all in one click

We developed a gem [jt_tools](https://github.com/jetthoughts/jt_tools) that will help you integrate most of these tools to your project in one “click”.

You will have everything pre-setup and ready for use.

**Dmitry Gorodnichy ***is a Software Engineer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/gorodnichy/)* *or [GitHub](https://github.com/dgorodnichy).*
>  *If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).*
