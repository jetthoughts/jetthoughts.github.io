---
dev_to_id: 1877646
title: "Manage Bundler indirect dependencies versions"
description: "Manage Bundler indirect dependencies versions   Have you seen that bundler stuck on finding..."
created_at: "2024-06-05T06:45:46Z"
edited_at: "2024-06-06T07:42:41Z"
draft: false
tags: ["ruby", "rails", "tips", "tutorial"]
canonical_url: "https://jetthoughts.com/blog/manage-bundler-indirect-dependencies-versions-ruby-rails"
slug: "manage-bundler-indirect-dependencies-versions-ruby-rails"
---

## Manage Bundler indirect dependencies versions

Have you seen that bundler stuck on finding how to upgrade your gems? What to do if there is a new breaking version of the *indirect* dependency, causing deployment fails?

![](https://cdn-images-1.medium.com/max/5892/1*yzcpUrANoH3HDerh89kYmA.png)

Sometimes we got broken deploy, because of the not supported version of the *gem*, and it has been used automatically as an *indirect* dependency.

Or bundler could find any upgrade because of conflict of the indirect dependencies.

So what can we do? How could we help bundler find better versions for indirect dependencies?

## Migrate from *indirect* to direct dependency status

Yep, that’s all. We just need to add *indirect* dependency as *direct*. And do not forget to add a notice comment to make sure that this gem is required only for assigning version constraints.

![](https://cdn-images-1.medium.com/max/3196/1*ISN6gm46tmI0BE2v72Nqsg.png)

With explicit version constraints assigned for *indirect* (and now *direct*) dependency, the bundler will have to satisfy them and will change other gems.
