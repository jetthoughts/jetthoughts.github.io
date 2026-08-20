---
okf_version: "0.2"
---

# JetThoughts Blog & Course — Knowledge Bundle

Curated operational knowledge for the Hugo static site at
`jetthoughts.github.io`, with emphasis on the 2026 course project
(`content/course/tech-for-non-technical-founders-2026/`).

**OKF v0.2 (adopted 2026-08-01).** Concepts MAY carry provenance/trust/lifecycle
frontmatter: `generated: { by: <actor>, at: <iso> }`, `verified: [{ by, at }]`,
`status: draft|stable|deprecated`, `stale_after: <YYYY-MM-DD>`. Actors use
`<producer>/<version>` (agents, e.g. `claude/fable-5`), `human:<id>`, or
`process:<id>` — the `human:` prefix is what raises a concept to the
human-reviewed trust tier. These are OPTIONAL and added honestly by whoever
touches a concept; absence never invalidates it (§11). Legacy concepts still
carrying only `timestamp` remain conformant and migrate as they're edited — do
NOT back-stamp `generated`/`verified` you didn't actually perform.

# Sections

* [Build & Test](build/) - build pipeline, validators, and the blocking test gates
* [Content](content/) - course structure, canonical numbers, and voice rules
* [Design](design/) - mermaid theme, house visual spec, covers, typography
* [Workflows](workflows/) - render-verification recipes, review-swarm patterns, the blog/LinkedIn/CSS pipelines, the visual scroll gate, and the 2607 outbound-sprint machinery
* [Architecture](architecture/) - Hugo site, CSS build pipeline, blog templates, cover images, SEO meta tags
* [Content Strategy](content-strategy/) - ICP profile, voice guide, and the pipeline-first content plan (20.09) governing all founder-facing content

# What belongs in this bundle

Rule, learned the hard way on 2026-07-26 (one concept was relocated twice):

* **`.okf/` holds durable operational knowledge distilled FROM research** - not
  the research itself, and not a copy of a doc that lives elsewhere. A concept
  that is a verbatim copy of a repo doc should be a pointer (see
  [architecture/](architecture/)).
* **Raw external research** belongs in `docs/projects/<project>/10-19-research/`
  (investigation and analysis).
* **Adopted, enforced specs** belong in `docs/projects/<project>/30-39-architecture-design/` -
  a doc that prescribes what creators MUST do goes here even when its origin
  was external research.
* **`log.md` records what changed, not what is true.** If a log entry's detail
  still matters six weeks later, lift it into a concept; the log gets squashed.
