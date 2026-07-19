# Master prompt — course landing hero cover (2400×1260)

Reusable AI-design prompt for the "From Idea to First Paying Customer" landing hero.
Feed to Stitch / Claude / any design model. Written 2026-07-12; supersedes the
M1-M5 chip-cluster art (which conveyed no journey information).

---

Design a 2400×1260 hero cover for a free online course landing page.

AUDIENCE: a non-technical first-time founder with a business idea and no idea
what to do first. She judges credibility in 3 seconds from this image. Nothing
in the art may look like developer tooling (no terminals, no code, no IDE
chrome) - the course's promise is "you can do this without engineers."

LAYOUT CONTRACT (six slots, all mandatory):
1. Top-left: wordmark "JetThoughts" + separator + category label "COURSE INDEX"
   (small caps, letterspaced).
2. Top-right: filled pill, rounded, ruby red: "Free · 2026".
3. Left half, vertically centered, three-line headline as typographic art:
   line 1 "Idea to" (white, heavy), line 2 "First Paying Users" (ruby-to-purple
   gradient, same size), line 3 "5 modules · 20+ chapters" (white, ~60% size).
4. Right half: THE JOURNEY VISUAL - the reason this cover exists. A single
   left-to-right route from a small "idea" origin (lightbulb spark) through
   FIVE named stage nodes to a money endpoint:
     Hypothesis → Validate → Design → Build → First customer
   Requirements:
   - Each node carries its NAME (not "M1".."M5" - numbers alone are mute).
   - The route visibly passes through GATES: after Validate, a small branch
     glyph hinting go/pivot/kill (one forward arrow, one loop-back arc) -
     this is the course's core mechanic and no competitor cover shows it.
   - Endpoint is distinct: a green-accented coin/receipt glyph with a check,
     signaling real money, not a certificate.
   - The path may rise gently left-to-right (progress metaphor) but must stay
     inside the right half and never collide with the headline block.
5. Bottom-left: three stat chips (dark cards, colored left borders red/purple/
   blue), each "LABEL value" where the value is NOT already in the headline:
   "MODULES 5 stages" is FORBIDDEN (redundant with line 3). Use instead:
   "TEMPLATES all free" · "SETUP no signup" · "PACE evenings, 6-10 wks".
6. Bottom-right: status dot + letterspaced caps: "● OPEN CURRICULUM"
   (green dot).

STYLE TOKENS (JetVelocity / Obsidian Engine):
- Background: 135° gradient #0d1117 → #10141a → #1a0a2e, subtle dot grid,
  one soft radial purple glow behind the journey visual.
- Ruby #cc342d (pill, gradient start, chip border 1, route arrows).
- Neon purple #a855f7 (gradient end, chip border 2, one node accent).
- Green #2ea043 family ONLY for the money endpoint + status dot.
- Typography: modern grotesque (Inter/Space Grotesk family), tight tracking
  on headline; small caps + 0.08em tracking on labels.
- Flat vector, thin 2px strokes on nodes, no skeuomorphism, no stock people,
  no glassmorphism.

ANTI-REDUNDANCY AUDIT (reject the design if any is true):
- The journey visual repeats only what the headline says (module count) while
  naming nothing.
- Any stat chip value is inferable from the headline.
- The endpoint reads as "graduation/certificate" rather than "customer paid".

LEGIBILITY GATES:
- Every node name legible at 360×189 thumbnail (min ~26px at full canvas).
- No text within 24px of any container edge; no element crosses another's text.
- The whole composition must survive a 1200×630 og:image center-crop.
