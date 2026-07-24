# Browser-Agent Prompt — Pre-Validated Send Run

> Copy-paste this whole prompt into a browser agent running in Paul's logged-in browser (Comet, or Claude-in-Chrome). For Comet, paste the current `SEND-SHEET.md` content directly below the prompt; Claude-in-Chrome can read the file from the repo.
> The agent researches first, then STOPS for Paul's approval, and sends nothing without it.

---

You are operating Paul Keen's logged-in browser to run a small, personal outreach batch from a send sheet. You send NOTHING without explicit per-message approval from Paul. Work one phase at a time.

## Phase 1 — Pre-research every prospect (no sending)

For each message in the send sheet:

1. **Open the source link.** Confirm the post still exists, the author handle matches the sheet, and the quoted line in our message is still present (post not edited or deleted). Dead/edited post = HOLD.
2. **Read the newest replies + the author's recent activity.** HOLD if: they say the problem is fixed or they hired someone; the product is dead; someone already pitched a similar audit offer in the thread; or Paul has already replied anywhere in the thread.
3. **Verify the personalization facts.** Identify their product/company name and the actual AI tool or dev-shop named in the post. If our message names the wrong tool (says Lovable, post says Bolt), flag it with a suggested one-word correction — do not silently rewrite the message.
4. **Message 5 (Joy Adamson) special routing:** the link is Nico Casavecchia's post — Joy's quote is her COMMENT on it. Find her comment, open her profile, confirm the account is active and DM-able. Her message goes as a LinkedIn DM from her profile, never as a comment on Nico's post.

Output one table:

| # | handle | GO / HOLD | evidence (1 line, with what you saw) | copy correction needed |

## Phase 2 — Approval gate (HARD STOP)

Show the table and the final copy of each GO message. Then stop and wait for Paul's explicit approval ("approve all" or "approve 1, 2, 4"). If any correction was flagged, show the corrected copy for that message and get it approved as corrected. Do not proceed on silence.

## Phase 3 — Send approved messages only

- Messages 1-4 (IndieHackers): **public reply on THEIR post** — not a DM.
- Message 5 (LinkedIn): **DM via Joy's profile**.
- Follow the sheet's day split and stagger (max 2 IH sends/day, 2-3 hours apart). Send one at a time; after each send, confirm it posted and copy the permalink.

## Phase 4 — Log

For every send, output a filled `pipeline.md` row: `opener # · handle · channel · action · sent date · permalink`. If you can write files (Claude-in-Chrome + repo session), append the rows to `docs/projects/2607-vibe-code-rescue/rescue-sprint/pipeline.md`; otherwise output them for Paul to paste.

Report anything unusual (login walls, spam warnings, UI blockers) instead of working around it.
