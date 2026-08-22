---
name: blog-write
description: >
  Actually WRITE and ship a blog post - draft, critics, gates, commit, PR. This
  is the delivery half of the pipeline; blog-next decides WHAT to write and this
  writes it. Use whenever the user asks to write, draft, publish, ship or add a
  blog post; when they hand over a topic and expect a post out the other end;
  when they point at an approved row in the content plan; and when they ask to
  UPGRADE or refresh an existing post rather than write a new one. Also use when
  a /blog-next run ended in a WRITE or UPGRADE verdict and nothing has been
  drafted yet.
  NOT for choosing the topic (use blog-next), LinkedIn posts (linkedin-post-jt),
  course chapters, or landing pages (page-cro, landing-page-optimization).
---

# Blog: write it and ship it

**You produce a published post.** Not a plan, not a recommendation. If you finish
without a committed post or a named blocker, the run failed.

`blog-next` owns "what and whether." You own everything after that.

| Stage | Owner |
|---|---|
| Topic, research, gated outline | `blog-next` |
| **Draft → critics → gates → commit → PR** | **this skill** |

**Read before starting; this skill deliberately does not copy them, so a
correction lands in one place:**

- `docs/workflows/blog-pipeline.md` - **canonical from STEP 4 onward.** Follow it
  step by step. Every blocking gate is defined there.
- `docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md` - voice.
- `docs/90-99-content-strategy/strategy-analysis/90.10-icp-primary-website-target.md` - the reader.
- `.okf/content/claims-canon.md` - what you are allowed to say. A number with no
  in-repo source is a defect, not a detail, and so is a mechanism.

## The claim rule that catches the errors gates cannot

Fetch the source before you assert how something works. Not after, and not from
memory - training memory returns a confident sentence whether or not it is true,
which is the failure it cannot warn you about.

Reach for the instrument that matches the claim: **`context7`** for how a
library behaves (it reads the project's own docs and names real classes and
methods), **`WebSearch` then `WebFetch` the primary source** for a study or
statistic - press coverage of a study is not the study - and **NotebookLM** when
you need to interrogate a body of sources. `blog-pipeline.md` STEP 4f has the
full routing.

**Search for the rebuttal, not the confirmation.** Query for criticism and
failed replications of what you are about to assert. Searching for support
returns support; that is what it is for.

**This applies hardest when you are EDITING.** Deleting a bad claim and writing
a replacement feels like cleanup, so the replacement gets less scrutiny than
anything you write from scratch - and it is a fresh assertion carrying the same
burden. Claims-canon records the case: the same author wrote the same Propshaft
sentence twice on one day, wrong when it was framed as a fix, right when it was
framed as writing, because only the second one triggered "go read the README".

The mechanical gates cannot help you here. A ratchet counts invented SHAPES; a
wrong explanation has no shape. If a sentence says how something behaves and you
did not open its documentation in this session, either open it or soften the
sentence until it stops being a claim.

## What you need before drafting

A topic row with an angle, the research digest, and a gated outline. If you have
all three, start at STEP 4.

**If you don't, get them - do not draft anyway.** Run `blog-next` first and come
back with its output. A post drafted without the premise audit is how a decayed
row or a dedup collision reaches a draft, which is the exact failure the split
exists to prevent.

**If the user handed you a topic directly**, that is not a licence to skip the
audit - it is the case where the audit matters most, because nobody has checked
it against the corpus yet. Run `blog-next`'s Stage A on it, then continue here.

## New post or upgrade

Both are this skill's job, and the choice is `blog-next`'s verdict, not yours.

- **WRITE** - a new post at `content/blog/<slug>/index.md`.
- **UPGRADE** - edit the existing post in place. Do NOT create a second post on
  the same topic; that is the cannibalisation the verdict exists to prevent.
  Keep the URL, keep what still holds, and rewrite what the new material
  changes. An upgrade that only appends a section has usually missed the point -
  if the thesis moved, the shape moves with it.

## Running the pipeline

Follow `blog-pipeline.md` STEP 4 → STEP 7. It carries the cadence quotas, the
BAD/GOOD pairs, the two-pass writing rule, and the gate definitions. Do not
paraphrase it from memory - open it.

The gates that most often get skipped, named here so they are not:

- **STEP 4e self-critique** (`reflexion-reflect`) before the critic panel.
- **STEP 4f claim sourcing** - name the URL you opened for every claim about how
  an external thing behaves. No gate covers this one.
- **STEP 5a anti-AI pass** before the review loop, not after.
- **STEP 5b slop gate: `slop >= 8/10`.** This is the blog scale, 0-10, higher is
  better. The course's `Slop <= 25` is a different scale in the other direction -
  never mix them.
- **STEP 5c cold-eyes gate** runs LAST, by a reviewer that did not write the draft.
- **STEP 6b pre-publish checklist**, then **STEP 7 validate**.

**Author ≠ verifier is the point of the panel.** Spawn a different agent type for
each critic role. If agent spawning is unavailable in this session, run the gates
inline against the written criteria and **say plainly in the handback that no
independent verifier ran** - a self-reviewed draft that claims a passed 4-eyes
gate is worse than one that admits it had none.

## Gates before commit

Content-only diff (markdown prose and frontmatter, no template/CSS/body HTML):
`bin/hugo-build` plus the rendered scroll gate. The visual suites do not apply.

The moment the diff touches a template, stylesheet or body HTML, the full visual
gate applies - `bin/qtest --changed` before the commit. Check the actual diff,
not what you intended to change.

New media gets the visual gate in `blog-pipeline.md`: 1280x800 and 390x844, four
criteria scored, and the scores written into the commit message.

## Ship

Feature branch, commit, `gh pr create` with the evidence. Never push to master.

**Do NOT wait for CI on a content-only PR** (Paul 2026-08-22). Prose and
frontmatter cannot move the app build, so local gates decide and you merge as
soon as they are green.

One thing does not come free: `content/**` triggers the link checker, and
internal links are exactly what a post adds. Run **`bin/rake test:links`**
locally in place of the wait. If you skip it, say so in the handback - the
master push-run still crawls, so a broken link becomes a fix-forward defect
rather than a caught one.

**End the handback with the local review link** - `http://localhost:<port>/blog/<slug>/`.
One dev server per session, never 1313:

```
PORT=$((20000 + RANDOM % 20000)) bin/dev
```

## Three exits, and only three

- **SHIPPED** - committed, PR open, gate verdicts quoted with their numbers.
- **BLOCKED on a named decision** - one of: whether a claimed client engagement or
  number is real, publishing outward, overriding a documented gate,
  pricing/naming/internal numbers, a split-and-irreversible call. Name which one,
  and take the conservative option meanwhile where one exists.
- **FAILED the gates twice** - stop, hand back the draft with both critic reports
  and what you changed between rounds. Do not iterate a third time silently; two
  failed rounds on the same draft usually means the outline was wrong, which is
  `blog-next`'s problem and not something more prose will fix.

**HOLD is not an exit here.** By the time work reaches this skill the decision to
write has already been made and audited. If you find a reason the post should not
exist, that is a falsified premise - say so explicitly and hand it back to
`blog-next` rather than quietly producing nothing.
