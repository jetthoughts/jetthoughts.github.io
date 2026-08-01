# snap_diff-capybara — upstream issues to file

Two bugs found 2026-08-01 while profiling this repo's visual suite. Paste each
block into a new issue at https://github.com/snap-diff/snap_diff-capybara/issues.

**Environment (both):** gem `capybara-screenshot-diff` 1.12.0 (git
`snap-diff/snap_diff-capybara@5ee298fbc3c1`), Ruby 4.0.6, Capybara 3.40.0,
Selenium Chrome (headless), `:vips` driver, `delayed = true`.

---

## Issue 1 — `Reporters::Default#generate` raises `TypeError` on a missing-image failure

**Title:** `Reporters::Default#generate` crashes with `TypeError: no implicit conversion of Symbol into Integer` when `failed_by` is the `"missing_image"` string

**Body:**

When a comparison fails because an image is missing, the reporter crashes
instead of producing the failure message.

Root cause — `failed_by` is set to a **String**, but the reporter indexes it
with a Symbol as if it were a Hash:

- `lib/capybara/screenshot/diff/image_compare.rb:128`
  ```ruby
  return build_null_difference("missing_image") unless images_exist?
  ```
  → `Difference#failed_by == "missing_image"` (a String).
- `lib/capybara/screenshot/diff/difference.rb:42`
  ```ruby
  def failed? = !!failed_by      # true for the "missing_image" string
  ```
- `lib/capybara/screenshot/diff/reporters/default.rb:25`
  ```ruby
  if difference.failed? && difference.failed_by[:different_dimensions]
  ```
  → `"missing_image"[:different_dimensions]` → `TypeError: no implicit
  conversion of Symbol into Integer`.

Contrast `difference_finder.rb:67`, which passes a **Hash**
(`{different_dimensions: true}`) — so the reporter's Hash assumption holds on
that path but not on the `"missing_image"` path.

**Stack trace:**
```
TypeError: no implicit conversion of Symbol into Integer
  .../reporters/default.rb:25:in 'String#[]'
  .../reporters/default.rb:25:in '#generate'
  .../image_compare.rb:107:in '#processed'
  .../image_compare.rb:90:in '#different?'
```

**Suggested fix:** normalize the sentinel to a Hash
(`build_null_difference({missing_image: true})`), or guard the reporter:
```ruby
if difference.failed? && difference.failed_by.is_a?(Hash) && difference.failed_by[:different_dimensions]
```

---

## Issue 2 — `skip_area` CSS selector that matches nothing waits `default_max_wait_time` per screenshot

**Title:** `skip_area` with a CSS selector matching zero visible elements blocks for `Capybara.default_max_wait_time` per screenshot

**Body:**

A `skip_area` selector that matches **no visible element** on the page makes
each screenshot block for the full `Capybara.default_max_wait_time` (default
5s), because the region lookup goes through Capybara's finder with its implicit
retry-until-timeout:

- `lib/capybara/screenshot/diff/browser_helpers.rb:101`
  ```ruby
  BrowserHelpers.session.all(selector, visible: true).map { |el| region_for(el) }
  ```

`session.all(sel, visible: true)` on a zero-match selector waits the whole max
wait time (Capybara treats "none yet" as "maybe later"). Selectors that *do*
match return instantly, so the cost only appears for masks pointing at absent
elements — easy to introduce accidentally with a shared default like
`skip_area: %w[picture img]` applied to a page that has neither.

**Reproduction / measurement** (page with no `<picture>`/`<img>`):
```
all('picture', visible: true)          5.01s
all('img', visible: true)              5.03s
all('picture', visible: true, wait: 0) 0.00s
same screenshot, skip_area %w[picture img]   11.33s
same screenshot, no skip_area                 1.30s
```
In our suite one test carried `skip_area: %w[picture img]` across 13
screenshots on an image-less fixture = ~130s of pure waiting (44% of the suite).

**Suggested fix:** resolve skip-area selectors with `wait: 0` (a mask region is
DOM that already exists at capture time; there's no reason to wait for it to
appear). Region lookup could pass `wait: 0` to `session.all` in
`all_visible_regions_for`, or the option could be surfaced so callers opt in.

**Workaround** (documented here for anyone hitting it): wrap the assertion in
`Capybara.using_wait_time(0)` and pin the capture `wait` explicitly (the stable
screenshoter requires `stability_time_limit <= wait`).
