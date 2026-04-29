# GSC Weekly SEO Review - 2026-04-29

**Property**: jetthoughts.com (root domain)
**Window**: last 7 days
**Total clicks**: ~7 | **Total impressions**: ~2,000+
**Reviewer**: SEO lead

---

## 1. TL;DR

- **Biggest opportunity**: ActiveModel `type_for_attribute` posts (335 impr / 0 clicks) and the LangGraph/CrewAI cluster (227 impr / 0 clicks). Title rewrites alone could reclaim 15-25 clicks/week. High intent, real readers, snippet failure.
- **Biggest waste**: 1,517 impressions across 4 "upwork login" navigational variants. Google has indexed our hiring posts for branded login intent. Zero conversion possible. Add `noindex` or rewrite titles to break the match.
- **Biggest surprise**: `/services/` is invisible. "react development company" (104 impr / 0 clicks) lands on a 2025 listicle (`discover-top-react-development-companies-of`), not `/services/app-web-development/`. The service page never appears for service-intent queries because its title says "Optimize & Empower Products At Any Stage."

---

## 2. Diagnosis table

| Query | Impr | Matching post | Current title | Why 0 CTR |
|---|---|---|---|---|
| upwork login | 998 | `why-it-hard-find-great-developer-on-upwork-other-freelance-platforms-senior` + 19 others | "Why Hiring Senior Developers on Freelance Platforms Fails" | Wrong intent. User wants the Upwork.com login screen. Our title cannot win this click. |
| activemodel::attributes type_for_attribute method | 220 | `new-in-rails-72-active-model-got-typeforattribute-changelog` | "New in Rails 7.2: Active Model Got type_for_attribute" | Reads like changelog gossip. Doesn't promise the API answer the dev is searching for. Meta is truncated mid-sentence. |
| activemodel::attributes type_for_attribute instance method | 115 | same as above | same | same problem - "instance method" qualifier shows the dev wants reference docs, not changelog news |
| crewai hierarchical multi-agent... | 114 | `crewai-multi-agent-systems-orchestration` | "CrewAI Multi-Agent Systems: Orchestrating Specialized AI Teams for Complex Tasks" | Title is 86 chars (truncated in SERP). Doesn't say "hierarchical" or "manager-worker" - exact words searched. |
| langgraph open source alternatives crewai autogen comparison 2025 | 113 | `autogen-crewai-langgraph-ai-agent-frameworks-2025` | "AutoGen vs CrewAI vs LangGraph: AI Framework Comparison 2025" | Title is fine (60 chars). Meta says "Save 40+ hours" - too marketing. Searcher wants "open source alternatives" framing. |
| react development company | 104 | `discover-top-react-development-companies-of` (blog) | "Discover the Top React Development Companies of 2025..." | Wrong page. Service intent. We rank a blog listicle, not `/services/`. `/services/_index.md` title doesn't contain "react" or "development company" anywhere. |
| laravel vs datadog | 96 | `laravel-performance-monitoring-complete-apm-comparison-guide` | "Laravel Performance Monitoring: Complete APM Comparison Guide" | Title is generic comparison. Doesn't surface "Datadog" (the second word the user typed). Snippet shows generic APM intro. |

---

## 3. Top 5 title/meta rewrites

| Query | Proposed title | Proposed meta | Win condition |
|---|---|---|---|
| `type_for_attribute` (335 impr combined) | `type_for_attribute in Rails 7.2 Active Model: API Reference` (60 chars) | `Rails 7.2 added type_for_attribute to Active Model. See the method signature, return type, and a working example for both Active Record and Active Model.` (155 chars) | 3% CTR = 10 clicks/week. Dev searchers click reference titles. |
| `crewai hierarchical multi-agent` (114) | `CrewAI Hierarchical Agents: Manager-Worker Orchestration` (56 chars) | `Build hierarchical CrewAI crews with a manager agent delegating to specialized workers. Code examples for orchestration, task routing, and v0.98+ patterns.` (158 chars) | 4% CTR = 5 clicks/week. Long-tail buyers convert. |
| `langgraph open source alternatives` (113) | `LangGraph vs CrewAI vs AutoGen: Open Source Alternatives 2025` (60 chars) | `Three open source agent frameworks compared: LangGraph state machines, CrewAI role-based crews, AutoGen conversations. License, deployment, and 2025 maturity.` (159 chars) | 4% CTR = 5 clicks/week. |
| `react development company` (104) | (Move ranking to /services/ - see section 5) | - | 5% CTR on /services/ = 5 clicks/week + lead intent |
| `laravel vs datadog` (96) | `Laravel + Datadog APM: Setup, Cost, and 3 Alternatives` (54 chars) | `Datadog APM for Laravel: instrumentation steps, monthly cost at scale, and how it compares with New Relic, Scout, and Blackfire on real benchmarks.` (152 chars) | 3% CTR = 3 clicks/week. |

Combined: ~28 clicks/week from rewrites alone (4x current total).

---

## 4. Junk query plan - "upwork login" cluster

**Diagnosis**: 20 hiring/freelance posts mention "Upwork" in passing. Google indexes 5+ of them for "upwork login" because the keyword appears alongside "platform" copy. Users clicking would bounce in 2 seconds - we can't serve login intent.

**Action (P1, 1 hour)**: For the 5 highest-impression Upwork posts, find/replace `Upwork login` and standalone `login` references in body copy. Where context allows, rephrase to `Upwork account` or remove entirely. This breaks the keyword match without altering the post's hiring-advice value.

**Do not** add `noindex` - the posts rank for legitimate hiring queries we want. Do not redirect - they are the canonical pages.

**Confirm in 14 days**: re-check GSC. If "upwork login" impressions drop >70% and other Upwork queries hold steady, the rephrase worked.

---

## 4b. Root-domain page analysis

**Homepage `/` (`content/_index.md`)**
- Title: "Startup MVP Development & Product Teams | JetThoughts"
- Meta: "Startup MVP development teams with 95% client retention..."
- **Captured**: brand query `jetthoughts` (2/3, 67% CTR - working)
- **Missed**: "ruby on rails development", "rails development services", "react development company" all 0 impressions for `/`. Homepage never enters consideration set for stack-specific queries.
- **Fix (P2)**: add an H2 + paragraph block targeting "Ruby on Rails development services" and "React development company" with a link to `/services/app-web-development/`. Homepage is too brand-focused.

**Services `/services/` (`content/services/_index.md`)**
- Title: `Optimize & Empower Products At Any Stage`
- Meta: "Transform your technology with expert engineering leadership..."
- **Captured**: nothing in this dataset
- **The problem**: title and H1 contain zero stack/service keywords. "react development company" (104 impr) does not match. Neither does "ruby on rails development" or "hire developers."
- **Fix (P0)**: rewrite frontmatter:
  - title: `Ruby on Rails & React Development Services | JetThoughts`
  - description: `Ruby on Rails and React development services for funded startups. 8-12 week MVPs, fractional CTOs, 95% client retention. Test-driven, transparent reporting.`
- **Net-new pages** (P2, 2 weeks out): Hugo permalink supports `/services/rails-development-services/` and `/services/react-development-services/` - we already have 14 service subpages. Add two stack-targeted pages and link from `/services/_index.md`.

**Other pages**: no signal in this 7-day window for `/about/`, `/careers/`, `/clients/`. Not blocking.

---

## 5. Service page funnel

The query `react development company` is service intent, but our blog listicle (`discover-top-react-development-companies-of`) outranks `/services/`. Three moves:

1. **Edit the listicle** to make it the funnel: section 1 = "JetThoughts" with internal link to `/services/app-web-development/`, anchor text "React development services". This converts the existing ranking instead of fighting it.
2. **Rewrite `/services/` title** (see 4b) so it competes for stack keywords.
3. **Add a CTA block** in the listicle: "Talking to React shops? Skip the search - book a 30-min architecture call" linking to /contact/.

Same pattern for "react development company" applies to "ruby on rails development company" (likely 50+ impr we're missing entirely).

---

## 6. Revised next-3-actions (ranked by impact/effort)

1. **`/services/_index.md` frontmatter rewrite** - 15 minutes, P0. Captures all stack-intent queries. Highest leverage in the entire review.
2. **`type_for_attribute` post title + meta rewrite** - 10 minutes, P0. 335 impr / 0 click is pure snippet failure. Easiest win.
3. **Upwork query rephrase across 5 posts** - 60 minutes, P1. Stops wasting impressions; cleans up our index quality signal.

Defer: net-new service pages (Rails/React) until #1-#3 ship and we measure GSC delta May 13.

---

## 7. What stays vs. what changes (vs. content plan 20.07)

**Stays**:
- 21-post rotation (Founders / Rails / AI). All current GSC pain is on existing posts, not on the planned content.
- Vibe coding angle weave.
- Post #8 (Quality Tax) and #11 (AI Code Ownership) - high ICP-E fit, no conflict.

**Changes**:
- **Insert "GSC Hotfix Week" before post #8** (May 6): 3 actions above. Two hours of work, ships before the next planned post. Update content plan with a "GSC Maintenance" stream entry dated 2026-05-01.
- **Reorder**: don't move the May 7 GSC validation reminder - keep it. Add: "On May 13, re-pull GSC and verify the three rewrites moved CTR above 1%."
- **Cut nothing**. The plan is sound; the existing site's snippet hygiene is the gap.

