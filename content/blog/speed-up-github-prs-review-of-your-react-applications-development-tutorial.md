---
dev_to_id: 1853466
title: "Speed up GitHub PR’s review of your React applications"
description: "Would you like to speed up PR’s review of React application, when you use Jest snapshot..."
created_at: "2024-05-15T05:55:46Z"
edited_at: "2024-06-27T15:52:06Z"
draft: false
tags: ["development", "tutorial", "github", "jest"]
canonical_url: "https://jetthoughts.com/blog/speed-up-github-prs-review-of-your-react-applications-development-tutorial/"
cover_image: "https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/speed-up-github-prs-review-of-your-react-applications-development-tutorial/file_0.jpeg"
slug: "speed-up-github-prs-review-of-your-react-applications-development-tutorial"
---
Would you like to speed up PR’s review of React application, when you use Jest snapshot testing?

![Photo by [Makarios Tang](https://unsplash.com/@makariostang?utm_source=medium&utm_medium=referral) on [Unsplash](https://unsplash.com?utm_source=medium&utm_medium=referral)](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/speed-up-github-prs-review-of-your-react-applications-development-tutorial/file_0.jpeg)

How much time do we spend on waiting while snap files being rendered? Working with lots of large React components’ .snap files, manually collapsing files over and over gets quite painful. But don’t panic, here is the solution: GitHub uses [Linguist](https://github.com/github/linguist) to compute stats about your files, ignore files that are vendored, and even to suppress files that are generated automatically. So, you can configure it to treat files of your choosing in a certain way.

![A hidden big snapshot file](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/speed-up-github-prs-review-of-your-react-applications-development-tutorial/file_1.png)

In the root of the repository create a .gitattributes file. Then use the linguist-generated attribute to mark or unmark paths that you would like to be ignored for the repository’s language statistics and hidden by default in diffs. For example:

![All files with snap extension won’t be rendered](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/speed-up-github-prs-review-of-your-react-applications-development-tutorial/file_2.png)

Use a .gitattributes file to mark files that match a given “pattern” with the specified attributes. A .gitattributes file uses the same rules for matching as .gitingore files.

**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).
>  *If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).*
