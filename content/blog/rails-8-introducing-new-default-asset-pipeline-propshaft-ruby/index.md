---
remote_url: https://dev.to/jetthoughts/rails-8-introducing-the-new-default-asset-pipeline-propshaft-5cpp
source: dev_to
remote_id: 2057856
dev_to_id: 2057856
dev_to_url: https://dev.to/jetthoughts/rails-8-introducing-the-new-default-asset-pipeline-propshaft-5cpp
title: 'Rails 8: Introducing the New Default Asset Pipeline – Propshaft'
description: The Rails asset pipeline helps manage static assets like CSS, JavaScript, and images. It improves...
created_at: '2024-10-25T14:36:50Z'
edited_at: '2024-11-25T15:31:45Z'
draft: false
tags:
- rails
- ruby
- changelog
canonical_url: https://jetthoughts.com/blog/rails-8-introducing-new-default-asset-pipeline-propshaft-ruby/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/rails-8-introducing-new-default-asset-pipeline-propshaft-ruby/cover.jpeg
metatags:
  image: cover.jpeg
slug: rails-8-introducing-new-default-asset-pipeline-propshaft-ruby
faqs:
  - question: "What is Propshaft in Rails 8?"
    answer: "Propshaft is the new default asset pipeline in Rails 8, designed to be more lightweight and straightforward than Sprockets. It focuses solely on serving traditional static assets like images, CSS, and non-JavaScript assets, allowing developers to choose their own JavaScript bundling tools."
  - question: "How does Propshaft differ from Sprockets?"
    answer: "Propshaft is simpler than Sprockets, focusing only on direct file linking and caching for static assets. Unlike Sprockets, it doesn't handle JavaScript bundling, letting developers use modern tools like esbuild or Vite for JavaScript asset management."
  - question: "Do I need to migrate from Sprockets to Propshaft?"
    answer: "Migration is not mandatory. Rails 8 applications will use Propshaft by default, but existing applications can continue using Sprockets. You can also manually switch between them based on your project's needs."
  - question: "What JavaScript bundling tools work with Propshaft?"
    answer: "Propshaft works with modern JavaScript bundlers like esbuild, Vite, Webpack, Rollup, and other tools of your choice. Since Propshaft doesn't handle JavaScript compilation, you have the flexibility to use any bundling solution."
  - question: "What are the main benefits of using Propshaft?"
    answer: "Propshaft offers simplicity with fewer configuration options, better performance for static asset serving, reduced complexity compared to Sprockets, and the freedom to choose modern JavaScript tooling that best fits your application."
  - question: "How do I configure Propshaft in my Rails application?"
    answer: "Propshaft requires minimal configuration and works out of the box with Rails 8. You can customize asset paths, configure compilers for different file types, and set up caching strategies through simple configuration options."
---

The Rails asset pipeline helps manage static assets like CSS, JavaScript, and images. It improves delivery speed by compressing and combining these files. Sprockets used to be the main tool for this, providing useful features like precompilation and versioning. However, it was often too complicated.

With Propshaft, Rails aims for simplicity. It focuses on key tasks like direct file linking and caching. This makes it easier for developers to manage their assets without extra confusion.

## What’s New in Rails 8?

Rails 8 [changes](https://github.com/rails/rails/pull/51799) the default asset pipeline to [Propshaft](https://github.com/rails/propshaft). Propshaft is designed to be more lightweight and straightforward than Sprockets, making it a good fit for modern web applications. Unlike Sprockets, Propshaft focuses solely on serving traditional static assets (images, CSS, and non-JavaScript assets), letting developers choose their own JavaScript bundling tool (like esbuild or Vite).

With Propshaft, Rails aims to provide:

- Simpler configuration: No complex setup, only a few paths are required.
- File-based asset resolution: Propshaft links to files directly, eliminating the need for runtime compilation.
- Seamless support for asset fingerprinting: Adds unique identifiers to filenames for cache busting.

Propshaft is optimized for serving and organizing assets without the extra overhead that some Sprockets features introduced.

## Key Differences Between Sprockets and Propshaft

The primary differences revolve around simplicity and performance. With Propshaft:

- No runtime compilation: Propshaft serves assets as they are, which avoids the need for heavy configuration or precompilation in development.
- Streamlined setup: Propshaft uses a more direct approach to loading assets.
- JavaScript bundling is separate: Propshaft only handles traditional assets, while JavaScript can be bundled by modern tools.

## Migration Tips

For existing Rails applications, moving from Sprockets to Propshaft involves:

1. Removing Sprockets gems (sprockets-rails) and adding propshaft.
2. Adjusting asset paths and configurations as needed.
3. Configuring your JavaScript bundler separately if using advanced JavaScript setups.

Full migration instruction [here](https://github.com/rails/propshaft/blob/main/UPGRADING.md).

This switch in Rails 8 is a step toward simplifying the asset pipeline, reducing build times, and making Rails apps faster and more modular.
