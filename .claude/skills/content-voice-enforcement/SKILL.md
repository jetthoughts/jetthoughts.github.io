# Content Voice Enforcement Skill
#
# Reusable voice enforcement for JetThoughts content — blog posts, LinkedIn,
# and marketing copy targeting the ICP-E audience (non-technical founder
# burned by a devshop).

## Overview
Enforces the JetThoughts voice guide, banned word list, structural patterns,
cadence quotas, and quality tests on all content.

## Voice Guide
See .apm/instructions/voice-guide.instructions.md for the full compiled extract.
Canonical source: docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md

## Two Voices
- **Founder posts**: Rob Walling directness + Rand Fishkin vulnerability
- **Tech posts**: Thoughtbot style (tension-first, opinionated, code as evidence)

## Quality Tests (run on every paragraph)
- **"Who" test**: who is doing what?
- **"Show" test**: did I show the mechanic or just label it?
- **"Coffee" test**: would a tired founder talk like this at a bar?
- **"90/10" test**: ≥90% educational, ≤10% promotional
- **"Trade-off" test**: acknowledged what the solution fails to do?
- **"Practitioner" test**: replace generalizations with specific incidents

## Slop Detector + Cold-Eyes Gate
- Run slop-detector on all drafts
- Run humanizer pass if flagged
- Cold-eyes gate (9 checks) mandatory before publishing
- See docs/workflows/blog-pipeline.md STEP 5a + STEP 5c

## Full Documentation
.apm/instructions/voice-guide.instructions.md
.apm/instructions/icp-target.instructions.md
docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md
docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md
