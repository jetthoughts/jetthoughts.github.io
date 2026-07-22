> DRAFT (T8 output) - 2026-07-22. Internal sales tool for the free Rescue Audit. Pending Paul's review. Objection pre-empts live in T9, not here.

# Discovery Kit — Free Rescue Audit

The free Rescue Audit is now an **async, AI-intensive technical due diligence**, not a live 45-minute code review. The 45-minute call is a **context and access session** — Paul meets the founder, maps the business pain, and secures read-only access to the artifacts we need. After the call, our team runs the audit offline and delivers a one-page verdict within 48 hours.

- For the call script, see [`45-minute-session-playbook.md`](45-minute-session-playbook.md).
- Two things still ground every question: the [Four Forces](customer-profile-four-forces.md), and the [D3 intake](assumptions-register.md).

---

## The new audit funnel

1. **Founder books** a 45-minute Rescue Context Call.
2. **Pre-call email** sets expectations and lists the access they need to prepare.
3. **45-minute Context Call** — Paul maps pain, confirms access, and schedules the follow-up.
4. **Async AI-intensive due diligence** — senior engineer + AI prompts review code, task board, and dev chats.
5. **One-page scorecard** delivered within 48 hours (Code health, Workflow health, Salvage vs. Rebuild verdict, Next step).
6. **30-minute Proposal Call** — Paul walks the founder through the findings and a fixed-price rescue plan.

---

## Why async beats live code review

A 45-minute screen share is not enough to understand a broken MVP. The real value comes from:
- **Depth**: tracing commit history, dependency trees, test coverage, and architectural patterns.
- **Context**: reading task boards and chat history reveals what the team promised vs. delivered.
- **Comfort**: the founder does not need to watch someone poke at their code in real time.
- **Honesty**: an offline audit lets us validate assumptions before naming a verdict.

The 45-minute call exists because a founder who got burned still needs to trust the person giving them the answer. Paul is that trust layer. The call is for context and access; the audit is for the technical truth.

---

## Async due diligence scope

The audit team reviews three artifact types. All access is read-only; see the data-handling contract below.

| Artifact | What we look for | Why it matters |
|---|---|---|
| **Code repository** (GitHub/GitLab) | Architecture, dependencies, test coverage, security, ownership, recent commits, branching hygiene | Tells us what is solid, what is fragile, and what is salvageable. |
| **Task / issue tracker** (Jira/Linear/Trello/GitHub Issues) | Backlog hygiene, ticket quality, estimation accuracy, scope creep, missing deliverables | Reveals process problems that code alone cannot. |
| **Dev communication** (Slack/Teams/Discord) | Communication patterns, escalations, blockers, undocumented decisions | Surfaces the human/team dynamics behind the breakage. |

### AI-assisted analysis prompts (engineer use only)

Use these as starting points for the AI-assisted review. The senior engineer validates every AI output by hand before it goes into the scorecard.

1. **Code archaeology**: "Summarize the tech stack, dependency versions, test coverage, and top 5 architectural risk areas in this repo."
2. **Security sweep**: "Identify exposed secrets, missing auth checks, SQL injection risks, and any PII handling issues."
3. **Commit history**: "Map the last 8 weeks of commits to the task board. Highlight rework, hotfixes, and untested changes."
4. **Task board health**: "Summarize open vs. closed tickets, average age, missing acceptance criteria, and recurring blockers."
5. **Chat sentiment**: "Extract the top 5 recurring problems, blockers, or escalations from this channel export."
6. **Salvage estimate**: "Estimate what percentage of the codebase is worth keeping and what parts need rebuilding."

---

## 45-minute session quick reference

| Time | Segment |
|---|---|
| 0-5 | Warm open + frame: this is context, not live code review |
| 5-20 | Situation + pain: what broke, what it costs, who built it |
| 20-35 | Access + workflow mapping: code, task board, chats, timeline |
| 35-40 | Salvage vs. reset framing |
| 40-45 | Next steps: 48-hour scorecard + 30-minute proposal call |

See the full script, suggested questions, and objection handling in [`45-minute-session-playbook.md`](45-minute-session-playbook.md).

---

## Data handling and access safety

The Rescue Audit is **read-only** by default. We look at your repo, task board, and chat history to understand the situation. We do not copy source code, secrets, customer data, or credentials into the write-up unless you explicitly ask us to — and then only the minimum necessary.

- **Read-only access**: We ask for read-only access to the repo, task board, and sanitized/non-production environment where possible. You keep ownership of every account at all times.
- **NDA**: We sign a mutual NDA before accessing sensitive artifacts.
- **No secret sharing**: Do not share production API keys, passwords, or customer databases with us. If we need to inspect a live issue, we guide you through it rather than handle credentials ourselves.
- **No customer data in the report**: The audit write-up contains only plain-English findings and recommendations. We do not paste user records, logs with PII, or internal credentials.
- **Revoke when done**: We expect you to remove our read access as soon as the audit is complete. We keep our working notes only long enough to finish the report, then delete them.
- **Retention**: Any screenshots or local notes we make are deleted within 30 days unless you explicitly ask us to keep them longer.

---

## One-page Rescue Audit — deliverable template

Paul fills this in after the async audit is complete and sends it as the promised write-up. Plain English, one page, no jargon the founder has to look up. Each row gets a Red, Amber, or Green and one sentence a non-technical founder can act on.

**Prepared for:** [Founder name] / [Company] - [date]
**Reviewed by:** [Senior engineer] with Paul Keen, fractional CTO

### Scorecard

| What we checked | In plain English | Rating | The one line that matters |
|---|---|---|---|
| Ownership | Do you hold the code and the servers, or does someone else? | 🔴/🟡/🟢 | [e.g. "The code is in your developer's GitHub, not yours - you can't move it without them today."] |
| Security | Can one user reach another user's data? Are passwords and keys exposed? | 🔴/🟡/🟢 | [e.g. "Any logged-in user can open another customer's account by changing the number in the web address."] |
| Automated testing | Does anything catch breakage before your users do? | 🔴/🟡/🟢 | [e.g. "Almost nothing is tested, so a change in one place quietly breaks another - which is what you've been living."] |
| Workflow health | Do tickets, sprints, and team communication match what the product actually needs? | 🔴/🟡/🟢 | [e.g. "Tickets are vague, sprints are missed, and the chat shows recurring blockers that never reach the founder."] |
| Salvageable | How much of what you paid for is worth keeping? | ~[N]% | [e.g. "Roughly 40% is solid. The login, payments, and data layer need replacing."] |
| What breaks next | If nothing changes, what's the most likely next failure? | 🔴/🟡/🟢 | [e.g. "The database has no backups - one bad deploy could wipe your customer data with no way back."] |

### The honest call

> **Verdict: [ Salvage / Fix the broken parts / Rebuild from scratch ]**
>
> [Two or three plain sentences. Name the choice and why. Example: "Keep it. About half of what you have is worth building on, and the broken half - login, payments, and the way data is stored - can be rebuilt on a solid foundation in 4 to 8 weeks. Starting over would cost you more and buy you nothing you don't already have."]
>
> [If rebuild: say so plainly, even though salvage is the easier sale for us. Example: "Rebuild the core. The foundation can't carry the product you're describing, and every fix on top of it will cost more than it saves. You'd keep your design and your data - not the code underneath."]

### Recommended next step

[One clear action. Usually one of:]
- "Get read access to your GitHub and AWS accounts first - here are the exact steps. You should hold these no matter what you decide."
- "If you want us to handle the fix, the next step is a 30-minute proposal call and a fixed-price rescue plan - no surprise number."
- "If you'd rather your current team fix it, take this scorecard to them and ask for a plan against these six points. You'll know fast whether they can."

---

## Cold-eyes (self-refute)

**The strongest case that this new process backfires:** A founder who just got burned may see the access request as invasive, and the shift from "live code review" to "we will get back to you" may feel like a bait-and-switch.

**Does it survive?** Yes, if the call is framed correctly. The 45-minute session playbook opens with a clear expectation reset: the call is for context and access, not live review. The NDA and read-only language come before any access request. The founder receives a concrete deliverable with a deadline (48 hours) and a concrete next step (proposal call). The audit is more thorough because it is offline, not less.

**What I changed off the back of this:**
- Split the old 45-minute agenda into a dedicated context-call playbook.
- Made the async audit explicit in the offer, booking page, and confirmation email.
- Added task board and dev chat review to the audit scope.
- Replaced the live-code-review promise with a 48-hour scorecard promise.

**Verdict: PASS.** The async model gives the founder a more honest answer while still giving Paul the human trust moment the sale needs.
