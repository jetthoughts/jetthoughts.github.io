---
title: 'Refactor Without Breaking Tests: The 3-Line Discipline in Ruby'
description: 'The refactor step breaks more tests than green ever does. Cap each refactor commit at three lines of Ruby and the suite stays green every time.'
date: 2026-05-04
draft: false
author: 'JetThoughts Team'
slug: refactor-step-tdd-three-line-discipline-ruby
keywords: 'refactor without breaking tests, micro refactoring ruby, tdd refactor step, three line refactor discipline, core 6 refactorings'
tags: ['tdd', 'ruby', 'refactoring', 'engineering', 'tech-debt']
categories: ['Engineering']
cover_image: cover.png
metatags:
  image: cover.png
  og_title: 'Refactor Without Breaking Tests: The 3-Line Discipline in Ruby'
  og_description: 'The refactor step breaks more tests than green ever does. Cap each refactor commit at three lines of Ruby and the suite stays green every time.'
cover_image_alt: 'Obsidian-dark cover with the headline The 3-Line Refactor Discipline, a faceted ruby gem on the right, and three chips reading CEILING 3 lines, LOOP TCR, MOVES Core 6'
canonical_url: 'https://jetthoughts.com/blog/refactor-step-tdd-three-line-discipline-ruby/'
related_posts: false
---

The refactor step is where most TDD suites go red. On a Rails 7.1 rescue we took over in Q1 2026, a developer finished a feature on cycle 4, the bar was green, and they decided to "clean up the file" before opening the PR. Forty minutes later they had renamed three things, extracted a class, inlined a constant, and the suite had 11 failures with stack traces that didn't agree on what broke first. They unwound changes until something passed, lost track of which version of which method they were on, and shipped the original mess after burning the afternoon.

A 200-line cleanup PR titled "refactor: tidy up Order" is the shape this failure usually takes. Reviewers can't bisect it. The author can't remember what they did first. The skip-the-refactor route - the one we covered in [TDD Without the Overkill](/blog/tdd-overkill-myth-lightweight-ruby/) - is the easier choice in the moment. They keep adding features, the file grows to 400 lines of accumulated Shameless Green, and the technical debt that the refactor step was supposed to keep paid down piles up commit by commit.

JT's house standard on refactoring caps each refactor commit at three lines of production code and runs the suite after each one. That keeps both failure modes off the table - the cleanup-PR explosion and the skip-it-entirely tech debt - because three lines is small enough that the suite either stays green or fails for an obvious reason. We work the move on the `Order` class from [TDD in Ruby: A Step-by-Step Guide](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/), so paste the cycle-4 version into your editor if you want to type along.

## Why the refactor step breaks more tests than green ever does

On the green step you have a built-in stop rule: write the smallest method body that turns the test green and walk away. Your change stays bounded - one method, often one expression - so when the suite explodes you only need to read one method to find what broke. The refactor step doesn't give you that. There's no "smallest change that makes the test pass" to anchor against.

With green code in front of you, the next move isn't a single failing test pulling you forward. It's aesthetic dissatisfaction with what you wrote thirty seconds ago. The dissatisfaction is real (the `Order` class at the end of Post A stores `price * quantity` in `@items`, which is fine for now and bad later) but it doesn't carry the same constraint the test did.

The 200-line cleanup PR is what dissatisfaction without a stopping rule produces. Each one bundles a real improvement (extracting a 60-line method, renaming a misleading instance variable) with three or four moves the reviewer can't tell apart.

## The 3-line ceiling

Each refactor commit changes at most three lines of production code. The cap makes the refactor step cheap enough to run after each green test, not once a quarter as a "cleanup PR."

Why three? You can hold three lines in your head while you answer "did this change behavior?" without re-running the suite mentally. A reviewer can do the same on your PR. A rename touches the method definition plus its call sites; if the rename you're attempting touches more than three lines, you split it by call-site across commits. An Extract Method touches three lines if you extract one expression: the new method definition, and the two callers replaced. An Introduce Local Variable is one line of addition.

If the commit touches three lines, only three lines can be wrong. When the suite goes red on a 3-line commit, you only need to read three lines. The fix is `git reset --hard HEAD`, then a smaller step. That usually means the original step wasn't safe and you need a setup move first. Three lines is also a 30-second pair review. The navigator reads the diff, says "yes, that's a rename" or "wait, you also moved the conditional," and the driver commits or undoes within a turn.

A ceiling this tight changes how you choose your next move. Refactors that might break the suite stop being worth the gamble - the cost of guessing wrong is total revert. The Core 6 list becomes the menu: pick a certain move, ship it, pick the next one. Strung together, those certain moves get the file to where you wanted it. Refactor stops being a 200-line afternoon. It becomes fifteen or twenty 3-line commits, each one ending on a green suite.

If your real refactor wants fifty lines moved at once, the work has structural prerequisites - skip ahead to the Mikado section for that case.

## The Core 6 refactorings

Arlo Belshee's [Core 6 list](https://arlobelshee.com/the-core-6-refactorings/) is the shortest answer to "what counts as a safe move?" Belshee frames safe refactorings as CRUD operations on a name, with six members: Rename, Inline, Extract Method, Introduce Local Variable, Introduce Parameter, and Introduce Field. Anything else - move method, replace conditional with polymorphism, replace inheritance with composition - is a sequence of these six.

This cap isn't dogma. These six moves are what your IDE can do correctly and your test suite can verify. Anything bigger needs the Mikado Method or it needs to wait until you have a better-named version of the code in front of you. We'll cover the three most common moves on the cycle-4 `Order` class.

Start with a Rename. The cycle-4 class stores priced-and-quantified subtotals in `@items`, but the name lies - they're not items, they're line totals. The first 3-line move is to rename the variable so the next developer doesn't get confused.

Before:

```ruby
class Order
  def initialize
    @items = []
  end

  def add(price:, quantity: 1)
    @items << price * quantity
  end

  def total
    @items.sum
  end
end
```

After (3 lines changed - the ivar declaration, the `add` push, the `total` sum):

```ruby
class Order
  def initialize
    @line_totals = []
  end

  def add(price:, quantity: 1)
    @line_totals << price * quantity
  end

  def total
    @line_totals.sum
  end
end
```

Run `bin/rake test:critical`. Four green tests. Commit:

```text
refactor: rename @items to @line_totals on Order
```

Next move, Introduce Local Variable. The expression `price * quantity` doesn't have a name, and the next time we touch this method we'll want a place to add tax or a discount. Give the expression a name now, while the change is one line:

```ruby
def add(price:, quantity: 1)
  line_total = price * quantity
  @line_totals << line_total
end
```

Two lines changed: one added, one modified. Tests stay green. Commit:

```text
refactor: name the per-line subtotal in Order#add
```

The third move is Extract Method, and it's driven by a new requirement rather than aesthetics. Suppose a test arrives that needs the line-total calculation from somewhere else - a `preview_total` method that sums a hypothetical line without storing it. Before writing the new method, extract the calculation so both call sites can share it. The honest move is four lines: delete the local, replace the push, add the method definition and body. Just over the limit, so split it into two commits and you stay safe.

First commit, add the private method body next to `add`:

```ruby
private

def calculate_line_total(price, quantity)
  price * quantity
end
```

Adding a method takes a few lines (signature, body, `end`, and the `private` keyword if not already in scope). The method is unused so the suite stays green. Commit:

```text
refactor: add Order#calculate_line_total (unused)
```

Second commit, route `add` through the new method:

```ruby
def add(price:, quantity: 1)
  @line_totals << calculate_line_total(price, quantity)
end
```

Two lines changed - the local goes away and the push gains a call. Suite stays green. Commit:

```text
refactor: route Order#add through calculate_line_total
```

Now the new feature can call `calculate_line_total(...)` from `preview_total` without duplicating the multiplication. The refactor was strictly preparation - it added no behavior. The behavior change goes in its own commit afterward, which keeps git bisect honest about which line caused which test to flip.

Any one of those commits could be reverted on its own without disturbing the others, which is what the 3-line ceiling buys you in exchange for the extra commits.

## TCR - the auto-revert that enforces tiny steps

Three lines is the ceiling. Test && Commit || Revert (TCR) is what enforces it without requiring willpower.

Kent Beck and Llewellyn Falco coined [TCR](https://medium.com/@kentbeck_7670/test-commit-revert-870bbd756864) in 2018 as a workflow that runs tighter than red-green-refactor. It fits on a Post-it. After each edit, run the suite. If green, commit. If red, throw the change away. Beck's exact phrasing: "if all tests pass, the code will be committed; if tests don't pass, your changes will be reverted."

The Ruby version that fits a Minitest project is a small bash script:

```bash
#!/usr/bin/env bash
# bin/tcr - usage: bin/tcr "rename @items to @line_totals"
message="${1:?supply a commit message}"
if bin/rake test:critical; then
  git commit -am "refactor: $message" || git reset --hard HEAD
else
  git reset --hard HEAD
fi
```

Save this as `bin/tcr` and run it after each refactor edit. This script lands at this length because the `if/then/else` form avoids the `&&...||` gotcha where a failed `git commit` (nothing staged, hook failure) triggers a reset even when the tests passed. The `${1:?...}` syntax errors out cleanly if you forget to supply a message. Call it as `bin/tcr "rename @items to @line_totals"`. If the suite passes, the change commits with the message you supplied. If the suite fails, the working tree resets to the last green commit. The auto-revert already happened by the time you'd notice you wanted to "fix it quickly."

Honeybadger walked through [a Ruby-specific TCR setup](https://www.honeybadger.io/blog/ruby-tcr-test-commit-revert/) in 2022, including a Guard configuration that runs TCR on each file save. Their summary of what changes when you adopt it: developers stop attempting moves they aren't certain about. The cost of guessing wrong is total revert, and the only way to move forward is to make smaller moves you can predict.

The `-am` flag commits tracked modifications only - new files need a `git add` before TCR catches them. Pre-commit hooks (RuboCop autocorrect, Brakeman, lefthook) interact badly with the script's commit step. RuboCop autocorrect that rewrites the staged file silently invalidates the just-passed test run; Brakeman and `bundle-audit` hooks taking 30s defeat the tight loop. Wire those tools as a pre-test step, or skip them during TCR sessions and run them in CI.

The trade-off is real. TCR is hostile to exploratory work - the kind where you don't know what you're trying yet. We turn TCR off during the green phase of new behavior (you need room to write code that doesn't compile yet) and turn it on for the refactor phase. On rescue engagements where the inherited suite takes 22 minutes - even after running parallel_tests across 8 cores - TCR is impossible until we've split the suite into a 90-second critical path. The first move is usually parallel_tests, flatware, or knapsack; if the suite is still over a minute after those, splitting `bin/rake test:critical` from the full integration sweep is the next move. Until then, the 3-line cap runs on the honor system plus pair programming.

TCR has one production-grade footgun: migrations. The script can revert your migration file but your local database has already changed schema. If your refactor batch contains a `db/migrate/*` change, run the migration manually, commit it on its own, and only then resume TCR for the surrounding refactor. Schema state lives outside git's reach.

## Flocking Rules tell you the next refactor for you

The 3-line ceiling answers "how big can this commit be." Flocking Rules answer "what should the next commit do." Sandi Metz's three rules from [99 Bottles of OOP](https://sandimetz.com/99bottles), which JT documents as an internal standard alongside Shameless Green: select the things that are most alike, find the smallest difference between them, and make the simplest change that will remove that difference. Repeat.

The rules turn the refactor step into a search procedure - no creative leap required. Two pieces of code that are 90% similar are the next refactoring target. The smallest difference between them is the next commit. The simplest change that removes the difference is the diff. You don't have to design anything. Spot the duplication, find what differs by the smallest amount, and make the smallest change that closes the difference. That's the next commit.

Suppose the `Order` class has grown a second method - a `preview_total` that takes a hypothetical line item and returns what the order total would be if that item were added:

```ruby
def add(price:, quantity: 1)
  @line_totals << calculate_line_total(price, quantity)
end

def preview_total(price:, quantity: 1)
  hypothetical = price * quantity
  @line_totals.sum + hypothetical
end
```

First flocking pass. The two methods aren't similar enough to merge - they do different things. But the local `hypothetical` calculation duplicates the `calculate_line_total` extraction we already did. The smallest difference between them: one inlines the multiplication, the other calls the private method. The simplest change that removes the difference is to have `preview_total` call the same method.

```ruby
def preview_total(price:, quantity: 1)
  @line_totals.sum + calculate_line_total(price, quantity)
end
```

Two lines changed, the suite stays green, commit. The duplication is gone and the per-line-total logic now lives in exactly one place.

Second pass. Both methods now call `calculate_line_total(price, quantity)`. The next-smallest difference is that one pushes the result onto the array and the other adds it to the array's sum. That's not a duplication worth removing yet - the rule of three says wait until you see the same shape three times before abstracting. We stop here.

The Flocking Rules also tell you when to stop. When the next-smallest difference between any two pieces of code is larger than three lines, or when removing it would require an abstraction the rule of three doesn't justify yet, you're done. Commit what you have. The next refactor cycle starts when the next failing test gives you a third example of the shape.

## Mikado Method - when 3 lines isn't enough

The 3-line ceiling assumes the refactor is safe. On greenfield code with a fast suite, the Core 6 moves are. On legacy code, they often aren't. You start an Extract Method on a 200-line monstrosity, the suite breaks in eleven places, and the failures are in three different files because the method secretly shared state with two other modules through an instance variable nobody documented. The 3-line commit is impossible because the underlying structural problem wants forty lines moved before the extract is even a coherent move.

That's the failure mode the [Mikado Method](https://www.manning.com/books/the-mikado-method) was built for. Daniel Brolund and Ola Ellnestam's 2014 book describes it as a way to "make small incremental improvements without breaking the existing codebase." The protocol: write down the goal. Attempt the change. When it breaks (test failure, compile error, anything), write down the prerequisite that made it break. Undo the change. Work on the prerequisite first - which itself may have prerequisites that land on the same graph.

The graph bottoms out at leaf changes that are safe enough to commit on their own. You walk back up the graph from the leaves, and when you finally attempt the original goal, every prerequisite is already done and the change is a 3-line commit. Nicolas Carlo's writeup of [the Mikado Method on legacy codebases](https://understandlegacycode.com/blog/a-process-to-do-safe-changes-in-a-complex-codebase/) makes the practice concrete with worked examples.

Cheap example on the `Order` class. Suppose you decide `@line_totals` should become a list of `LineItem` value objects, not raw integers. You attempt the change: rename the variable, switch the storage to `LineItem.new(price:, quantity:)`, update `total` to sum `line.subtotal`. Three tests fail because two callers in another file did `order.instance_variable_get(:@line_totals).first` (a violation we covered in Post A's "common mistakes" section, but legacy code has it). The Mikado prerequisite: rewrite those callers to use a public method first. Undo the storage change, write the public method (`Order#line_totals` returning a copy), update the callers, commit. Now retry the original storage change. It's a 3-line commit again.

Mikado is the acknowledgement that the 3-line rule has limits. On a clean codebase with good tests, you almost never need it. On a rescue, it's the difference between landing a refactor in a week and abandoning it after three days. We use it on roughly one in four rescue engagements - the ones where the inherited code has the deepest coupling.

## How JetThoughts uses this on rescues

Here's what one of those rescues looked like. The 4,000-commit Rails repo we picked up in Q3 2025 had structural and behavioral changes mixed in roughly half its commits and no separation rule in place. Their lead engineer told us in the kickoff: "we just stopped writing tests for refactors after the first big merge conflict." Skipped refactor steps had piled up for two years; when they did refactor, they bundled the cleanup into a feature commit. `git bisect` on regressions was useless because suspect commits straddled the line between behavior change and rename.

The rebuild pattern from those rescues is consistent. Split the suite to get a 90-second critical path. Turn on TCR for the refactor phase. Cap refactor commits at three lines, and use the [pull-request review standard](/blog/effortless-code-conventions-review-for-pull-request-changes-ruby-ci/) to enforce that limit as a merge gate. After the first month at most rescues, 600-line cleanup PRs are gone - what TCR enforces produces 5-20 small commits per hour instead. The bisect cost on the next regression drops from four hours to a two-minute `git bisect` and a ninety-second revert.

If you're holding a Rails codebase where every refactor proposal turns into "let's not touch it," we run a free 45-minute audit: one senior developer reads your suite and your last five PRs, you get a one-page written assessment naming the three changes that pay back fastest. No contract, no follow-up sales call. If you're a developer who recognizes this pattern in your codebase but doesn't sign contracts, forward this post to whoever does.

[Talk to us about your codebase](/contact-us/).

## Further reading

- [Arlo Belshee, "The Core 6 Refactorings"](https://arlobelshee.com/the-core-6-refactorings/) - the six moves every safe refactor is built from
- [Kent Beck, "test && commit || revert"](https://medium.com/@kentbeck_7670/test-commit-revert-870bbd756864) - the auto-revert discipline that enforces tiny steps
- [Daniel Brolund and Ola Ellnestam, *The Mikado Method* (Manning, 2014)](https://www.manning.com/books/the-mikado-method) - safe refactoring on legacy codebases
- [Sandi Metz, *99 Bottles of OOP*](https://sandimetz.com/99bottles) - Shameless Green and the Flocking Rules
- [Nicolas Carlo, "A process to do safe changes in a complex codebase"](https://understandlegacycode.com/blog/a-process-to-do-safe-changes-in-a-complex-codebase/) - Mikado Method walkthrough on real legacy code
- [Honeybadger, "TCR in Ruby"](https://www.honeybadger.io/blog/ruby-tcr-test-commit-revert/) - Ruby-specific TCR setup with Guard

Related: [TDD in Ruby step-by-step](/blog/test-driven-development-tdd-in-ruby-step-by-guide-tutorial-bestpractices/), [why lightweight TDD ships faster](/blog/tdd-overkill-myth-lightweight-ruby/), [refactoring callbacks into services](/blog/how-avoid-callbacks-using-services-rails-refactoring/), [why and how to use TDD](/blog/why-how-use-tdd-main-tips-testing/).
