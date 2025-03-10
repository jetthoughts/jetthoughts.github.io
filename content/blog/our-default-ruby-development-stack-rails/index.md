---
remote_url: https://dev.to/jetthoughts/our-default-ruby-development-stack-72k
source: dev_to
remote_id: 1880251
dev_to_id: 1880251
dev_to_url: https://dev.to/jetthoughts/our-default-ruby-development-stack-72k
title: Our Default Ruby Development Stack
description: Our Default Ruby Development Stack     Not that long ago I joined JetThoughts. By this time...
created_at: '2024-06-07T10:47:23Z'
edited_at: '2024-11-26T16:02:11Z'
draft: false
tags:
- rails
- ruby
- tutorial
canonical_url: https://jetthoughts.com/blog/our-default-ruby-development-stack-rails/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/our-default-ruby-development-stack-rails/cover.jpeg
metatags:
  image: cover.jpeg
slug: our-default-ruby-development-stack-rails
---

## Our Default Ruby Development Stack

![](file_0.jpeg)

Not that long ago I joined **JetThoughts**. By this time I studied the team, the workflow, colleagues minds (just a little) and technologies used to build applications.

**Development** is based on agile methodologies which means that clients are continuously getting new or changed functionality for their product deployed and maintained.

Applications I know about are written in **Ruby on Rails**. Technologies used by team are mostly common for RoR developers but therefore flexible to meet clients requirements. We use both default(omakase) and advanced technologies stacks.

The most common **database choice** is PostgreSQL but MongoDB or any other SQL(which relates to default stack), or NoSQL database can be used too.

**Front-end technologies** are ERB, Haml, Bootstrap, Javascript, Coffeescript, AngularJS.

**ERB** — I guess you guys all know about it. It belongs to the default stack. Erb allows us to embed :surprise: ruby code into text documents, we use it in html templates. It can be topped with bootstrap to get the flavour of multiple device and screen size support.

Then comes up **haml**, a lightweight markup language that helps us to markup our templates easier and faster.

**JavaScript** and **СoffeeScript** both let you add some dynamics to your application. From Rails version 3.1 СoffeeScript goes default. Someone might not like coffee, but who cares? You can always remove it from your project. **AngularJS** is a front-end web framework. Angular is maintained by Google for single-page applications. One day I will use it too, but that is way other story.

For **asynchronous tasks handling** we use either Sidekiq or DelayedJob. DelayedJob uses SQL database for storage. Sidekiq uses redis for storage and gives better performance for massive jobs.

**Testing.** First it requires some test data. For these purposes we use fixtures/factory girl. I’m not gonna dive deep into argues which one to use, just need to mention that fixtures belong to omakase stack. After setting up the test data you are ready to write **unit tests**. At JetThoughts we do it using Minitest and Rspec. Rspec got its DSL magic, Minitest goes more ruby way. For integration testing we use capybara and phantomjs. As a **preloader** we use Spring, it keeps application running in background significantly reducing time spent to run test. Tests are run locally as well as on continuous integration server running Teamcity.

**For writing code** we use Vim, Sublime, and RubyMine. Most of team uses RubyMine because it is IDE, not just a text editor, and its magic simplifies coding process. I still can’t get used to it so my choice is vim+plugins. Written code is stored in Github or Bitbucket. I guess Github is an obvious choice:

* user-friendly interface eases team collaboration;

* community choice.

Result products can be deployed almost on every **server** able to run Ruby, but for staging we often using Heroku as it requires minimum setup and can run a lot of different versions easily. Also we use Chef to automate servers setup.

Many **opensource libraries/gems** also used for development to achieve fast and convenient result. Our developers contribute to most of these projects paying tribute and supporting community.

The whole team masters default stack technologies, the rest is optional. As my spiritual mentor once said: “You can do everything with a blade. If you can’t solve problem with blade than you are causing the problem.” I consider this is a metaphor which means that omakase stack is enough (and more than enough) to build an application. That’s why we relate to omakase stack as to a base stack. The team can decide whether they need anything unusual.
