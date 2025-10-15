# JT Site Agent Coordination Guide - Hybrid Approach

**Created**: 2025-10-15T14:15:00Z
**Purpose**: Resolve Content QA agent memory access issues with hybrid coordination

## Problem Summary

The Content QA agent reported memory access issues because upstream agents weren't storing their outputs in accessible locations. The memory system is functional, but agents need explicit instructions on WHERE to store outputs.

## Solution: Hybrid Coordination Pattern

### Strategy
- **Memory**: Store coordination metadata, status updates, and cross-references
- **Filesystem**: Store detailed work outputs, reports, and analysis documents
- **Benefit**: QA agents can check memory for status, then read filesystem for details

## Implementation Guidelines

### For Content Creation Workflow

#### Step 1: Content Creator Agent
```javascript
Task("Content Creator", "
**EXPLICIT WORK INSTRUCTIONS**:

**STEP 1 - CREATE content** (use Write tool):
```
Write file_path=\"content/blog/[slug].md\" with frontmatter and content
```

**STEP 2 - STORE metadata** (memory coordination):
Store in memory namespace: jt_site/content/created/[timestamp]
- Key: [slug]
- Value: {file_path, word_count, seo_keywords, created_at}

**STEP 3 - CREATE summary report** (use Write tool):
```
Write file_path=\"_runtime/content-creation-report-[timestamp].md\"
```

**CRITICAL**: You must USE these tools, not just coordinate.", "content-creator")
```

#### Step 2: SEO Specialist Agent
```javascript
Task("SEO Specialist", "
**EXPLICIT WORK INSTRUCTIONS**:

**STEP 1 - RETRIEVE content metadata** (memory):
```
Retrieve from: jt_site/content/created/*
```

**STEP 2 - READ content files** (use Read tool):
```
Read file_path=\"content/blog/[slug].md\"
```

**STEP 3 - ANALYZE and STORE results**:
- Memory: jt_site/seo/analysis/[timestamp]/[slug]
- Filesystem: _runtime/seo-analysis-[timestamp].md

**CRITICAL**: Document findings in BOTH locations.", "seo-specialist")
```

#### Step 3: Content QA Agent
```javascript
Task("Content QA", "
**EXPLICIT VALIDATION INSTRUCTIONS**:

**STEP 1 - CHECK memory for completion status**:
```
Search namespace: jt_site/content/created/*
Search namespace: jt_site/seo/analysis/*
```

**STEP 2 - READ work outputs** (use Read tool):
```
Read file_path=\"_runtime/content-creation-report-*.md\"
Read file_path=\"_runtime/seo-analysis-*.md\"
Read file_path=\"content/blog/[slug].md\"
```

**STEP 3 - VALIDATE and REPORT**:
- Memory: jt_site/qa/validation/[timestamp] (status: PASS/FAIL)
- Filesystem: _runtime/qa-validation-[timestamp].md (detailed findings)

**CRITICAL**: You must READ the actual files, not assume they exist.", "tester")
```

### For CSS Migration Workflow

#### Step 1: CSS Researcher
```javascript
Task("CSS Researcher", "
**EXPLICIT RESEARCH INSTRUCTIONS**:

**STEP 1 - ANALYZE CSS files** (use Read + Grep tools):
```
Read file_path=\"themes/beaver/assets/css/590-layout.css\"
Grep pattern=\"\\.fl-row\" --path \"themes/beaver/assets/css/\"
```

**STEP 2 - STORE findings in BOTH locations**:
- Memory: hugo/css/research/[timestamp]
  - Key: pattern_count
  - Value: {total_patterns: X, files_affected: Y, extraction_commands: [...]}
- Filesystem: _runtime/css-research-[timestamp].md
  - Detailed analysis with line numbers and code examples

**CRITICAL**: Store extraction commands so implementer knows exactly what to do.", "researcher")
```

#### Step 2: CSS Implementer
```javascript
Task("CSS Implementer", "
**EXPLICIT IMPLEMENTATION INSTRUCTIONS**:

**STEP 1 - RETRIEVE research** (memory + filesystem):
```
Retrieve from: hugo/css/research/*
Read file_path=\"_runtime/css-research-*.md\"
```

**STEP 2 - EXECUTE extractions** (use Edit tool):
```
Edit file_path=\"themes/beaver/assets/css/590-layout.css\"
old_string=\"[exact lines from research]\"
new_string=\"[PostCSS mixin call]\"
```

**STEP 3 - COMMIT and STORE progress**:
```
Bash command=\"cd /path && git add . && git commit -m 'Extract pattern X'\"
```
- Memory: hugo/css/implementation/[timestamp]/pattern_[N] (status: COMPLETED)
- Filesystem: _runtime/css-implementation-log-[timestamp].md

**CRITICAL**: Store progress after EACH extraction so QA can validate incrementally.", "coder")
```

#### Step 3: CSS QA Validator
```javascript
Task("CSS QA", "
**EXPLICIT VALIDATION INSTRUCTIONS**:

**STEP 1 - CHECK implementation status** (memory):
```
Search namespace: hugo/css/implementation/*
```

**STEP 2 - READ implementation log** (filesystem):
```
Read file_path=\"_runtime/css-implementation-log-*.md\"
```

**STEP 3 - RUN tests** (use Bash tool):
```
Bash command=\"cd /path && bin/rake test:critical\"
```

**STEP 4 - VALIDATE and REPORT**:
- Memory: hugo/css/validation/[timestamp] (status: ALL_TESTS_PASS)
- Filesystem: _runtime/css-qa-validation-[timestamp].md

**CRITICAL**: You must RUN tests yourself, not assume they pass.", "tester")
```

## Memory Namespace Conventions

### JT Site Namespaces
```yaml
jt_site_namespaces:
  content_creation: "jt_site/content/created/{timestamp}/{slug}"
  seo_analysis: "jt_site/seo/analysis/{timestamp}/{slug}"
  qa_validation: "jt_site/qa/validation/{timestamp}"
  coordination: "jt_site/coordination/{agent_type}/{timestamp}"

hugo_namespaces:
  css_research: "hugo/css/research/{timestamp}"
  css_implementation: "hugo/css/implementation/{timestamp}/pattern_{N}"
  css_validation: "hugo/css/validation/{timestamp}"
  architecture_decisions: "hugo/architecture/decisions/{timestamp}"
  template_patterns: "hugo/templates/patterns/{pattern_type}"
```

## Filesystem Organization

### Runtime Directory Structure
```
_runtime/
├── content-creation-report-{timestamp}.md
├── seo-analysis-{timestamp}.md
├── qa-validation-{timestamp}.md
├── css-research-{timestamp}.md
├── css-implementation-log-{timestamp}.md
└── css-qa-validation-{timestamp}.md
```

### Lifecycle Management
- **TTL**: 7 days for analysis reports
- **Cleanup**: Automatic after validation complete
- **Archive**: Move to docs/ if permanent documentation needed

## Validation Checklist

Before spawning jt_site agent swarm, verify:

- [ ] Each agent has EXPLICIT tool usage instructions (Read, Write, Edit, Bash)
- [ ] Each agent stores outputs in BOTH memory and filesystem
- [ ] Memory keys use consistent namespace patterns
- [ ] Filesystem outputs go to `_runtime/` directory
- [ ] Downstream agents RETRIEVE from upstream namespaces
- [ ] QA agents have verification steps (not assumptions)
- [ ] All bash commands include full paths and error handling
- [ ] Git commits happen after EACH incremental change

## Anti-Patterns to Avoid

### ❌ Vague Coordination Tasks
```javascript
// WRONG - Agent will run hooks and stop
Task("Researcher", "Analyze CSS patterns and coordinate with team", "researcher")
```

### ✅ Explicit Tool Usage
```javascript
// CORRECT - Agent knows exactly what to do
Task("Researcher", "
**STEP 1 - READ** (use Read tool):
```
Read file_path=\"themes/beaver/assets/css/590-layout.css\"
```

**STEP 2 - STORE** (memory + filesystem):
Memory: hugo/css/research/{timestamp}
Filesystem: _runtime/css-research-{timestamp}.md
", "researcher")
```

### ❌ Assuming Memory Access
```javascript
// WRONG - Agent assumes data exists
Task("QA", "Validate the CSS implementation quality", "tester")
```

### ✅ Explicit Retrieval
```javascript
// CORRECT - Agent retrieves and validates
Task("QA", "
**STEP 1 - RETRIEVE** (memory):
```
Search namespace: hugo/css/implementation/*
```

**STEP 2 - READ** (filesystem):
```
Read file_path=\"_runtime/css-implementation-log-*.md\"
```

**STEP 3 - VALIDATE** (run tests):
```
Bash command=\"bin/rake test:critical\"
```
", "tester")
```

## Success Criteria

- ✅ Content QA agent can access all upstream work outputs
- ✅ Memory namespaces contain coordination metadata
- ✅ Filesystem contains detailed work outputs
- ✅ No agent reports "waiting for content delivery"
- ✅ Cross-agent dependencies explicitly defined
- ✅ All validation steps use actual tool operations

## Implementation Status

**Memory System**: ✅ Functional (tested write/read operations)
**Agent Configurations**: ✅ Exist and reference memory coordination
**Workflow Design**: ⚠️ Needs hybrid coordination implementation
**Next Step**: Apply these patterns to jt_site agent task descriptions

---

**References**:
- CLAUDE.md: Lines 78-88 (RED phase memory patterns)
- content-creator.md: Lines 285-303 (memory coordination)
- hugo-expert.md: Lines 315-325 (Hugo namespaces)
