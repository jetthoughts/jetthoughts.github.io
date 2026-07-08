---
title: "4.2 · Who Owns Your GitHub, AWS, and Database?"
aliases: ["/blog/github-aws-database-ownership-checklist/"]
description: "Before you hire anyone, lock down who owns the code, cloud, and domain. A 45-minute Friday audit surfaces every credential that should be in your name."
date: 2026-05-13
draft: false
course_chapter: true
author: "JetThoughts Team"
slug: github-aws-database-ownership-checklist
keywords:
  - aws root account ownership
  - github org ownership founder
  - database password ownership
  - non technical founder ownership audit
  - contractor credential audit
tags:
  - founders
  - non-technical-founder
  - course-companion
  - oversight
categories: ["Founders"]
cover_image: cover.png
metatags:
  image: cover.png
  og_title: "4.2 · Who Owns Your GitHub, AWS, and Database?"
  og_description: "Before you hire anyone, lock down who owns the code, cloud, and domain. A 45-minute Friday audit surfaces every credential that should be in your name."
cover_image_alt: "JetThoughts blog cover showing four labeled boxes - Code, Cloud, Secrets, Domain - with red question marks over three of them and one founder email in green"
canonical_url: "https://jetthoughts.com/course/tech-for-non-technical-founders-2026/github-aws-database-ownership-checklist/"
related_posts: false
---

> **Module 4 · Step 2 of 4** · [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/)
>
> **Input:** a build-path decision from Chapter 4.1 (self-serve or hire)
>
> **Output:** a Day-1 audit confirming you own your code, cloud, and domain before the build starts (or a recovery plan if you don't)

> **TL;DR:** Before you hire anyone, run this 12-item audit. It takes 45 minutes. If you skip it, the story below is how it ends: the founder who spent 14 months before discovering the AWS root password was in someone else's Gmail.

> **If you signed up for Lovable + Supabase + Stripe yourself (the default Path 2 from Ch 4.1), here is your 5-minute self-check** - the rest of this chapter applies the day you hire a contractor:
>
> 1. **GitHub**: account in your name, your email, your password manager. (If you used Lovable's "sign in with Google," your Google account IS the GitHub owner. Confirm.)
> 2. **Lovable + Supabase + Stripe**: signed up with your personal email, billed to your card. (Not a co-founder's, not a friend's.)
> 3. **Domain (if purchased)**: registered to your name in your registrar account.
> 4. **No shared admin passwords**: only you have the master password to each.
> 5. **2FA on all four** (GitHub, Supabase, Stripe, domain registrar): turned on.
>
> Pass all 5? You can skim the rest of the chapter as a future reference. Fail any? Fix that one before continuing - the 12-item audit below is the deeper version.

This audit applies BEFORE you hand over a credit card to your first contractor. It also works as a post-hire check, but the cheaper time to run it is on Day 1, not month 14, when the story below kicks off.

Here's what happens if you skip it. A founder we saw last year: fourteen months into a build, 1,800 paying clinics, a Stripe account in the founder's name, and the AWS root password sitting in the contractor's personal Gmail. The founder had to send three emails asking the contractor to please change the root account email. He took six days.

*Ownership*: who controls the GitHub org, the AWS root account, the domain registrar, and the prod database. A Day-1 audit means you can switch contractors Tuesday without losing access to your own codebase Wednesday.

Open the AWS console. Top-right corner. Click your account name. Read the email address on the root user. Whose inbox does that land in tonight?

## The 2026 credential trap looks different

The contractors who create single points of failure in 2026 are not the same shops that did it in 2020. AI-augmented contractors spin up your entire infrastructure during the Cursor or Claude Code session on Day 1: GitHub org, AWS account, Vercel project, Supabase database, Stripe integration, Sentry, PostHog. They use whatever email was already logged in. Usually their own. The senior dev who set everything up moves to another client in month four. The junior who inherits your project does not know which credentials live where. Six months later, you are paying for accounts that nobody on the current team can administer.

There is a second pattern, even more common: the **cloud-default-account problem**. A contractor opens a fresh AWS account using the company credit card you handed them, then sets the root email to a shared `dev@` mailbox that the agency owns. AWS treats whichever email is on the root as the legal account holder. Your incorporation paperwork is irrelevant if the root email belongs to someone else. [AWS's own root user documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html) is blunt about this: the root user has unrestricted access, and recovering control without the root credentials means filing a support ticket with corporate documents and waiting days.

The financial damage is rarely the headline number on the contractor invoice. It is the day production breaks at 9pm and you cannot push a fix because you cannot read the prod database password. The week lost to support recovery while your customers see a maintenance page. None of that hits the budget line that says "engineering."

![Four labeled zones a non-technical founder must own: Code (GitHub org and repos), Cloud (AWS root and billing), Secrets (database credentials and API keys), and Domain (registrar and DNS). Each zone shows the failure mode if a contractor email is on it instead of the founder.](ownership-zones.svg)

## What good looks like vs what bad looks like

Every item rhymes the same way when it passes: an email on a domain you control, billing on a card you own, MFA on a phone in your pocket, and a password in a vault you can read. Failure rhymes too: somebody else's email, somebody else's card, and "let me ask Marcus" as the answer to "who can rotate this?"

Three pairs that come up most often in ownership audits.

**Item #4 - AWS root account email**

> Bad: Root email is `aws@bigdevshop.com`. The bill goes to their AmEx ending 4421. You have an IAM user but have never logged in as root.
> Good: Root email is `aws@mycompany.com`. The password is in your 1Password. MFA is on your phone with backup codes in your office safe. Bill goes to your company card.

If the contractor controls the root email, AWS support will treat them as the account holder, not you. The incorporation paperwork in your filing cabinet does not matter to AWS until support has worked through their recovery process - which takes 3-5 business days after you have proven who you are.

![Side-by-side panel showing the AWS root account fields - account email, billing card, your access level, recovery time if the agency disappears - in the bad scenario where everything points at the agency, and the good scenario where everything points at the founder. The Bad column shows aws@bigdevshop.com, agency AmEx, IAM-only access, and a 3-5 day support recovery. The Good column shows aws@mycompany.com, founder AmEx, root password in 1Password with MFA, and same-day recovery by revoking the contractor.](bad-vs-good-email.svg)

**Item #7 - Production database password**> Bad: "Marcus has it. Slack him and he can DM it to you."
> Good: "I opened AWS Secrets Manager just now and read it myself. I rotated it once in March when we offboarded the previous DBA."
The Marcus answer means you have a single point of failure. It does not matter whether Marcus is honest, kind, or available - one person holding the prod DB password is one person away from a production outage you cannot fix. Firing Marcus does not fix it. Putting the credential in a store you administer, with Marcus pulling read access from there, does.

**Item #10 - Domain registrar**

> Bad: Domain renewal notices arrive at `dev@theiragency.com`. You have never logged into Namecheap or GoDaddy in your life.
> Good: Logged into the registrar with your account. WHOIS shows your name. Auto-renew is on, charged to your card, and you have your phone scanned for MFA.

A domain transfer is the slowest recovery on the list. [ICANN's transfer policy](https://www.icann.org/resources/pages/transfers-2024-en) requires a five-day approval window after the auth code is released, and many registrars add a 60-day post-registration lockout window during which transfers cannot start at all. If someone else holds your domain and refuses to cooperate, your customers are looking at a static placeholder for two weeks while you escalate to ICANN's transfer dispute resolution.

## The 12 items, in four zones (fill-in-the-blank reference)

Those three pairs anchor the pattern; the table below is the fill-in-the-blank version - 12 items, the exact pass criterion for each, the recovery steps when one fails. The full audit lives at the [GitHub / AWS / Database Ownership Checklist](/course/tech-for-non-technical-founders-2026/ownership-checklist/).

> **Acronyms in the table below:** IAM = Identity and Access Management (AWS's user-permissions system, separate from the root account). MFA = Multi-Factor Authentication (the 6-digit code your phone shows when you log in - a second proof beyond your password). WHOIS = the public registry that shows who legally owns a domain. ICANN = the global body that enforces domain-transfer rules (the source of the 14-day wait if your registrar lock isn't released).

| Zone | Item | Pass Criterion |
|---|---|---|
| **Code** | GitHub org owner | Your company email, not the agency's |
| | Repo collaborators | Can be removed by you alone, without permission |
| | Branch protection on main | Enabled and you can override in an emergency |
| **Cloud** | AWS root account email | Sits on a domain you control |
| | Billing card | Yours and you can download every invoice yourself |
| | IAM admin user | In your name with MFA on, separate from root |
| **Secrets and database** | Production DB credentials | Readable by you tonight without paging an engineer |
| | Secrets store | (Secrets Manager, Vault, Doppler) administered by you |
| | Database backups | Running nightly with a restore runbook you can execute |
| **Domain and external services** | Domain registrar | WHOIS shows your name and your renewal email |
| | DNS provider | Logged in under your account with MFA, ready to add an A record now |
| | Third-party API keys | (Stripe, SendGrid, Twilio, OpenAI, Plaid) on your account, your card |

Two of those twelve are existential. AWS root email controls whether a contractor can lock you out in ten minutes. Domain registrar turns into a 14-day ICANN-mandated wait if someone else will not release the auth code. The other ten matter; these two end the company if they go wrong.

```mermaid
%%{init: {'theme':'base', 'themeVariables': {'fontFamily':'Caveat, Patrick Hand, cursive', 'primaryColor':'#f5f5f5', 'primaryBorderColor':'#666', 'lineColor':'#333', 'primaryTextColor':'#1a1a1a'}}}%%
flowchart TD
    Start(["Friday afternoon. Alone.<br/>Credit card + Notion doc."])
    Start --> Code{Code: Are you<br/>GitHub org Owner?}
    Code -->|Yes| Cloud{Cloud: Is the AWS<br/>root email yours?}
    Code -->|No| FixCode[Slack the lead engineer.<br/>Self-serve org transfer]

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

    Recovery --> Escalate{Did the contractor<br/>cooperate within 7 days<br/>code / 14 days cloud /<br/>auth code at all?}
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

Most audit failures are sloppy Day-1 setup, not malice. The contractor was moving fast in the kickoff sprint, used whatever email was logged in, and nobody went back to clean it up. The fix follows three steps in this order, and the order matters.

| Step | What to do | Cadence |
|---|---|---|
| 1: Stop the bleeding | Get yourself an admin path into every system the contractor controls. AWS root password reset to your email. Your name added as GitHub org owner alongside theirs. Your card added as the primary on Stripe, SendGrid, and OpenAI. Do this before the next sprint so you have a quiet window before anyone notices. | This sprint |
| 2: Extract the IP | Pull a fresh clone of every repo to a private GitHub org under your account. Export the database to an S3 bucket on an AWS account in your name. Document where every secret currently lives and where it will live after the migration. Work patiently on the existing setup. | Next sprint |
| 3: Legal escalation, only if needed | A reasonable cooperation window looks like 7 days for GitHub org transfer, 14 days for AWS root, and the auth code released at all for the domain. If they stall, retain a lawyer for a one-time $2K-$5K letter referencing your contract's IP-assignment clause. | 7-14 days (or legal engagement) |

The artifact at [/course/tech-for-non-technical-founders-2026/ownership-checklist/](/course/tech-for-non-technical-founders-2026/ownership-checklist/) walks the exact recovery sequence per item, including the AWS support phone script and the registrar auth-code request template.

## What to do tomorrow

| Step | Action |
|---|---|
| **Block the calendar** | Calendar invite to yourself titled "Ownership audit." Treat it like an investor meeting. No interruptions. Coffee on, phone on Do Not Disturb. |
| **Start with AWS** | Open the AWS console first. Top-right, click the account name, click Account. Read the root user email. If it is not on a domain you control, that one item is your audit's first failure. |
| **Run the 12-item audit** | Download the [GitHub / AWS / Database Ownership Checklist](/course/tech-for-non-technical-founders-2026/ownership-checklist/) and run through it. Record pass/fail for each of the 12 items. Create a one-page summary to forward to your investor or board. |
| **Triage the failures** | If three or more items fail, consider [the 30-day exit guide](/blog/fire-dev-shop-guide/) for a structured transition. |

## Advanced (optional)

| Topic | When to scope | When to skip |
|---|---|---|
| **Signed key infrastructure** | You have 50+ users AND you handle regulated data. Rotating to asymmetric signing keys (AWS KMS, HashiCorp Vault Transit engine) means revocation actually removes access. | You have <50 users. Defer to month three, not month eighteen. |
| **Security audit reference** | Before an enterprise prospect sends a SOC2 questionnaire. Run [AWS Trusted Advisor](https://aws.amazon.com/premiumsupport/technology/trusted-advisor/) (free for Business/Enterprise) or [Prowler](https://github.com/prowler-cloud/prowler) (open-source). Both produce reports answering 80% of infra questions. | You have no enterprise prospects yet. No need for SOC2 or formal audit. |

Ownership audit done right means no Marcus stands between you and a 9pm Tuesday production fix.

## Further reading

- AWS, [AWS Account Root User documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html) - the official explanation of why the root email is the master credential and how account recovery works.
- ICANN, [Transfer Policy](https://www.icann.org/resources/pages/transfers-2024-en) - the rules every domain registrar must follow when transferring a domain between accounts, including the 60-day lockout and 5-day approval windows.
- GitGuardian, [The State of Secrets Sprawl 2024](https://www.gitguardian.com/state-of-secrets-sprawl-report-2024) - 12.8 million secrets exposed in public GitHub commits in 2023, with `.env` files as one of the most common leak vectors.
- Rails Guides, [Security: Custom Credentials](https://guides.rubyonrails.org/security.html#custom-credentials) - the canonical Rails answer to the "where do production secrets live?" question, replacing the old `database.yml` plaintext pattern.
- Will Larson (via First Round Review), [Engineering leadership anti-patterns from Stripe, Uber, Carta](https://review.firstround.com/unexpected-anti-patterns-for-engineering-leaders-lessons-from-stripe-uber-carta/) - on ownership and accountability in engineering teams, including who holds the keys to production.
- AWS, [Reset a lost or forgotten root user password](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_passwords_change-root.html) - the support process and timeline if you need to recover a root account where someone else controls the email.

> **Done when:** All 12 items on the ownership checklist are audited, failures are documented, and a recovery plan exists for each failure.
> **Next click:** [4.3a · The Self-Serve MVP Stack: Tools & Setup](/course/tech-for-non-technical-founders-2026/self-serve-mvp-stack-lovable-supabase-stripe-2026/)
> **If blocked:** If the AWS root email belongs to someone else and they won't cooperate, start the AWS support recovery process immediately (3-5 business days). Do not build on an account you don't own.

> **Case Study: Tomas & Mia**
>
> **Tomas**: Audits all 12 items. Finds GitHub under his personal email (good), but no AWS account (creates one). Domain auto-renewing on a registrar he forgot the password to. Spends a Friday fixing all three. Now owns everything.
>
> **Mia**: Audits all 12 items. Owns her domain (good), has personal GitHub but no org (creates one). No secrets manager - creates a 1Password vault. Spends a Friday afternoon. Now owns everything.

---

*Built by [JetThoughts](https://jetthoughts.com) as part of the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) curriculum.*
