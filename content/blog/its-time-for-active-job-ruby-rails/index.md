---
remote_url: https://dev.to/jetthoughts/its-time-for-active-job-eph
source: dev_to
remote_id: 1880305
dev_to_id: 1880305
dev_to_url: https://dev.to/jetthoughts/its-time-for-active-job-eph
title: It’s Time For Active Job
description: It’s Time For Active Job     Recently we have upgraded one of our own projects to Rails 4.2....
created_at: '2024-06-07T11:47:31Z'
edited_at: '2024-11-25T15:34:09Z'
draft: false
tags:
- ruby
- rails
- develpment
- tutorial
canonical_url: https://jetthoughts.com/blog/its-time-for-active-job-ruby-rails/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/its-time-for-active-job-ruby-rails/cover.jpeg
metatags:
  image: cover.jpeg
slug: its-time-for-active-job-ruby-rails
---

## It’s Time For Active Job

![](file_0.jpeg)

Recently we have upgraded one of our own projects to Rails 4.2. New minor version contains many improvements of old features and adds some new ones. One of most interesting (and helpful) new features is adding a new framework for declaring jobs and making them run on a variety of queuing backends — **Active Job**.

It is hard to imagine any big and complex Rails project without background jobs processing. There are many gems for this task: **[Delayed Job](https://github.com/collectiveidea/delayed_job), [Sidekiq](https://github.com/mperham/sidekiq), [Resque](https://github.com/resque/resque), [SuckerPunch](https://github.com/brandonhilkert/sucker_punch)** and more. And Active Job has arrived here to rule them all.

Active Job provides unified interface to hide real background jobs library from our eyes and to simplify migration from one background jobs processing library to another. Also it is cool that Active Job provides a generator to create jobs. I really don’t like to write almost the same code over and over again and a good tool should take all routine work upon itself.

That looks cool and useful. So it’s time to use Active Job in our project.

## Move Delayed Job to Backend

We already use Delayed Job in a project. So, first of all, we should tell Active Job which backend it should use.

We should create initializer for active jobs in the config/initializers folder:

```
Rails.application.config.active_job.queue_adapter = :delayed_job

```

We will take as example one of our workers (we used “worker” term for classes which we use in a background):

```ruby
class SendNewFeedbackNotificationWorker
  attr_reader :showing_id, :user_id

  def initialize(showing_id, user_id)
    @showing_id = showing_id
    @user_id = user_id
  end

  def perform
    showing = Showing.find(showing_id)
    user    = User.find(user_id)
    NewFeedbackNotificationService.new(showing, user).perform
  end
end
```

And this is the way how we used it:

```
SendNewFeedbackNotificationWorker.new(showing.id, user.id).delay.perform
```

Let’s rewrite it for Active Job. We use generator for create new jobs:

```

$ rails g job SendNewFeedbackNotification

invoke  test_unit
create  test/jobs/send_new_feedback_notification_job_test.rb
create  app/jobs/send_new_feedback_notification_job.rb
```

We can see that generator creates a test file for us too and this is a good reminder for you to write tests for a job. Before committing changes you will need to choose between deleting a file (we don’t leave empty files in projects) or writing some tests.

Let’s see what a generator has created.

```
class SendNewFeedbackNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
  end
end
```

It has created a new class which is descendant of `ActiveJob::Base` with name ending with Job. Also it is set to use a default queue (can be changed by `--queue another_queue` generator’s option but simple replacing this in code is much quicker).

It is left to change #perform method in the created job:

```ruby
class SendNewFeedbackNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(showing_id, user_id)
    showing = Showing.find(showing_id)
    user    = User.find(user_id)
    NewFeedbackNotificationService.new(showing, user).perform
  end
end
```

And replace old calls `SendNewFeedbackNotificationWorker.new(arguments).delay.perform` to new calls `SendNewFeedbackNotificationJob.perform_later(arguments)`.

## Enqueue a job with options

You can change a queue and time for running a job by #set method on job. It can accept these options:

* `:wait` - enqueues the job with the specified delay;

* `:wait_until` - enqueues the job at the time specified (override :wait if both specified;

* `:queue` - enqueues the job on the specified queue.

Examples:

```ruby
SendNewFeedbackNotificationJob.set(queue: 'urgent').perform_later(showing, user)
SendNewFeedbackNotificationJob.set(wait: 15.minutes).perform_later(showing, user)
SendNewFeedbackNotificationJob.set(wait_until: 10.hours.since(Date.tomorrow)).perform_later(showing, user)
```

**Note:** you can check available features for your backend of choice in Rails [documentation](http://edgeapi.rubyonrails.org/classes/ActiveJob/QueueAdapters.html#module-ActiveJob::QueueAdapters-label-Backends+Features).

## Pass models instances to your jobs

It is a common recommendation to pass models ids instead of models instances to background jobs. Because in this case we already know that model will have the latest saved state when a job will start processing it and this prevents possible issues in serializing and deserializing.

And [Global ID](https://github.com/rails/globalid) was created to simplify jobs. Because using Global ID allows you to pass models to jobs without fear and with less code.

We can rewrite our job using models instead of ids.

```

class SendNewFeedbackNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(showing, user)
    NewFeedbackNotificationService.new(showing, user).perform
  end
end
```

And use it in the following way:

```
SendNewFeedbackNotificationJob.perform_later(showing, user)
```

All the magic is done by Active Job and Active Record using Global ID.

Active Job serializes arguments which you pass to perform_later. And it has a special case for models which mixin `GlobalID::Identification` module. In this case Active Job serializer calls `.to_global_id.to_s` on the model and passes returned string to queue adapter instead of a model.

Before performing job Active Job deserializer detects Global ID identifier, finds a model using `GlobalID::Locator.locate` and passes the found model as an argument to job’s #perform method.

## Testing of Jobs

Active Job also contains a useful module `ActiveJob::TestHelper`. When we include this module to our test class it overwrites `before_setup` and `after_teardown` methods.

In before_setup it sets Active Job to use a test queue adapter instead of the original one and clears lists of enqueued and performed jobs in this adapter. And it restores original adapter in the after_teardown to not interfere on next tests.

Also this module provides several useful methods which allow us to verify that our jobs are working properly.

Let's assume that we create a job for sending notification to user in the controller:

```ruby
class UsersFeedbacksController < ApplicationController

  def create
    ...
    SendNewFeedbackNotificationJob.perform_later(showing, user)
  end

end
```

Then we can use these helpers to check that this action works right.

`assert_enqueued_jobs(number)` - checks that exact number of jobs were added to queue:

```ruby
assert_enqueued_jobs 1 do
  post :create
end
```

`assert_enqueued_with(args)` - checks that block enqueues job with given arguments:

```ruby
assert_enqueued_with(job: SendNewFeedbackNotificationJob,
                     args: [showing, user],
                     queue: 'default') do
  post :create
end
```

`perform_enqueued_jobs` - performs jobs created in the passed block instead of queuing them:

```ruby
perform_enqueued_jobs do
  post :create
end
```

## What we have done

So let’s have a look once again on how we have changed the code.

Worker *before:*

```ruby
class SendNewFeedbackNotificationWorker
  attr_reader :showing_id, :user_id

  def initialize(showing_id, user_id)
    @showing_id = showing_id
    @user_id = user_id
  end

  def perform
    showing = Showing.find(showing_id)
    user    = User.find(user_id)
    NewFeedbackNotificationService.new(showing, user).perform
  end
end
```

Job *after:*

```ruby
class SendNewFeedbackNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(showing, user)
    NewFeedbackNotificationService.new(showing, user).perform
  end
end
```

Enqueueing worker *before:*

```ruby
SendNewFeedbackNotificationWorker.new(showing.id, user.id).delay.perform
```

Enqueuing job *after:*

```ruby
SendNewFeedbackNotificationJob.perform_later(showing, user)
```

Looks like our jobs became much cleaner with Active Job.

And a small notice about deploying these changes to *production*. We **should not delete** previous `SendNewFeedbackNotificationWorker` class right now. Because during deploy it may happen that previously used worker was delayed but has not been processed before the deploy. And after deploy this job fails because DelayedJob couldn’t create instance of already deleted class. *Adding and deleting of a job shouldn’t be done in single deploy.*

**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
>  If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).
