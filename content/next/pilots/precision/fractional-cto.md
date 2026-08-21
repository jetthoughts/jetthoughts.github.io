---
title: Fractional CTO (Precision pilot)
description: Design-register pilot C - "Engineered Precision" skin over the settled fractional-CTO landing anatomy. Same copy as pilots A and B; only the register differs.
layout: landing
type: next
# Drives both the CSS file and the bundle name in layouts/next/landing.html,
# so pilots B and C reuse this template by changing one line.
register: precision
# Self-hosted display faces for this register (themes/beaver/static/). Another
# register omits this key and ships no webfont at all.
font:
  css: /css/fonts-precision.css
  preload: /fonts/inter-latin.woff2

nav:
  links:
    - name: Services
      url: /services/
    - name: Use Cases
      url: /use-cases/
    - name: Blog
      url: /blog/
    - name: Course
      url: /course/tech-for-non-technical-founders-2026/
    - name: Clients
      url: /clients/
  cta:
    name: Book a free consultation
    url: /free-consultation/

hero:
  eyebrow: Fractional CTO
  headline: A technical partner in days, not months of hiring
  subhead: Your dev shop isn't working. Your investors want a technical update. You need someone who can audit the code, fix the team, and give you a straight answer.
  primary:
    name: Book a free consultation
    url: /free-consultation/
  secondary:
    name: Book a 30-min call
    url: /contact-us/
  derisk: You keep the written assessment whether or not we work together.
  # Markdown, rendered inline - the bold carries the emphasis the blueprint
  # gave <strong>. Clutch rating is linked to the profile (claims-canon).
  stats:
    - Starts in **days**
    - No equity, no lock-in
    - "[**4.8**/5 on Clutch](https://clutch.co/profile/jetthoughts)"

monthOne:
  headline: What a fractional CTO does in month one
  items:
    - Reads the codebase and tells you what state it's actually in
    - Sits in on your standups and tells you which ones are theatre
    - Writes the technical section of your investor update
    - Decides what gets rebuilt and what you can live with
    - Sends you the Friday report from week one

comparison:
  eyebrow: The maths
  headline: What you're comparing it against
  fractionalLabel: Fractional CTO
  fulltimeLabel: Full-time CTO
  rows:
    - label: Cost
      fractional: A fraction of a full-time hire
      fulltime: Full salary, benefits, and equity
    - label: Equity
      fractional: None
      fulltime: Typically required
    - label: Time to start
      fractional: Days
      fulltime: Months of hiring
    - label: If it isn't working
      fractional: You stop. No severance, no re-hire.
      fulltime: Severance and a re-hire
    - label: Best when
      fractional: Pre-Series A, or stabilising after a bad build
      fulltime: Post-Series A, with a team to own

steps:
  eyebrow: How it starts
  headline: Four weeks from first email to a plan you can act on
  intro: You don't sign a retainer to find out what's wrong. The assessment comes first.
  list:
    - title: Code review first
      body: "You send access. You get a written assessment: what's solid, what's fragile, what's going to cost you."
    - title: A 30-minute call
      body: We walk you through the assessment in plain English. Most founders take the document to their board whether or not they hire us.
    - title: Week one on the ground
      body: Your fractional CTO joins standups, reads the backlog, and sends the first Friday report.
    - title: Month one plan
      body: What gets rebuilt, what gets left alone, what it costs, in what order. You own the code and the plan.

clients:
  eyebrow: Clients + case studies
  headline: Clients stay for years, not quarters.
  stats:
    # `derived: tenure` is what makes the template compute the value from
    # site.Params.foundingYear. Keyed on its own field, not on the label -
    # a label-keyed branch falls back silently when someone rewords it.
    - derived: tenure
      label: Years of industry experience
    - value: "5"
      label: Years of average client relationship
    - value: 8+
      label: Years of average developer experience
  cases:
    - name: Agent Inbox
      body: Hired us to build their real-estate communication platform, get it market-ready, and grow the team around it.
      tech: [Rails, React, Node.js]
      url: /clients/agent-inbox/
    - name: Open Apply
      body: Hired us to debug their school-admissions product, optimize the user experience, and streamline internal project management.
      tech: [Rails, Hotwire, Tailwind]
      url: /clients/open-apply/
    - name: Mobile Coach
      body: Hired us to support and extend the products around their enterprise chatbot platform, and to scale their R&D and engineering teams.
      tech: [Rails, AWS, PostgreSQL]
      url: /clients/mobile-coach/

testimonial:
  eyebrow: From a client
  # VERBATIM tail of the canon description in data/testimonials.yaml (Bruno
  # Wozniak). The design blueprint had smoothed it to "They were detailed and
  # precise, helping us find problems..." - a real person's words are not copy
  # to tighten. Asserted by test/unit/next_rail_test.rb against the yaml.
  quote: Their team was also detailed and precise, helping us to find problems before they appear. We knew exactly what was happening and where we were going the whole time.
  attribution: Bruno Wozniak · Director of Engineering, PubNative
  sourceName: verified Clutch review
  sourceUrl: https://clutch.co/profile/jetthoughts
  proof:
    - "[**4.8**/5.0 on Clutch](https://clutch.co/profile/jetthoughts)"
    - "**5-year** average client relationship"

closing:
  headline: Still deciding?
  body: The consultation is free. The assessment is yours either way.
  cta:
    name: Book a free consultation
    url: /free-consultation/

footer:
  columns:
    - heading: Services
      links:
        - name: Fractional CTO
          url: /services/fractional-cto/
        - name: Fractional Product Management
          url: /services/fractional-product-management/
        - name: App/Web Development
          url: /services/app-web-development/
        - name: Talent Recruiting & Training
          url: /services/talent-recruiting-training/
    - heading: Proof
      links:
        - name: Clients
          url: /clients/
        - name: Use Cases
          url: /use-cases/
        - name: Friday report
          url: /friday-report/
    - heading: Learn
      links:
        - name: Blog
          url: /blog/
        - name: Course
          url: /course/tech-for-non-technical-founders-2026/
        - name: About us
          url: /about-us/
---
