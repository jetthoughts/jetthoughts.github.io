---
type: Architecture Decision
title: Operational Dependency Map — How Sam Obtains Every Input
description: Per-lesson map of external accounts, templates, blank sources, wait times, and Plan B paths. Every [BRACKET] placeholder traces to its upstream lesson. Confirms original inputs are only rough idea + Gmail + browser.
resource: docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.06-operational-dependency-map.md
tags: [course, dependencies, operations, templates]
timestamp: 2026-07-18T00:00:00Z
---

# Overview

Maps every lesson's operational prerequisites — what Sam needs, **how
Sam obtains it**, and which upstream lesson produced it. Extends the
[ICP journey SIPOC](/architecture/icp-journey-sipoc.md) with the
operational layer agents need to validate tool ordering and
dependency completeness.

# Original-Inputs Principle

Sam arrives with exactly three things:
1. **Rough idea or instinct** — raw material for the 1.1 hypothesis
2. **Gmail account** — powers Google Drive, Analytics, Sheets, Forms; used for all external signups
3. **Browser** — required for every external service signup

Everything else — Stripe, ad accounts, Lovable, Supabase, GitHub, AWS,
domain — is set up during the course.

# Coverage

- **20 lessons** mapped (core + optional), each with 🔑 accounts, ⏳ wait
  times, 💰 costs, 📝 templates, 📦 outputs, 🆘 Plan B paths
- **12 distinct external services** with exact signup URLs
- **8 wait-time dependencies** with parallel-run mitigations
- **27 Plan B recovery paths** matching "If this fails" sections
- **Cross-lesson parallelism table** — what to start early to unblock
  downstream steps
- **Budget trajectory**: $0 (organic) to $7,280 (LinkedIn B2B maximum);
  $0 path exists at every step
- **Complete dependency chain diagram** tracing every `[BRACKET]`
  placeholder to its upstream source

# Agent validation checklist

- Every `[BRACKET]` placeholder has a documented upstream source
- No lesson requires an account set up in a later lesson
- Original inputs are exactly: rough idea + Gmail + browser
- Every 🔑 setup lists the exact URL
- Deposit math in 5.6 traces to 1.5 price hypothesis (×12, ×10-30%, $500 floor)
- DPA success criteria trace to 2.5 validated problem statement
- Outreach message language traces to 5.1 Q3 verbatim answers

# Citations

[1] `docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.06-operational-dependency-map.md`
[2] `data/course_sequence.yaml`
