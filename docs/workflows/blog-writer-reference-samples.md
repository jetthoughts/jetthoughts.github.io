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
credits collaborators by name. Mimic the CADENCE - sentence rhythm,
specificity density, level of self-disclosure - never the phrasing. At the
end of every draft, the writer agent must include the comment
`<!-- Reference cadence: <author> -->` immediately above the frontmatter
or below the closing CTA so reviewers can verify the post leans toward the
intended voice.
