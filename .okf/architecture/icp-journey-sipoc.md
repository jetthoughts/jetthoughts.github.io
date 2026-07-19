---
type: Reference
title: "ICP Journey SIPOC: Sam's Path Through the Course"
description: Visual Mermaid flowchart of Sam's full journey through all 25 lessons, gate thresholds, branch paths, and artifact handoffs. Machine-readable and human-readable.
resource: docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.05-icp-journey-sipoc.md
tags: [course, architecture, icp, journey-map]
timestamp: 2026-07-18T00:00:00Z
---

# 30.05 — ICP Journey SIPOC: Sam's Path Through the Course

**Status:** Canonical journey map — agent-parseable and human-readable
**Date:** 2026-07-18
**Purpose:** Visual source-of-truth for the full ICP journey. Agents can validate lesson ordering, gate thresholds, tool references, and artifact handoffs against this diagram. Humans can scan it to understand the course flow at a glance.

**ICP:** Sam — first-time non-technical founder, idea-stage, ~$20K savings, evenings/weekends pace, zero coding ability.
**Course promise:** Rough idea → signed paid pilot, no coding required.
**Total time:** 10-16 weeks at evenings-and-weekends pace (6-10 weeks full-time).

---

## Mermaid Flowchart (Machine-Readable)

```mermaid
%%{init: {'theme':'base', 'themeVariables': {'fontFamily':'Inter, system-ui, sans-serif', 'fontSize':'13px', 'primaryColor':'#f0f9f0', 'primaryBorderColor':'#2e7d32', 'lineColor':'#555', 'primaryTextColor':'#1a1a1a'}}}%%
flowchart TB
    %% ═══════════════════════════════════════
    %% ENTRY
    %% ═══════════════════════════════════════
    Start(["Rough idea"])
    Start --> HowWorks["Ch.0 · How This Course Works<br/>⏱ 10 min read<br/>📦 Map: 5 modules, 20+ lessons, 6 artifacts"]
    HowWorks --> QS(["Fast path? → Quickstart<br/>⏱ 3 min<br/>Core lessons only"])
    HowWorks --> FAQ(["Stuck? → FAQ<br/>15 Q&A"])

    %% ═══════════════════════════════════════
    %% MODULE 1: Hypothesis & Smoke Test
    %% ⏱ 2-3 weeks evenings, ~7 days full-time
    %% ═══════════════════════════════════════
    HowWorks --> M1_1
    QS --> M1_1
    subgraph M1["<b>MODULE 1 · Hypothesis & Smoke Test</b><br/>⏱ 2-3 weeks evenings / ~7 days full-time"]
        direction TB
        M1_1["1.1 · Form Your Founding Hypothesis<br/>🛠 Notebook + kitchen timer<br/>📦 Founding Hypothesis doc<br/>Gate: ≥14/20, no lens &lt;2"]
        M1_1 --> M1_1Gate{Score ≥14/20?}
        M1_1Gate -->|Yes| M1_2
        M1_1Gate -->|No| M1_1Fix["Fix: tighten blanks with Reddit/G2 quotes"]
        M1_1Fix --> M1_1

        M1_2["1.2 · Build Smoke-Test Page<br/>🛠 Mixo or Carrd<br/>📦 Live landing page URL<br/>Check: one stranger names who it's for in 3s"]
        M1_2 --> M1_2Gate{Stranger passes<br/>3-second test?}
        M1_2Gate -->|Yes| M1_3
        M1_2Gate -->|No| M1_2Fix["Fix: rewrite headline"]
        M1_2Fix --> M1_2

        M1_3["1.3 · Wire Tracking<br/>🛠 Microsoft Clarity + GA4<br/>📦 Tracking installed + verified"]
        M1_3 --> M1_4

        M1_4["1.4 · Run Smoke Test<br/>🛠 Meta/Google/LinkedIn/Reddit Ads<br/>📦 Conversion rate from 300 cold visitors"]
        M1_4 --> M1_4Gate{Conversion rate?}
        M1_4Gate -->|"&lt;3% Kill/Pivot"| M1_Kill["↩ Back to 1.1 — rewrite hypothesis"]
        M1_4Gate -->|"3–<6% Iterate"| M1_Iterate["Fix headline/audience, re-run"]
        M1_Iterate --> M1_4
        M1_4Gate -->|"≥6% Promising"| M1_5

        M1_5["1.5 · Price Hypothesis<br/>🛠 Stripe Payment Links<br/>📦 Click-to-payment signal"]
    end

    M1_5 --> M1_Out(["✅ M1 OUT: Founding Hypothesis + live landing page + tracking + conversion data + price signal"])
    M1_Out --> M2_1

    %% ═══════════════════════════════════════
    %% MODULE 2: Validate the Problem
    %% ⏱ 3-5 weeks full-time
    %% ═══════════════════════════════════════
    subgraph M2["<b>MODULE 2 · Validate the Problem</b><br/>⏱ 3-5 weeks full-time (booking interviews is the long pole)"]
        direction TB
        M2_1["2.1 · The Mom Test<br/>🛠 Mom Test Interview Script<br/>📦 5-8 past-tense question list"]
        M2_1 --> M2_2Detour{First time<br/>interviewing?}
        M2_2Detour -->|Yes optional| M2_2["2.2 · AI Persona Rehearsal<br/>🛠 Claude or ChatGPT<br/>📦 Sharpened question list"]
        M2_2Detour -->|No skip| M2_3
        M2_2 --> M2_3

        M2_3["2.3 · Find 10 People: Where<br/>🛠 Reddit, LinkedIn, X<br/>📦 30-name list"]
        M2_3 --> M2_4

        M2_4["2.4 · Find 10 People: What to Say<br/>🛠 Outreach Sequence Template<br/>📦 10 booked interviews"]
        M2_4 --> Interviews["▶ RUN 10 INTERVIEWS ◀<br/>⏱ Days, not one sitting<br/>Use 2.1 script<br/>Score each within 5 min of hanging up"]

        Interviews --> M2_5

        M2_5["2.5 · Synthesis: Build, Pivot, Kill<br/>🛠 Validated Problem Statement Template<br/>90 min: score 10 transcripts, count strong signals"]
        M2_5 --> M2_5Gate{Strong signals<br/>in 10 calls?}
        M2_5Gate -->|"≥7 BUILD"| M2_6
        M2_5Gate -->|"4-6 PIVOT"| M2_Pivot["↩ Back to 2.3 — refine ICP, run 5 more interviews"]
        M2_5Gate -->|"&lt;4 KILL"| M2_Kill["↩ Back to 1.1 — rewrite hypothesis, re-run 2.3"]

        M2_6["2.6 · Build Clickable Prototype<br/>🛠 Lovable<br/>📦 5 silent-observation sessions"]
        M2_6 --> M2_6Gate{"4+ of 5 pass?<br/>(silent observation)"}
        M2_6Gate -->|"No, fix"| M2_6Fix["Fix: iterate prototype<br/>based on observation notes"]
        M2_6Fix --> M2_6
    end

    M2_6Gate -->|"Yes, 4+ pass"| M2_Out(["✅ M2 OUT: 10 scored transcripts + build/pivot/kill decision + prototype feedback + verbatim vocabulary"])
    M2_Out --> M3_1

    %% ═══════════════════════════════════════
    %% MODULE 3: Design from Evidence
    %% ⏱ ~1 week
    %% ═══════════════════════════════════════
    subgraph M3["<b>MODULE 3 · Design from Evidence</b><br/>⏱ ~3-5 days (one evening + lunch-break check)"]
        direction TB
        M3_1["3.1 · One-Page Product Brief<br/>🛠 Vibe PRD Template<br/>📦 5-section brief (&le;250 words)"]
        M3_1 --> M3_2

        M3_2["3.2 · Quality-Check: Features → Outcomes<br/>🛠 Claude or ChatGPT<br/>📦 Outcome-shaped Section 3<br/>Gate: peer review names nothing outside no-go list"]
    end

    M3_2 --> M3_Out(["✅ M3 OUT: One-page Product Brief + outcome-shaped feature list + no-go list"])
    M3_Out --> M4_1

    %% ═══════════════════════════════════════
    %% MODULE 4: Build It Yourself
    %% ⏱ 2-4 weeks
    %% ═══════════════════════════════════════
    subgraph M4["<b>MODULE 4 · Build It Yourself</b><br/>⏱ 2-4 weeks"]
        direction TB
        M4_1["4.1 · Should You Hire?<br/>🛠 Build Path Decision Worksheet<br/>📦 4-way path: self-serve / validate / fractional CTO / hire"]
        M4_1 --> M4_1Gate{Build path?}
        M4_1Gate -->|Self-serve| M4_2["4.2 · Ownership Audit<br/>🛠 Ownership Checklist<br/>📦 All accounts in founder's name<br/>Applies to ALL paths"]
        M4_1Gate -->|Validate| M4_Validate["Validate without code<br/>Airbnb test"]
        M4_1Gate -->|Fractional CTO| M4_Frac["Fractional CTO bridge<br/>→ Hire-track supplementary reference"]
        M4_1Gate -->|Hire| M4_Hire["Hire a team<br/>→ SOW Reading Guide"]

        M4_Validate --> M4_2
        M4_Frac --> M4_2
        M4_Hire --> M4_2

        M4_2 --> M4_Route{Building it<br/>yourself?}
        M4_Route -->|Yes| M4_3
        M4_Route -->|No hired/frac| M4_HireRef["→ Hire-track ref / SOW Guide / Fractional CTO"]

        M4_3["4.3 · Self-Serve Stack: Tools & Setup<br/>🛠 Lovable + Supabase + Stripe<br/>📦 3 pre-flight rules locked + scope-leak watchlist"]
        M4_3 --> M4_4

        M4_4["4.4 · Self-Serve Stack: Build Phases<br/>🛠 Same stack + custom domain<br/>📦 Live MVP at real URL<br/>Gate: 5 green lights"]
        M4_4 --> M4_4Gate{5 green lights?}
        M4_4Gate -->|Yes| M4_Out
        M4_4Gate -->|No| M4_4Fix["Fix red light first"]
        M4_4Fix --> M4_4

        M4_Out(["✅ M4 OUT: Build-path decision + locked ownership + live MVP at real URL"])
    M4_Out -.->|"Optional: monthly after launch"| M4_5Opt["4.5 · Ceiling Signals<br/>🛠 Monthly calendar block<br/>📦 Ceiling signal watchlist"]
    M4_5Opt -.-> M5_1
    M4_Out -.->|"Optional"| M4_5Opt["4.5 · Ceiling Signals<br/>🛠 Monthly calendar block<br/>📦 Ceiling signal watchlist"]
    M4_5Opt --> M5_1
    M4_Out --> M5_1

    %% ═══════════════════════════════════════
    %% MODULE 5: First Paying Customer
    %% ⏱ 2-4 weeks
    %% ═══════════════════════════════════════
    subgraph M5["<b>MODULE 5 · First Paying Customer</b><br/>⏱ 2-4 weeks"]
        direction TB
        M5_1["5.1 · Sean Ellis 40% Test<br/>🛠 PMF Survey Template<br/>📦 Must-have segment identified<br/>Gate: 40%+ 'very disappointed'"]
        M5_1 --> M5_1Gate{40%+ very<br/>disappointed?}
        M5_1Gate -->|Yes| M5_2Detour
        M5_1Gate -->|No| M5_FixProduct["Fix the product before acquiring"]

        M5_2Detour{Need to pick<br/>a channel?}
        M5_2Detour -->|Yes optional| M5_2["5.2 · Choose Your Channel<br/>🛠 Channel Selection Framework<br/>📦 One committed channel"]
        M5_2Detour -->|No skip| M5_3
        M5_2 --> M5_3

        M5_3["5.3 · Build 50-Name Network List<br/>🛠 Google Sheet<br/>📦 50 names in 4 buckets"]
        M5_3 --> M5_4

        M5_4["5.4 · Write the Outreach Message<br/>🛠 Loom<br/>📦 4 message variants + 90s Loom"]
        M5_4 --> M5_5

        M5_5["5.5 · Send, Track, Read Replies<br/>🛠 Same spreadsheet<br/>📦 Demos booked"]
        M5_5 --> M5_6

        M5_6["5.6 · Charge Before You Ship<br/>🛠 DPA Template + Stripe<br/>📦 Signed DPA + cleared deposit<br/>Gate: $500+ deposit received"]
        M5_6 --> M5_6Gate{Deposit<br/>cleared?}
        M5_6Gate -->|Yes| M5_Out
        M5_6Gate -->|No| M5_6Fix["Objection-handle or move to next lead"]

        M5_FixProduct --> M4_4

        M5_Out(["🏁 COURSE COMPLETE<br/>Signed paid pilot<br/>First dollar from a customer, not a favor"])

    M5_FixProduct --> M4_4

    M5_Out -.->|"Optional: if warm list runs dry"| M5_7Opt["5.7 · Cold Outbound<br/>🛠 LinkedIn Sales Navigator<br/>📦 30 filtered messages, 1-2 pilots"]
    M5_7Opt -.-> GoingFurther
    M5_Out -.->|"Optional"| M5_7Opt["5.7 · Cold Outbound<br/>🛠 LinkedIn Sales Navigator<br/>📦 30 filtered messages, 1-2 pilots"]
    M5_7Opt --> GoingFurther
    M5_Out --> GoingFurther["Going Further chapters<br/>(trigger-based)<br/>Churn triage · Pivot/Persevere · Hire track<br/>Agency AI questions · Friday Demo Rule<br/>Weekly Dev Report · Org Chart"]

    %% ═══════════════════════════════════════
    %% STYLING
    %% ═══════════════════════════════════════
    classDef entry fill:#e8f4f8,stroke:#0277bd,stroke-width:2.5px,color:#1a1a1a
    classDef lesson fill:#fff,stroke:#555,stroke-width:1.5px,color:#1a1a1a
    classDef gate fill:#faf5ff,stroke:#a855f7,stroke-width:2px,color:#1a1a1a
    classDef kill fill:#ffebee,stroke:#c62828,stroke-width:2px,color:#1a1a1a
    classDef out fill:#f0f9f0,stroke:#2e7d32,stroke-width:2.5px,color:#1a1a1a
    classDef finish fill:#e8f5e9,stroke:#2e7d32,stroke-width:3px,color:#1a1a1a
    classDef optional fill:#f5f5f5,stroke:#999,stroke-width:1px,stroke-dasharray:5,color:#666
    classDef interview fill:#fff5f5,stroke:#cc342d,stroke-width:2px,color:#1a1a1a

    class Start,HowWorks entry
    class M1_1,M1_2,M1_3,M1_4,M1_5,M2_1,M2_3,M2_4,M2_5,M2_6,M3_1,M3_2,M4_1,M4_2,M4_3,M4_4,M5_1,M5_3,M5_4,M5_5,M5_6,M2_6Fix lesson
    class M1_1Gate,M1_2Gate,M1_4Gate,M2_5Gate,M2_6Gate,M4_1Gate,M4_4Gate,M5_1Gate,M5_2Detour,M5_6Gate gate
    class M1_Kill,M2_Kill kill
    class M1_Out,M2_Out,M3_Out,M4_Out out
    class M5_Out,GoingFurther finish
    class M2_2,M4_5Opt,M5_2,M5_7Opt,QS,FAQ optional
    class Interviews interview
```

---

## Text Summary (Human-Readable)

### Sam starts with: a rough idea, $20K savings, evenings/weekends, zero coding ability.

| Module | Input | Lessons (Core) | Gate | Output | Time |
|---|---|---|---|---|---|
| **M1: Hypothesis & Smoke Test** | Rough idea | 1.1 Hypothesis → 1.2 Landing page → 1.3 Tracking → 1.4 300 visitors → 1.5 Price button | ≥6% conversion from cold traffic | Founding Hypothesis + live page + conversion data + price signal | 2-3 weeks |
| **M2: Validate the Problem** | M1 artifacts | 2.1 Mom Test script → 2.3 Find people → 2.4 Book interviews → [run 10 interviews] → 2.5 Synthesis → 2.6 Prototype | ≥7/10 have spent time/money on problem | 10 scored transcripts + build/pivot/kill + prototype feedback | 3-5 weeks |
| **M3: Design from Evidence** | Validated problem + prototype vocab | 3.1 Product Brief → 3.2 Features→Outcomes | Every feature traces to interview quote | One-page brief + outcome-shaped feature list + no-go list | ~1 week |
| **M4: Build It Yourself** | Quality-checked brief | 4.1 Hire decision → 4.2 Ownership → 4.3 Stack setup → 4.4 Build phases | 5 green lights (Stripe live, custom domain, ICP tested, no errors, demo recording) | Live MVP at real URL with all accounts in founder's name | 2-4 weeks |
| **M5: First Paying Customer** | Live MVP | 5.1 PMF test → 5.3 Network list → 5.4 Outreach → 5.5 Send/track → 5.6 Paid pilot | $500+ deposit cleared via Stripe | Signed DPA + first dollar from a customer | 2-4 weeks |

### Branch paths (where Sam can loop back):
- **1.1 → 1.1**: Score <14/20 — tighten blanks
- **1.4 → 1.1**: <3% conversion — kill/pivot hypothesis
- **2.5 → 2.3**: 4-6 strong signals — pivot, refine ICP, 5 more interviews
- **2.5 → 1.1**: <4 strong signals — kill, rewrite hypothesis
- **4.4 → 4.4**: Red light — fix before advancing

### Optional detours:
- **2.2**: AI persona rehearsal (skip if interviewed before)
- **4.5**: Ceiling signals (monthly check, start after launch)
- **5.2**: Channel selection (skip if channel is obvious)
- **5.7**: Cold outbound (skip if warm network produced customers)

### Total artifacts (Founder OS): 6
Founding Hypothesis · Landing page · Validated Problem Statement · Product Brief · Live MVP · Signed paid pilot

---

## Agent Validation Checklist

Agents reading this diagram can validate:

- [ ] Every lesson slug in `data/course_sequence.yaml` appears as a node
- [ ] Gate thresholds match prose: ≥6% Promising (1.4), ≥7/10 build (2.5), $500+ deposit (5.6)
- [ ] Optional lessons are not prerequisites for core lessons in later modules
- [ ] Each module's output feeds the next module's first input
- [ ] No lesson references a tool that hasn't been introduced in a prior lesson
- [ ] Branch paths (pivot/kill) loop back to the correct re-entry point
- [ ] Time estimates are internally consistent (M1 2-3w + M2 3-5w + M3 ~1w + M4 2-4w + M5 2-4w = 10-17w evenings)
