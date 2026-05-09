# LinkedIn ICP-E Validation Posts

Drafts for the 2-week LinkedIn ICP validation campaign.

**Plan:** `docs/workflows/linkedin-icp-validation-plan.md`
**Cadence:** 5 posts/week, 10 posts total
**Goal:** Validate whether LinkedIn surfaces non-technical founders with control-loss symptoms (progress mirage, missing access, requirements drift, etc.)

## File naming

`week{N}-{day}-{slug}.md`

## Posting workflow

1. Copy the post body - everything **after** the closing `---` of the YAML frontmatter, not the frontmatter itself - into the LinkedIn composer
2. Append UTM-tagged link if the post references an artifact you host
3. Reply to founder comments within 2 hours, ask one clarifying question before DM
4. Tag every qualified responder with one pain label: `progress`, `access`, `requirements`, `cheap-talent`, `salvage`
5. Update weekly review table in the validation plan every Friday

> The `---` lines fence the YAML metadata used by the post pipeline (week, hypothesis, UTM, status). LinkedIn does not read frontmatter - only the prose below it.
