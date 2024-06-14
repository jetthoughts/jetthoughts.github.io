---
dev_to_id: 1560068
title: "Optimize your Chrome options for testing to get x1.25 impact"
description: "🚀 Increase Browser Test Speed with Chrome Options Optimization 🚀  Are you looking to supercharge your..."
created_at: "2023-08-05T13:23:55Z"
edited_at: "2024-06-14T08:01:40Z"
draft: false
tags: ["testing", "performance", "productivity", "browser"]
canonical_url: "https://jetthoughts.com/blog/optimize-your-chrome-options-for-testing-get-x125-impact-performance/"
slug: "optimize-your-chrome-options-for-testing-get-x125-impact-performance"
---
🚀 Increase Browser Test Speed with Chrome Options Optimization 🚀

Are you looking to supercharge your browser tests and optimize their speed? By fine-tuning your Chrome browser options, you can significantly enhance the performance of your automated tests.

Below are some Chrome options that helped me get x1.25 improvement:

```ruby
CHROME_ARGS = {
  'allow-running-insecure-content' => nil,
  'autoplay-policy' => 'user-gesture-required',
  'disable-add-to-shelf' => nil,
  'disable-background-networking' => nil,
  'disable-background-timer-throttling' => nil,
  'disable-backgrounding-occluded-windows' => nil,
  'disable-breakpad' => nil,
  'disable-checker-imaging' => nil,
  'disable-client-side-phishing-detection' => nil,
  'disable-component-extensions-with-background-pages' => nil,
  'disable-datasaver-prompt' => nil,
  'disable-default-apps' => nil,
  'disable-desktop-notifications' => nil,
  'disable-dev-shm-usage' => nil,
  'disable-domain-reliability' => nil,
  'disable-extensions' => nil,
  'disable-features' => 'TranslateUI,BlinkGenPropertyTrees',
  'disable-hang-monitor' => nil,
  'disable-infobars' => nil,
  'disable-ipc-flooding-protection' => nil,
  'disable-notifications' => nil,
  'disable-popup-blocking' => nil,
  'disable-prompt-on-repost' => nil,
  'disable-renderer-backgrounding' => nil,
  'disable-setuid-sandbox' => nil,
  'disable-site-isolation-trials' => nil,
  'disable-sync' => nil,
  'disable-web-security' => nil,
  'enable-automation' => nil,
  'force-color-profile' => 'srgb',
  'force-device-scale-factor' => '1',
  'ignore-certificate-errors' => nil,
  'js-flags' => '--random-seed=1157259157',
  'disable-logging' => nil,
  'metrics-recording-only' => nil,
  'mute-audio' => nil,
  'no-default-browser-check' => nil,
  'no-first-run' => nil,
  'no-sandbox' => nil,
  'password-store' => 'basic',
  'test-type' => nil,
  'use-mock-keychain' => nil
}.map { |k, v| ["--#{k}", v].compact.join('=') }.freeze


class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1024, 768] do |options|
    options.args.concat CHROME_ARGS
  end
end
```

## Descriptions per option

`--allow-running-insecure-content`: Disables the warning message when loading insecure content on a secure page, which can save time during testing.

`--autoplay-policy=user-gesture-required`: Adjusts the autoplay policy, requiring user gestures to start media playback, potentially reducing unwanted interactions during testing.

`--disable-add-to-shelf`: Disables the "Add to Shelf" feature, which is unnecessary for automated tests.

`--disable-background-networking`: Prevents background networking tasks, focusing resources on the foreground tasks relevant to testing.

`--disable-background-timer-throttling`: Disables timer throttling in the background, helping to speed up background operations during tests.

`--disable-backgrounding-occluded-windows`: Disables backgrounding of occluded windows, improving focus on the main testing window.

`--disable-breakpad`: Disables crash reporting, which is not essential for automated testing.

`--disable-checker-imaging`: Disables checker imaging, reducing unnecessary image processing during tests.

`--disable-client-side-phishing-detection`: Turns off client-side phishing detection, streamlining security checks during testing.

`--disable-component-extensions-with-background-pages`: Disables extensions with background pages, saving resources for test-specific tasks.

`--disable-datasaver-prompt`: Disables the data saver prompt, which is irrelevant for testing scenarios.

`--disable-default-apps`: Disables default apps, focusing on the necessary components for browser testing.

`--disable-desktop-notifications`: Disables desktop notifications, avoiding interruptions during testing.

`--disable-dev-shm-usage`: Disables the use of the /dev/shm shared memory file system, which may reduce memory usage during testing.

`--disable-domain-reliability`: Disables domain reliability checks, potentially speeding up network-related tasks during testing.

`--disable-extensions`: Disables extensions during testing, eliminating any interference they might cause.

`--disable-features=TranslateUI,BlinkGenPropertyTrees`: Disables specific browser features like TranslateUI and BlinkGenPropertyTrees that may not be necessary for testing.

`--disable-hang-monitor`: Disables the hang monitor feature, which helps avoid unnecessary interruptions during tests.

`--disable-infobars`: Disables the yellow info bar that displays when Chrome is controlled by automated software, streamlining the testing experience.

`--disable-ipc-flooding-protection`: Disables IPC flooding protection, potentially improving inter-process communication performance during tests.

`--disable-logging`: Disables logging to improve test performance and avoid unnecessary log entries.

`--disable-notifications`: Disables browser notifications, avoiding interruptions during testing.

`--disable-popup-blocking`: Disables the popup blocker to avoid interference with specific test scenarios.

`--disable-prompt-on-repost`: Disables prompts when navigating to a reposted page, streamlining automated navigation.

`--disable-renderer-backgrounding`: Disables renderer backgrounding, which can speed up foreground tasks during tests.

`--disable-setuid-sandbox`: Disables the setuid sandbox, potentially reducing security overhead during testing.

`--disable-site-isolation-trials`: Disables site isolation trials, which might improve resource usage during testing.

`--disable-sync`: Disables browser sync functionality, which may not be required during automated tests.

`--disable-web-security`: Disables web security features, potentially speeding up interactions during testing, but be cautious when testing untrusted websites.

`--enable-automation`: Enables automation features, helpful for controlling the browser during automated tests.

`--force-color-profile=srgb`: Forces the browser to use the sRGB color profile, streamlining color rendering during testing.

`--force-device-scale-factor=1`: Forces the device scale factor to 1, potentially improving consistency in visual testing.

`--ignore-certificate-errors`: Ignores certificate errors, helpful when dealing with self-signed certificates during testing.

`--js-flags=--random-seed=1157259157`: Sets specific JavaScript flags with a random seed, potentially improving consistency in JavaScript testing.

`--metrics-recording-only`: Enables metrics recording only, valid for collecting performance metrics during testing.

`--mute-audio`: Mutes audio playback during testing, avoiding audio distractions.

`--no-default-browser-check`: Skips the default browser check, streamlining test setup.

`--no-first-run`: Skips the first-run experience, useful for repeated testing.

`--no-sandbox`: Disables the sandbox, potentially reducing overhead during testing.

`--password-store=basic`: Sets the password store to basic, simplifying password management during testing.

`--test-type`: Sets the test type, potentially influencing browser behavior during testing.

`--use-mock-keychain`: Uses a mock keychain for credentials, improving security and avoiding popups during testing.

## Disclaimer

Remember that not all of these options may be relevant to your specific testing needs, so evaluating their impact on your test environment and application behavior is essential. Happy optimizing! 🚀💨

---

**Paul Keen** is an Open Source Contributor and a Chief Technology Officer at [JetThoughts](https://www.jetthoughts.com). Follow him on [LinkedIn](https://www.linkedin.com/in/paul-keen/) or [GitHub](https://github.com/pftg).

If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).
