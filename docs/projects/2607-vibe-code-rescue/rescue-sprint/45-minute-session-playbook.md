> DRAFT - 2026-07-22. Playbook for the 45-minute Rescue Context Call. Pending Paul's review.

# 45-Minute Session Playbook — Rescue Context Call

**At a glance:** 45-minute founder call → collect read-only access to code, task board, and dev chats → 48-hour AI-assisted Rescue Audit → 30-minute proposal call.

The technical audit is now run **offline, after the call**. We use AI-assisted prompts and senior-engineer review to run intensive due diligence on the founder's code, task board, and developer chats. The 45-minute session is not the audit itself — it is the **strategic context, access, and trust call** that makes the async audit possible.

**Purpose of this call:**
1. Make the founder feel heard and understood.
2. Map the business pain, urgency, and decision constraints.
3. Secure read-only access to the artifacts we need to audit (code, task board, chats).
4. Set clear expectations: a written verdict lands in ~48 hours, then a 30-minute proposal call follows.

---

## Pre-call prep (Paul or assistant sends after booking)

Send a short email immediately after booking:

> Subject: Your Free Rescue Audit — what to prepare
>
> Hi [Name],
>
> Looking forward to our 45-minute context call. Here is what happens:
> - We use the call to understand the business pain and collect read-only access to your code, task board, and dev chats.
> - After the call, our team runs an intensive AI-assisted technical due diligence offline.
> - Within 48 hours you receive a one-page, plain-English scorecard: what's solid, what's fragile, and whether to salvage or rebuild.
> - We then book a 30-minute proposal call to walk through the findings and a fixed-price rescue plan.
>
> Please have handy:
> - A link to your app / website.
> - Admin access to your code repo (GitHub/GitLab) and hosting account (AWS/Vercel/etc.).
> - Access to your task board (Jira/Linear/Trello) and dev chat (Slack/Teams).
>
> We will send a mutual NDA before we look at anything sensitive.
>
> — Paul

---

## 45-minute agenda

| Time | Segment | Goal |
|---|---|---|
| 0-5 | Warm open + frame | Set expectations: this call is context, not live code review. |
| 5-20 | Situation + pain | Understand what broke, what it costs, who built it, and why now. |
| 20-35 | Access + workflow mapping | Collect read-only access to code, task board, and chats. Map the dev workflow. |
| 35-40 | Salvage vs. reset framing | Pre-empt rebuild fear; explain how the async audit will identify what is worth keeping. |
| 40-45 | Next steps + proposal call booking | Confirm access, 48-hour deliverable, schedule follow-up. |

---

## The call, segment by segment

### 0-5 — Warm open and frame

The founder may expect a live demo or technical review. Reset the frame in the first minute.

**Suggested way in:**

> "Before we start, I want to set expectations. This call is about understanding your business and getting access to the right artifacts so my team can run a deep, AI-assisted audit *after* we hang up. We will not solve code problems live — that is what the next 48 hours are for. You will get a plain-English scorecard, then we will book 30 minutes to walk through what to do next."

**Key questions:**
- "What made this the week you looked for outside help?"
- "How did you find us — referral, LinkedIn, or searching for a rescue team?"

### 5-20 — Situation and pain (SPIN)

Get the founder to tell the story in their own words. Listen for Push and Anxiety forces.

**Suggested way in:**

> "Walk me through what happened. When did the app stop feeling like it was heading in the right direction?"

**Key questions:**
- "What is breaking right now, and how do you know?"
- "When it broke in front of a real user or stakeholder, what happened next?"
- "Who else is watching this land — investors, customers, cofounders?"
- "If nothing changes, where are you in three months?"
- "Do you actually trust what your current team is telling you about progress?"

### 20-35 — Access and workflow mapping

This is the operational core of the call. You need enough access to run a complete due diligence.

**Suggested way in:**

> "To give you an honest verdict, we need to look at three things: the code itself, how work is tracked, and how the team communicates. I will send you a mutual NDA before anyone opens anything. We only ever need read-only access."

**Collect access to:**
1. **Code repository** (GitHub/GitLab/Bitbucket) — read-only.
2. **Hosting / deployment accounts** (AWS, Vercel, Heroku, etc.) — read-only or sanitized view.
3. **Task / issue tracker** (Jira, Linear, Trello, GitHub Issues) — read-only.
4. **Developer communication** (Slack, Teams, Discord) — read-only export or limited channel access.

**Key questions:**
- "Who built this — dev shop, freelancer, AI tool, or in-house team?"
- "Where does the code live, and do you have admin rights to add a read-only user?"
- "Where does the app run? Is the AWS/hosting account in your name or the developer's?"
- "Where is the work tracked? Jira, Linear, GitHub Issues, a Trello board?"
- "Where does the team chat? Slack, Teams, Discord? Can you add a read-only export?"
- "What is the real deadline — a launch, a raise, a customer renewal?"

If the founder cannot grant access during the call, name the exact next step and who will do it.

### 35-40 — Salvage vs. reset framing

The founder is likely bracing for "throw it all away." Defuse that fear.

**Suggested way in:**

> "Most founders assume the answer is 'start over.' In our rescues, we usually keep 30-50% of the existing code. The audit will tell us exactly which half is load-bearing and which half is cardboard."

**Key questions:**
- "If the honest answer turned out to be 'this is salvageable,' would you believe it?"
- "What is the one part of the product you absolutely cannot afford to rebuild from scratch?"

### 40-45 — Next steps and proposal-call booking

Close with clarity, not pressure.

**Say this:**

> "Here is what happens next:
> 1. You grant read-only access and we sign the NDA.
> 2. Our team runs the AI-assisted audit over the next 48 hours.
> 3. You receive a one-page scorecard: code health, workflow health, salvage vs. rebuild verdict, and recommended next step.
> 4. We book a 30-minute call to review the findings and, if it makes sense, a fixed-price rescue proposal."
>
> "The scorecard is yours whether or not we work together. The goal is that you finally know where you stand."

---

## Access checklist (post-call)

Use this checklist to confirm you have everything needed before starting the async audit.

- [ ] Mutual NDA signed.
- [ ] Read-only access granted to code repo.
- [ ] Read-only or sanitized access granted to hosting/deployment account.
- [ ] Read-only access granted to task / issue tracker.
- [ ] Read-only export or channel access granted to dev chat.
- [ ] Founder confirmed the deadline, budget stage, and decision-making timeline.
- [ ] Follow-up proposal call scheduled.

---

## Objection handling

**"Why can't you just look at the code now on the call?"**
> "We could, but a real audit takes focused, offline time. We use AI-assisted analysis to trace how the code, task board, and team communication line up. Doing it offline gives you a much more honest answer than a 45-minute screen share."

**"I don't want you reading our Slack."**
> "We only look at developer workflow and ticket history — not business secrets. We sign a mutual NDA, we take read-only exports, and we purge everything within 30 days. If a channel is sensitive, just exclude it and tell us which ones cover the build process."

**"How do I know this isn't just a sales pitch?"**
> "The scorecard is yours whether or not you hire us. If the answer is 'stay where you are,' we will tell you. We only win if the audit is honest, because our rescue starts with trust."

---

## Cold-eyes (self-refute)

**Risk:** A founder who just got burned may see the access request as invasive, and the lack of live technical answers as a bait-and-switch.

**Mitigation:**
- Frame the call clearly in the booking confirmation email so no one expects live code review.
- Lead with the NDA and read-only language before asking for access.
- Keep the SPIN/pain segment first; do not let the call feel like a vendor qualification form.
- Promise a concrete deliverable with a deadline (48 hours) and a concrete next step (proposal call).

**Verdict: PASS.** The call earns trust, secures access, and sets up the async audit to produce a defensible verdict.
