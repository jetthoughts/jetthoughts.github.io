---
dev_to_id: 1853610
title: Migrate from Sidekiq to Sidekiq.cr in Rails application
description: Where is it better to start the Sidekiq jobs transition from Ruby to Crystal in order to...
created_at: '2024-05-15T07:33:16Z'
edited_at: '2024-11-26T16:04:15Z'
draft: false
tags:
- tdd
- testing
- development
- tutorial
canonical_url: https://jetthoughts.com/blog/migrate-from-sidekiq-sidekiqcr-in-rails-application-tdd-testing/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/migrate-from-sidekiq-sidekiqcr-in-rails-application-tdd-testing/cover.png
slug: migrate-from-sidekiq-sidekiqcr-in-rails-application-tdd-testing
metatags:
  image: cover.png
---
> # Where is it better to start the Sidekiq jobs transition from Ruby to Crystal in order to optimize the resources usage on the server and, at the same time, not to struggle with the duplication?

![](file_0.png)

Let’s conduct a little experiment and see if it is possible to integrate the *Sidekiq.cr* into the Rails application without spending a lot of effort and keeping the code cleanliness.

## Ruby Part

In the *Rails* application, it’s better to isolate the logic by creating the job in a separate service before getting it to work with the *Crystal* implementation.

For using the *Crystal* worker implementation, its class name and the *Sidekiq* queue name should be defined as the arguments. This is the way our service will look like:

That’s all for the Rails application!!!

## Crystal Part

In order to support the worker implementation on *Crystal*, this part should have *Sidekig.cr. *As it is pointed in the [documentation](https://github.com/mperham/sidekiq.cr/wiki/Getting-Started#create-some-jobs-using-the-client-api):
>  Crystal can push jobs for a Ruby process to consume, and vice versa. 
The Crystal Web UI can monitor Ruby processes, and vice versa.

The next requisition is the ability to work with a database that is the same for the *Rails* and the *Crystal* parts. There are several frameworks based on *Crystal*, which allow such a database connection. To make a choice, we formed the following requirements:

* it should be easy to customize and maintain

* it should allow finding the record in a database and updating it

After some research, we choose [*Granite](https://github.com/amberframework/granite). *Its pros are:

* easy support

* ability to define only attributes, which are going to be used

* supporting the Rails-like helpers to operate with the records

The model in the *Crystal* application will look like:

Example of environment configuration in the s*hard.yml*:

[Configure the connection](https://github.com/amberframework/granite/blob/master/docs/readme.md#register-a-connection) to a database:

max_pool_size and initial_pool_size — are configuration parameters for the [connection pool](https://crystal-lang.org/reference/database/connection_pool.html).

The next step — *Sidekiq::CLI* configuration and preload of the connection with a database:

WORKER_CR_CONCURRENCY- is the environment variable that defines the maximum size for a connection pool.

## Sidekiq worker in the Crystal Part

This worker will be responsible for fetching the record from the database and running some services:

The worker’s name should match WORKER_NAME defined in the *Rails* service:
```
    WORKER_NAME = 'Broolik::Worker::URLChecker'
```
Specify the queue for the job the same as in the *Rails* *ScheduleUrlCheckService*:
```
    'queue' => 'worker.cr'
```
## Make friends Crystal and Ruby

Thus, the installation of the *Crystal* part is started using the command:
```
    crystal build src/sidekiq.cr -o bin/sidekiq.cr --release
```
Finally, run:
```
    bin/sidekiq.cr -q worker.cr -c 100 -e production
```
## Link to the example

You can find this example in our repository [jetthoughts/broolik-worker.cr](https://github.com/jetthoughts/broolik-worker.cr).

**Sergey Sviridov** is a Software Engineer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/sergey-sviridov-83007199) or [GitHub](https://github.com/SviridovSV).
>  *If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).*
