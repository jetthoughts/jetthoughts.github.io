---
title: "Rails 7 End of Life: Pick Your Exit"
description: "Rails 7.1 got no patch for CVE-2026-66066, a CVSSv4 9.5 pre-auth RCE. How to find every app of yours on a dead branch and pick between four realistic exits."
date: 2026-08-08
draft: true
author: "JetThoughts"
slug: "rails-7-eol-unpatched-security-exposure"
keywords: "rails 7 end of life, rails 7.1 security support, rails eol, rails 7.1 no patch, rails lts, CVE-2026-66066, rails upgrade"
tags:
- rails
- security
- cve
- upgrade
categories:
- Rails
- Security
cover_image: cover.png
metatags:
  image: cover.png
cover_image_alt: "Rails 7 end of life cover - no patch for CVE-2026-66066 on 7.1, four exit paths compared"
canonical_url: https://jetthoughts.com/blog/rails-7-eol-unpatched-security-exposure/
---

On July 29 the Rails security team fixed a CVSSv4 9.5 vulnerability in Active Storage - an unauthenticated upload that reads files off your server and [escalates to code execution](https://github.com/rails/rails/security/advisories/GHSA-xr9x-r78c-5hrm). Three branches got a patched release that day: 7.2, 8.0, and 8.1. One of those three, 7.2, reaches the end of its security support tomorrow - it carries the patch, and then upstream stops shipping it fixes. Rails 7.1 and everything below it got nothing.

That's the concrete version of Rails 7 end of life. Rails 7.1 had [finished its security support period](https://rubyonrails.org/2025/10/29/new-rails-releases-and-end-of-support-announcement) by October 2025, so when CVE-2026-66066 landed, the backport list stopped at 7.2.

If your app sits on 7.1 or lower and processes image variants, there's no version on your branch to bump to. The fix lives on branches you're not on.

The CVE itself already has a [full writeup](/blog/rails-cve-2026-66066-active-storage-rce/): mechanism, detection inside a running app, the libvips 8.13 requirement, the secret rotation order. This post covers the problem that outlives this CVE. You're on an unsupported Rails, the next critical will skip you the same way, and there are four ways out.

## Skipped on schedule

The [maintenance policy](https://rubyonrails.org/maintenance) gives a minor series bug fixes for one year and security fixes for two, counted from the series' first release. 7.1 shipped on October 5, 2023. Its two years ran out, and the October 2025 announcement closed the series at 7.1.6 - final release, no successor.

March already showed how this plays out in practice. [CVE-2026-41316](/blog/rails-cve-2026-41316-founder-guide/), the ERB/Marshal deserialization RCE, got backports for 7.2, 8.0, and 8.1 in the [March 23 release](https://rubyonrails.org/2026/3/23/Rails-Versions-7-2-3-1-8-0-4-1-and-8-1-2-1-have-been-released) and nothing for 7.0 or 7.1. Two criticals in four months skipping the same versions is the policy running exactly as written, and it'll run the same way on the next advisory.

## Find every app on a dead branch

One app is a one-minute check. The fleet is where the work hides - a dozen client apps under one agency contract, or repos you inherited that nobody has opened since 2024.

Start with the lockfiles. Here's a loop that prints the resolved Rails version for every app under a directory:

```bash
for lock in */Gemfile.lock; do
  printf '%-32s %s\n' "${lock%/Gemfile.lock}" \
    "$(awk '$1 == "rails" && $2 ~ /^\([0-9]/ { gsub(/[()]/, "", $2); print $2; exit }' "$lock")"
done
```

Anything starting 7.1, 7.0, or 6.x goes on the list. For repos you don't have cloned, GitHub code search runs the same sweep across an org:

```bash
gh search code --owner your-org --filename Gemfile.lock '"rails (7.1"'
```

Then let [bundler-audit](https://github.com/rubysec/bundler-audit) tell each app which advisories hit its exact gem set:

```bash
gem install bundler-audit
bundle-audit check --update
```

On a 7.1 app it flags GHSA-xr9x-r78c-5hrm with a solution list - 7.2.3.2, 8.0.5.1, 8.1.3.1 - containing no version you can reach without leaving the branch. Paste that output into the ticket.

Last, sort that list by whether this specific CVE can reach each app. The [CVE writeup](/blog/rails-cve-2026-66066-active-storage-rce/) carries the exposure checks - which libvips the running process links, whether an attachment path takes uploads from someone who never logged in. Run them per app and let the answers rank the queue. Anything that takes public uploads and turns them into image variants is a P0.

## Exit 1: upgrade, and aim past 7.2

Upgrade if you can. Every other exit on this list buys time and leaves the branch dead.

Pick the target with the support clock in view. 7.2 is the smallest hop from 7.1, but its [security support ends August 9, 2026](https://rubyonrails.org/2025/10/29/new-rails-releases-and-end-of-support-announcement), so on its own it trades one dead branch for another; paired with the paid 7.2 LTS line in exit 2 it holds up. 8.0 holds until November 7, 2026, three months away.

8.1 is the only hop that buys real time - security fixes run to October 2027. Budget the Ruby bump into the same plan: Rails 8 needs Ruby 3.2 or newer, and a 7.1 app often isn't there yet.

How long the move takes is dominated by your app, not by Rails - test coverage decides most of it, and every pinned gem or private-API monkey patch adds its own detour. Plan in weeks.

The per-hop mechanics haven't changed since the Rails 6 era: update the Gemfile, run `rails app:update`, clear the deprecation list against the old version, keep the app deployable the whole way. Our [Rails 6-to-7 migration guide](/blog/rails-7-upgrade-guide-step-by-step-migration/) walks that sequence step by step; a 7.1-to-8.1 move repeats it for each version hop with a fresh deprecation list.

If you're rebuilding images along the way, the [Rails 8 Docker production guide](/blog/rails-8-docker-deployment-production-guide/) covers pinning system libraries so a base-image rebuild doesn't quietly undo your work.

## Exit 2: pay a vendor to patch a dead branch

[HeroDevs](https://www.herodevs.com/blog-posts/cve-2026-66066-rails-active-storage-arbitrary-file-read-and-rce) sells drop-in replacements for Rails 6.x, 7.0, and 7.1, and shipped a remediation for CVE-2026-66066 on those lines. [makandra's Rails LTS](https://railslts.com/en) covers 2.3 through 6.1 plus a [7.2 LTS line](https://makandracards.com/railslts) that tracks the latest 7.2 release, delivered as a Gemfile source swap. For an app on 7.1 the practical pick is HeroDevs - makandra's coverage jumps from 6.1 to 7.2, so reaching its LTS means doing the 7.2 hop first and then paying to stay.

Both sell what upstream stopped shipping: CVE fixes without a migration. Neither stops the rest of the ecosystem from moving on. Gem releases keep raising the minimum Rails version, so you pin dependencies at their last compatible release one by one, and each pin is one more thing the eventual upgrade has to unwind.

Used as a bridge - six months of cover while the upgrade gets staffed - that's a fair trade. Settling in permanently just grows the bill for the migration you'll still run someday.

## Exit 3: remove the surface this CVE needs

CVE-2026-66066 runs through variant processing in libvips. An app that stops feeding it can't be hit by this one:

- Check whether you still need variants at all. Some apps carry `image_processing` from an old scaffold and never call `.variant` - dropping the gem ends the exposure and shortens the Gemfile.
- If you do need variants, the advisory ships a workaround that runs on an unpatched gem, and swapping the image processor is the other lever. The [CVE writeup](/blog/rails-cve-2026-66066-active-storage-rce/) has both, with the library versions each one requires and the trade-off each one carries.

This closes one CVE and leaves the branch where it was. The next unpatched critical could land in Action Pack or Active Record, and you can't delete those.

This one ships in an afternoon and needs no budget line, which is why it goes first even when exit 1 is already funded.

## Exit 4: accept it and build walls

For an internal tool or an app already scheduled for decommission, accepting the risk can be the honest call.

Moving uploads behind authentication cuts the attacker pool from "anyone with the URL" to "people with accounts", and admin-only upload cuts it to staff. For this CVE that's a real reduction, since the exploit has to deliver a file into variant processing.

A WAF is thin cover here. The exploit is a correctly formed multipart upload whose hostile part is the image bytes themselves, so a ruleset inspecting request shapes has nothing to match on. Edge rules that restrict upload content types and rate-limit endpoints trim opportunistic scans; they won't stop a targeted attempt.

None of it changes what a SOC 2 auditor or an acquirer's diligence checklist sees: an EOL framework with a known unpatched critical. You can hold that position - expect to write the explanation memo more than once.

## Which exit, which app

Match each app from your fleet sweep to a row - a mixed portfolio usually lands in several.

| Situation | Move |
|---|---|
| Public uploads + variants, 7.1 or below | Exit 3 today, exit 1 starting this sprint |
| Revenue app, upgrade can't start this quarter | Exit 2 as the bridge, exit 1 on the calendar with a date |
| 5.2/6.1 app, long life, no budget | Exit 2, with the renewal cost budgeted year over year |
| Internal tool behind SSO, no public uploads | Exit 4 now, fold exit 1 into next quarter's maintenance |
| App with a real decommission date | Exit 4, with the date and the accepted risk written down |

## Put the dates where you'll see them

The support deadlines from exit 1 belong in the calendar, each with an owner - treat them like TLS certificate expiries, not facts you rediscover inside an advisory email.

Then open the ticket. The bundle-audit output from the fleet sweep is the body, and the [migration guide](/blog/rails-7-upgrade-guide-step-by-step-migration/) is the first link in it.

## Sources

- [GHSA-xr9x-r78c-5hrm - official Rails advisory](https://github.com/rails/rails/security/advisories/GHSA-xr9x-r78c-5hrm)
- [Rails 7.2.3.2 / 8.0.5.1 / 8.1.3.1 release announcement](https://rubyonrails.org/2026/7/29/Rails-Versions-7-2-3-2-8-0-5-1-and-8-1-3-1-have-been-released)
- [New Rails releases and end of support announcement (October 2025)](https://rubyonrails.org/2025/10/29/new-rails-releases-and-end-of-support-announcement)
- [Rails maintenance policy](https://rubyonrails.org/maintenance)
- [HeroDevs: CVE-2026-66066 remediation for EOL Rails](https://www.herodevs.com/blog-posts/cve-2026-66066-rails-active-storage-arbitrary-file-read-and-rce)
- [Rails LTS by makandra](https://railslts.com/en)
- [bundler-audit](https://github.com/rubysec/bundler-audit)

<!-- Reference cadence: thoughtbot -->
