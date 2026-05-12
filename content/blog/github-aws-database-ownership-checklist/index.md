---
title: "6.1 · Who Owns Your GitHub, AWS, and Database?"
description: "If a contractor's email sits on your AWS root account, you do not actually own your company. A 45-minute Friday audit surfaces every hostage credential."
date: 2026-10-14
draft: false
author: "JetThoughts Team"
slug: github-aws-database-ownership-checklist
keywords:
  - aws root account ownership
  - github org ownership founder
  - database password ownership
  - non technical founder ownership audit
  - dev shop hostage situation
tags:
  - founders
  - non-technical-founder
  - course-companion
  - oversight
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "6.1 · Who Owns Your GitHub, AWS, and Database?"
  og_description: "If a contractor's email sits on your AWS root account, you do not actually own your company. A 45-minute Friday audit surfaces every hostage credential."
cover_image_alt: "JetThoughts blog cover showing four labeled boxes - Code, Cloud, Secrets, Domain - with red question marks over three of them and one founder email in green"
canonical_url: "https://jetthoughts.com/blog/github-aws-database-ownership-checklist/"
related_posts: false
---

> **Module 6 · Step 1 (umbrella, before the 6A/6B branch)** · [Tech for Non-Technical Founders 2026](/blog/tech-for-non-technical-founders-2026/) course.
> Input: a build-path decision from Module 5 (self-serve or hire). Output: a 45-minute Day-1 audit confirming you own your code, cloud, and domain before the build starts (or a recovery plan if you don't).

*Ownership*: Who controls the GitHub org, the AWS root account, the domain registrar, and the prod database. A Day-1 audit means you can fire your team Tuesday without losing the codebase Wednesday.

Open the AWS console. Top-right corner. Click your account name. Read the email address on the root user. Whose inbox does that land in tonight?

A health-tech founder we picked up in Q3 2026 had been billing **$23K a month** with the same agency for fourteen months. She had a Delaware C-corp, a Stripe account in her name, and 1,800 paying clinics on her platform. She did not have the AWS root password. The email on the root was the agency owner's personal Gmail. When that founder asked us to do an emergency rescue after a botched migration, our first hour was not technical. It was three back-and-forth emails to the agency owner asking him to please change the root account email and send the new password to a Notion doc he could not see. He took six days.

## The 2026 hostage situation looks different

The agencies that hold founders hostage in 2026 are not the same shops that did it in 2020. The new pattern: AI-augmented contractors who spin up your entire infrastructure during the Cursor or Claude Code session on Day 1 - GitHub org, AWS account, Vercel project, Supabase database, Stripe integration, Sentry, PostHog - and use whatever email was already logged in. Usually their own. The senior dev who set everything up moves to another client in month four. The junior who inherits your project does not know which credentials live where. Six months later, you are paying for accounts that nobody on the current team can administer.

There is a second pattern, even more common: the **cloud-default-account problem**. A contractor opens a fresh AWS account using the company credit card you handed them, then sets the root email to a shared `dev@` mailbox that the agency owns. AWS treats whichever email is on the root as the legal account holder. Your incorporation paperwork is irrelevant if the root email belongs to someone else. [AWS's own root user documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html) is blunt about this: the root user has unrestricted access, and recovering control without the root credentials means filing a support ticket with corporate documents and waiting days.

The financial damage is rarely the headline number on the agency invoice. It is the day production breaks at 9pm and you cannot push a fix because you cannot read the prod database password. It is the week you lose to AWS support recovery while your customers see a maintenance page. It is the $11K legal retainer you pay to escalate when the agency stops answering. None of that hits the budget line that says "engineering."

![Four labeled zones a non-technical founder must own: Code (GitHub org and repos), Cloud (AWS root and billing), Secrets (database credentials and API keys), and Domain (registrar and DNS). Each zone shows the failure mode if a contractor email is on it instead of the founder.](ownership-zones.svg)

## The 12 items, in one sentence each

The full audit lives at the [GitHub / AWS / Database Ownership Checklist](/blog/ownership-checklist/) - 12 items, the exact pass criterion for each, the recovery steps when one fails. Here is the one-line summary of each so you know what you are getting:

**Code (3 items):**

1. **GitHub org owner** is your company email, not the agency's.
2. **Repo collaborators** can be removed by you alone, without permission.
3. **Branch protection on `main`** is enabled and you can override in an emergency.

**Cloud (3 items):**

4. **AWS root account email** sits on a domain you control.
5. **Billing card** is yours and you can download every invoice yourself.
6. **IAM admin user** in your name with MFA on, separate from root.

**Secrets and database (3 items):**

7. **Production DB credentials** readable by you tonight without paging an engineer.
8. **Secrets store** (Secrets Manager, Vault, Doppler) administered by you.
9. **Database backups** running nightly with a restore runbook you can execute.

**Domain and external services (3 items):**

10. **Domain registrar** WHOIS shows your name and your renewal email.
11. **DNS provider** logged in under your account with MFA, ready to add an A record now.
12. **Third-party API keys** (Stripe, SendGrid, Twilio, OpenAI, Plaid) on your account, your card.

Three of those are bigger than the rest. The AWS root email is the one that controls whether the agency can lock you out in ten minutes. The production database credentials are the one that determines whether you can rotate access tonight if a developer rage-quits. The domain registrar is the one that turns into a 14-day ICANN-mandated wait if the agency will not release the auth code. The other nine are also important. Those three are existential.

## What good looks like vs what bad looks like

The pattern is the same on every item: an email on a domain you control, billing on a card you own, MFA on a phone in your pocket, and a password in a vault you can read. The pattern of failure is the same too: somebody else's email, somebody else's card, and "let me ask Marcus" as the answer to "who can rotate this?"

Three pairs that come up most often in rescue audits.

**Item #4 - AWS root account email**

> Bad: Root email is `aws@bigdevshop.com`. The bill goes to their AmEx ending 4421. You have an IAM user but have never logged in as root.
> Good: Root email is `aws@mycompany.com`. The password is in your 1Password. MFA is on your phone with backup codes in your office safe. Bill goes to your company card.

If the agency controls the root email, AWS support will treat them as the account holder, not you. The incorporation paperwork in your filing cabinet does not matter to AWS until support has worked through their recovery process - which takes 3-5 business days after you have proven who you are.

![Side-by-side panel showing the AWS root account fields - account email, billing card, your access level, recovery time if the agency disappears - in the bad scenario where everything points at the agency, and the good scenario where everything points at the founder. The Bad column shows aws@bigdevshop.com, agency AmEx, IAM-only access, and a 3-5 day support recovery. The Good column shows aws@mycompany.com, founder AmEx, root password in 1Password with MFA, and same-day recovery by revoking the contractor.](bad-vs-good-email.svg)

**Item #7 - Production database password**

> Bad: "Marcus has it. Slack him and he can DM it to you."
> Good: "I opened AWS Secrets Manager just now and read it myself. I rotated it once in March when we offboarded the previous DBA."

The Marcus answer is the hostage answer. It does not matter whether Marcus is honest, kind, or available - one person holding the prod DB password is one person away from a production outage you cannot fix. The fix is not firing Marcus. The fix is putting the credential in a store you administer and giving Marcus read access from there.

**Item #10 - Domain registrar**

> Bad: Domain renewal notices arrive at `dev@theiragency.com`. You have never logged into Namecheap or GoDaddy in your life.
> Good: Logged into the registrar with your account. WHOIS shows your name. Auto-renew is on, charged to your card, and you have your phone scanned for MFA.

A domain transfer is the slowest recovery on the list. [ICANN's transfer policy](https://www.icann.org/resources/pages/transfers-2024-en) requires a five-day approval window after the auth code is released, and many registrars add a 60-day post-registration lockout window during which transfers cannot start at all. If the agency holds your domain and refuses to cooperate, your customers are looking at a static placeholder for two weeks while you escalate to ICANN's transfer dispute resolution.

```mermaid
%%{init: {'theme':'base', 'themeVariables': {'fontFamily':'Caveat, Patrick Hand, cursive', 'primaryColor':'#f5f5f5', 'primaryBorderColor':'#666', 'lineColor':'#333', 'primaryTextColor':'#1a1a1a'}}}%%
flowchart TD
    Start(["Friday afternoon. Alone.<br/>Credit card + Notion doc."])
    Start --> Code{Code: Are you<br/>GitHub org Owner?}
    Code -->|Yes| Cloud{Cloud: Is the AWS<br/>root email yours?}
    Code -->|No| FixCode[Slack the lead engineer.<br/>5-min org transfer]

    Cloud -->|Yes, with MFA| Sec{Secrets: Can you read<br/>the prod DB password<br/>tonight without asking?}
    Cloud -->|No| FixCloud[Self-serve email change<br/>or 3-5 day AWS support<br/>recovery with corp docs]

    Sec -->|Yes, from your vault| Dom{Domain: Does WHOIS<br/>show your name +<br/>renewal email?}
    Sec -->|"'Marcus has it'"| FixSec[Set up Secrets Manager<br/>or 1Password vault tonight.<br/>Migrate this sprint]

    Dom -->|Yes, on your card| Pass[Audit clean.<br/>Quarterly recurring block.<br/>Email investor / board.]
    Dom -->|No| FixDom[Initiate registrar transfer.<br/>Budget 14 days minimum.<br/>Escalate to ICANN if blocked]

    FixCode --> Recovery[Recovery plan<br/>started this Friday]
    FixCloud --> Recovery
    FixSec --> Recovery
    FixDom --> Recovery

    Recovery --> Escalate{Did the agency<br/>cooperate within 7 days<br/>code / 14 days cloud /<br/>auth code at all?}
    Escalate -->|Yes| Pass
    Escalate -->|No| Lawyer[Retain lawyer.<br/>$2K-$5K beats<br/>a stalled checkout]

    classDef good fill:#f0f9f0,stroke:#2e7d32,stroke-width:2.5px,color:#1a1a1a
    classDef bad  fill:#fff5f5,stroke:#cc342d,stroke-width:2.5px,color:#1a1a1a
    classDef neutral fill:#f5f5f5,stroke:#666,stroke-width:2px,color:#1a1a1a
    classDef start fill:#e8f4f8,stroke:#0277bd,stroke-width:2.5px,color:#1a1a1a

    class Start start
    class Code,Cloud,Sec,Dom,Escalate neutral
    class Pass good
    class FixCode,FixCloud,FixSec,FixDom,Recovery,Lawyer bad
```

## When the audit fails: a recovery plan that takes weeks, not months

Most audit failures are sloppy Day-1 setup, not malice. The agency was moving fast in the kickoff sprint, used whatever email was logged in, and nobody went back to clean it up. The fix follows three steps in this order, and the order matters.

**Step 1: Stop the bleeding.** Get yourself an admin path into every system the agency controls. AWS root password reset to your email. Your name added as GitHub org owner alongside theirs. Your card added as the primary on Stripe, SendGrid, and OpenAI. You are not removing the agency yet. You are giving yourself a parallel key so they cannot lock you out while you sort the rest. Do this on a Friday so you have the weekend before anyone notices.

**Step 2: Extract the IP.** Pull a fresh clone of every repo to a private GitHub org under your account. Export the database to an S3 bucket on an AWS account in your name. Document where every secret currently lives and where it will live after the migration. The point is not to switch off the agency's access yet. It is to make sure you can keep operating if they shut everything down tomorrow morning. Two weeks of work on the existing setup is fine. Two weeks of hostage negotiation while production is down is not.

**Step 3: Legal escalation, only if needed.** If the agency cooperates with email transfers, root password resets, and domain auth codes within a reasonable window - 7 days for GitHub org transfer, 14 days for AWS root, the auth code at all for the domain - you do not need a lawyer. You need a project manager and a follow-up email. If they stall, retain a lawyer for a one-time $2K-$5K letter referencing your contract's IP-assignment clause. Founders who try to negotiate for a month usually lose. The legal fee is cheaper than three more weeks of stalled checkout.

The artifact at [/blog/ownership-checklist/](/blog/ownership-checklist/) walks the exact recovery sequence per item, including the AWS support phone script and the registrar auth-code request template.

## What to do tomorrow

1. **Block 45 minutes on this Friday afternoon.** Calendar invite to yourself titled "Ownership audit." Treat it like an investor meeting. No interruptions. Coffee on, phone on Do Not Disturb.

2. **Open the AWS console first, before any other system.** Top-right, click the account name, click Account. Read the root user email. If it is not on a domain you control, that one item is your audit's first failure - and the most expensive one to fix later.

3. **Download the [GitHub / AWS / Database Ownership Checklist](/blog/ownership-checklist/) and run the 45-minute audit Friday.** The artifact has the exact pass criterion for each of the 12 items, the recovery sequence per failure, and the one-page summary you forward to your investor or board the same day. If three or more items fail, cross-reference [the eight dev-shop red flags](/blog/dev-shop-red-flags-checklist/) and consider whether you need [the 30-day exit guide](/blog/fire-dev-shop-guide/) next.

## Further reading

- AWS, [AWS Account Root User documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html) - the official explanation of why the root email is the master credential and how account recovery works.
- ICANN, [Transfer Policy](https://www.icann.org/resources/pages/transfers-2024-en) - the rules every domain registrar must follow when transferring a domain between accounts, including the 60-day lockout and 5-day approval windows.
- GitGuardian, [The State of Secrets Sprawl 2024](https://www.gitguardian.com/state-of-secrets-sprawl-report-2024) - 12.8 million secrets exposed in public GitHub commits in 2023, with `.env` files as one of the most common leak vectors.
- Rails Guides, [Security: Custom Credentials](https://guides.rubyonrails.org/security.html#custom-credentials) - the canonical Rails answer to the "where do production secrets live?" question, replacing the old `database.yml` plaintext pattern.
- Will Larson (via First Round Review), [Engineering leadership anti-patterns from Stripe, Uber, Carta](https://review.firstround.com/unexpected-anti-patterns-for-engineering-leaders-lessons-from-stripe-uber-carta/) - on ownership and accountability in engineering teams, including who holds the keys to production.
- AWS, [Reset a lost or forgotten root user password](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_passwords_change-root.html) - the support process and timeline if you need to recover a root account where someone else controls the email.

Built by JetThoughts as part of the [Tech for Non-Technical Founders 2026](/blog/tech-for-non-technical-founders-2026/) curriculum.
