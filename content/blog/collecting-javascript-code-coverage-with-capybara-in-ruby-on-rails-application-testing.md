---
dev_to_id: 1852568
title: "Collecting JavaScript code coverage with Capybara in Ruby on Rails application"
description: "Having JavaScript code covered by Capybara system tests, can we utilize them for the code..."
created_at: "2024-05-14T11:32:21Z"
edited_at: "2024-07-03T12:20:07Z"
draft: false
tags: ["capybara", "testing", "javascript", "rails"]
canonical_url: "https://jetthoughts.com/blog/collecting-javascript-code-coverage-with-capybara-in-ruby-on-rails-application-testing/"
cover_image: "https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/collecting-javascript-code-coverage-with-capybara-in-ruby-on-rails-application-testing/cover.png"
slug: "collecting-javascript-code-coverage-with-capybara-in-ruby-on-rails-application-testing"
---
### Having JavaScript code covered by Capybara system tests, can we utilize them for the code coverage collecting and get the aggregated result with the coverage from the unit tests?

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/collecting-javascript-code-coverage-with-capybara-in-ruby-on-rails-application-testing/file_0.png)

We want to be sure that all code responsible for key user journey scenarios of our app is covered with tests.

For example, there is a Ruby on Rails application that uses [Webpacker](https://github.com/rails/webpacker) and has JavaScript files that are covered by the system tests. [Capybara](https://github.com/teamcapybara/capybara) is used as the system testing tool.
>  How to get code coverage combining the results of system and unit tests?

### Inject getting coverage for JavaScript code

For getting coverage of the JavaScript code, we use [Istanbul Instrumenter Loader](https://github.com/webpack-contrib/istanbul-instrumenter-loader). It needs to be added as a dev dependency with the package manager ([Link to installation](https://github.com/webpack-contrib/istanbul-instrumenter-loader#install)).

This instrumenter is already outdated, but [Jest](https://jestjs.io/) is still using it to get coverage, and we have not found any alternatives to work with Webpack directly.

The Istanbul Instrumenter Loader will be run on the Webpack compilation stage for the *test* environment. So we placed it in the *webpack* folder.

 <iframe src="https://medium.com/media/7d5a4dd75250a2595a7a469a86915293" frameborder=0></iframe>

### Getting coverage after testing in the browser

After running the system test, the browser stores the coverage value in the global variable *_coverage_**. ***We need to extract from the page and save it.

 <iframe src="https://medium.com/media/f80bf6e4f0cad89401e3d9aaa0494b3a" frameborder=0></iframe>

This helper will store the coverage value from the ***_coverage_*** variable into the JSON file. We need to call it after each system test.

### Aggregate the coverage values

For collecting the coverage results we will use [Codecov](https://github.com/codecov/codecov-ruby). It has several arguments in his favor:

* aggregate the coverage results for different code parts (e.g. Ruby and JavaScript) in one place.

* manage the reports from the Istanbul Instrumenter Loader

* allow merging the coverage reports from several sources

Here is the example of a script that prepares the compilation with the Istanbul Instrumenter, runs the system tests, aggregates the code coverage results and sends the report to Codecov:

 <iframe src="https://medium.com/media/7e002600771a238a710db20467daa60e" frameborder=0></iframe>

After system tests running,

    bin/rails test:system

we’ll have a bunch of generated JSON files in the *e2e_coverage* folder containing coverage reports for the JavaScript code. Each file corresponds to one test.

At the next stage, they are merged into one JSON file. For this purpose, we use [nyc](https://github.com/istanbuljs/nyc) (Istanbul’s command line interface).

This is a more advanced tool for collecting coverage, but it does not allow us to build a report because it does not work with Webpack directly. We can take advantage of the useful property that it supports — the [*merge](https://github.com/istanbuljs/nyc#what-about-nyc-merge)* command.

    npx nyc merge ./e2e_coverage  coverage.json

Finally, the aggregated report is sent to the Codecov with *e2e* flag:

    npx codecov -f coverage.json -F e2e

And that’s all — we just got the JavaScript coverage without writing any actual JavaScript tests.

**Sergey Sviridov** is a Software Engineer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/sergey-sviridov-83007199) or [GitHub](https://github.com/SviridovSV).

**Dmitry Tsvetkov** *is a Software Engineer at JetThoughts. Follow him on [LinkedIn](https://www.linkedin.com/in/dmitry-tsvetkov-a374095a/) or [GitHub](https://github.com/vlaew).*
>  *If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).*
