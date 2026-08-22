# Reference Voice Samples for Blog Writer

These three excerpts represent the target voice for JetThoughts blog posts:
practitioner anchoring, sentence-length variance, named-actor specificity,
and the ability to make a technical point without a credentialed-lecturer
cadence.

The writer agent should match the CADENCE of these samples, not their
phrasing. Do not copy sentences. Do not adopt all three voices at once -
pick the closest match for the post's structural shape (incident vs
tutorial vs essay) and lean toward that one.

---

## Sample 1: Patrick McKenzie ("patio11")

**Source**: [The business of check cashing](https://www.bitsaboutmoney.com/archive/the-business-of-check-cashing/) (Bits about Money, January 30, 2024)
**Why this voice**: Essay-shape. Notice the embodied dialogue ("You know, we have been in this game for decades..."), the casual French aside ("bonne chance"), the throwaway specifics ($450, ChexSystems, "compliance keeps a file to scare young analysts"), and the comfort with long sentences that pack three clauses before the verb lands. The authority comes from inhabiting the operator's head, not from listing credentials.

> You know, we have been in this game for decades, and like to think we are pretty good at it. We did not _make up_ that estimate of creditworthiness. We most definitely did not engage in illegal discriminatory practices, like inferring creditworthiness from zip code. We know that would be extremely probative data if we were allowed to use it, because we're in the data and math business and good at our jobs, but egads. Can you imagine the fines we'd pay? The headlines? Compliance keeps a file to scare young analysts with. No, we paid a few dollars to get a report from ChexSystems, which said that _the literal same person_ who wants us to extend credit ripped off the bank down the street for $450 a few months ago. If you were in consumer banking, and you're not because we are having this discussion, you would recognize that as multiple years of the contribution margin of a checking account relationship. Do _you_ want to extend them credit? Then _bonne chance_. We decline.
>
> The world's financial system is predicated on the U.S. government being definitionally zero credit risk when denominated in dollars. Every other kind of debt in the world is defined in reference to a Treasury.
>
> _A portion_ of the price of every cell in that pricing grid is credit risk. Just like the spread between a bond and a Treasury of the same duration is a reflection of marginal riskiness, the spread between personal checks and government checks is a reflection of "the credit risk of the types of people who most commonly write checks to poor people."
>
> As you can see, by simple subtraction, this spread is non-zero but low.
>
> Now what causes the price to be so hard high for the reference risk? Well, Treasuries _certainly_ pay out _to someone_, but not everyone in the world who says they own $1 million in Treasuries actually does. Government checks don't have credit risk _directly_, they have operational risk which becomes a credit risk. In the case where either the person cashing them isn't the person named on the check, or where the government later comes to the conclusion that it didn't _really_ want to pay them, that money could (at some risk) be clawed back from the bank, and therefore from the check casher.

---

## Sample 2: thoughtbot

**Source**: [How fast can an ActiveRecord SQL query run?](https://thoughtbot.com/blog/how-fast-can-an-activerecord-sql-query-run) (thoughtbot blog, Fritz Meissner, March 31, 2025)
**Why this voice**: Tutorial-shape. Senior engineer talking to a peer who is two levels down on the same problem. Notice the concrete starting condition (20ms query, RDS performance insights), the named-tool specificity (Skylight, `pg_stat_activity`, cloudping.co, "50th percentile within my AWS region is 1.7ms"), and the closing measurement that shows the real trade-off worked ("dropped to 1ms or less", "20x"). No throat-clearing. The post earns its conclusion by showing receipts.

> Your database monitoring (perhaps Amazon RDS performance insights, Skylight, or the Postgres pg_stat_activity view) is telling you that one particular query in your Rails app is causing heavy load. Unfortunately, it already seems pretty fast. What are the odds that you can get it to run any faster?
>
> I had a case where the query generating the heaviest load in an application took 20 milliseconds. It was also the fastest query in the application; some queries in the same application take entire seconds to run! Surely the fastest query in the system had little room for optimisation?
>
> It's possible to get really good, detailed answers about duration and optimisation strategies for specific queries using a database query planner, but sometimes it's nice to have a rule of thumb that can guide one to a quick answer like: "this query's duration is [or is not] very close in speed to the fastest my query could possibly run and so I likely therefore can [or cannot] optimise it".
>
> Here's a trick you can run in the Rails console of your production environment to find out how fast the fastest possible queries can run:
>
>     > ActiveRecord::Base.logger = Logger.new(STDOUT) # assuming you have SQL logging turned off
>     > ActiveRecord::Base.connection.execute("SELECT 1;")
>     D, [2025-03-21T14:03:35.765188 #8173] DEBUG -- :    (0.7ms)  select 1;
>
> In this snippet we're turning on ActiveRecord SQL logging (for this Rails console only) as it is normally disabled in production. Then we're running a query that does not touch any real data. The resulting logging shows that our query takes 0.7ms.
>
> `SELECT 1;` is the minimum work that can be done in the database. The only work that happens is Rails assembling a SQL request, connecting to the database (which is normally on a different server), and returning an answer. Any "real" query must run slower than that because it has to search for and return real data.
>
> It's interesting to compare this number with the time it takes for a minimal network request to go from application server to database server. If you have terminal acess to your application server, you could use the ping utility to get that number. If you're in the cloud, you might need to rely on sites like cloudping.co (for Amazon) to tell you how long a network round trip takes. The 50th percentile cloudping time within my AWS region is reported to be 1.7ms, so this minimal query is faster than the average round trip time.
>
> This was a real life example: I had previously thought that my 20ms query was pretty much as fast as things could get, but once I realised that a "fastest possible" SQL query could go much faster, I was emboldened to try optimise. I was able to drop the query time drastically: in fact, ActiveRecord now reports that the query takes 1 millisecond or less.

---

## Sample 3: Julia Evans ("jvns.ca")

**Source**: [Some notes on starting to use Django](https://jvns.ca/blog/2026/01/27/some-notes-on-starting-to-use-django/) (jvns.ca, January 27, 2026)
**Why this voice**: Notes/incident-shape. Curious, conversational, first-person. Notice the comfort with admitting weakness ("I had a bad habit of never reading the documentation"), the specific code anchors (`@admin.register(Zine)`, `Zine.objects.exclude(product__order__email_hash=email_hash)`), and the explicit comparison to a prior failure ("trying to operate Postgres and not being able to understand what was going on, I decided to run all of my small websites with SQLite instead"). Sentences vary from one short clause to three. She uses "I" and "you" without apology and credits other people by name ("Thanks to Marco Rogers for convincing me to give ORMs a chance").

> I spent some time trying to learn Rails in 2020, and while it was cool and I really wanted to like Rails (the Ruby community is great!), I found that if I left my Rails project alone for months, when I came back to it it was hard for me to remember how to get anything done because (for example) if it says `resources :topics` in your `routes.rb`, on its own that doesn't tell you where the topics routes are configured, you need to remember or look up the convention.
>
> Being able to abandon a project for months or years and then come back to it is really important to me (that's how all my projects work!), and Django feels easier to me because things are more explicit.
>
> In my small Django project it feels like I just have 5 main files (other than the settings files): `urls.py`, `models.py`, `views.py`, `admin.py`, and `tests.py`, and if I want to know where something else is (like an HTML template) is then it's usually explicitly referenced from one of those files.
>
> For this project I wanted to have an admin interface to manually edit or view some of the data in the database. Django has a really nice built-in admin interface, and I can customize it with just a little bit of code.
>
> For example, here's part of one of my admin classes, which sets up which fields to display in the "list" view, which field to search on, and how to order them by default.
>
>     @admin.register(Zine)
>     class ZineAdmin(admin.ModelAdmin):
>         list_display = ["name", "publication_date", "free", "slug", "image_preview"]
>         search_fields = ["name", "slug"]
>         readonly_fields = ["image_preview"]
>         ordering = ["-publication_date"]
>
> In the past my attitude has been "ORMs? Who needs them? I can just write my own SQL queries!". I've been enjoying Django's ORM so far though, and I think it's cool how Django uses `__` to represent a JOIN, like this:
>
>     Zine.objects
>         .exclude(product__order__email_hash=email_hash)
>
> This query involves 5 tables: zines, zine_products, products, order_products, and orders. To make this work I just had to tell Django that there's a `ManyToManyField` relating "orders" and "products", and another `ManyToManyField` relating "zines", and "products", so that it knows how to connect zines, orders, products.
>
> After having a bad experience trying to operate Postgres and not being able to understand what was going on, I decided to run all of my small websites with SQLite instead. It's been going way better, and I love being able to backup by just doing a `VACUUM INTO` and then copying the resulting single file.

---


## Sample 4: Arkency (the competitor we are furthest from)

**Sources**: [Ingress is not the owner of the invariant](https://blog.arkency.com/ingress-is-not-the-owner-of-the-invariant/) (Szymon Fiedler, 2026-06-16) and [Maintaining an organizational knowledge graph with an LLM and event sourcing](https://blog.arkency.com/maintaining-an-organizational-knowledge-graph-with-an-llm-and-event-sourcing/) (Piotr Jurewicz, 2026-08-11)

**Why this voice**: added 2026-08-22 after Paul called our own posts off-level. Arkency does four things our drafts had not been doing at all, and each one is copyable without copying phrasing.

**1. A named human writes it.** Every post carries an author name and an author page. Ours said `author: 'JetThoughts Team'`, which is the faceless register we were trying to avoid everywhere else.

**2. Cards on the table, before the argument.** Fiedler opens a polemic about invariants with:

> A disclaimer: I'm a [RailsEventStore](https://railseventstore.org) maintainer and this article ends up on the Arkency blog — so cards are on the table. Despite this, I'm keeping the core of my argument in pure `ActiveRecord`: no step of the reasoning requires _RES_. I only show the _RES_ version at the end, separately, as "and this is what it looks like when you're not typing it in manually". If you're convinced by the bare-metal _AR_ reasoning, not the library, that's what matters.

Declaring the conflict AND then deliberately arguing without the product is credibility engineering of a kind we have no equivalent for. Copy the move, not the words: when a post could be read as selling something, say so, then make the argument survive without the sale.

**3. Argue with a named peer, respectfully.** That post is subtitled "A polemic with *Callbacks Are Not Invariants* by Brandon Weaver", links it, and includes a section called "Where Weaver is right — and what I'm not saying". We cite aggregate HN comment counts; they engage one person's actual argument. Aggregates cost nothing to cite, which is why they persuade nobody.

**4. H2s that are moves in an argument.** "We agree about the disease" → "A name that promises more than it delivers" → "Core: ingress doesn't own the invariant" → "Where Weaver is right — and what I'm not saying" → "Landing". Each heading advances a case. Compare our "Green answers a question nobody asked", which is an observation wearing a heading.

**Opening lines carry the thesis and sound human:**

> Organizations are surprisingly good at forgetting.
> Decisions are made on calls, insights get buried in Slack threads, and a month later no one remembers why things are the way they are.

**Density to match**: the knowledge-graph post runs 8 code blocks AND 4 images - an ontology diagram, an extraction screenshot, a provenance view, and a cost chart. The invariant post runs 8-10 code examples across ~3,500-4,000 words. First person throughout: "I enjoy", "I hate", "My claim".

---

## Sample 5: Evil Martians

**Source**: [Flaky tests, be gone](https://evilmartians.com/chronicles/flaky-tests-be-gone-long-lasting-relief-chronic-ci-retry-irritation.md)

**Why this voice**: the density ceiling. ~28 code blocks in one post, a named and linked client (ClickFunnels), and the outcome stated as a measured range with its scope: "from flaky tests with ~80% success rates to 100% reliability across their massive test suite (9k+ unit, 1k+ feature tests)".

Two moves worth stealing:

**A table of contents as anchor links** in the opening, so a reader who only wants the quarantine protocol can jump to it. Long posts owe the reader navigation.

**Playfulness that does not undercut authority.** The reliability claim carries a mock-pharmaceutical disclaimer - "These statements have not been evaluated by the FDA (Flaky Detection Authority)" - which lets them state a strong number and immediately show they know its limits. Humour is doing honesty's job here, not decoration's.

> Every developer knows this pain: your test suite passes locally but fails on CI. You click "Retry" and hold your breath. It passes! But was it a real fix or just luck?

Second person, present tense, a scene the reader has lived. No throat-clearing.

---

## The 2026-08-22 audit: what our posts were missing

Measured against the three above, not asserted:

| | Evil Martians | thoughtbot | Arkency | ours (before) |
|---|---|---|---|---|
| code blocks | ~28 | console + timings | 8-10 | **0** |
| images/diagrams | 0 | - | 4 | **0** |
| named client | ClickFunnels | David Pace, Merck | - | **none** |
| named author | - | - | every post | **"JetThoughts Team"** |
| engages a named peer | - | - | Brandon Weaver, linked | **none** |
| discloses own interest | - | - | explicit, up front | **none** |
| costly position | - | "don't hire thoughtbot" | argues against a friend | **none** |

The pattern across all three: **an artifact the reader can use, plus receipts.** Ours were essays about ideas. An essay with no code, no diagram, no named source and no disclosed interest is asking to be believed on tone alone, which is the one thing a sceptical founder will not extend.
## How to use these samples in the writer prompt

Pick ONE sample as the cadence anchor for each post based on structural
shape. Essays and explainers (why a financial/operational/economic system
behaves the way it does) lean toward Sample 1 - patio11 cadence: long
sentences with embedded clauses, embodied dialogue or roleplay, throwaway
named specifics, comfort with stating "we decline" without softening.
Tutorials, postmortems, and how-fast/how-fix posts (tested code, measurable
outcome, named tool) lean toward Sample 2 - thoughtbot cadence: concrete
starting condition, named tools and dollar/millisecond numbers, code block
in the middle, closing measurement that proves the trade-off. Field notes,
"I tried X and here's what I noticed" posts, and curiosity-driven
investigations lean toward Sample 3 - jvns.ca cadence: first-person,
admits weakness, comfortable with parenthetical asides, varies sentence
length aggressively (one-clause sentences next to three-clause ones),
credits collaborators by name. Opinion and positioning posts - the ones aimed at a founder rather than a
practitioner - lean toward **Sample 4, Arkency**: a named human author, the
conflict of interest declared before the argument starts, one named peer
engaged rather than an aggregate cited, and H2s that are moves in a case
rather than observations. Dense technical walkthroughs lean toward
**Sample 5, Evil Martians**: anchor-link navigation up front, a named client,
and an outcome stated with its scope.

**Two things are not cadence choices and apply to every post** (added
2026-08-22, after three of ours shipped without either):

1. **An artifact the reader can use.** A command they run, a diff they apply,
   a config they copy. A post with zero code blocks and zero diagrams is
   asking to be believed on tone, which is what a sceptical founder will not
   extend. Check the count before handback, not after.
2. **Receipts.** A named source, a linked study read at the primary, or our own
   measured number with its denominator. "Studies show" and aggregate comment
   counts cost nothing to write and persuade nobody.

Mimic the CADENCE - sentence rhythm,
specificity density, level of self-disclosure - never the phrasing. At the
end of every draft, the writer agent must include the comment
`<!-- Reference cadence: <author> -->` immediately above the frontmatter
or below the closing CTA so reviewers can verify the post leans toward the
intended voice.
