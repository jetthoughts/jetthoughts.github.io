---
dev_to_id: 1091289
title: "Manage Bundler indirect dependencies versions"
description: "Have you seen that bundler stuck on finding how to upgrade your gems? What to do if there is a new..."
created_at: "2022-05-20T16:20:34Z"
edited_at: "2022-05-20T16:23:27Z"
sync_date: "2024-05-24T11:41:22Z"
draft: false
tags: ["ruby", "beginners", "tutorial"]
canonical_url: "https://jtway.co/manage-bundler-indirect-dependencies-versions-e0ed99ac2bd5?source=friends_link&sk=443e7e5a3e4f97c6cfa99d4e42d717bd"
slug: "manage-bundler-indirect-dependencies-versions-ruby-beginners"
---
Have you seen that bundler stuck on finding how to upgrade your gems? What to do if there is a new breaking version of the indirect dependency, causing deployment fails?
![Bundler looks for options](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/4sxis2wl9dy5364bl24a.png)
 
Sometimes we got broken deploy, because of the not supported version of the gem, and it has been used automatically as an indirect dependency.

Or bundler could find any upgrade because of conflict of the indirect dependencies.

So what can we do? How could we help bundler find better versions for indirect dependencies?

## Migrate from indirect to direct dependency status
Yep, that's all. We just need to add indirect dependency as direct. And do not forget to add a notice comment to ensure that this gem is required only for assigning version constraints.
![Add direct dependency to add constraint for indirect](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/pbxx3fzqemouy7a2uml4.png)

With explicit version constraints assigned for indirect (and now direct) dependency, the bundler will have to satisfy them and will change other gems.

---

Paul Keen is a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
