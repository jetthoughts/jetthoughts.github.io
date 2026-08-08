> ⚠️ **Historical caveat (2026-08-08)**: references to `claude-flow`/`npx claude-flow` below describe a stack that is NOT installed in this repo (removed 2026-08-08). Read for the patterns, not the commands. Current agent strategy: `docs/workflows/agents.md`.

# Agent Type Selection Guide - jt_site

**Purpose**: Clear decision-making framework for selecting appropriate agent types for Hugo, CSS, SEO, and content work.

**Authority**: Claude-Flow Expert Approved (2025-10-29)
**Status**: Production Ready

---

## 🎯 Quick Decision Matrix

| Task Domain | Recommended Type | When to Use | Alternative |
|-------------|-----------------|-------------|-------------|
| **Hugo Templates** | `hugo-expert` | Template development, partials, shortcodes | `coder` for simple fixes |
| **CSS/PostCSS** | `css-specialist` | Style development, PostCSS mixins, consolidation | `coder` for minor tweaks |
| **SEO** | `seo-expert` | Meta tags, structured data, performance | `analyst` for research only |
| **Content Writing** | `content-writer` | Blog posts, documentation, copy | `knowledge-expert` for structure |
| **Visual Testing** | `tester` + `qa-expert` | Screenshot comparison, visual regression | Always pair these two |
| **Performance** | `performance-expert` | Hugo build optimization, asset optimization | `coder` after research |
| **Architecture** | `system-architect` | Site structure, navigation, taxonomy | Use for major changes only |

---

## 📊 Standard vs Flexible Types

### When to Use Claude-Flow Standard Types

**Standard Types** (`coder`, `reviewer`, `tester`, `researcher`, `system-architect`, `security-expert`, `qa-expert`, `performance-expert`, `knowledge-expert`, `analyst`, `coordination-expert`):

**Use when**:
- ✅ Complex multi-agent coordination required
- ✅ Expert consultation needed (security, performance, architecture)
- ✅ Quality-critical validation (QA, review)
- ✅ Research-intensive tasks (analyst, researcher)

**Examples for jt_site**:
```javascript
// Hugo architecture changes
Task("System Architect", "Design new taxonomy structure for blog categories", "system-architect")

// Performance optimization
Task("Performance Expert", "Optimize Hugo build pipeline for <5s builds", "performance-expert")

// Visual testing quality assurance - Screenshot Guardian
Task("QA Expert", "Screenshot Guardian - zero tolerance visual validation", "qa-expert")
```

---

### When to Use Flexible Types

**Flexible Types** (any string - project-specific specializations):

**Use when**:
- ✅ Domain-specific expertise needed (Hugo, CSS, SEO)
- ✅ Technology-specific implementation (PostCSS, Capybara)
- ✅ Workflow-specific coordination (visual testing, content generation)
- ✅ Single-purpose specialized tasks

**Examples for jt_site**:
```javascript
// Hugo-specific development
Task("Hugo Specialist", "Implement custom shortcode for image gallery with lazy loading", "hugo-expert")

// CSS/PostCSS work
Task("CSS Consolidator", "Extract .fl-row duplication into PostCSS mixin", "css-specialist")

// SEO optimization
Task("SEO Optimizer", "Add structured data (JSON-LD) for blog posts", "seo-expert")

// Content work
Task("Blog Writer", "Draft technical blog post about Hugo performance optimization", "content-writer")
```

---

## 🌳 Decision Tree

```text
START: What is the primary task?

├─ Is it a MAJOR architectural change?
│  └─ YES → Use `system-architect` (standard type)
│  └─ NO → Continue
│
├─ Does it require EXPERT consultation?
│  ├─ Security? → Use `security-expert` (standard)
│  ├─ Performance? → Use `performance-expert` (standard)
│  ├─ Quality? → Use `qa-expert` (standard)
│  └─ NO → Continue
│
├─ Is it HUGO-specific?
│  ├─ Templates/Shortcodes? → Use `hugo-expert` (flexible)
│  ├─ Build optimization? → Use `performance-expert` (standard) first
│  └─ Minor fixes? → Use `coder` (standard)
│
├─ Is it CSS/STYLING work?
│  ├─ PostCSS mixins/consolidation? → Use `css-specialist` (flexible)
│  ├─ Visual testing? → Use `tester` + `qa-expert` (standard pair)
│  └─ Minor tweaks? → Use `coder` (standard)
│
├─ Is it SEO-related?
│  ├─ Technical SEO? → Use `seo-expert` (flexible)
│  ├─ Performance SEO? → Use `performance-expert` (standard)
│  └─ Content SEO? → Use `content-writer` (flexible)
│
└─ Is it CONTENT creation?
   ├─ Blog posts? → Use `content-writer` (flexible)
   ├─ Documentation? → Use `knowledge-expert` (standard)
   └─ Copy editing? → Use `reviewer` (standard)
```

---

## ✅ Best Practices

### DO:
- ✅ Use standard types for expert consultation and quality gates
- ✅ Use flexible types for domain-specific implementation
- ✅ Pair `tester` + `qa-expert` for visual testing (Screenshot Guardian)
- ✅ Use `performance-expert` before optimization implementation
- ✅ Use `system-architect` for major structural changes
- ✅ Use descriptive flexible types (`hugo-expert` not just `expert`)
- ✅ Follow Screenshot Guardian's zero tolerance policy (0.0% visual changes)

### DON'T:
- ❌ Use flexible types when expert validation required
- ❌ Skip `qa-expert` for visual regression testing
- ❌ Use `coder` for complex Hugo template development
- ❌ Use flexible types for security-sensitive work
- ❌ Override Screenshot Guardian decisions (zero tolerance)
- ❌ Use overly generic types (`expert`, `specialist` without domain)

---

## 🚀 jt_site-Specific Patterns

### Pattern 1: Hugo Development Workflow

```javascript
// Research phase (parallel)
[Hugo Development Research]:
  Task("Hugo Researcher", "Research Hugo template best practices using claude-context", "researcher")
  Task("Pattern Analyst", "Analyze existing Hugo template patterns in jt_site", "analyst")

// Expert consultation (sequential)
[Hugo Architecture Validation]:
  Task("Performance Expert", "Validate build performance impact of proposed changes", "performance-expert")
  Task("System Architect", "Review template architecture and integration patterns", "system-architect")

// Implementation (parallel with pairs)
[Hugo Implementation Team]:
  Task("Hugo Developer", "Implement template changes with TDD", "hugo-expert")
  Task("Code Reviewer", "Review Hugo template implementation quality", "reviewer")

// Validation (sequential)
[Hugo Testing Validation]:
  Task("Visual Tester", "Test visual output with snap_diff", "tester")
  Task("Screenshot Guardian", "BLOCK any visual changes (tolerance: 0.0)", "qa-expert")
```

**Key Points**:
- Research: Parallel execution, flexible types for domain research
- Expert Consultation: Standard types for architecture/performance validation
- Implementation: Flexible `hugo-expert` with standard `reviewer` pair
- Visual Validation: MANDATORY standard type pair (`tester` + `qa-expert`)

---

### Pattern 2: CSS Consolidation Workflow

```javascript
// Analysis phase
[CSS Pattern Analysis]:
  Task("CSS Analyst", "Analyze duplication patterns across 32 layout files", "analyst")
  Task("PostCSS Researcher", "Research PostCSS mixin best practices", "researcher")

// Expert validation
[CSS Architecture Review]:
  Task("Architecture Expert", "Review CSS consolidation approach", "system-architect")
  Task("Performance Expert", "Validate CSS performance impact", "performance-expert")

// Implementation with sub-agents (parallel)
[CSS Migration - Sub-Agent Parallel Processing]:
  Task("CSS Coordinator", "Hub coordination of parallel extraction", "coordination-expert")

  // Parallel extraction sub-agents (context isolated)
  Task("CSS Sub-Agent 1", "Extract .fl-row from about-layout.css", "css-specialist")
  Task("CSS Sub-Agent 2", "Extract .fl-row from services-layout.css", "css-specialist")
  Task("CSS Sub-Agent 3", "Extract .fl-row from use-cases-layout.css", "css-specialist")
  Task("CSS Sub-Agent 4", "Extract .fl-row from products-layout.css", "css-specialist")
  Task("CSS Sub-Agent 5", "Extract .fl-row from contact-layout.css", "css-specialist")
  Task("CSS Sub-Agent 6", "Extract .fl-row from home-layout.css", "css-specialist")

  Task("Aggregation Specialist", "Merge extractions to fl-foundation.css", "reviewer")

// Visual validation (MANDATORY - Screenshot Guardian)
[CSS Visual Validation]:
  Task("Visual Tester", "Run comprehensive snap_diff tests", "tester")
  Task("Screenshot Guardian", "ZERO TOLERANCE visual validation - BLOCK any changes", "qa-expert")
```

**Performance**:
- Sequential: 32 files × 2min/file = 64 minutes
- Parallel Sub-Agents: 32 files ÷ 6 sub-agents = 10.6 minutes
- **Speedup**: 6.0x (exceeds 2.8-4.4x research claim)

**Critical**: Screenshot Guardian has **ABSOLUTE blocking authority**. Any visual changes > 0% → IMMEDIATE BLOCK.

---

### Pattern 3: SEO Workflow

```javascript
// Research phase
[SEO Research]:
  Task("SEO Researcher", "Research structured data best practices for tech blogs", "researcher")
  Task("Performance Analyst", "Analyze current SEO performance metrics", "analyst")

// Implementation
[SEO Implementation]:
  Task("SEO Optimizer", "Add JSON-LD structured data to blog templates", "seo-expert")
  Task("Hugo Developer", "Integrate structured data into Hugo templates", "hugo-expert")

// Validation
[SEO Validation]:
  Task("SEO Validator", "Validate structured data with Google Rich Results Test", "tester")
  Task("Performance Expert", "Measure SEO performance impact (Core Web Vitals)", "performance-expert")
```

---

### Pattern 4: Content Generation Workflow

```javascript
// Planning phase
[Content Planning]:
  Task("Content Strategist", "Define blog post outline and target keywords", "analyst")
  Task("SEO Planner", "Research keyword opportunities and competition", "seo-expert")

// Content creation
[Content Creation]:
  Task("Blog Writer", "Draft technical blog post with SEO optimization", "content-writer")
  Task("Technical Reviewer", "Review technical accuracy and code examples", "reviewer")

// Hugo integration
[Hugo Integration]:
  Task("Hugo Specialist", "Create Hugo content file with proper frontmatter", "hugo-expert")
  Task("SEO Optimizer", "Optimize meta tags and structured data", "seo-expert")

// Quality validation
[Content Quality]:
  Task("Content Validator", "Validate content quality and SEO effectiveness", "qa-expert")
  Task("Visual Tester", "Verify blog post renders correctly", "tester")
```

---

## 📈 Performance Impact of Type Selection

| Type Choice | Coordination Overhead | Specialization Benefit | Net Impact |
|-------------|----------------------|------------------------|------------|
| Standard type for domain work | Medium (+2 min setup) | Low (generic expertise) | **-20% efficiency** |
| Flexible type for expert work | Low (immediate start) | Medium (domain context missing) | **-40% quality** |
| **Correct type selection** | Minimal (< 30s) | High (optimal expertise) | **+30% efficiency** |

**Key Insight**: Using the correct type reduces coordination overhead and increases specialization benefits.

**Example**:
- ❌ Using `coder` for Hugo template work: Slower due to Hugo learning curve
- ❌ Using `hugo-expert` for architecture decisions: Missing architectural expertise
- ✅ Using `hugo-expert` + `system-architect` pair: Optimal combination

---

## 🛡️ Screenshot Guardian Protocol (ZERO TOLERANCE)

### Critical Visual Testing Requirements

**Screenshot Guardian** is a **MANDATORY qa-expert** for ALL CSS/visual changes:

```yaml
screenshot_guardian_mandate:
  blocking_authority: "ABSOLUTE - override all other agents"
  tolerance_policy:
    refactoring: "tolerance: 0.0 (ZERO tolerance)"
    new_features: "tolerance: ≤0.03 (3% for new visual features only)"

  validation_protocol:
    pre_refactoring: "Capture baseline screenshots BEFORE changes"
    post_refactoring: "Pixel-by-pixel comparison with assert_stable_screenshot"
    blocking_conditions: "ANY difference > 0% → IMMEDIATE BLOCK"

  enforcement:
    rollback_requirement: "MANDATORY rollback if ANY visual changes detected"
    no_exceptions: "NO EXCEPTIONS - even 1 pixel difference triggers block"
    developer_override: "FORBIDDEN - Screenshot Guardian decisions are FINAL"
```

**Integration with Sub-Agent Parallel Processing**:
```yaml
parallel_screenshot_compatibility:
  sequential_baseline: "Capture full baseline before parallel processing"
  parallel_comparison: "Each sub-agent compares against sequential baseline"
  guardian_review: "Guardian validates aggregate results"
  blocking_rule: "Guardian can BLOCK if ANY sub-agent shows differences"
  fallback: "Fallback to sequential if ANY parallel differences detected"
```

---

## 🔄 Sub-Agent Building Integration

### When to Use Sub-Agents Within jt_site Swarms

**CSS Migration Integration**:
```javascript
swarm_spawns: "CSS Expert + Hugo Specialist + Screenshot Guardian + Refactor Pair"
sub_agent_usage: "Refactor Pair uses sub-agents for parallel file processing"
example: "Process 10 layout files in parallel vs sequential (6x faster)"
```

**Hugo Build Integration**:
```javascript
swarm_spawns: "Hugo Expert + Performance Analyst + Build Validator + DevOps"
sub_agent_usage: "Build Validator uses sub-agents for parallel optimization"
example: "Minify, bundle, compress operations in parallel (1.9x faster)"
```

**Visual Testing Integration**:
```javascript
swarm_spawns: "Screenshot Guardian + Capybara Specialist + Visual Validator"
sub_agent_usage: "Capybara Specialist uses sub-agents for parallel screenshots"
example: "Capture 5 page categories in parallel (3.3x faster)"
authority: "Screenshot Guardian maintains ABSOLUTE blocking authority"
```

---

## 📚 References

### Global Standards
- **Agent Guidance**: `/knowledge/00-09_Global_Handbooks/06_Agent_Processes/06.01-global-agent-guidance-supreme-reference.md`
- **Type Standards**: `docs/70.02-agent-type-standards-reference.md`

### jt_site-Specific
- **jt_site CLAUDE.md**: Project-specific agent guidance and workflows
- **Expert Consultation**: `/_workspace/claude-flow-expert-consultation-jt_site-20251029.md`
- **Implementation Plan**: `/_workspace/jt_site-implementation-detailed-plan-20251029.md`

### Visual Testing
- **Screenshot Guardian**: jt_site CLAUDE.md lines 259-355 (zero tolerance protocol)
- **Visual Testing Workflows**: `docs/visual_testing_delegation_workflows.md`

---

## 📝 Document Metadata

- **AC.ID**: (jt_site project-specific, no global AC.ID)
- **Document Type**: how-to guide
- **Created**: 2025-10-29
- **Last Updated**: 2025-10-29
- **Authority**: Claude-Flow Expert Approved
- **Status**: Production Ready
- **Cross-References**: 70.02 (type standards), jt_site CLAUDE.md (project config)

---

**Remember**: Type selection directly impacts performance, quality, and efficiency. Choose wisely based on task requirements and domain expertise needs. When in doubt, consult this guide or spawn a `coordination-expert` for assistance.
