# JT_Site Memory Namespace Standardization

## 🎯 Executive Summary

This document defines the **MANDATORY** memory namespace standards for all jt_site agents to ensure consistent coordination, quality tracking, and sprint workflow integration.

**Status**: ENFORCED  
**Compliance**: MANDATORY  
**Last Updated**: 2025-01-09  

---

## 📊 Standardized Memory Namespace Structure

### Root Namespace: `jt_site/`

All jt_site agent memory operations MUST use the `jt_site/` root namespace to prevent conflicts with other projects.

### Complete Namespace Taxonomy

```yaml
jt_site/
├── coordination/           # Cross-agent communication
│   ├── {agent_type}/      # Agent-specific coordination
│   │   └── {timestamp}/   # Time-based tracking
│   ├── handoff/           # Story handoff tracking
│   │   └── {story_id}/    # Per-story handoffs
│   └── sync/              # Synchronization points
│       └── {sprint}/      # Sprint synchronization
│
├── quality/               # Quality framework tracking
│   ├── validation/        # Validation results
│   │   ├── pre/          # Pre-implementation
│   │   ├── during/       # During-implementation
│   │   └── post/         # Post-implementation
│   ├── gates/            # Quality gate status
│   │   └── {gate_name}/  # Specific gate tracking
│   └── metrics/          # Quality metrics
│       └── {metric}/     # Individual metrics
│
├── anti_duplication/      # File duplication prevention
│   ├── files/            # File operation tracking
│   │   ├── created/      # New file creation
│   │   ├── modified/     # File modifications
│   │   └── validated/    # Validation results
│   ├── violations/       # Duplication violations
│   │   └── {timestamp}/  # Violation tracking
│   └── patterns/         # Pattern detection
│       └── {pattern}/    # Specific patterns
│
├── hugo_site/            # Hugo-specific coordination
│   ├── content/          # Content management
│   │   ├── posts/       # Blog posts
│   │   └── pages/       # Static pages
│   ├── templates/        # Template tracking
│   │   ├── layouts/     # Layout templates
│   │   └── partials/    # Partial templates
│   ├── config/          # Configuration
│   │   └── {env}/       # Environment configs
│   └── builds/          # Build tracking
│       └── {build_id}/  # Build-specific data
│
├── sprint/              # Agile workflow coordination
│   ├── {sprint_number}/ # Sprint-specific data
│   │   ├── stories/     # User stories
│   │   ├── tasks/       # Sprint tasks
│   │   ├── velocity/    # Velocity tracking
│   │   └── burndown/    # Burndown data
│   ├── backlog/         # Product backlog
│   │   └── {priority}/  # Prioritized items
│   └── ceremonies/      # Sprint ceremonies
│       ├── planning/    # Sprint planning
│       ├── standup/     # Daily standups
│       ├── review/      # Sprint reviews
│       └── retro/       # Retrospectives
│
└── learning/            # Ecosystem learning
    ├── patterns/        # Successful patterns
    │   ├── success/     # What worked
    │   └── failure/     # What didn't work
    ├── optimizations/   # Performance improvements
    │   └── {component}/ # Component-specific
    └── insights/        # Analytical insights
        └── {category}/  # Categorized insights
```

---

## 🔧 Usage Examples

### Coordination Memory

```bash
# Store cross-agent coordination
npx claude-flow@alpha hooks memory-store \
  --key "jt_site/coordination/content-creator/$(date +%s)" \
  --value "Created job story JT-001 for homepage redesign"

# Store story handoff
npx claude-flow@alpha hooks memory-store \
  --key "jt_site/coordination/handoff/JT-001/dev-to-qa" \
  --value "Story JT-001 handed off from development to QA"
```

### Quality Tracking

```bash
# Store pre-implementation validation
npx claude-flow@alpha hooks memory-store \
  --key "jt_site/quality/validation/pre/$(date +%s)" \
  --value "Zero-defect validation passed for template refactor"

# Track quality gate status
npx claude-flow@alpha hooks memory-store \
  --key "jt_site/quality/gates/functional-correctness" \
  --value "100% functional correctness achieved"
```

### Anti-Duplication Tracking

```bash
# Track file creation
npx claude-flow@alpha hooks memory-store \
  --key "jt_site/anti_duplication/files/created/$(date +%s)" \
  --value "Created new file: layouts/blog/single.html"

# Record duplication violation
npx claude-flow@alpha hooks memory-store \
  --key "jt_site/anti_duplication/violations/$(date +%s)" \
  --value "Prevented duplication: single_new.html blocked"
```

### Hugo Site Coordination

```bash
# Track content creation
npx claude-flow@alpha hooks memory-store \
  --key "jt_site/hugo_site/content/posts/$(date +%s)" \
  --value "Published: understanding-zero-defect-philosophy.md"

# Store build status
npx claude-flow@alpha hooks memory-store \
  --key "jt_site/hugo_site/builds/build-$(date +%s)" \
  --value "Build successful: 0 errors, 0 warnings"
```

### Sprint Workflow

```bash
# Track sprint story
npx claude-flow@alpha hooks memory-store \
  --key "jt_site/sprint/1/stories/JT-001" \
  --value "Story points: 5, Status: in-progress"

# Update burndown
npx claude-flow@alpha hooks memory-store \
  --key "jt_site/sprint/1/burndown/day-3" \
  --value "Remaining points: 32, Completed: 8"
```

---

## 📋 Agent-Specific Patterns

### Content-Creator (Product Owner)
```yaml
primary_namespaces:
  - jt_site/coordination/content-creator/*
  - jt_site/hugo_site/content/*
  - jt_site/sprint/*/stories/*
  - jt_site/sprint/backlog/*
```

### Hugo-Expert (Technical Lead)
```yaml
primary_namespaces:
  - jt_site/coordination/hugo-expert/*
  - jt_site/hugo_site/templates/*
  - jt_site/hugo_site/config/*
  - jt_site/quality/gates/*
```

### Hugo-Site-Developer (Developer)
```yaml
primary_namespaces:
  - jt_site/coordination/hugo-site-developer/*
  - jt_site/hugo_site/templates/*
  - jt_site/anti_duplication/files/*
  - jt_site/sprint/*/tasks/*
```

### SEO-Specialist (Quality)
```yaml
primary_namespaces:
  - jt_site/coordination/seo-specialist/*
  - jt_site/quality/validation/*
  - jt_site/quality/metrics/*
  - jt_site/hugo_site/content/*
```

### Build-Monitor (Scrum Master)
```yaml
primary_namespaces:
  - jt_site/coordination/build-monitor/*
  - jt_site/hugo_site/builds/*
  - jt_site/sprint/*/velocity/*
  - jt_site/sprint/*/burndown/*
```

---

## 🚨 Compliance Requirements

### MANDATORY Rules

1. **Always use `jt_site/` root** - Never store directly in global namespace
2. **Include timestamps** - Use `$(date +%s)` for time-based tracking
3. **Follow depth limits** - Maximum 4 levels deep
4. **Use consistent separators** - Always use `/` not `-` or `_` for paths
5. **Validate before storing** - Check namespace exists and is correct

### FORBIDDEN Patterns

❌ **DO NOT USE:**
- `quality/functional-correctness/*` (missing jt_site root)
- `jt-site/coordination/*` (hyphen instead of underscore)
- `jt_site_coordination_agent/*` (underscores instead of slashes)
- `jt_site/very/deep/nested/path/structure/*` (exceeds depth limit)

✅ **CORRECT:**
- `jt_site/quality/functional-correctness/*`
- `jt_site/coordination/agent/*`
- `jt_site/sprint/1/stories/*`

---

## 🔍 Validation Commands

### Check Namespace Compliance
```bash
# Validate namespace format
npx claude-flow@alpha hooks memory-search \
  --pattern "jt_site/*" \
  --validate-structure true

# Find non-compliant entries
npx claude-flow@alpha hooks memory-search \
  --pattern "*" \
  --exclude "jt_site/*" \
  --report-violations true
```

### Migration Support
```bash
# Migrate old namespaces
npx claude-flow@alpha hooks memory-migrate \
  --from "quality/*" \
  --to "jt_site/quality/*" \
  --dry-run false
```

---

## 📊 Monitoring & Reporting

### Namespace Usage Statistics
```bash
# Get namespace usage report
npx claude-flow@alpha hooks memory-stats \
  --namespace "jt_site/*" \
  --group-by "category" \
  --format "table"
```

### Cross-Agent Coordination Report
```bash
# Analyze coordination patterns
npx claude-flow@alpha hooks memory-analyze \
  --namespace "jt_site/coordination/*" \
  --report "cross-agent" \
  --timeframe "sprint"
```

---

## 🎯 Integration with Handbook

This namespace standard integrates with:
- **CLAUDE.md**: Section on Memory Coordination
- **Knowledge Base**: `/knowledge/35.12-memory-coordination-patterns-reference.md`
- **Zero-Defect Philosophy**: Quality tracking namespaces
- **Anti-Duplication System**: File operation tracking
- **Agile Framework**: Sprint workflow coordination

---

**ENFORCEMENT**: All agents MUST comply with these standards  
**VALIDATION**: Automatic validation on memory operations  
**COMPLIANCE**: Required for production deployment