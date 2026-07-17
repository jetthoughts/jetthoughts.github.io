# Bundle Update Log

## 2026-07-13
* **Update**: taste anchor established at `.stitch/course-taste-design.md` - Stitch-skill DESIGN.md encoding the course design language + anti-pattern bans; used as the scoring lens for taste-critic passes (see [review-swarm](/workflows/review-swarm.md)).
* **Update**: [render-verification](/workflows/render-verification.md) - render from `_dest/public-dev/` (relative URLs), never the stale repo-root `public/`; stale-tree reviews produce false missing-asset findings.
* **Initialization**: Created the bundle with build/, content/, design/, and workflows/ sections distilled from CLAUDE.md, docs/workflows/, .stitch/design.md, and the 2026-07 course review sprints.

## 2026-07-17 - M2 compression migration
Module 2 (last unmigrated module, 1,652-5,124 body words/lesson) compressed to
exemplar parity (1,265-2,038; migrated 1.4 exemplar = 1,258 on the same basis).
Depth moved to four new reference companions: mom-test-full,
persona-rehearsal-full, find-10-people-full (shared 2.3+2.4),
prototype-build-full. Operative rule learned: the 30.03 numeric bands are
unreachable when mandated keeps (full prompts, teaching tables, reuse bridges)
exceed the band - EXEMPLAR PARITY on an identical measurement basis is the
real gate, not the raw number. M3 (3.1/3.2 at ~2,900w) is the remaining
unmigrated pair.

## 2026-07-17 (later) - Full-course migration complete
M3 (3.1/3.2), M4 (all five), and M5 (5.1/5.2/5.6/5.7) migrated to v2
micro-lesson form in one 5-fixer wave; 11 new reference companions created
(every module now has its deep-dive set). Canon punch-list applied (Cursor
seat range, "Sixty percent" stat, PR #847 collision, fast/easy/free columns,
Chapter 0 -> Overview, faq 12-rules pointer). Cold-eyes M3+ reuse review
fixed 4 restart defects (5.3 warm-list seeding, SOW brief-as-scope, 5.1
persona reconciliation, PRD Section 2). No v1 long-form lessons remain.
Gotcha: claude-flow daemons recreate .git/index.lock continuously - commit
via retry loop (rm lock + immediate git add/commit, up to 10 attempts).
