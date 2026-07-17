---
title: "Full Reference: Infrastructure Ownership"
description: "The complete ownership reference - the 2026 AI-contractor credential trap, the good-vs-bad walkthrough for the three items that fail most, the three-step recovery sequence, the advanced hardening notes, and the full further-reading set. Companion to Lesson 4.2."
date: 2026-05-13
draft: false
slug: ownership-full
---

> **Reference companion to [Lesson 4.2 · Who Owns Your GitHub, AWS, and Database?](/course/tech-for-non-technical-founders-2026/github-aws-database-ownership-checklist/)** - the 2026 credential trap, the good-vs-bad walkthrough for the three items that fail most, the full recovery sequence, and the advanced hardening notes. Read the micro-lesson first for the 12-item audit and the Friday routine; return here when an item fails and you need the deep recovery detail.

---

![Four labeled zones a non-technical founder must own: Code (GitHub org and repos), Cloud (AWS root and billing), Secrets (database credentials and API keys), and Domain (registrar and DNS). Each zone shows the failure mode if a contractor email is on it instead of the founder.](ownership-zones.svg)

## The 2026 credential trap looks different

The contractors who create single points of failure in 2026 are not the same shops that did it in 2020. AI-augmented contractors spin up your entire infrastructure during the Cursor or Claude Code session on Day 1: GitHub org, AWS account, Vercel project, Supabase database, Stripe integration, Sentry, PostHog. They use whatever email was already logged in. Usually their own. The senior dev who set everything up moves to another client in month four. The junior who inherits your project does not know which credentials live where. Six months later, you are paying for accounts that nobody on the current team can administer.

There is a second pattern, even more common: the **cloud-default-account problem**. A contractor opens a fresh AWS account using the company credit card you handed them, then sets the root email to a shared `dev@` mailbox that the agency owns. AWS treats whichever email is on the root as the legal account holder. Your incorporation paperwork is irrelevant if the root email belongs to someone else. [AWS's own root user documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html) is blunt about this: the root user has unrestricted access, and recovering control without the root credentials means filing a support ticket with corporate documents and waiting days.

The financial damage is rarely the headline number on the contractor invoice. It is the day production breaks at 9pm and you cannot push a fix because you cannot read the prod database password. The week lost to support recovery while your customers see a maintenance page. None of that hits the budget line that says "engineering."

## What good looks like vs what bad looks like

Every item rhymes the same way when it passes: an email on a domain you control, billing on a card you own, MFA (the same two-factor login code) on a phone in your pocket, and a password in a vault you can read. Failure rhymes too: somebody else's email, somebody else's card, and "let me ask Marcos" as the answer to "who can rotate this?"

Three pairs that come up most often in ownership audits.

**Item #4 - AWS root account email**

> Bad: Root email is `aws@bigdevshop.com`. The bill goes to their AmEx ending 4421. You have an IAM user (a limited-permission login, not the all-powerful root account) but have never logged in as root.
> Good: Root email is `aws@mycompany.com`. The password is in your 1Password. MFA is on your phone with backup codes in your office safe. Bill goes to your company card.

If the contractor controls the root email, AWS support will treat them as the account holder, not you. The incorporation paperwork in your filing cabinet does not matter to AWS until support has worked through their recovery process - which takes 3-5 business days after you have proven who you are.

![Side-by-side panel showing the AWS root account fields - account email, billing card, your access level, recovery time if the agency disappears - in the bad scenario where everything points at the agency, and the good scenario where everything points at the founder. The Bad column shows aws@bigdevshop.com, agency AmEx, IAM-only access, and a 3-5 day support recovery. The Good column shows aws@mycompany.com, founder AmEx, root password in 1Password with MFA, and same-day recovery by revoking the contractor.](bad-vs-good-email.svg)

**Item #7 - Production database password**

> Bad: "Marcos has it. Slack him and he can DM it to you."
> Good: "I opened AWS Secrets Manager just now and read it myself. I rotated it once in March when we offboarded the previous DBA (database administrator - the person who manages your production database)."

The Marcos answer means you have a single point of failure. It does not matter whether Marcos is honest, kind, or available - one person holding the prod DB password is one person away from a production outage you cannot fix. Firing Marcos does not fix it. Putting the credential in a store you administer, with Marcos pulling read access from there, does.

**Item #10 - Domain registrar**

> Bad: Domain renewal notices arrive at `dev@theiragency.com`. You have never logged into Namecheap or GoDaddy in your life.
> Good: Logged into the registrar with your account. WHOIS shows your name. Auto-renew is on, charged to your card, and you have your phone scanned for MFA.

A domain transfer is the slowest recovery on the list. [ICANN's Transfer Policy](https://www.icann.org/en/contracted-parties/accredited-registrars/resources/domain-name-transfers/policy) gives your current registrar up to five days to hand over the transfer auth code, allows a further five-day window for the losing registrar to release the transfer once you request it, and many registrars add a 60-day lock after registration or a recent transfer during which transfers cannot start at all. If someone else holds your domain and refuses to cooperate, your customers are looking at a static placeholder for two weeks while you escalate to ICANN's transfer dispute resolution.

## When the audit fails: a recovery plan that takes weeks, not months

Most audit failures are sloppy Day-1 setup, not malice. The contractor was moving fast in the kickoff sprint, used whatever email was logged in, and nobody went back to clean it up. The fix follows three steps in this order, and the order matters.

| Step | What to do | Cadence |
|---|---|---|
| 1: Stop the bleeding | Get yourself an admin path into every system the contractor controls. AWS root password reset to your email. Your name added as GitHub org owner alongside theirs. Your card added as the primary on Stripe, SendGrid, and OpenAI. Do this before the next sprint so you have a quiet window before anyone notices. | This sprint |
| 2: Extract the IP (intellectual property - your source code and data, legally distinct from an IP network address) | Pull a fresh clone of every repo to a private GitHub org under your account. Export the database to an S3 bucket on an AWS account in your name. Document where every secret currently lives and where it will live after the migration. Work patiently on the existing setup. | Next sprint |
| 3: Legal escalation, only if needed | A reasonable cooperation window looks like 7 days for GitHub org transfer, 14 days for AWS root, and the auth code released at all for the domain. If they stall, retain a lawyer for a one-time $2K-$5K letter referencing your contract's IP-assignment clause. | 7-14 days (or legal engagement) |

The [ownership checklist template](/course/tech-for-non-technical-founders-2026/ownership-checklist/) walks the exact recovery sequence per item, including the AWS support phone script and the registrar auth-code request template.

## Advanced (optional)

| Topic | When to scope | When to skip |
|---|---|---|
| **Signed key infrastructure** | You have 50+ users AND you handle regulated data. Rotating to asymmetric signing keys (AWS KMS, HashiCorp Vault Transit engine) means revocation actually removes access. | You have <50 users. Defer to month three, not month eighteen. |
| **Security audit reference** | Before an enterprise prospect sends a SOC2 questionnaire. Run [AWS Trusted Advisor](https://aws.amazon.com/premiumsupport/technology/trusted-advisor/) (free for Business/Enterprise) or [Prowler](https://github.com/prowler-cloud/prowler) (open-source). Both produce reports answering 80% of infra questions. | You have no enterprise prospects yet. No need for SOC2 or formal audit. |

Ownership audit done right means no Marcos stands between you and a 9pm Tuesday production fix.

## Further reading

- AWS, [AWS Account Root User documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html) - the official explanation of why the root email is the master credential and how account recovery works.
- ICANN, [Transfer Policy](https://www.icann.org/en/contracted-parties/accredited-registrars/resources/domain-name-transfers/policy) - the rules every domain registrar must follow when transferring a domain between accounts, including the 60-day lock and the five-day code-release and transfer-release windows.
- GitGuardian, [The State of Secrets Sprawl 2024](https://www.gitguardian.com/state-of-secrets-sprawl-report-2024) - 12.8 million secrets exposed in public GitHub commits in 2023, with `.env` files as one of the most common leak vectors.
- Rails Guides, [Security: Custom Credentials](https://guides.rubyonrails.org/security.html#custom-credentials) - the canonical Rails answer to the "where do production secrets live?" question, replacing the old `database.yml` plaintext pattern.
- Will Larson (via First Round Review), [Engineering leadership anti-patterns from Stripe, Uber, Carta](https://review.firstround.com/unexpected-anti-patterns-for-engineering-leaders-lessons-from-stripe-uber-carta/) - on ownership and accountability in engineering teams, including who holds the keys to production.
- AWS, [Reset a lost or forgotten root user password](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_passwords_change-root.html) - the support process and timeline if you need to recover a root account where someone else controls the email.

---

*Built by [JetThoughts](https://jetthoughts.com) as a companion reference to the [From Idea to First Paying Customer](/course/tech-for-non-technical-founders-2026/) free curriculum.*
