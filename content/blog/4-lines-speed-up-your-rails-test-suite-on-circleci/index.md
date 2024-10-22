---
dev_to_id: 1880171
title: "4 lines to Speed Up your Rails Test Suite on CircleCI"
description: "Most of our projects have a big code base of assets which dramatically reduce not only browser page..."
created_at: "2024-06-07T09:15:36Z"
edited_at: "2024-10-22T20:07:15Z"
draft: false
tags: []
canonical_url: "https://jetthoughts.com/blog/4-lines-speed-up-your-rails-test-suite-on-circleci/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fraw.githubusercontent.com%2Fjetthoughts%2Fjetthoughts.github.io%2Fmaster%2Fstatic%2Fassets%2Fimg%2Fblog%2F4-lines-speed-up-your-rails-test-suite-on-circleci%2Ffile_0.jpeg"
slug: "4-lines-speed-up-your-rails-test-suite-on-circleci"
metatags:
  image: cover.jpeg
---
![](file_0.jpeg)

Most of our projects have a big code base of assets which dramatically reduce not only browser page rendering but also increase passing test suites.

The *Rails* asset pipeline provides an *assets:precompile* *rake* task to allow assets to be compiled and cached up front rather than compiled every time the app boots.
>  We found that with precompiled assets all test suite is passed faster. For some project, we got **50% improvement**.

This approach shows how you can skip compilation of assets every time you run a test.

## Solution
>  This solution for CircleCI, but you could migrate it to other CI.

Add precompile assets step with caching result into *.circle/config.yml*:

```yaml
      - restore_cache:
          keys:
            - v1-asset-cache-{{ arch }}-{{ .Branch }}
            - v1-asset-cache-

      - run: bundle exec rake assets:precompile

      - save_cache:
          key: v1-asset-cache-{{ arch }}-{{ .Branch }}-{{ epoch }}
          paths:
            - public/assets
            - tmp/cache/assets/sprockets
```

and here complete [CircleCI config](https://gist.github.com/pftg/92cb374182ffec19c37352c435fb3684).

## Benchmark

![](file_1.jpeg)

We generated a simple [*Rails 5 *project with Bootstrap and Foundation](https://github.com/jetthoughts/playground-for-speedup-tests-by-precompile-assets).

On this simple example we got **20% improvement.**

*There are 2 branches: [master](https://github.com/jetthoughts/playground-for-speedup-tests-by-precompile-assets/tree/master) — with assets precompilation enabled and [without-assets-precompilation](https://github.com/jetthoughts/playground-for-speedup-tests-by-precompile-assets/tree/without-assets-precompilation) without assets precompilation enabled*

## Extra: speedup Rails 4 system tests

On *Rails 5*, the asset digest is enabled by default which allows us to cache assets on a browser, but on *Rails 4* you should add some changes in order to make it works.

```yaml

Rails.application.configure do
  # ...
  # For Rails 4 we need to add those settings
  config.serve_static_files = true
  config.static_cache_control = 'public, max-age=2592000'
  config.assets.digest = true
  config.assets.debug = false

  if ENV['CI']
    config.assets.compile = false
    config.assets.js_compressor = :uglifier
  end
end
```
## Conclusion

This configuration allowed us to reduce and in most cases completely drop time on the assets compilation in tests.
>  If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co) and [trending tech stories](https://jtway.co/trending).
