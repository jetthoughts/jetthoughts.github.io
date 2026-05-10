# Proof-Signal Portfolio Map

**Status:** Living document. Update on every new cluster post.
**Last updated:** 2026-05-10

## Why this exists

Within the JT topic cluster (transparency, code health, dev-shop oversight, vibe coding), each post should anchor on a distinct proof signal that no sibling post leads with. Otherwise the cluster reads as "the same advice, repackaged."

This document tracks which post owns which signal, so future posts can pick an unused signal as their anchor instead of repeating an existing one.

Caught 2026-05-10: scipab Path B initially used "staging URL" for the Situation question, exactly the LinkedIn Mon/Tue lead signal. Fix was to retarget scipab's S to "user-impact verification" — a signal not used elsewhere.

## How to use this map

Before finalizing any post in the cluster:

1. Identify the post's PRIMARY proof signal — the diagnostic the reader is supposed to run on their team or codebase.
2. Check this map. If another post already owns that signal as its lead, swap to an unused signal from the bank.
3. After publishing, update this map to record the new ownership.

## Current ownership

| Proof signal | Primary owner | Secondary references |
|--------------|---------------|----------------------|
| Staging URL / clickable demo on Friday | `linkedin-posts/icp-validation/week1-mon-jira-not-progress.md` | LinkedIn Tue, Wed poll, planned Friday Demo Rule blog post |
| Smallest-thing-on-staging question script | `linkedin-posts/icp-validation/week1-tue-staging-question.md` | — |
| Trust signals poll (closed tickets / weekly demos / staging URL / standup updates) | `linkedin-posts/icp-validation/week1-wed-trust-signals-poll.md` | — |
| Test coverage % + commit size + monitoring + code duplication (5-signal table) | `content/blog/vibe-coding-crisis-ai-code-debt/index.md` | scipab references TDD |
| File-touch count for small change + test failure history + secrets storage + rollback drill + 3am alert | `content/blog/vibe-coding-disposable-by-design/index.md` | — |
| Generate-validate-kill workflow (cost math) | `content/blog/vibe-coding-disposable-by-design/index.md` | — |
| Four public failures (Lovable, Replit, Moltbook, EnrichLead) | `content/blog/vibe-coding-disposable-by-design/index.md` | — |
| 25-month decay timeline (Inc.com auditor data) | `content/blog/47-startups-failed-same-coding-mistake/index.md` | — |
| User-impact verification (which users used what shipped) | `content/blog/scipab-tell-better-business-stories-startup-management/index.md` | — |
| Plain-English jargon test (specific failure mechanic vs vague "complexity") | `content/blog/scipab-tell-better-business-stories-startup-management/index.md` | — |
| Cap-table math (slip translated to runway $/days) | `content/blog/scipab-tell-better-business-stories-startup-management/index.md` | — |
| Dev shop red flags checklist (contract clauses, IP ownership, termination) | `content/blog/dev-shop-red-flags-checklist/index.md` | scipab links forward |
| Weekly report from team (test coverage trend, what shipped) | `content/blog/how-know-what-your-team-doing-remote-startup/index.md` | scipab links forward |

## Unused signals available for the next post

| Available signal | Why it's useful | Sketch of how a post could lead with it |
|-------------------|-----------------|------------------------------------------|
| Pull-request size + reviewer-name distribution | Healthy teams have many small PRs reviewed by multiple people | "Pull one PR from this week and ask: who reviewed it, how long did review take, was anything pushed back" |
| On-call rotation visibility (who answered the last 3 alerts, response times) | Maps to operational maturity | "If your team can't tell you who got the last 3am page, the on-call is theatrical" |
| Customer support tickets tagged to the build that introduced them | Maps engineering output to customer pain | "Trace one open support ticket back to the commit that caused it" |
| Cloud bill week-over-week, broken down by service | Maps engineering decisions to founder runway directly | "Which AWS service line grew the most this month, and why" |
| Dependency upgrade cadence (when was the last security patch applied) | Vendor-due-diligence signal | "Pull `Gemfile.lock` or `package-lock.json` modification dates — if nothing's been touched in 60 days, the team isn't patching" |
| Documentation freshness (which docs were edited this quarter) | Evidence of living vs dead engineering culture | "Open `README.md` or `CONTRIBUTING.md` and check the git blame — if every line is from project init, nobody owns the docs" |

## Update protocol

When publishing a new cluster post:

1. Identify the post's primary proof signal.
2. If the signal is already in the "Current ownership" table — STOP and pick a different one.
3. Add a row to "Current ownership" with the post path and the signal name.
4. If you used a signal from "Unused signals available," remove it from that table.
5. If the post introduces a NEW signal not previously in either table, add it to "Current ownership" with a brief description that future posts can scan.
