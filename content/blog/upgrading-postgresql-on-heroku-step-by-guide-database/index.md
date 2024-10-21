---
dev_to_id: 1760994
title: "Upgrading PostgreSQL on Heroku: A Step-by-Step Guide"
description: "Are you looking to upgrade your PostgreSQL database on Heroku? Whether it's for performance..."
created_at: "2024-02-14T10:13:29Z"
edited_at: "2024-10-21T15:41:03Z"
draft: false
tags: ["database", "heroku", "rails", "webdev"]
canonical_url: "https://jetthoughts.com/blog/upgrading-postgresql-on-heroku-step-by-guide-database/"
cover_image: "https://media.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fmedia.dev.to%2Fcdn-cgi%2Fimage%2Fwidth%3D1000%2Cheight%3D420%2Cfit%3Dcover%2Cgravity%3Dauto%2Cformat%3Dauto%2Fhttps%253A%252F%252Fdev-to-uploads.s3.amazonaws.com%252Fuploads%252Farticles%252F2c5qjz882l3ilco1o4eg.jpeg"
slug: "upgrading-postgresql-on-heroku-step-by-guide-database"
metatags:
  image: cover.jpeg
---
Are you looking to upgrade your PostgreSQL database on Heroku? Whether it's for performance improvements or staying up-to-date with the latest features, upgrading your database is a crucial task. In this guide, we'll walk you through the process of upgrading PostgreSQL on Heroku with clear, step-by-step instructions.

## 1. Create a DB Follower
The first step in the PostgreSQL upgrade process is to create a database follower. This is essential for minimizing downtime during the upgrade.

```bash
heroku addons:create heroku-postgresql:standard-0 --follow HEROKU_POSTGRESQL_OLD --app your_app_name
```
Replace `HEROKU_POSTGRESQL_OLD_URL`, `standard-0`, and `your_app_name` with values specific for your app configuration.
Wait for the follower to start up:

```bash
heroku pg:wait --app your_app_name

# You can check the follower's status
heroku pg:info --app your_app_name
```
Wait for the follower to catch up, we'll need the follower to be fully in sync to minimize the downtime. In the follower DB info it should contain `Behind By: 0 commits`.

## 2. Turn on Maintenance Mode
To ensure a smooth upgrade process, it's recommended to turn on maintenance mode for your app.

```bash
heroku maintenance:on --app your_app_name

# Check the maintenance status
heroku maintenance --app your_app_name
```

## 3. Upgrade the Follower
Before upgrading, confirm that the follower has caught up fully:

```bash
heroku pg:info --app your_app_name
# Should have Behind By:   0 commits
```
Now, proceed with the upgrade:

```bash
heroku pg:upgrade HEROKU_POSTGRESQL_FOLLOWER_URL --app your_app_name

heroku pg:wait --app your_app_name
```

## 4. Promote the Follower
Promote the upgraded follower to be the new primary database:

```bash
heroku pg:promote HEROKU_POSTGRESQL_FOLLOWER_URL --app your_app_name
```

## 5. Stop Maintenance Mode
Once the upgrade and promotion are complete, turn off maintenance mode:

```bash
heroku maintenance:off --app your_app_name

# Verify the status:
heroku pg:info --app your_app_name
```

## 6. Ensure that the app works correctly & all app data is present.
Make sure that all parts of the app are using the new DB, perform automated & manual checks to verify that everything works as expected. You can wait a couple of days/weeks (in case if there are some daily/weekly background jobs/tasks) to ensure that there're no longer requests to the old DB.
In case of any issues found on this step you can quickly switch back to using the old DB, fix them & repeat the upgrade steps at a later time.

## 7. Destroy the Old Database
Finally, you can safely destroy the old database to clean up resources:

```bash
heroku addons:destroy HEROKU_POSTGRESQL_OLD --app your_app_name
```
Congratulations! You have successfully upgraded your PostgreSQL database on Heroku. This process ensures minimal downtime and a smooth transition to the latest version. Keep in mind that database upgrades should be performed with caution, and it's recommended to have backups in place before initiating any major changes.

## Further improvements
To minimize downtime, you can consider configuring you app to use multiple database setup: with primary/replica DBs. Instead of switching maintenance mode on, you can switch to read-only mode. There's a gem called [rails_failover](https://github.com/discourse/rails_failover) that makes the set up easier.
