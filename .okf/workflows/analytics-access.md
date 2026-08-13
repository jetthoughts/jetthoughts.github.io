---
type: Playbook
title: Analytics access (GA4 + Search Console MCP)
description: How an agent session queries live GA4 and Search Console data for jetthoughts.com - the two local MCP servers, which property IDs are correct, why the two servers cannot share credentials, and the data-lag/duplicate-property traps.
tags: [analytics, ga4, search-console, mcp, seo, tooling]
generated:
  by: claude/opus-5
  at: 2026-08-13T00:00:00Z
verified:
  - by: claude/opus-5
    at: 2026-08-13T00:00:00Z
status: stable
sources:
  - resource: "/content-strategy/content-plan.md"
    title: "content-plan"
---

Until 2026-08-13 all GSC analysis ran off hand-downloaded CSV exports (see the
`jetthoughts.com-Performance-on-Search-2026-07-19/` citation in
[content-plan](/content-strategy/content-plan.md)). Two local MCP servers now
serve the same data live, so re-pulling a date range is a query, not an export.

# The two servers

Registered at Claude Code **user scope** (`~/.claude.json`), so they load in
every repo and every worktree - not just the one they were added from. Both run
through `uvx`; there is nothing vendored in this repo and nothing to install.

| Server | Command | Credential |
|---|---|---|
| `google-analytics` | `uvx analytics-mcp` | gcloud ADC at `~/.config/gcloud/application_default_credentials.json` |
| `gsc` | `uvx mcp-search-console` | own OAuth client at `~/.config/google-mcp/client_secrets.json`; token cached at `~/Library/Application Support/mcp-gsc/token.json` |

GCP project `snippets-454308` has `analyticsdata`, `analyticsadmin`, and
`searchconsole` enabled. Credential files live outside the repo by design and
must never be committed - this repo is public.

# Which property to query

Both accounts carry several overlapping properties. Picking the wrong one
silently returns real-looking but wrong numbers.

* **GA4** - account `10749382` (JetThoughts). The site is property
  **`328508492`** ("Home Page - GA4"). `315618854` ("Blog - GA4") and
  `332322607` ("jetthoughts-blog") are separate and are NOT the site total.
* **Search Console** - use **`sc-domain:jetthoughts.com`**. The URL-prefix
  properties (`https://jetthoughts.com/`, `https://www.jetthoughts.com/`) each
  cover only part of the traffic. `jtway.co`, `elital.jetthoughts.com`, and
  `execshub.jtway.co` are different sites.

# Traps

* **The two servers cannot share one credential.** gcloud's built-in ADC OAuth
  client may request `analytics.readonly` (a normal scope) but Google blocks it
  for `webmasters*` (a sensitive scope) - `gcloud auth application-default
  login --scopes=...webmasters...` fails with "This app is blocked". GSC
  therefore needs a self-owned **Desktop** OAuth client with the Google account
  added under Audience -> Test users; Testing mode grants sensitive scopes with
  no app-verification review. The "Google hasn't verified this app" interstitial
  is expected (Advanced -> Go to (unsafe)).
* **`GSC_CREDENTIALS_PATH` takes service-account files only.** It loads via
  `from_service_account_file`; an authorized-user ADC file will not load there.
* **Never set `GSC_OAUTH_CLIENT_SECRETS_FILE` to a path that does not exist** -
  the server fail-fasts on it before ever reading its cached token, so a
  speculative value breaks an otherwise-working token.
* **GSC data lags ~2-3 days.** Query windows must end ~3 days back or the tail
  reads as zero-traffic days that are really just unreported.
* **ADC with no `quota_project_id`** only produces a gcloud warning; GA calls
  still succeed on per-user quota. Silence it with `gcloud auth
  application-default set-quota-project snippets-454308` - safe here only
  because that project already has the three APIs enabled. Pointing a quota
  project at a project where the API is disabled turns working calls into
  `SERVICE_DISABLED` 403s.
* **Servers registered mid-session are not usable in that session** - Claude
  Code must restart before their tools load.

# Baseline at setup

Recorded 2026-08-13 so later pulls have something to diff against.

| Source | Window | Numbers |
|---|---|---|
| GA4 `328508492` | last 7 days | 1,445 sessions |
| GSC `sc-domain:jetthoughts.com` | 2026-07-14 .. 2026-08-10 | 142 clicks, 104,754 impressions, 0.14% CTR, avg position 18.1 |

Top queries in that window: `jetthoughts` (10 clicks / 23 impressions),
`rails install dependencies` (10/55), `langchain tutorial` (2/137),
`datadog laravel` (1/12), `falcon ruby` (1/27). The shape - six-figure
impressions converting at 0.14% from position 18 - is a visibility problem,
not a relevance one, and matches the 0.09% CTR baseline
[content-plan](/content-strategy/content-plan.md) was built from.
