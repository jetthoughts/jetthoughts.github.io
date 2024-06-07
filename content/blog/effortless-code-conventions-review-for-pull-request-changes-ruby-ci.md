---
dev_to_id: 1880211
title: "Effortless Code Conventions Review for Pull Request Changes"
description: "Reliably arranged source code helps hackability. You can filter code speedier if its..."
created_at: "2024-06-07T10:03:27Z"
edited_at: ""
draft: false
tags: ["ruby", "ci", "github", "codereview"]
canonical_url: "https://dev.to/jetthoughts/effortless-code-conventions-review-for-pull-request-changes-4p4k"
slug: "effortless-code-conventions-review-for-pull-request-changes-ruby-ci"
---


> # Reliably arranged source code helps hackability. You can filter code speedier if its organizing is predictable.

![Photo by [chuttersnap](https://unsplash.com/photos/15IqNc61SeY?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)](https://cdn-images-1.medium.com/max/6052/1*6GJBCYttzY_EMd6RXU4Bvg.jpeg)

To fight with non-consistent source code formatting there are static analysis tools such as [RuboCop](https://github.com/bbatsov/rubocop).

We decided to share code formatting feedback directly on [GitHub](https://github.com/) by commenting *Pull Requests* changes.

There is a suitable tool for this job - [pronto](https://github.com/mmozuras/pronto). With help of *CI *(in our case that’s [CircleCI](https://circleci.com/)) we run it for each *Pull Request*.

## Our *CircleCI 2.0* configuration to run pronto
>  **NOTE: **In order to reduce mess with dependencies we put all our linters and ***pronto*** into separate ***Gemfile.tools***.

```yaml
# .circleci/config.yml
version: 2
jobs:
  lint:
    environment:
      - BUNDLE_GEMFILE: Gemfile.tools
    docker:
      # specify the version you desire here
      - image: circleci/ruby:2.4.2-stretch-node-browsers
        environment:
          RAILS_ENV: test
          RACK_ENV: test

    working_directory: ~/repo

    steps:
      - checkout
      - restore_cache:
          keys:
          - v1-tools-dependencies-{{ checksum "Gemfile.tools.lock" }}
          # fallback to using the latest cache if no exact match is found
          - v1-tools-dependencies-

      - run:
          name: install cmake
          command: |
            sudo apt-get install cmake
      - run:
          name: install dependencies
          command: |
            bundle check --path vendor/bundle || bundle install --jobs=4 --retry=3 --path vendor/bundle
      - save_cache:
          paths:
            - ./vendor/bundle
          key: v1-tools-dependencies-{{ checksum "Gemfile.tools.lock" }}


      - run:
          name: run source code analysis
          command: |
            bundle exec pronto run -c origin/master -f github_status -f github_pr_review --exit-code
      - store_artifacts:
          path: ./tmp

workflows:
  version: 2
  release:
    jobs:
      - lint:
# Run lint after tests
#          requires:
#            - test
```

```ruby
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'pronto'
gem 'oj'
gem 'pronto-rubocop', require: false
gem 'pronto-scss', require: false
gem 'pronto-eslint', require: false
gem 'pronto-brakeman', require: false
gem 'pronto-rails_best_practices', require: false
```

Finally, you need to add *PRONTO_GITHUB_ACCESS_TOKEN*. You could obtain your *PERSONAL GITHUB ACCESS TOKEN* by following [this instruction](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) and check [environment variable on CircleCI](https://circleci.com/docs/2.0/env-vars/#adding-environment-variables-in-the-app) to add it to the project.

## Summary

There are similar ready SASS solutions to help you with reducing the amount of waste:

* [https://www.codacy.com/](https://www.codacy.com/)

* [https://hakiri.io/](https://hakiri.io/)

* [https://codeclimate.com/](https://codeclimate.com/)

* [https://gemnasium.com/](https://gemnasium.com/)

* [https://appcanary.com/](https://appcanary.com/)

* [https://www.pullreview.com/](https://www.pullreview.com/).

But they are not free and most of them are solve only specific problems.

With *pronto*, you have more options to customize by:

* setup specific code analyzers for the different problems

* easier support rules to follow company conventions

* store rules in the repository with project source code

Let’s remove the waste of time for trivial problems and spend it on codding!

## Get More

[Contact us](http://www.jetthoughts.com/contact.html) to find out more about how we work. We’re excited to help you — as always, we’d love to hear what you think!

***Paul Keen **is a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [](https://twitter.com/ChrisKeathley)[*LinkedIn](https://www.linkedin.com/in/paul-keen/) *or [GitHub](https://github.com/pftg).*
>  If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).
