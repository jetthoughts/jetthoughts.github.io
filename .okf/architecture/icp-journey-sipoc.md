---
type: Architecture Decision
title: ICP Journey SIPOC — Sam's Path Through the Course
description: Mermaid flowchart mapping every lesson, gate threshold, branch path, tool, time estimate, and artifact from rough idea to signed paid pilot. Agent-parseable; used to validate lesson ordering and dependency chains.
resource: docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.05-icp-journey-sipoc.md
tags: [course, icp, mermaid, journey, sipoc]
timestamp: 2026-07-18T00:00:00Z
---

# Overview

Canonical Mermaid flowchart of Sam's (the ICP) full journey through the
*From Idea to First Paying Customer* course — 25 lesson nodes from rough
idea to signed paid pilot. Every gate threshold, branch path, tool
annotation, time estimate, and artifact handoff is diagrammed.

When validating the course for ordering correctness, tool introduction
order, or gate-threshold consistency, agents should consume this diagram
first.

# Key elements

- **25 lesson nodes** — every slug from `data/course_sequence.yaml`
  represented as a diagram node
- **Gate diamonds** with exact thresholds: ≥6% Promising (1.4), ≥7/10
  build (2.5), 4+ of 5 prototype passes (2.6), $500+ deposit (5.6)
- **Branch paths** with correct re-entry points: pivot → 2.3, kill → 1.1
- **Tool annotations** per lesson (🛠) matching introduction order
- **Artifact outputs** per lesson (📦) feeding downstream lessons
- **Optional detours** on dotted edges: 2.2 (AI persona rehearsal), 4.5
  (ceiling signals), 5.2 (channel selection), 5.7 (cold outbound)
- **M4 routing gate**: all paths converge at ownership audit (4.2), then
  split — self-serve continues to stack build (4.3-4.4), non-self-serve
  terminates at external references

# Companion document

The [operational dependency map](/architecture/operational-dependency-map.md)
extends this journey with per-lesson operational prerequisites: what
accounts Sam needs, what templates he fills, where each `[BRACKET]`
placeholder value comes from upstream, and Plan B recovery paths.

# Agent validation checklist

- Every lesson slug in `data/course_sequence.yaml` appears as a node
- Gate thresholds match prose in their respective lessons
- Optional lessons are not prerequisites for core lessons
- Each module's output feeds the next module's first input
- No lesson references a tool introduced in a later lesson
- Branch paths loop back to correct re-entry points
- Time estimates are internally consistent (10-17w evenings)

# Citations

[1] `docs/projects/2605-tech-for-non-technical-founders/30-39-architecture-design/30.05-icp-journey-sipoc.md`
[2] `data/course_sequence.yaml`
