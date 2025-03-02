---
remote_url: https://dev.to/jetthoughts/manage-bundler-indirect-dependencies-versions-ep7
source: dev_to
remote_id: 1091289
dev_to_id: 1091289
dev_to_url: https://dev.to/jetthoughts/manage-bundler-indirect-dependencies-versions-ep7
title: Manage Bundler indirect dependencies versions
description: Have you seen that bundler stuck on finding how to upgrade your gems? What to do if there is a new...
created_at: '2022-05-20T16:20:34Z'
edited_at: '2024-11-25T15:41:39Z'
draft: false
tags:
- ruby
- beginners
- tutorial
canonical_url: https://jetthoughts.com/blog/manage-bundler-indirect-dependencies-versions-ruby-beginners/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/manage-bundler-indirect-dependencies-versions-ruby-beginners/cover.png
metatags:
  image: cover.png
slug: manage-bundler-indirect-dependencies-versions-ruby-beginners
---
Have you seen that bundler stuck on finding how to upgrade your gems? What to do if there is a new breaking version of the indirect dependency, causing deployment fails?
![Bundler looks for options](file_0.png)
 
Sometimes we got broken deploy, because of the not supported version of the gem, and it has been used automatically as an indirect dependency.

Or bundler could find any upgrade because of conflict of the indirect dependencies.

So what can we do? How could we help bundler find better versions for indirect dependencies?

## Migrate from indirect to direct dependency status
Yep, that's all. We just need to add indirect dependency as direct. And do not forget to add a notice comment to ensure that this gem is required only for assigning version constraints.
![Add direct dependency to add constraint for indirect](file_1.png)

With explicit version constraints assigned for indirect (and now direct) dependency, the bundler will have to satisfy them and will change other gems.

