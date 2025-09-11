# Claude Code Configuration - Agile SPARC Development Environment

## 🏃 AGILE SPRINT MANAGEMENT FRAMEWORK

### ⚡ CRITICAL DISTINCTION: Sprints vs Iterations vs Micro-Refactoring

**IMPORTANT**: This configuration properly separates three distinct concepts:

```yaml
hierarchy_clarification:
  sprints:
    definition: "2-week development periods for major goal achievement"
    duration: "14 days"
    team_capacity: "400 hours (5 developers × 2 weeks × 40 hours)"
    contains: "2 weekly iterations"
    focus: "Sprint goal delivery and stakeholder value"
    
  iterations:
    definition: "1-week development cycles within sprints"
    duration: "7 days"
    team_capacity: "200 hours (5 developers × 40 hours)"
    purpose: "Focused development work with rapid feedback"
    planning_unit: "Primary unit for capacity and story planning"
    
  micro_refactoring:
    definition: "Quality technique for safe code changes during development"
    scope: "Individual code modifications within iteration tasks"
    size_limit: "3 lines per change, 50 lines per task"
    purpose: "Maintain code quality and prevent regressions"
    relationship: "Technique used WITHIN iteration development work"

key_understanding:
  - "Iterations are NOT 3-line changes"
  - "Iterations are 1-week development cycles with 5 developers"
  - "Micro-refactoring is a quality technique used during iterations"
  - "WIP limits apply at iteration level, not micro-change level"
```

### 📅 Sprint and Iteration Structure

**SPRINT FRAMEWORK**: 2-week sprints containing 2 weekly iterations for focused development cycles.

```yaml
sprint:
  number: 1
  name: "Foundation Sprint"
  duration: "2 weeks"  # Contains 2 weekly iterations
  start_date: "2025-01-06"
  end_date: "2025-01-20"
  velocity_target: 40
  total_capacity: 400  # hours (5 developers × 2 weeks × 40 hours)
  
iteration_structure:
  iteration_1:
    duration: "1 week"
    dates: "2025-01-06 to 2025-01-12"
    team_size: 5  # developers
    capacity_per_developer: 40  # hours per week
    total_iteration_capacity: 200  # hours (5 × 40)
    focus: "Foundation setup and core implementation"
    
  iteration_2:
    duration: "1 week"
    dates: "2025-01-13 to 2025-01-20"
    team_size: 5  # developers
    capacity_per_developer: 40  # hours per week
    total_iteration_capacity: 200  # hours (5 × 40)
    focus: "Integration, testing, and sprint goal completion"

team_capacity_calculation:
  developers: 5
  hours_per_developer_per_week: 40
  weekly_iteration_capacity: 200  # hours
  sprint_capacity: 400  # hours (2 iterations)
  focus_factor: 75%  # actual productive time
  effective_sprint_capacity: 300  # hours
```

### 🎯 WIP LIMITS ENFORCEMENT (MANDATORY)

**CRITICAL: All development MUST follow strict WIP limits at iteration and developer levels:**

```yaml
wip_limits:
  # Organizational Level
  active_goals: 1        # Only ONE goal at a time
  active_sprints: 1      # Only ONE sprint active
  active_iterations: 1   # Only ONE iteration active at a time
  
  # Team Level (per iteration)
  active_job_stories: 3  # Maximum 3 stories in progress (5 developers)
  active_tasks: 5        # One task per developer maximum
  
  # Developer Level
  stories_per_developer: 1     # Only ONE story per developer
  tasks_per_developer: 1       # Only ONE task per developer
  micro_changes_per_task: unlimited  # 3-line changes within tasks
  
wip_enforcement:
  iteration_level: true    # Enforce at weekly iteration level
  developer_level: true    # Enforce at individual developer level
  micro_change_level: false # Micro-refactoring is a technique, not WIP unit
  block_exceeding: true
  alert_at_100_percent: true
  auto_validation: true
  cooperative_decomposition: required
```

### 📊 Sprint Goals & Job Stories

#### Current Sprint Goal
**Primary Objective**: Establish Agile-compliant CLAUDE.md structure with hugo site quality framework integration

### 📝 Job Stories Format (Complete Templates)

#### Job Story Template Structure

```yaml
job_story_template:
  format: "When I [situation], I want to [motivation], so I can [expected outcome]"

  components:
    situation:
      description: "The context and circumstances when the need arises"
      examples:
        - "When I am reviewing pull requests"
        - "When I need to deploy a new feature"
        - "When I encounter a bug in production"

    motivation:
      description: "What the user wants to accomplish (the desire)"
      examples:
        - "I want to ensure code quality standards"
        - "I want to minimize deployment risks"
        - "I want to quickly identify root causes"

    expected_outcome:
      description: "The benefit or value delivered (the outcome)"
      examples:
        - "so I can maintain high code quality across the team"
        - "so I can deploy with confidence and minimal downtime"
        - "so I can restore service quickly and prevent recurrence"

  quality_criteria:
    - independent: "Can be developed and delivered independently"
    - negotiable: "Details can be discussed and refined"
    - valuable: "Delivers clear business or user value"
    - estimable: "Size and complexity can be estimated"
    - small: "Can be completed within one sprint"
    - testable: "Has clear acceptance criteria"
```

#### Job Story Examples for JT Site Development

```yaml
example_job_stories:
  content_management:
    id: "JT-CONTENT-001"
    story: "When I am creating new blog posts, I want to use standardized templates and workflows, so I can maintain consistency and reduce publishing time"
    acceptance_criteria:
      - given: "A new blog post needs to be created"
        when: "I use the content creation workflow"
        then: "The post follows standard structure and is ready for review"
    story_points: 5

  site_performance:
    id: "JT-PERF-001"
    story: "When I deploy site updates, I want automated performance validation, so I can ensure user experience remains optimal"
    acceptance_criteria:
      - given: "Site changes are ready for deployment"
        when: "Performance tests run automatically"
        then: "Performance metrics meet or exceed baseline requirements"
    story_points: 8

  accessibility_compliance:
    id: "JT-A11Y-001"
    story: "When I develop new site features, I want automated accessibility checking, so I can ensure compliance with WCAG guidelines"
    acceptance_criteria:
      - given: "New UI components are implemented"
        when: "Accessibility tests are executed"
        then: "All components meet WCAG 2.1 AA standards"
    story_points: 3
```

#### Active Job Story Template
```yaml
job_story_format: "When I [situation], I want to [motivation], so I can [expected outcome]"

active_job_story:
  id: "JT-001"
  story: "When I am developing the JT site, I want to have a comprehensive Agile CLAUDE.md configuration, so I can ensure sprint-driven development with quality gates"
  acceptance_criteria:
    - given: "Agent spawning for JT site development"
      when: "Agents follow Agile CLAUDE.md configuration"
      then: "All agents operate within WIP limits and sprint boundaries"
  definition_of_done:
    - code_complete: true
    - tests_passing: true
    - code_reviewed: true
    - sprint_goal_aligned: true
```

## 📚 KNOWLEDGE-DRIVEN DEVELOPMENT

**This project follows comprehensive knowledge management practices. All agents MUST consult the structured knowledge base before proposing solutions.**

**Knowledge Base Location**: `/knowledge/` - Complete practices, processes, solutions, and templates
**Documentation Base Location**: `/docs/` - Project documentation and architectural decisions
**Knowledge Index**: `/knowledge/KNOWLEDGE_INDEX.md` - Navigation guide for all knowledge

### 🎯 Core Knowledge Principles
1. **Package-Search Priority Development**: Use `package-search` MCP as PRIMARY tool for dependency research, `claude-context` for local patterns, `context7` as fallback only. MANDATORY: AC.82.01
2. **Pattern Consistency**: Follow established patterns from knowledge base solutions
3. **Quality Assurance**: Apply comprehensive validation checklists for all implementations
4. **Security-First**: Implement security practices from knowledge base frameworks
5. **TDD Methodology**: Follow test-driven development from knowledge base practices
6. **Agile Compliance**: Follow sprint boundaries, WIP limits, and cooperative decomposition

### 🎯 Quality Framework Integration (MANDATORY)

**CRITICAL UPDATE**: All Hugo site development agents MUST follow the enhanced quality framework for zero-defect development.

#### Quality Framework References (HIGHEST PRIORITY)

- **`/knowledge/90.01-zero-defect-philosophy-explanation.md`** - Zero-Defect Philosophy (MANDATORY CONSULTATION)
- **`/knowledge/90.02-prevention-first-methodology-how-to.md`** - Prevention-First Methodology
- **`/knowledge/90.03-consistency-pattern-library-reference.md`** - Consistency Pattern Library
- **`/knowledge/36.01-technical-debt-elimination-how-to.md`** - Technical Debt Elimination Protocols

#### Enhanced Quality Gate Coordination

```yaml
quality_framework_integration:
  zero_defect_philosophy: true
  prevention_first_methodology: required
  consistency_pattern_validation: true
  technical_debt_elimination: mandatory
  
hugo_quality_coordination_hooks:
  pre_task_quality_validation: |
    # Consult quality framework before any Hugo site task
    echo "📊 Quality Framework Consultation: $TASK"
    echo "   - AC.90.01: Zero-Defect Philosophy"
    echo "   - AC.90.02: Prevention-First Methodology" 
    echo "   - AC.90.03: Consistency Pattern Library"
    echo "   - AC.36.01: Technical Debt Elimination"
    
  during_task_quality_monitoring: |
    # Continuous quality validation during Hugo development
    echo "🔍 Quality Monitoring: Ensuring zero-defect site quality"
    
  post_task_quality_assessment: |
    # Final quality compliance validation
    echo "✅ Quality Assessment Complete: Zero defects in site development"
```

#### Hugo Site Quality Considerations

**Hugo-Specific Quality Framework Application:**

1. **Content Quality**: Zero tolerance for broken links, missing images, or malformed markdown
2. **Performance Quality**: Optimal build times and fast page loading with proper optimization
3. **Accessibility Quality**: Full compliance with WCAG guidelines and semantic HTML
4. **SEO Quality**: Proper metadata, structured data, and search engine optimization
5. **Visual Quality**: Consistent design, responsive layout, and cross-browser compatibility

#### Memory Namespace Patterns for Quality Framework

```bash
# Quality framework coordination namespaces for Hugo site
quality/hugo/zero-defect/*           # Zero-defect validation results
quality/hugo/prevention-first/*      # Prevention-first methodology application
quality/hugo/consistency/*           # Consistency pattern validation
quality/hugo/technical-debt/*        # Technical debt elimination tracking
quality/hugo/content-quality/*       # Content quality validation results
quality/hugo/performance/*           # Performance optimization tracking
```

## 👥 AGILE AGENT ROLES & COORDINATION

### 🎭 Scrum Team Agent Configuration

#### Product Owner Agent
```yaml
name: "product-owner"
responsibilities:
  - backlog_prioritization
  - acceptance_criteria_definition
  - stakeholder_communication
  - sprint_goal_setting
  - job_story_validation
hooks:
  pre: |
    echo "🎯 Product Owner: Validating sprint goals and WIP limits"
    npx claude-flow@alpha hooks pre-sprint --role "product-owner" --validate-wip
  post: |
    echo "✅ Product Owner: Sprint acceptance validation complete"
    npx claude-flow@alpha hooks post-sprint --validate-acceptance
```

#### Scrum Master Agent
```yaml
name: "scrum-master"
responsibilities:
  - impediment_removal
  - ceremony_facilitation
  - wip_limits_enforcement
  - team_velocity_tracking
  - process_improvement
  - cooperative_decomposition_coordination
hooks:
  daily: |
    echo "📋 Scrum Master: Facilitating daily standup with WIP validation"
    npx claude-flow@alpha hooks daily-standup --collect-updates --validate-wip
  sprint: |
    echo "🔄 Scrum Master: Sprint ceremony coordination"
    npx claude-flow@alpha hooks sprint-ceremony --type "$CEREMONY_TYPE"
```

#### Development Team Agents (5-Developer Team)
```yaml
team_composition:
  - name: "lead-developer"
    capacity: 40  # hours per iteration (1 week)
    sprint_capacity: 80  # hours per sprint (2 weeks)
    skills: ["architecture", "hugo", "javascript", "mentoring"]
    wip_limit: 1  # one story at a time
    
  - name: "hugo-developer"
    capacity: 40  # hours per iteration
    sprint_capacity: 80  # hours per sprint
    skills: ["hugo", "markdown", "scss", "javascript", "testing"]
    wip_limit: 1
    
  - name: "frontend-developer"
    capacity: 40  # hours per iteration
    sprint_capacity: 80  # hours per sprint
    skills: ["css", "javascript", "responsive-design", "accessibility"]
    wip_limit: 1
    
  - name: "content-developer"
    capacity: 40  # hours per iteration
    sprint_capacity: 80  # hours per sprint
    skills: ["content-creation", "seo", "markdown", "accessibility"]
    wip_limit: 1
    
  - name: "qa-engineer"
    capacity: 40  # hours per iteration
    sprint_capacity: 80  # hours per sprint
    skills: ["testing", "accessibility", "performance", "validation"]
    wip_limit: 1

iteration_capacity_totals:
  weekly_iteration: 200  # hours (5 × 40)
  sprint_total: 400      # hours (2 × 200)
  effective_capacity: 300 # hours (75% focus factor)
```

### Agent Memory Coordination
```bash
# Each agent uses unique coordination key with sprint context
tests/generated/{agent-name}/sprint-{number}/*

# Check existing tests before creating new ones
npx claude-flow@alpha hooks memory-search \
  --pattern "tests/generated/*" \
  --key "*{test-topic}*" \
  --sprint-context "sprint-1"

# Store sprint-specific progress
npx claude-flow@alpha hooks memory-store \
  --key "sprint/1/progress/{agent-name}" \
  --value "$TASK_PROGRESS"
```

### Quick Reference Resources
- **Quick Reference**: `/knowledge/20.04-tdd-quick-reference.md`
- **Implementation Guide**: `/knowledge/20.03-tdd-enforcement-how-to.md`
- **Standards Reference**: `/knowledge/20.01-tdd-standards-reference.md`
- **Methodology Details**: `/knowledge/32.01-tdd-methodology-explanation.md`

## 🗂️ KNOWLEDGE ORGANIZATION REQUIREMENTS

### 📋 Johnny Decimal + Diátaxis Compliance (MANDATORY)

**ALL new content in `/knowledge/` and `/docs/` folders MUST follow these standards:**

#### File Naming Convention
```
AC.ID-content-type.md
```

Where:
- **AC** = Area Code (10-99)
- **ID** = Unique identifier within area (01-99)
- **content-type** = Diátaxis classification

**Example**: `20.15-testing-tutorial.md` (Area 20, ID 15, Tutorial content)

#### Johnny Decimal Areas (Required Structure)
```
10-19  Core Development Practices
20-29  Testing & Quality Assurance
30-39  Architecture & Design Patterns
40-49  Security & Compliance
50-59  Deployment & Operations
60-69  Project Management & Processes
70-79  Templates & Boilerplates
80-89  Integration & APIs
90-99  System Administration
```

#### Diátaxis Content Classification (Required)
- **tutorial** - Learning-oriented step-by-step guides
- **how-to** - Problem-solving oriented practical guides
- **explanation** - Understanding-oriented theoretical background
- **reference** - Information-oriented lookup materials

### 🔍 Content Health Standards

#### Mandatory Quality Gates for All Knowledge Content
1. **Structural Integrity**
   - Johnny Decimal compliance check
   - Diátaxis classification verification
   - Cross-reference validation
   - Naming convention adherence

2. **Content Quality Standards**
   - Clear, actionable headings
   - Consistent terminology usage
   - Complete examples and code snippets
   - Links to related content

3. **Duplication Prevention**
   - Content similarity scanning
   - Redundancy elimination
   - Consolidation recommendations
   - Cross-reference optimization

4. **Consistency Monitoring**
   - Template adherence checking
   - Style guide compliance
   - Formatting standardization
   - Metadata completeness

### 🛡️ Enforcement Mechanisms

#### Pre-Content Creation Validation
**ALL agents creating knowledge/docs content MUST:**

1. **Research Phase** (Before Writing):
```bash
# Search existing content for duplication
claude-context search "[topic]" --path "/knowledge/" --limit 20
claude-context search "[topic]" --path "/docs/" --limit 20

# Validate Johnny Decimal area assignment
echo "🏷️ Assigning Johnny Decimal area for: [topic]"
echo "🔍 Checking area availability in current structure"

# Determine Diátaxis classification
echo "📚 Content type classification:"
echo "- Tutorial: Step-by-step learning guide?"
echo "- How-to: Problem-solving guide?"
echo "- Explanation: Conceptual background?"
echo "- Reference: Lookup information?"
```

2. **Structure Validation** (During Creation):
```bash
# Validate file naming convention
filename_pattern="^[0-9]{2}\.[0-9]{2}-(tutorial|how-to|explanation|reference)\.md$"
echo "✅ Filename follows AC.ID-content-type.md pattern"

# Check Johnny Decimal area consistency
area_code=$(echo "$filename" | cut -d'.' -f1)
echo "🗂️ Area code: $area_code - Validating against established areas"

# Verify Diátaxis classification alignment
content_type=$(echo "$filename" | grep -o '\-(tutorial|how-to|explanation|reference)' | sed 's/-//')
echo "📖 Content type: $content_type - Validating content structure"
```

3. **Cross-Reference Maintenance** (After Creation):
```bash
# Update knowledge index
echo "📇 Updating /knowledge/KNOWLEDGE_INDEX.md with new entry"

# Validate cross-references
echo "🔗 Checking all internal links for validity"

# Trigger reindexing for search optimization
echo "🔄 Triggering knowledge base reindexing"
```

### 🚨 Zero-Legacy Knowledge Policy

**CRITICAL: All knowledge management follows zero-legacy tolerance:**

1. **Immediate Compliance**: No grandfathering of existing content - ALL content must be migrated to new structure
2. **Complete Migration**: Partial compliance is not acceptable - full Johnny Decimal + Diátaxis adoption required
3. **Automated Enforcement**: Pre-commit hooks prevent non-compliant content creation
4. **Continuous Monitoring**: Real-time validation of all knowledge/docs changes

### 📊 Knowledge Health Metrics

**Required monitoring and reporting:**

1. **Structural Health**: 100% Johnny Decimal + Diátaxis compliance
2. **Content Quality**: >95% content quality score
3. **Cross-Reference Integrity**: 0 broken internal links
4. **Duplication Rate**: <5% content similarity
5. **Search Optimization**: >90% findability score

## 🔄 COOPERATIVE DECOMPOSITION PROTOCOLS

### 🧩 Task Decomposition Framework

**MANDATORY: All job stories MUST be cooperatively decomposed following Agile principles:**

```yaml
cooperative_decomposition:
  job_story_breakdown:
    max_story_points: 8
    min_story_points: 1
    ideal_story_points: 3-5
  
  decomposition_process:
    1. "Identify user value delivery"
    2. "Break into testable increments"
    3. "Ensure independent deliverables"
    4. "Validate INVEST criteria"
    5. "Assign story points cooperatively"
  
  invest_criteria:
    independent: required
    negotiable: required
    valuable: required
    estimable: required
    small: required
    testable: required
```

#### Decomposition Agent Coordination
```bash
# Cooperative story decomposition
echo "🧩 Starting cooperative decomposition for: $JOB_STORY"
npx claude-flow@alpha hooks decompose-story \
  --story "$JOB_STORY" \
  --agents "product-owner,scrum-master,hugo-developer" \
  --validate-invest

# Store decomposition results
npx claude-flow@alpha hooks memory-store \
  --key "decomposition/sprint-1/$STORY_ID" \
  --value "$DECOMPOSITION_RESULT"
```

## 🧬 MICRO-REFACTORING DEVELOPMENT TECHNIQUE

### Development Quality Protocol (Used Within Iterations)

**IMPORTANT DISTINCTION**: Micro-refactoring is a DEVELOPMENT TECHNIQUE used WITHIN weekly iterations, NOT the definition of iterations themselves.

**CLARIFICATION**:
- **ITERATIONS**: 1-week development cycles (200 hours with 5 developers)
- **MICRO-REFACTORING**: Quality technique for making small, safe changes during development
- **SPRINTS**: 2-week periods containing 2 iterations

#### The 3-Line Micro-Refactoring Technique (Quality Practice)
```yaml
micro_refactoring_technique:
  purpose: "Safe, testable changes during iteration development"
  scope: "Individual code changes within iteration tasks"
  max_lines_per_micro_change: 3
  max_total_lines_per_task: 50  # Within iteration tasks
  test_after_each_change: required
  rollback_on_failure: automatic
  continuous_validation: true
  
context_clarification:
  used_within: "Weekly iteration development work"
  not_used_for: "Defining iteration duration or capacity"
  relationship: "Quality technique supporting iteration delivery"
  wip_application: "Applied to individual code changes, not iteration planning"
```

#### Implementation Protocol (Within Iteration Tasks)

**Phase 1: Iteration Task Breakdown**
- Break iteration tasks into small, manageable units
- Apply micro-refactoring technique to individual code changes
- Plan maximum 50 lines total per iteration task
- Identify rollback points for each micro-change
- Ensure each micro-change is independently testable

**Iteration Context**:
- Micro-refactoring applies to code changes WITHIN iteration tasks
- Iteration planning focuses on story delivery and team capacity
- Quality technique supports but doesn't define iteration structure

**Phase 2: Micro-Change Execution** 
```bash
# Execute EVERY change as micro-step
for micro_change in "${micro_changes[@]}"; do
    # 1. Make 3-line change
    apply_micro_change "$micro_change"
    
    # 2. Test immediately
    if ! run_tests; then
        echo "❌ ROLLBACK: Micro-change failed tests"
        git checkout -- .
        exit 1
    fi
    
    # 3. Validate working state
    verify_system_stability
done
```

**Phase 3: Continuous Validation**
- Test after EVERY 3-line change
- Validate system remains in working state
- Rollback immediately on any failure
- Document successful micro-patterns

#### Rollback Procedures

**Immediate Rollback Triggers:**
- Any test failure after micro-change
- System instability detected
- Build failure or compilation error
- Performance degradation detected

**Rollback Execution:**
```bash
# Automatic rollback protocol
rollback_micro_change() {
    echo "🔄 Rolling back failed micro-change..."
    git checkout -- .
    echo "✅ System restored to last working state"
    validate_rollback_success
}
```

#### Agent Integration Requirements

**ALL AGENTS MUST (During Iteration Development):**
1. **Plan iteration tasks**: Decompose iteration work into deliverable units
2. **Apply micro-refactoring**: Use 3-line technique for code changes within tasks
3. **Execute incrementally**: Apply micro-changes one step at a time within tasks
4. **Test continuously**: Validate after each micro-change
5. **Rollback immediately**: Revert failed micro-changes
6. **Document patterns**: Record successful micro-refactoring patterns

**Iteration vs Micro-Refactoring Distinction**:
- **Iteration Planning**: Focus on story delivery, team capacity, weekly goals
- **Micro-Refactoring**: Focus on safe code changes during development
- **Integration**: Micro-refactoring supports iteration delivery quality

#### Handbook Compliance Integration

**Core Handbook Principles (ENFORCED):**
- **Always start fixing bugs with reproduction test**
- **Avoid fallbacks - fail fast, do not hide errors**
- **Do not override or monkey patch external dependencies**  
- **Use always the simplest naive solutions (KISS, YAGNI)**
- **After each new change check tests - rollback on fail**
- **ENFORCE: Use TDD only for adding new behaviors; micro refactoring for refinement**
- **Split work into smallest non-breaking tasks with intensive test verification**
- **Guarantee working solution at any time**
- **Prioritize radical KISS, YAGNI, Readability, Low Cognitive Load**

## 🔍 PACKAGE-SEARCH MCP PRIORITY (MANDATORY)

**STATUS**: PRODUCTION ACTIVE  
**COMPLIANCE**: MANDATORY for all Hugo/Jekyll dependency research  
**REFERENCE**: AC.82.01 Package-Search MCP Priority

### Core Mandate for jt_site

**ALL Hugo site agents MUST prioritize package-search MCP** for external dependency research:

```yaml
research_hierarchy:
  1_primary: "package-search MCP - npm, golang packages for Hugo/Jekyll"
  2_secondary: "claude-context - local Hugo patterns and config"
  3_fallback: "context7 - documentation only when package-search unavailable"
```

### Required Usage Pattern for Hugo Development

```python
# MANDATORY: Search Hugo-related packages FIRST
mcp__package-search__package_search_hybrid(
    registry_name="npm",  # For Hugo/Jekyll npm packages
    package_name="hugo",  # Or "jekyll", "postcss", etc.
    semantic_queries=["static site generation", "template patterns", "build optimization"],
    pattern=r"hugo|jekyll|static.*site"
)

# For Go packages (Hugo is written in Go)
mcp__package-search__package_search_hybrid(
    registry_name="golang_proxy",
    package_name="gohugoio/hugo",
    semantic_queries=["template rendering", "content processing"],
    pattern=r"func.*Render|type.*Page"
)
```

### Hugo/Jekyll Specific Examples

- **Template patterns**: `semantic_queries=["Hugo template functions", "Jekyll liquid templates"]`
- **Build optimization**: `semantic_queries=["static site build performance", "asset pipeline"]`
- **CSS/PostCSS**: `semantic_queries=["PostCSS configuration", "TailwindCSS Hugo integration"]`
- **SEO patterns**: `semantic_queries=["SEO optimization for static sites"]`

### Validation Requirements

```bash
# Pre-task validation for Hugo agents
echo "🔍 Package Search Priority: ACTIVE for Hugo/Jekyll"
echo "📦 Searching for static site patterns in: $PACKAGE_NAME"

# Post-task metrics
echo "✅ Package-search utilized for Hugo dependency research"
```

## 🛡️ VERIFICATION-FIRST DEVELOPMENT (MANDATORY)

### Prevent Regressions Through Verification

**ALL development work MUST start with verification to prevent issues like the PostCSS bug that was "fixed" 3+ times.**

#### Core Principle: Reproduce Before Fix
**No work begins without a failing test that proves the issue exists.**

### The Verification-First Protocol

#### 1️⃣ START with Reproduction Test (MANDATORY - BLOCKING)
```javascript
Task("Developer", `
  🚨 MANDATORY BLOCKING PROTOCOL - NO EXCEPTIONS:
  
  BEFORE any work:
  1. 🚨 MUST create reproduction test that FAILS:
     - Run in production mode: HUGO_ENVIRONMENT=production hugo --minify
     - Test MUST fail to prove issue exists
     - BLOCKED from proceeding if test passes
  
  2. 🚨 MUST save test command for re-verification:
     - Store test in memory: reproduction-tests/[ISSUE]/command
     - Document expected failure behavior
  
  3. 🚨 BLOCKING: Cannot start fix until test fails correctly
     - No work begins without failing reproduction test
     - Verify test reproduces exact issue
  
  MANDATORY TEST ENFORCEMENT:
  - Run bin/test before starting - BLOCKED if fails
  - Run bin/test after reproduction test creation
  - AUTOMATIC rollback on any test regression
`, "coder")
```

#### 2️⃣ Use claude-context for Comprehensive Search (MANDATORY - BLOCKING)
```javascript
Task("Developer", `
  🚨 MANDATORY COMPREHENSIVE SEARCH - NO EXCEPTIONS:
  
  BEFORE any fixes:
  1. 🚨 MUST run bin/test - BLOCKED if fails
  
  2. 🚨 MUST use claude-context (NOT grep):
     - Index if needed: npx claude-context index_codebase --path "."
     - Search ALL patterns: npx claude-context search_code --query "[issue]" --path "."
     - Search variations: case-sensitive, case-insensitive, partial matches
  
  3. 🚨 MUST create COMPLETE inventory:
     - Find ALL affected files (not just first few)
     - Include all file types: html, js, css, md, json, yaml
     - Store in memory: npx claude-flow@alpha hooks memory-store --key "work/[TASK]/inventory"
  
  4. 🚨 BLOCKING: Must report "Found X files" BEFORE starting:
     - List ALL files found
     - Verify inventory completeness
     - BLOCKED from starting fixes without complete inventory
  
  5. 🚨 MUST run bin/test after search to establish baseline
  
  ZERO TOLERANCE: Incomplete search leads to regression bugs
`, "researcher")
```

#### 3️⃣ Track Progress with Memory (MANDATORY - BLOCKING)
```javascript
Task("Developer", `
  🚨 MANDATORY PROGRESS TRACKING - BLOCKING COMPLETION:
  
  TRACK all changes with TEST VALIDATION:
  
  - After finding each file:
    npx claude-flow@alpha hooks memory-store --key "work/[TASK]/[FILE]" --value "found"
    
  - After fixing each file:
    🚨 MUST run bin/test immediately - AUTOMATIC rollback if fails
    npx claude-flow@alpha hooks memory-store --key "work/[TASK]/[FILE]" --value "fixed"
    
  - After verifying each file:
    🚨 MUST run bin/test again to confirm stability
    npx claude-flow@alpha hooks memory-store --key "work/[TASK]/[FILE]" --value "verified"
  
  BLOCKING COMPLETION REQUIREMENTS:
  
  1. 🚨 MUST run reproduction test with empty cache
  2. 🚨 MUST run bin/test - BLOCKED if any test fails
  3. 🚨 MUST verify ALL files marked as "verified" in memory
  4. 🚨 MUST verify bin/build, bin/dev still work
  5. 🚨 BLOCKED from claiming success until ALL requirements met
  
  ZERO TOLERANCE: Cannot claim completion with failing tests
`, "coder")
```

### MANDATORY TEMPLATE FOR ALL WORK (BLOCKING ENFORCEMENT)

**ALL development tasks MUST use this template with ZERO TOLERANCE:**

```javascript
Task("Verification-First Developer", `
  🚨 MANDATORY VERIFICATION-FIRST PROTOCOL - NO EXCEPTIONS:
  
  🛑 PRE-WORK BLOCKING VALIDATION:
  - MUST run bin/test BEFORE starting - BLOCKED if fails
  - Cannot proceed without passing tests
  
  🧪 STEP 1: REPRODUCE (MANDATORY - BLOCKING)
  - 🚨 MUST write test that FAILS showing the issue
  - 🚨 MUST run test command: [specific command]
  - 🚨 BLOCKED from proceeding if test doesn't fail
  - 🚨 MUST run bin/test after reproduction test
  
  🔍 STEP 2: SEARCH (MANDATORY - COMPREHENSIVE)
  - 🚨 MUST use claude-context: search_code --query "[search]" --path "."
  - 🚨 MUST find ALL related files (not just first few)
  - 🚨 MUST list all files found BEFORE starting
  - 🚨 MUST store complete inventory in memory
  - 🚨 BLOCKED from starting without complete inventory
  
  🔧 STEP 3: FIX (MANDATORY TEST ENFORCEMENT)
  - Fix files systematically ONE AT A TIME
  - 🚨 MUST run bin/test after EACH file change
  - 🚨 AUTOMATIC ROLLBACK: git checkout -- . if tests fail
  - 🚨 CANNOT proceed to next file until tests pass
  - Track progress in memory for each file
  
  ✅ STEP 4: VERIFY (BLOCKING COMPLETION)
  - 🚨 MUST run reproduction test - MUST now pass
  - 🚨 MUST run bin/dtest - ALL tests must pass
  - 🚨 MUST verify bin/build works
  - 🚨 MUST verify bin/dev works
  - 🚨 BLOCKED from claiming success until ALL verifications pass
  
  ZERO TOLERANCE: No shortcuts, no exceptions, no bypass
`, "coder")
```

### Why This Prevents Regressions

1. **Reproduction Test**: Ensures we understand the actual problem
2. **claude-context Search**: Finds ALL instances, not just obvious ones
3. **Memory Tracking**: Prevents forgetting what was checked
4. **Empty Cache Testing**: Reveals hidden dependencies

### Memory Pattern (Simplified)

```yaml
work/
  [task_name]/
    test_command     # The reproduction test
    inventory        # All files found
    [file_path]      # Status: found|fixed|verified
```

### Quick Verification Commands

```bash
# Search comprehensively
npx claude-context search_code --query "PostCSS" --path "."

# Track in memory
npx claude-flow@alpha hooks memory-store --key "work/TASK/file.html" --value "fixed"

# Check progress
npx claude-flow@alpha hooks memory-search --pattern "work/TASK/*" --key "*"

# Verify with empty cache
rm -rf public resources/_gen && hugo --environment production
```

#### Enforcement Mechanisms

```bash
# Hook integration for micro-change validation
pre_change_validation() {
    echo "🧬 Validating micro-change compliance..."
    
    # Check change size
    local lines_changed=$(git diff --cached --numstat | awk '{sum+=$1+$2} END {print sum}')
    if [[ $lines_changed -gt 3 ]]; then
        echo "❌ BLOCKING: Change exceeds 3-line limit ($lines_changed lines)"
        return 1
    fi
    
    # Ensure tests exist and pass
    if ! run_comprehensive_tests; then
        echo "❌ BLOCKING: Tests must pass before micro-change"
        return 1
    fi
}

post_change_validation() {
    echo "🔍 Validating micro-change success..."
    
    # Run tests immediately after change
    if ! run_comprehensive_tests; then
        echo "❌ ROLLBACK: Tests failed after micro-change"
        git checkout -- .
        return 1
    fi
    
    echo "✅ Micro-change validated successfully"
}
```

#### Verification Requirements

**MANDATORY VERIFICATION AFTER EACH MICRO-CHANGE (BLOCKING):**

1. **Immediate Test Validation (MANDATORY - BLOCKING)**
   ```bash
   # 🚨 MUST run after EVERY 3-line change - NO EXCEPTIONS
   mandatory_test_validation() {
       echo "🚨 MANDATORY: Testing after micro-change"
       
       # Run comprehensive test suite - BLOCKING
       if ! bin/test; then
           echo "❌ AUTOMATIC ROLLBACK: Tests failed"
           git checkout -- .
           echo "🚫 BLOCKED: Cannot proceed with failing tests"
           exit 1
       fi
       
       # Additional validations
       hugo build --verbose --dry-run || { git checkout -- .; exit 1; }
       npm run lint || { git checkout -- .; exit 1; }
       
       echo "✅ Micro-change validation passed"
   }
   ```

2. **System Stability Verification (MANDATORY - BLOCKING)**
   ```bash
   # 🚨 MUST verify system remains in working state
   mandatory_system_stability() {
       echo "🚨 MANDATORY: System stability verification"
       
       # Test Hugo server functionality
       if ! timeout 30 hugo server --bind 0.0.0.0 --port 1313 >/dev/null 2>&1 &; then
           echo "❌ AUTOMATIC ROLLBACK: Hugo server broken"
           git checkout -- .
           exit 1
       fi
       
       local hugo_pid=$!
       sleep 5
       
       if ! curl -f http://localhost:1313/ >/dev/null 2>&1; then
           kill $hugo_pid 2>/dev/null
           echo "❌ AUTOMATIC ROLLBACK: Site not accessible"
           git checkout -- .
           exit 1
       fi
       
       kill $hugo_pid 2>/dev/null
       echo "✅ System stability verified"
   }
   ```

3. **Performance Impact Validation (MANDATORY - BLOCKING)**
   ```bash
   # 🚨 MUST ensure no performance regression
   mandatory_performance_validation() {
       echo "🚨 MANDATORY: Performance regression check"
       
       # Get baseline if not exists
       if [ ! -f ".baseline_build_time" ]; then
           echo "Establishing baseline build time..."
           time hugo build 2>&1 | grep real | awk '{print $2}' > .baseline_build_time
       fi
       
       local baseline=$(cat .baseline_build_time)
       local current=$(time hugo build 2>&1 | grep real | awk '{print $2}')
       
       # Simple comparison (simplified - could be enhanced)
       if [ "$current" != "$baseline" ]; then
           echo "⚠️ Performance change detected: $baseline -> $current"
           # Could implement more sophisticated comparison here
       fi
       
       echo "✅ Performance validation completed"
   }
   ```

**MANDATORY REVERIFICATION PROTOCOL (BLOCKING):**
- 🚨 ALL agents MUST use paired validation (coder + reviewer) - NO EXCEPTIONS
- 🚨 Complex changes (>1 micro-step) REQUIRE reviewer agent verification - BLOCKING
- 🚨 Critical changes (security, architecture) MANDATE paired validation - BLOCKING  
- 🚨 Simple changes (≤3 lines) REQUIRE post-completion validation - BLOCKING
- 🚨 ALL changes MUST pass bin/test before reviewer validation
- 🚨 Reviewer MUST run bin/test independently before approval
- 🚨 BLOCKED from merging without reviewer + test validation
- 🚨 AUTOMATIC rollback if post-review tests fail

## 📈 AGILE METRICS & SPRINT TRACKING

### 🔥 Velocity Tracking & Burndown
```yaml
velocity_metrics:
  current_sprint: 35  # story points
  rolling_average: 38  # last 3 sprints
  capacity_utilization: 87.5%
  
burndown_chart:
  ideal_line: linear
  actual_progress: [40, 35, 32, 28, 24, 20, 15, 10, 5, 0]
  current_day: 5
  remaining_points: 24
  
wip_metrics:
  goals_in_progress: 1
  sprints_active: 1
  job_stories_active: 1
  tasks_active: 1
  wip_efficiency: 98.2%
```

### 🎯 Prioritization Frameworks

#### MoSCoW Method Implementation

```yaml
moscow_prioritization:
  framework:
    must_have:
      description: "Critical requirements that must be delivered for success"
      criteria:
        - business_critical: "Essential for business operation"
        - compliance_required: "Regulatory or legal requirement"
        - user_blocking: "Prevents core user workflows"
      jt_site_examples:
        - responsive_design: "Site must work on all devices"
        - content_publishing: "Ability to publish and manage blog content"
        - site_performance: "Page load times under 3 seconds"

    should_have:
      description: "Important but not critical; can be delayed if necessary"
      criteria:
        - user_experience: "Significantly improves user experience"
        - competitive_advantage: "Provides business differentiation"
        - efficiency_gain: "Improves operational efficiency"
      jt_site_examples:
        - advanced_search: "Enhanced content search capabilities"
        - social_sharing: "Social media integration and sharing"
        - newsletter_signup: "Email subscription functionality"

    could_have:
      description: "Nice to have features that add value but aren't essential"
      criteria:
        - enhancement: "Enhances existing functionality"
        - convenience: "Provides user convenience"
        - future_planning: "Sets foundation for future features"
      jt_site_examples:
        - dark_mode: "Dark theme option for users"
        - comment_system: "Blog post commenting functionality"
        - content_rating: "User rating system for articles"

    wont_have:
      description: "Features explicitly excluded from current scope"
      criteria:
        - out_of_scope: "Not aligned with current objectives"
        - resource_intensive: "Requires more resources than available"
        - low_value: "Provides minimal user or business value"
      jt_site_examples:
        - e_commerce: "Online store functionality"
        - user_accounts: "User registration and profiles"
        - real_time_chat: "Live chat support system"

  prioritization_process:
    step_1_requirement_gathering:
      - identify_all_requirements: "List all potential features and requirements"
      - stakeholder_input: "Collect input from all stakeholders"
      - user_research: "Validate requirements against user needs"

    step_2_moscow_classification:
      - collaborative_categorization: "Team assigns MoSCoW categories"
      - business_value_assessment: "Evaluate business impact of each item"
      - technical_feasibility: "Assess implementation complexity"

    step_3_validation_refinement:
      - stakeholder_review: "Validate categorization with stakeholders"
      - capacity_alignment: "Ensure Must/Should items fit sprint capacity"
      - dependency_analysis: "Identify and resolve dependencies"
```

#### WSJF (Weighted Shortest Job First) Calculations

```yaml
wsjf_prioritization:
  calculation_formula:
    wsjf_score: "(User_Business_Value + Time_Criticality + Risk_Reduction) / Job_Size"

  scoring_criteria:
    user_business_value:
      scale: "1-10 (Fibonacci: 1, 2, 3, 5, 8)"
      definition: "Relative benefit to users and business"

    time_criticality:
      scale: "1-10 (Fibonacci: 1, 2, 3, 5, 8)"
      definition: "How time-sensitive the feature is"

    risk_reduction:
      scale: "1-10 (Fibonacci: 1, 2, 3, 5, 8)"
      definition: "How much risk the feature mitigates"

    job_size:
      scale: "1-13 (Fibonacci: 1, 2, 3, 5, 8, 13)"
      definition: "Relative size/effort required for implementation"

  jt_site_wsjf_examples:
    responsive_design:
      user_business_value: 8
      time_criticality: 8
      risk_reduction: 5
      job_size: 5
      wsjf_score: 4.2  # (8+8+5)/5

    content_management:
      user_business_value: 8
      time_criticality: 5
      risk_reduction: 3
      job_size: 3
      wsjf_score: 5.3  # (8+5+3)/3

    social_sharing:
      user_business_value: 3
      time_criticality: 2
      risk_reduction: 1
      job_size: 2
      wsjf_score: 3.0  # (3+2+1)/2

  wsjf_coordination_protocol:
    scoring_session:
      participants: [ "product-owner", "scrum-master", "technical-lead", "stakeholder-rep" ]
      duration: "60 minutes"
      process:
        - feature_presentation: "Present each feature for scoring"
        - individual_scoring: "Each participant scores independently"
        - discussion_alignment: "Discuss score differences and align"
        - final_calculation: "Calculate WSJF scores and rank features"
```

#### Prioritization Coordination Commands

```bash
# MoSCoW prioritization session
echo "📊 MoSCoW Prioritization Session"
Task("Product Owner", "Lead MoSCoW categorization with stakeholder input and business value focus", "product-owner")
Task("Technical Lead", "Assess technical feasibility and implementation complexity for prioritization", "system-architect")
Task("Scrum Master", "Facilitate prioritization discussion and ensure capacity alignment", "scrum-master")

# WSJF calculation session  
echo "⚖️ WSJF Calculation Session"
npx claude-flow@alpha prioritization wsjf-calculate \
  --features "$FEATURE_LIST" \
  --participants "product-owner,scrum-master,technical-lead" \
  --store-results "backlog/prioritization/$(date +%s)"

# Store prioritization results
npx claude-flow@alpha hooks memory-store \
  --key "prioritization/moscow/$(date +%s)" \
  --value "$MOSCOW_RESULTS"
  
npx claude-flow@alpha hooks memory-store \
  --key "prioritization/wsjf/$(date +%s)" \
  --value "$WSJF_RESULTS"
```

### 🏗️ Sprint Ceremonies (Detailed Structure with Mandatory Participation)

#### Sprint Planning Ceremony

```yaml
sprint_planning:
  ceremony_structure:
    duration: "2-4 hours (2-week sprint)"
    mandatory_participants: [ "product-owner", "scrum-master", "development-team", "stakeholders" ]

  part_1_what_to_do:
    duration: "50% of ceremony time"
    activities:
      - sprint_goal_definition:
          responsibility: "product-owner"
          outcome: "Clear, measurable sprint goal"
          validation: "Team understanding and commitment"

      - backlog_review:
          responsibility: "product-owner"
          outcome: "Prioritized and refined backlog items"
          validation: "Stories meet Definition of Ready"

      - story_selection:
          responsibility: "development-team"
          outcome: "Sprint backlog with committed stories"
          validation: "Capacity and velocity alignment"

      - wip_limits_validation:
          responsibility: "scrum-master"
          outcome: "WIP limits respected in planning"
          validation: "Single active goal/sprint/story confirmation"

  part_2_how_to_do:
    duration: "50% of ceremony time"
    activities:
      - task_decomposition:
          responsibility: "development-team"
          outcome: "Stories broken into actionable tasks"
          validation: "Tasks are <8 hours, clearly defined"

      - technical_planning:
          responsibility: "technical-lead"
          outcome: "Technical approach and architecture decisions"
          validation: "Feasibility and risk assessment complete"

      - capacity_planning:
          responsibility: "scrum-master"
          outcome: "Realistic sprint commitment based on team capacity"
          validation: "Historical velocity and availability considered"

      - definition_of_done_review:
          responsibility: "entire-team"
          outcome: "Shared understanding of completion criteria"
          validation: "All team members can articulate DoD"

ceremony_coordination:
  pre_planning_preparation:
    - backlog_refinement_complete: "All stories refined and estimated"
    - velocity_data_available: "Historical velocity data prepared"
    - capacity_calculation: "Team availability and capacity calculated"
    - research_completed: "Technical research for complex stories done"

  during_planning_facilitation:
    - timebox_management: "Scrum Master enforces timeboxes"
    - participation_facilitation: "All team members contribute actively"
    - decision_documentation: "Key decisions and assumptions documented"
    - commitment_validation: "Team genuinely commits to sprint goal"

  post_planning_validation:
    - sprint_board_setup: "Sprint board configured with selected stories"
    - capacity_vs_commitment: "Commitment aligns with team capacity"
    - dependencies_identified: "External dependencies documented"
    - communication_plan: "Stakeholder communication plan established"
```

#### Daily Standup Ceremony

```yaml
daily_standup:
  ceremony_structure:
    duration: "15 minutes maximum"
    frequency: "Daily at consistent time"
    mandatory_participants: [ "development-team", "scrum-master" ]
    optional_participants: [ "product-owner", "stakeholders" ]

  three_questions_format:
    what_did_i_do:
      focus: "Progress toward sprint goal"
      validation: "Specific accomplishments, not just activities"
      wip_check: "Confirm single-task focus maintained"

    what_will_i_do:
      focus: "Next steps toward sprint goal"
      validation: "Clear, actionable next steps"
      capacity_check: "Realistic based on remaining capacity"

    what_impediments:
      focus: "Blockers preventing progress"
      validation: "Specific impediments requiring help"
      action_plan: "Clear owner and resolution plan"

  wip_limits_validation:
    active_task_check: "Each team member working on exactly one task"
    story_progress_check: "Only one story active per team member"
    sprint_goal_alignment: "All work aligns with sprint goal"
    impediment_escalation: "WIP-blocking impediments escalated immediately"

  standup_outcomes:
    transparency: "Team has visibility into all work and progress"
    coordination: "Team coordination and collaboration optimized"
    impediment_identification: "Blockers identified and escalated quickly"
    sprint_goal_focus: "Team remains focused on sprint goal achievement"
```

#### Sprint Review Ceremony

```yaml
sprint_review:
  ceremony_structure:
    duration: "1-2 hours (2-week sprint)"
    mandatory_participants: [ "product-owner", "scrum-master", "development-team", "key-stakeholders" ]

  review_activities:
    sprint_goal_assessment:
      responsibility: "scrum-master"
      outcome: "Clear assessment of sprint goal achievement"
      validation: "Objective measurement against defined criteria"

    product_increment_demo:
      responsibility: "development-team"
      outcome: "Working software demonstrated to stakeholders"
      validation: "All completed stories meet Definition of Done"

    stakeholder_feedback:
      responsibility: "product-owner"
      outcome: "Stakeholder input on product direction and priorities"
      validation: "Feedback documented and prioritized"

    backlog_updates:
      responsibility: "product-owner"
      outcome: "Product backlog updated based on review insights"
      validation: "New priorities and stories added as needed"

  quality_validation:
    completed_work_only: "Only fully completed, tested work demonstrated"
    working_software: "All demos use working software, not mockups"
    stakeholder_engagement: "Stakeholders actively participate and provide feedback"
    backlog_evolution: "Product backlog evolves based on learnings"
```

#### Sprint Retrospective Ceremony

```yaml
sprint_retrospective:
  ceremony_structure:
    duration: "1-1.5 hours (2-week sprint)"
    mandatory_participants: [ "scrum-master", "development-team" ]
    optional_participants: [ "product-owner" ]

  retrospective_format:
    what_went_well:
      focus: "Positive practices and successes to continue"
      validation: "Specific examples with measurable impact"
      action: "Document practices to maintain"

    what_could_improve:
      focus: "Challenges and areas for improvement"
      validation: "Specific issues with actionable solutions"
      action: "Prioritize improvements for next sprint"

    action_items:
      focus: "Concrete steps to implement improvements"
      validation: "Clear owner, timeline, and success criteria"
      action: "Commit to specific improvements"

  improvement_tracking:
    action_item_monitoring: "Track completion of retrospective actions"
    metric_improvement: "Measure impact of implemented changes"
    continuous_evolution: "Process improvements compound over time"
    team_ownership: "Team owns their process improvement"

  wip_limits_retrospective:
    wip_compliance_review: "Assess WIP limits adherence during sprint"
    bottleneck_identification: "Identify workflow bottlenecks"
    process_optimization: "Optimize workflow to support WIP limits"
    commitment_vs_delivery: "Review capacity planning accuracy"
```

#### Sprint Ceremonies Automation
```bash
# Sprint Planning (automated coordination)
npx claude-flow@alpha scrum sprint-planning \
  --duration "4-hours" \
  --participants "product-owner,scrum-master,hugo-developer,content-developer,qa-engineer" \
  --sprint-goal "$SPRINT_GOAL" \
  --enforce-wip-limits \
  --validate-capacity

# Daily Standup (automated)
npx claude-flow@alpha scrum daily-standup \
  --collect-updates \
  --identify-blockers \
  --update-burndown \
  --validate-wip-limits \
  --duration "15-minutes"

# Sprint Review (automated demo and feedback collection)
npx claude-flow@alpha scrum sprint-review \
  --demo-completed-work \
  --collect-feedback \
  --update-product-backlog \
  --assess-sprint-goal \
  --duration "2-hours"

# Sprint Retrospective (automated improvement tracking)
npx claude-flow@alpha scrum retrospective \
  --collect-feedback \
  --identify-improvements \
  --create-action-items \
  --track-previous-actions \
  --duration "90-minutes"
```

## 🚨 CRITICAL: CONCURRENT EXECUTION & FILE MANAGEMENT

**ABSOLUTE RULES**:
1. ALL operations MUST be concurrent/parallel in a single message
2. **NEVER save working files, text/mds and tests to the root folder**
3. ALWAYS organize files in appropriate subdirectories
4. **USE CLAUDE CODE'S TASK TOOL** for spawning agents concurrently, not just MCP
5. **ENFORCE WIP LIMITS** - Only 1 goal, 1 sprint, 1 job story, 1 task at a time

### ⚡ GOLDEN RULE: "1 MESSAGE = ALL RELATED OPERATIONS"

**MANDATORY PATTERNS:**
- **TodoWrite**: ALWAYS batch ALL todos in ONE call (5-10+ todos minimum)
- **Task tool (Claude Code)**: ALWAYS spawn ALL agents in ONE message with full instructions
- **File operations**: ALWAYS batch ALL reads/writes/edits in ONE message
- **Bash commands**: ALWAYS batch ALL terminal operations in ONE message
- **Memory operations**: ALWAYS batch ALL memory store/retrieve in ONE message

### 🎯 CRITICAL: Agile-Compliant Agent Execution

**Claude Code's Task tool with Agile constraints:**
```javascript
// ✅ CORRECT: Agile-compliant parallel agent execution with WIP limits
[Single Message - Sprint Task Execution]:
  // Spawn Agile team agents with WIP enforcement
  Task("Product Owner", "Define and validate current job story: $ACTIVE_JOB_STORY. Ensure WIP limits maintained.", "product-owner")
  Task("Scrum Master", "Facilitate sprint coordination and remove impediments. Monitor WIP compliance.", "scrum-master")
  Task("Hugo Developer", "Implement ONLY the active task: $ACTIVE_TASK. Follow micro-change protocol.", "hugo-developer")
  Task("Content Developer", "Support active task with content needs. Maintain focus on single story.", "content-developer")
  Task("QA Engineer", "Test active implementation incrementally. Validate story acceptance criteria.", "qa-engineer")
  
  // Sprint context and WIP validation
  mcp__claude-flow__memory_usage({
    action: "store",
    key: "sprint/1/active_context",
    value: {
      active_goal: "$SPRINT_GOAL",
      active_job_story: "$JOB_STORY_ID",
      active_task: "$TASK_ID",
      wip_compliance: true
    }
  })
```

**MCP tools are ONLY for coordination setup:**
- `mcp__claude-flow__swarm_init` - Initialize coordination topology
- `mcp__claude-flow__agent_spawn` - Define agent types for coordination
- `mcp__claude-flow__task_orchestrate` - Orchestrate high-level workflows

### 📁 File Organization Rules

**NEVER save to root folder. Use these directories:**
- `/src` - Source code files
- `/tests` - Test files
- `/docs` - Documentation and markdown files
- `/config` - Configuration files
- `/scripts` - Utility scripts
- `/examples` - Example code

## 🛡️ REGRESSION PREVENTION PROTOCOL (MANDATORY)

### Critical Bug Fix Requirements

**ALL bug fixes MUST follow this protocol to prevent regression:**

#### 1️⃣ Comprehensive Search Before Fix
- NEVER fix based on first few grep results
- ALWAYS search with multiple patterns and variations
- Create complete inventory BEFORE starting fixes
- Use memory to track all found instances

#### 2️⃣ Verification-First Development  
- Write failing test FIRST
- Test must simulate production environment
- Clear all caches before testing
- Only claim success when test passes

#### 3️⃣ Progress Tracking
- Use memory namespaces: fixes/{issue}/inventory
- Track: total-found, attempted, completed, verified
- Block success claims without 100% completion

### 🔍 Comprehensive Search Protocol

**MANDATORY SEARCH PATTERNS FOR ALL BUG FIXES:**

```bash
# Phase 1: Multi-Pattern Search (REQUIRED)
comprehensive_search() {
    local issue="$1"
    local pattern="$2"
    
    echo "🔍 Comprehensive Search Protocol for: $issue"
    
    # Search with all variations
    patterns=("$pattern" "${pattern,,}" "${pattern^^}" "${pattern^}")
    file_types=("*.html" "*.js" "*.css" "*.md" "*.tsx" "*.ts" "*.json" "*.yaml" "*.yml")
    
    # Create complete inventory
    find . -type f \( ${file_types[@]/#/-name } \) | \
    xargs grep -l -E "(${patterns[0]}|${patterns[1]}|${patterns[2]}|${patterns[3]})" > /tmp/fix_inventory_$issue.txt
    
    local count=$(wc -l < /tmp/fix_inventory_$issue.txt)
    echo "📋 Found $count files requiring fixes"
    
    # Store in memory
    npx claude-flow@alpha hooks memory-store --key "fixes/$issue/total-found" --value "$count"
    npx claude-flow@alpha hooks memory-store --key "fixes/$issue/inventory" --value "$(cat /tmp/fix_inventory_$issue.txt)"
    
    if [ "$count" -eq 0 ]; then
        echo "⚠️ WARNING: No files found - pattern might be incorrect"
        return 1
    fi
    
    echo "✅ Comprehensive search complete: $count files identified"
    return 0
}
```

### 🧪 Verification-First Development Protocol

**MANDATORY TEST CREATION BEFORE ANY FIX:**

```bash
# Phase 2: Create Failing Test (REQUIRED)
create_verification_test() {
    local issue="$1"
    local description="$2"
    
    echo "🧪 Creating verification test for: $issue"
    
    # Test script must fail before fix
    cat > /tmp/verify_test_$issue.sh << 'EOF'
#!/bin/bash
set -e

# Production build test
echo "🏗️ Testing production build..."
hugo --environment production --minify

# Additional validation can go here
echo "✅ Production build successful"
EOF

    chmod +x /tmp/verify_test_$issue.sh
    
    # Test MUST fail before fix
    if /tmp/verify_test_$issue.sh; then
        echo "⚠️ WARNING: Test passed - issue might already be fixed or test incorrect"
        echo "🔍 Please verify the issue exists and test is correct"
        return 1
    fi
    
    echo "✅ Verification test fails as expected - ready to proceed with fix"
    npx claude-flow@alpha hooks memory-store --key "fixes/$issue/test-created" --value "true"
    return 0
}
```

### 📊 Progress Tracking Protocol

**MANDATORY PROGRESS TRACKING:**

```bash
# Phase 3: Track Fix Progress (REQUIRED)
track_fix_progress() {
    local issue="$1"
    local file="$2"
    local status="$3"  # attempted|completed|verified
    
    # Update progress counters
    local current=$(npx claude-flow@alpha hooks memory-retrieve --key "fixes/$issue/$status" 2>/dev/null || echo "0")
    local new_count=$((current + 1))
    
    npx claude-flow@alpha hooks memory-store --key "fixes/$issue/$status" --value "$new_count"
    
    # Store file-specific progress
    npx claude-flow@alpha hooks memory-store --key "fixes/$issue/files/$file" --value "$status"
    
    echo "📊 Progress Update: $file marked as $status"
}

# Validation before claiming success
validate_fix_completion() {
    local issue="$1"
    
    local total=$(npx claude-flow@alpha hooks memory-retrieve --key "fixes/$issue/total-found")
    local verified=$(npx claude-flow@alpha hooks memory-retrieve --key "fixes/$issue/verified" 2>/dev/null || echo "0")
    
    if [ "$verified" != "$total" ]; then
        echo "❌ BLOCKED: Cannot claim success"
        echo "📊 Progress: $verified/$total files verified"
        echo "🚫 Must fix ALL files before claiming success"
        return 1
    fi
    
    # Final verification test
    if ! /tmp/verify_test_$issue.sh; then
        echo "❌ BLOCKED: Final verification test failed"
        return 1
    fi
    
    echo "✅ All fixes verified successfully: $total/$total"
    return 0
}
```

### 🛡️ Anti-Regression Memory System

**Memory namespace patterns for tracking fixes:**

```bash
# Anti-regression memory organization
fixes/{issue_type}/
├── total-found              # Total files requiring fixes
├── inventory                 # Complete list of affected files  
├── attempted                 # Number of files fix was attempted on
├── completed                 # Number of files fix was completed on
├── verified                  # Number of files where fix was verified
├── test-created             # Whether verification test was created
├── test-passed              # Whether final test passed
└── files/
    ├── file1.html           # Status: attempted|completed|verified
    ├── file2.js             # Status: attempted|completed|verified
    └── ...
```

## 🛡️ ANTI-DUPLICATION ENFORCEMENT SYSTEM

### 🚫 CRITICAL: FILE DUPLICATION PREVENTION

**ZERO TOLERANCE POLICY**: Creating duplicate files is the #1 anti-pattern that creates maintenance burden and technical debt.

#### Forbidden Duplication Patterns
```bash
# ❌ ABSOLUTELY FORBIDDEN PATTERNS:
existing_file.py + existing_file_refactored.py
service.py + service_refactored.py
component.tsx + component_new.tsx
utils.js + utils_updated.js
config.json + config_v2.json
README.md + README_new.md

# ✅ CORRECT APPROACH: ALWAYS EDIT EXISTING FILES
# Use Edit/MultiEdit tools to modify existing files directly
Edit(existing_file.py, old_content, new_content)
MultiEdit(existing_file.py, [{old_string, new_string}, ...])
```

### 📋 MANDATORY VALIDATION PROTOCOL

**ALL agents MUST follow this validation sequence:**

#### Phase 1: Pre-Creation Validation (MANDATORY)
```bash
# Step 1: Search for existing similar files
claude-context search "[filename_root]" --path "." --limit 20

# Step 2: Check for existing variations
find . -name "*[base_name]*" -type f | grep -E "\.(py|js|ts|tsx|md|json)$"

# Step 3: Validate Edit vs Write tool usage
if [[ -f "$TARGET_FILE" ]]; then
  echo "🚫 DUPLICATION BLOCKED: File exists, MUST use Edit tools"
  echo "✅ CORRECT ACTION: Edit('$TARGET_FILE', old_content, new_content)"
  exit 1
fi

# Step 4: Memory-based duplication tracking
npx claude-flow@alpha hooks memory-search --pattern "files/created/*" --key "*$BASE_NAME*"
```

#### Phase 2: During-Work Validation (ENFORCED)
```bash
# Continuous monitoring during file operations
validate_file_operation() {
  local operation="$1"
  local file_path="$2"

  if [[ "$operation" == "Write" && -f "$file_path" ]]; then
    echo "🚨 DUPLICATION VIOLATION: Attempting to Write existing file"
    echo "🛑 BLOCKED: Use Edit tools for existing files"
    echo "📝 REQUIRED: Edit('$file_path', old_content, new_content)"
    return 1
  fi

  # Check for suffix patterns
  if echo "$file_path" | grep -E "_(refactored|new|updated|v[0-9]|copy|backup)\."; then
    echo "🚨 SUFFIX VIOLATION: Forbidden file suffix detected"
    echo "🛑 BLOCKED: Never create files with suffixes like _refactored, _new, etc."
    return 1
  fi
}
```

#### Phase 3: Post-Task Validation (AUTOMATIC)
```bash
# Automatic duplication detection after task completion
post_task_duplication_scan() {
  echo "🔍 Scanning for accidental duplications..."

  # Find potential duplicates by similar names
  find . -type f -name "*.*" | \
  sed 's/\.[^.]*$//' | \
  sort | uniq -d | while read base; do
    duplicates=$(find . -name "${base}*" -type f)
    if [ $(echo "$duplicates" | wc -l) -gt 1 ]; then
      echo "🚨 DUPLICATION DETECTED: $duplicates"
      echo "🛠️ REQUIRED ACTION: Consolidate or remove duplicates"
    fi
  done
}
```

## Project Overview

This project uses SPARC (Specification, Pseudocode, Architecture, Refinement, Completion) methodology with Claude-Flow orchestration for systematic Test-Driven Development.

## SPARC Commands

### Core Commands
- `npx claude-flow sparc modes` - List available modes
- `npx claude-flow sparc run <mode> "<task>"` - Execute specific mode
- `npx claude-flow sparc tdd "<feature>"` - Run complete TDD workflow
- `npx claude-flow sparc info <mode>` - Get mode details

### Batchtools Commands
- `npx claude-flow sparc batch <modes> "<task>"` - Parallel execution
- `npx claude-flow sparc pipeline "<task>"` - Full pipeline processing
- `npx claude-flow sparc concurrent <mode> "<tasks-file>"` - Multi-task processing

### Build Commands
- `npm run build` - Build project
- `npm run test` - Run tests
- `npm run lint` - Linting
- `npm run typecheck` - Type checking

## SPARC Workflow Phases

1. **Specification** - Requirements analysis (`sparc run spec-pseudocode`)
2. **Pseudocode** - Algorithm design (`sparc run spec-pseudocode`)
3. **Architecture** - System design (`sparc run architect`)
4. **Refinement** - TDD implementation (`sparc tdd`)
5. **Completion** - Integration (`sparc run integration`)

## Code Style & Best Practices

- **Modular Design**: Files under 500 lines
- **Environment Safety**: Never hardcode secrets
- **Test-First**: Write tests before implementation
- **Clean Architecture**: Separate concerns
- **Documentation**: Keep updated

## 🚀 Available Agents (54 Total) + Agile Roles

### 🏃 Agile-Specific Agents
`product-owner`, `scrum-master`, `hugo-developer`, `content-developer`, `agile-coordinator`

### Core Development
`coder`, `reviewer`, `tester`, `planner`, `researcher`

**CRITICAL**: All agents MUST use generic names without project prefixes. Use `coordinator` NOT `jt-coordinator`.

### Swarm Coordination
`hierarchical-coordinator`, `mesh-coordinator`, `adaptive-coordinator`, `collective-intelligence-coordinator`, `swarm-memory-manager`

### Consensus & Distributed
`byzantine-coordinator`, `raft-manager`, `gossip-coordinator`, `consensus-builder`, `crdt-synchronizer`, `quorum-manager`, `security-manager`

### Performance & Optimization
`perf-analyzer`, `performance-benchmarker`, `task-orchestrator`, `memory-coordinator`, `smart-agent`

### GitHub & Repository
`github-modes`, `pr-manager`, `code-review-swarm`, `issue-tracker`, `release-manager`, `workflow-automation`, `project-board-sync`, `repo-architect`, `multi-repo-swarm`

### SPARC Methodology
`sparc-coord`, `sparc-coder`, `specification`, `pseudocode`, `architecture`, `refinement`

### Specialized Development
`backend-dev`, `mobile-dev`, `ml-developer`, `cicd-engineer`, `api-docs`, `system-architect`, `code-analyzer`, `base-template-generator`

### Testing & Validation
`tdd-london-swarm`, `production-validator`

### Migration & Planning
`migration-planner`, `swarm-init`

## 🎯 Claude Code vs MCP Tools

### Claude Code Handles ALL EXECUTION:
- **Task tool**: Spawn and run agents concurrently for actual work
- File operations (Read, Write, Edit, MultiEdit, Glob, Grep)
- Code generation and programming
- Bash commands and system operations
- Implementation work
- Project navigation and analysis
- TodoWrite and task management
- Git operations
- Package management
- Testing and debugging

### MCP Tools ONLY COORDINATE:
- Swarm initialization (topology setup)
- Agent type definitions (coordination patterns)
- Task orchestration (high-level planning)
- Memory management
- Neural features
- Performance tracking
- GitHub integration

**KEY**: MCP coordinates the strategy, Claude Code's Task tool executes with real agents.

## 🚀 Quick Setup

```bash
# Add Claude Flow MCP server
claude mcp add claude-flow npx claude-flow@alpha mcp start
```

## MCP Tool Categories

### Coordination
`swarm_init`, `agent_spawn`, `task_orchestrate`

### Monitoring
`swarm_status`, `agent_list`, `agent_metrics`, `task_status`, `task_results`

### Memory & Neural
`memory_usage`, `neural_status`, `neural_train`, `neural_patterns`

### GitHub Integration
`github_swarm`, `repo_analyze`, `pr_enhance`, `issue_triage`, `code_review`

### System
`benchmark_run`, `features_detect`, `swarm_monitor`

## 🚀 Agent Execution Flow with Claude Code

### The Correct Pattern:

1. **Optional**: Use MCP tools to set up coordination topology
2. **REQUIRED**: Use Claude Code's Task tool to spawn agents that do actual work
3. **REQUIRED**: Each agent runs hooks for coordination
4. **REQUIRED**: Batch all operations in single messages

### Example Full-Stack Development:

```
// Single message with all agent spawning via Claude Code's Task tool
[Parallel Agent Execution]:
  Task("Backend Developer", "Build REST API with Express. Use hooks for coordination.", "backend-dev")
  Task("Frontend Developer", "Create React UI. Coordinate with backend via memory.", "coder")
  Task("Database Architect", "Design PostgreSQL schema. Store schema in memory.", "code-analyzer")
  Task("Test Engineer", "Write Jest tests. Check memory for API contracts.", "tester")
  Task("DevOps Engineer", "Setup Docker and CI/CD. Document in memory.", "cicd-engineer")
  Task("Security Auditor", "Review authentication. Report findings via hooks.", "reviewer")

  // All todos batched together
  TodoWrite { todos: [...8-10 todos...] }

  // All file operations together
  Write "backend/server.js"
  Write "frontend/App.jsx"
  Write "database/schema.sql"
```

## 🚀 Enhanced Agent Capabilities with Quality Framework

### Cross-Agent Coordination Protocols

**Enhanced agent coordination includes quality framework integration:**

```yaml
enhanced_agent_capabilities:
  quality_framework_integration: true
  zero_defect_methodology: required
  prevention_first_coordination: true
  consistency_pattern_enforcement: true
  technical_debt_prevention: mandatory

cross_agent_memory_patterns:
  quality_validation_results: "quality/*/validation/*"
  prevention_methodology_state: "quality/*/prevention/*" 
  consistency_patterns: "quality/*/consistency/*"
  debt_elimination_tracking: "quality/*/technical-debt/*"
  content_quality_validation: "quality/*/content-quality/*"
  performance_optimization: "quality/*/performance/*"
```

### Quality-Enhanced Agent Enhancement References

**ALL Hugo site development agents MUST reference these enhanced capabilities:**

- **Enhanced Quality-Driven Development**: Zero-defect philosophy integration for site quality
- **Prevention-First Coordination**: Proactive quality issue prevention in content and code
- **Consistency Pattern Validation**: Automated pattern compliance checking for site consistency
- **Technical Debt Elimination**: Real-time debt detection and resolution in site architecture

## 🚨 BUG FIX ENFORCEMENT RULES (ZERO TOLERANCE)

### AUTOMATIC FAILURE CONDITIONS (BLOCKING)

**Agents will be IMMEDIATELY BLOCKED and marked as FAILED if they:**

1. **🚫 CLAIM FIX WITHOUT COMPREHENSIVE SEARCH**
   - Fixing based on `head -5` or partial results
   - Not checking all file types and variations
   - Missing files from inventory
   - Not using claude-context for search
   - **AUTOMATIC FAILURE**: Agent blocked from continuing

2. **🚫 TEST WITH CACHE PRESENT**
   - Not clearing resources/_gen before testing
   - Using cached build results
   - Testing different environment than production
   - Not running bin/test for verification
   - **AUTOMATIC FAILURE**: Agent blocked from continuing

3. **🚫 INCOMPLETE PROGRESS TRACKING**
   - Not using memory to track fixes
   - Claiming success with partial completion
   - No verification test created
   - Not running bin/test after each change
   - **AUTOMATIC FAILURE**: Agent blocked from continuing

4. **🚫 BYPASS TEST VALIDATION (NEW)**
   - Starting work without running bin/test first
   - Making changes without running bin/test after each
   - Claiming completion without ALL tests passing
   - Deleting or commenting out tests to make them "pass"
   - **AUTOMATIC FAILURE**: Agent immediately suspended

### Bug Fix Agent Protocol

**When spawning agents for bug fixes, ALWAYS include:**

```javascript
Task("Bug Fixer", `
  🚨 MANDATORY BUG FIX PROTOCOL - ZERO TOLERANCE:
  
  🛑 PRE-FIX BLOCKING VALIDATION:
  - MUST run bin/test FIRST - BLOCKED if fails
  - Cannot start fix work until tests pass
  
  1. 🚨 COMPREHENSIVE SEARCH (BLOCKING):
     - MUST use claude-context search (NOT grep/find)
     - MUST search ALL file types with ALL pattern variations
     - MUST create complete inventory before starting ANY fixes
     - MUST store inventory: npx claude-flow@alpha hooks memory-store --key "fixes/[ISSUE]/inventory"
     - BLOCKED from starting fixes without complete inventory
  
  2. 🚨 VERIFICATION FIRST (BLOCKING):
     - MUST write test that FAILS before any fix
     - BLOCKED from proceeding if test doesn't fail correctly
     - MUST run bin/test after creating reproduction test
  
  3. 🚨 TRACK PROGRESS WITH TEST ENFORCEMENT:
     - MUST run bin/test after EACH file fixed
     - AUTOMATIC ROLLBACK: git checkout -- . if bin/test fails
     - MUST update memory after EACH file: npx claude-flow@alpha hooks memory-store
     - MUST track: attempted, completed, verified WITH test results
     - BLOCKED from claiming success until 100% verified
  
  4. 🚨 FINAL VALIDATION (BLOCKING COMPLETION):
     - MUST run reproduction test - should now PASS
     - MUST run bin/test - ALL tests must pass
     - MUST verify bin/dtest works
     - MUST verify bin/build works
     - MUST verify bin/dev works
     - MUST check all files in inventory are fixed
     - MUST verify with empty cache
  
  🚫 BLOCKED FROM CLAIMING SUCCESS WITHOUT:
  ✓ Complete inventory of ALL affected files
  ✓ Reproduction test passing
  ✓ bin/build working
  ✓ bin/dev working  
  ✓ bin/test passing (ALL tests)
  ✓ bin/dtest passing (ALL tests)
  ✓ Verification with empty cache
  
  ZERO TOLERANCE: No exceptions, no shortcuts, no bypass
`, "coder")
```

### Memory Enforcement

**Check before allowing success claim:**

```bash
# Pre-success validation hook
validate_bug_fix_success() {
    local issue="$1"
    
    # 🚨 MANDATORY: Check comprehensive search was done
    local total=$(npx claude-flow@alpha hooks memory-retrieve --key "fixes/$issue/total-found" 2>/dev/null)
    if [ -z "$total" ] || [ "$total" -eq 0 ]; then
        echo "❌ BLOCKED: No comprehensive search performed"
        echo "🔍 Must run comprehensive_search function first"
        echo "🚨 MANDATORY: Use claude-context for complete file inventory"
        return 1
    fi
    
    # 🚨 MANDATORY: Check verification test was created AND tests pass
    local test_created=$(npx claude-flow@alpha hooks memory-retrieve --key "fixes/$issue/test-created" 2>/dev/null)
    if [ "$test_created" != "true" ]; then
        echo "❌ BLOCKED: No verification test created"
        echo "🧪 Must create failing verification test first"
        echo "🚨 MANDATORY: Reproduction test required before any fixes"
        return 1
    fi
    
    # 🚨 MANDATORY: Check bin/test passes
    if ! bin/test; then
        echo "❌ BLOCKED: bin/test failing"
        echo "🚨 MANDATORY: ALL tests must pass before claiming success"
        echo "🔧 REQUIRED: Fix failing tests or revert changes"
        return 1
    fi
    
    # 🚨 MANDATORY: Check build tools work
    if ! bin/build; then
        echo "❌ BLOCKED: bin/build broken"
        echo "🚨 MANDATORY: Build system must work"
        return 1
    fi
    
    if ! bin/dev --help >/dev/null 2>&1; then
        echo "❌ BLOCKED: bin/dev broken"
        echo "🚨 MANDATORY: Development tools must work"
        return 1
    fi
    
    # 🚨 MANDATORY: Check all files were verified
    local verified=$(npx claude-flow@alpha hooks memory-retrieve --key "fixes/$issue/verified" 2>/dev/null || echo "0")
    if [ "$verified" != "$total" ]; then
        echo "❌ BLOCKED: Cannot claim success"
        echo "📊 Progress: $verified/$total files verified"
        echo "🚫 Must fix ALL files before claiming success"
        echo "🚨 ZERO TOLERANCE: Incomplete fixes cause regressions"
        return 1
    fi
    
    # Final verification test
    if [ ! -f "/tmp/verify_test_$issue.sh" ]; then
        echo "❌ BLOCKED: Verification test script missing"
        return 1
    fi
    
    if ! /tmp/verify_test_$issue.sh; then
        echo "❌ BLOCKED: Final verification test failed"
        echo "🔧 Fix is incomplete - test still fails"
        return 1
    fi
    
    echo "✅ All validation gates passed - success claim approved"
    return 0
}
```

### MANDATORY Test Deletion Prevention (ZERO TOLERANCE)

**BLOCKING: Agents CANNOT delete or disable tests:**

```bash
# Pre-commit hook to prevent test deletion
prevent_test_deletion() {
    echo "🛡️ ZERO TOLERANCE: Test deletion prevention"
    
    # Check for deleted test files
    local deleted_tests=$(git diff --cached --name-status | grep '^D.*\.\(test\|spec\)\.')
    
    if [ -n "$deleted_tests" ]; then
        echo "❌ BLOCKED: Test file deletion detected"
        echo "🚫 FORBIDDEN: Cannot delete test files to make tests pass"
        echo "📋 Deleted tests:"
        echo "$deleted_tests"
        echo "🔄 REQUIRED: git checkout -- [test_files]"
        echo "🛠️ CORRECT APPROACH: Fix the code, not delete the tests"
        exit 1
    fi
    
    # Check for commented out test cases
    local commented_patterns=(
        "// .*\(it\|describe\|test\)\("
        "/\* .*\(it\|describe\|test\)\("
        "# .*\(it\|describe\|test\)\("
        "<!-- .*\(it\|describe\|test\)\("
    )
    
    for pattern in "${commented_patterns[@]}"; do
        local commented_tests=$(find . -name "*.\(test\|spec\).*" -exec grep -l "$pattern" {} \; 2>/dev/null)
        
        if [ -n "$commented_tests" ]; then
            echo "⚠️ WARNING: Commented test cases detected"
            echo "🔍 Files with commented tests:"
            echo "$commented_tests"
            echo "🛠️ REQUIRED: Fix failing tests instead of commenting them out"
        fi
    done
    
    # Check for disabled test blocks
    local disabled_tests=$(find . -name "*.\(test\|spec\).*" -exec grep -l "\(skip\|pending\|disabled\|ignore\)" {} \; 2>/dev/null)
    
    if [ -n "$disabled_tests" ]; then
        echo "⚠️ WARNING: Disabled test cases detected"
        echo "🔍 Files with disabled tests:"
        echo "$disabled_tests"
        echo "🛠️ REVIEW REQUIRED: Justify why tests are disabled"
    fi
    
    echo "✅ Test deletion prevention check completed"
}
```

### Claude-Flow Hooks Configuration (ENHANCED WITH TEST ENFORCEMENT)

**Create mandatory test enforcement hooks:**

```yaml
# .claude-flow/hooks/test-enforcement.yaml
hooks:
  test-enforcement-protocol:
    pre-task:
      - name: mandatory-pre-test-validation
        required: true
        blocking: true
        script: |
          echo "🚨 MANDATORY: Pre-task test validation"
          
          # BLOCKING: Tests must pass before starting
          if ! bin/test; then
            echo "❌ BLOCKED: Tests failing before task begins"
            echo "🛑 CANNOT START: Fix failing tests first"
            exit 1
          fi
          
          echo "✅ Pre-task test validation passed"
          
      - name: test-deletion-prevention
        required: true
        blocking: true
        script: |
          prevent_test_deletion
          
    during-task:
      - name: mandatory-test-after-each-change
        required: true
        blocking: true
        script: |
          echo "🚨 MANDATORY: Testing after file change"
          
          # Run comprehensive test suite
          if ! bin/test; then
            echo "❌ AUTOMATIC ROLLBACK: Tests failed"
            git checkout -- .
            echo "🚫 BLOCKED: Cannot proceed with failing tests"
            exit 1
          fi
          
          echo "✅ During-task test validation passed"
          
      - name: track-progress-with-tests
        required: true
        script: |
          echo "📊 Tracking progress with test validation"
          
          # Store test results in memory
          local test_result=$(bin/test > /tmp/test_output 2>&1 && echo "passed" || echo "failed")
          
          npx claude-flow@alpha hooks memory-store \
            --key "test-validation/$TASK_ID/$FILE/result" \
            --value "$test_result" \
            --namespace "test-enforcement"
            
          # Track detailed progress
          npx claude-flow@alpha hooks memory-store \
            --key "progress/$TASK_ID/$FILE/status" \
            --value "file:$FILE,status:$STATUS,test_result:$test_result,timestamp:$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
            --namespace "test-enforcement"
    
    post-task:
      - name: mandatory-final-test-validation
        required: true
        blocking: true
        script: |
          echo "🎯 BLOCKING: Final test validation"
          
          # BLOCKING: Build tools must work
          if ! bin/build; then
            echo "❌ BLOCKED: Build system broken"
            exit 1
          fi
          
          if ! bin/dev --help >/dev/null 2>&1; then
            echo "❌ BLOCKED: Development tools broken"
            exit 1
          fi

          # BLOCKING: All tests must pass
          if ! bin/test; then
            echo "❌ BLOCKED: Cannot claim completion with failing tests"
            exit 1
          fi
          
          echo "✅ Final test validation passed - task can be marked complete"
          
      - name: prevent-test-deletion-on-completion
        required: true
        blocking: true
        script: |
          prevent_test_deletion
          
      - name: cleanup-with-verification
        required: false
        script: |
          echo "🧹 Cleaning up with final verification..."
          
          # One final test before cleanup
          if ! bin/dtest; then
            echo "❌ WARNING: Tests failing during cleanup"
            echo "🛠️ Manual intervention may be required"
          fi
          
          # Clean up temporary files
          rm -f /tmp/fix_inventory_*.txt
          rm -f /tmp/verify_test_*.sh
          rm -f /tmp/test_output
```

### ENHANCED Regression Prevention Examples

**Example: PostCSS Bug Fix with MANDATORY Test Enforcement**

```bash
# Example: Fixing PostCSS references with ZERO TOLERANCE test enforcement
ISSUE="postcss-references"
PATTERN="postcss"

echo "🚨 MANDATORY BUG FIX PROTOCOL: $ISSUE"

# 0. PRE-FIX TEST VALIDATION (MANDATORY - BLOCKING)
echo "🛑 PRE-FIX: Mandatory test validation"
if ! bin/test; then
    echo "❌ BLOCKED: Tests already failing before fix"
    echo "🛠️ REQUIRED: Fix existing test failures first"
    exit 1
fi
echo "✅ Pre-fix test validation passed"

# 1. Comprehensive Search (MANDATORY)
echo "🔍 MANDATORY: Comprehensive search"
comprehensive_search "$ISSUE" "$PATTERN"
# ENHANCED: Use claude-context instead of grep
npx claude-context search_code --query "postcss" --path "."
# Result: Found 9 files (not just 4!) - ALL must be tracked

# 2. Create Verification Test (MANDATORY)
echo "🧪 MANDATORY: Verification test creation"
create_verification_test "$ISSUE" "PostCSS references causing build failures"
# Result: Test fails as expected
# ENHANCED: Run bin/test after creating reproduction test
if ! bin/test; then
    echo "🚨 NOTE: Reproduction test created, bin/test fails as expected"
else
    echo "⚠️ WARNING: Reproduction test may not be reproducing the issue"
fi

# 3. Fix Each File with MANDATORY Test Enforcement
echo "🔧 MANDATORY: Fix files with test enforcement"
for file in $(cat /tmp/fix_inventory_$ISSUE.txt); do
    echo "🔧 Fixing: $file"
    
    # Apply fix
    sed -i 's/postcss/PostCSS/g' "$file"
    track_fix_progress "$ISSUE" "$file" "attempted"
    
    # 🚨 MANDATORY: Test after EACH file change
    echo "🚨 MANDATORY: Testing after fixing $file"
    if ! bin/test; then
        echo "❌ AUTOMATIC ROLLBACK: Fix broke tests"
        git checkout -- "$file"
        echo "🚫 BLOCKED: Cannot proceed - fix broke tests"
        exit 1
    fi
    
    # Verify fix
    if grep -q "PostCSS" "$file" && ! grep -q "postcss" "$file"; then
        track_fix_progress "$ISSUE" "$file" "completed"
        track_fix_progress "$ISSUE" "$file" "verified"
        echo "✅ Fixed and tested: $file"
    else
        echo "❌ Fix failed: $file"
        exit 1
    fi
done

# 4. Final Validation (MANDATORY - BLOCKING)
echo "🎯 MANDATORY: Final validation"

# ENHANCED: Comprehensive final validation
if ! validate_fix_completion "$ISSUE"; then
    echo "❌ BLOCKED: Fix completion validation failed"
    exit 1
fi

# ENHANCED: Verify build tools still work
if ! bin/build; then
    echo "❌ BLOCKED: Build system broken after fix"
    exit 1
fi

if ! bin/dev --help >/dev/null 2>&1; then
    echo "❌ BLOCKED: Development tools broken after fix"
    exit 1
fi

# Final test suite
if ! bin/dtest; then
    echo "❌ BLOCKED: Final test suite failing"
    exit 1
fi

echo "✅ COMPLETE: All 9 files fixed, all tests pass, all tools work"
echo "🚨 ZERO TOLERANCE PROTOCOL: Successfully enforced"
```

## 📋 Agent Coordination Protocol

## 🔄 AGILE WORKFLOW PATTERNS

### 🎯 Job Story Management
```yaml
job_story_template:
  format: "When I [situation], I want [motivation], so I can [expected outcome]"
  acceptance_criteria:
    - given: "Initial context"
      when: "Action taken"
      then: "Expected outcome"
  definition_of_done:
    - code_complete: true
    - tests_passing: true
    - code_reviewed: true
    - documentation_updated: true
    - sprint_goal_aligned: true
    - wip_limits_respected: true
```

### 🗺️ User Story Mapping (Complete Methodology)

#### Story Mapping Framework

```yaml
story_mapping:
  methodology:
    purpose: "Visualize user journey and organize stories by value delivery"
    structure:
      - user_activities: "High-level user goals and workflows"
      - user_tasks: "Specific tasks users perform"
      - user_stories: "Detailed stories that support tasks"
      - story_details: "Acceptance criteria and technical details"

  mapping_process:
    phase_1_discovery:
      - identify_user_personas: "Define primary and secondary users"
      - map_user_journey: "Document end-to-end user experience"
      - identify_activities: "Extract main user activities"

    phase_2_organization:
      - break_into_tasks: "Decompose activities into specific tasks"
      - write_user_stories: "Create stories supporting each task"
      - add_story_details: "Define acceptance criteria and DoD"

    phase_3_prioritization:
      - vertical_slicing: "Identify minimum viable releases"
      - horizontal_grouping: "Organize by user workflow priority"
      - sprint_planning: "Assign stories to sprints based on value"

  jt_site_user_activities:
    content_consumption:
      description: "Users reading and engaging with blog content"
      tasks:
        - browse_articles: "Find and read relevant articles"
        - search_content: "Search for specific topics or information"
        - share_content: "Share articles on social media or email"

    knowledge_exploration:
      description: "Users exploring JetThoughts expertise and services"
      tasks:
        - review_portfolio: "Browse case studies and project examples"
        - learn_about_team: "Understand team expertise and approach"
        - contact_inquiry: "Submit consultation or project inquiries"

    professional_networking:
      description: "Users connecting with JetThoughts professionals"
      tasks:
        - view_team_profiles: "Learn about individual team members"
        - connect_social: "Follow on social media platforms"
        - subscribe_updates: "Subscribe to newsletter or RSS feed"
```

#### Story Mapping Coordination Protocol

```bash
# User story mapping session coordination
echo "🗺️ Initiating user story mapping for: $EPIC"
npx claude-flow@alpha story-map init \
  --epic "$EPIC" \
  --personas "$USER_PERSONAS" \
  --activities "$USER_ACTIVITIES"

# Collaborative mapping with agents
Task("User Research", "Analyze user journey and identify key activities for JT site", "researcher")
Task("Story Mapper", "Create story map structure and organize by user value", "product-owner")
Task("Technical Mapper", "Add technical considerations and dependencies to story map", "system-architect")

# Store mapping results in memory
npx claude-flow@alpha hooks memory-store \
  --key "story-mapping/jt-site/$(date +%s)" \
  --value "$MAPPING_RESULT"
```

### 🧩 Cooperative Decomposition (Grooming Session Protocols)

#### Decomposition Session Framework

```yaml
cooperative_decomposition:
  session_structure:
    preparation_phase:
      duration: "15 minutes"
      activities:
        - review_story_context: "Understand story background and user value"
        - research_technical_requirements: "Identify technical dependencies"
        - prepare_decomposition_materials: "Gather templates and estimation tools"

    research_first_approach:
      duration: "20 minutes"
      mandatory_research:
        - existing_patterns: "Search codebase for similar implementations"
        - framework_capabilities: "Validate Hugo and tool capabilities"
        - knowledge_base_consultation: "Review established patterns and practices"
        - cross_reference_validation: "Check for related work and dependencies"

    decomposition_phase:
      duration: "30 minutes"
      collaborative_process:
        - story_analysis: "Break story into logical components"
        - task_identification: "Identify specific development tasks"
        - dependency_mapping: "Map technical and business dependencies"
        - estimation_session: "Collaboratively estimate effort using planning poker"

    validation_phase:
      duration: "15 minutes"
      quality_gates:
        - invest_criteria_check: "Validate Independent, Negotiable, Valuable, Estimable, Small, Testable"
        - acceptance_criteria_review: "Ensure clear and testable acceptance criteria"
        - definition_of_done_alignment: "Confirm DoD compliance"
        - wip_limits_validation: "Ensure decomposition supports WIP limits"

  research_first_protocols:
    mandatory_tools:
      - claude_context: "Search existing codebase patterns"
      - context7: "Validate framework specifications"
      - knowledge_base: "Consult established practices"
      - docs_mcp: "Reference documentation patterns"

    research_validation:
      pattern_consistency: "Ensure new work aligns with existing patterns"
      framework_compliance: "Validate against Hugo and tool capabilities"
      knowledge_integration: "Apply learned practices from knowledge base"
      dependency_analysis: "Identify and validate all dependencies"
```

#### Grooming Session Coordination

```bash
# Pre-grooming research phase (MANDATORY)
echo "🔍 Pre-Grooming Research Phase for: $STORY_ID"
Task("Research Agent", "Research existing patterns, framework capabilities, and knowledge base practices for story context", "researcher")
Task("Pattern Validator", "Validate story alignment with existing codebase patterns and architecture", "system-architect")
Task("Knowledge Consultant", "Consult knowledge base for established practices and solutions", "planner")

# Cooperative decomposition session
echo "🧩 Cooperative Decomposition Session for: $STORY_ID"
Task("Product Owner", "Lead story analysis and value clarification with acceptance criteria validation", "product-owner")
Task("Scrum Master", "Facilitate collaborative decomposition and ensure INVEST criteria compliance", "scrum-master")
Task("Technical Lead", "Identify technical tasks, dependencies, and implementation approach", "system-architect")
Task("Developer", "Estimate implementation effort and validate technical feasibility", "hugo-developer")
Task("QA Engineer", "Define testing approach and validate acceptance criteria testability", "qa-engineer")

# Post-grooming validation and storage
npx claude-flow@alpha hooks memory-store \
  --key "grooming/decomposition/$STORY_ID" \
  --value "$DECOMPOSITION_RESULT"
```

### 🔀 Sprint Board Integration
```javascript
// Parallel task management with Agile board visualization
[Single Message - Sprint Task Movement]:
  Task("Move to In Progress", "Update active job story status with WIP validation", "scrum-master")
  Task("Assign Developer", "Assign hugo-developer to active task only", "product-owner")
  Task("Update Burndown", "Recalculate remaining work and velocity", "qa-engineer")
  
  // Update sprint board state
  npx claude-flow@alpha kanban update \
    --story "$ACTIVE_STORY" \
    --column "in_progress" \
    --assignee "hugo-developer" \
    --validate-wip-limits
```

### Every Agent Spawned via Task Tool MUST:

**1️⃣ BEFORE Work - Agile Context Validation:**
```bash
# Validate sprint and WIP context
echo "🏃 Sprint Context Validation: $TASK"
npx claude-flow@alpha hooks pre-task --description "$TASK" --sprint-context "sprint-1"
npx claude-flow@alpha hooks session-restore --session-id "swarm-sprint-1"

# Validate WIP limits compliance
echo "⚖️ WIP Limits Validation"
npx claude-flow@alpha hooks validate-wip \
  --current-goal "$SPRINT_GOAL" \
  --current-story "$ACTIVE_JOB_STORY" \
  --current-task "$ACTIVE_TASK"

# Cooperative decomposition check
echo "🧩 Cooperative Decomposition Check"
npx claude-flow@alpha hooks validate-decomposition \
  --story-id "$JOB_STORY_ID" \
  --task-id "$TASK_ID"
```

**2️⃣ DURING Work - Agile Progress Tracking:**
```bash
# Sprint-aware progress tracking
npx claude-flow@alpha hooks post-edit \
  --file "$FILE" \
  --memory-key "sprint/1/$AGENT_NAME/$STEP" \
  --story-context "$JOB_STORY_ID"

# Agile notification with burndown update
npx claude-flow@alpha hooks notify \
  --message "$WORK_COMPLETED" \
  --update-burndown \
  --validate-story-progress

# WIP compliance monitoring
echo "📊 WIP Compliance Check: Task progress within limits"
npx claude-flow@alpha hooks monitor-wip --agent "$AGENT_NAME"
```

**3️⃣ AFTER Work - Sprint Integration & Validation:**
```bash
# Sprint task completion with acceptance criteria validation
npx claude-flow@alpha hooks post-task \
  --task-id "$TASK_ID" \
  --story-id "$JOB_STORY_ID" \
  --validate-acceptance-criteria

# Sprint metrics and velocity update
npx claude-flow@alpha hooks update-sprint-metrics \
  --sprint "1" \
  --completed-points "$STORY_POINTS" \
  --update-velocity

# Agile session end with retrospective data
npx claude-flow@alpha hooks session-end \
  --export-metrics true \
  --sprint-context "sprint-1" \
  --collect-retrospective-data
```

## 🎯 Agile Concurrent Execution Examples

### ✅ CORRECT AGILE WORKFLOW: Sprint-Driven MCP + Claude Code Execution

```javascript
// Step 1: Initialize Agile sprint coordination
[Single Message - Sprint Initialization]:
  mcp__claude-flow__swarm_init { 
    topology: "hierarchical", 
    maxAgents: 5,
    strategy: "agile-sprint",
    wip_enforcement: true
  }
  
  // Spawn Agile team agents
  mcp__claude-flow__agent_spawn { type: "product-owner", name: "JT Product Owner" }
  mcp__claude-flow__agent_spawn { type: "scrum-master", name: "JT Scrum Master" }
  mcp__claude-flow__agent_spawn { type: "hugo-developer", name: "JT Hugo Developer" }
  mcp__claude-flow__agent_spawn { type: "content-developer", name: "JT Content Developer" }
  mcp__claude-flow__agent_spawn { type: "qa-engineer", name: "JT QA Engineer" }

// Step 2: Sprint execution with WIP limits enforcement
[Single Message - Agile Sprint Execution]:
  // Claude Code's Task tool spawns Agile team with sprint context
  Task("Product Owner", "Define and prioritize current job story: JT-001. Validate acceptance criteria and ensure WIP limits (1 active story only).", "product-owner")
  Task("Scrum Master", "Facilitate sprint coordination, monitor WIP compliance, and track velocity for sprint-1.", "scrum-master")
  Task("Hugo Developer", "Implement ONLY active task from JT-001. Follow micro-change protocol with sprint context.", "hugo-developer")
  Task("Content Developer", "Support active hugo implementation with content needs. Maintain single-story focus.", "content-developer")
  Task("QA Engineer", "Test active implementation against acceptance criteria. Update burndown chart.", "qa-engineer")

  // Batch ALL sprint todos with story points
  TodoWrite { todos: [
    {id: "JT-001", content: "Establish Agile CLAUDE.md configuration", status: "in_progress", priority: "high", points: 8, sprint: 1},
    {id: "JT-002", content: "Integrate WIP limits enforcement", status: "pending", priority: "high", points: 5, sprint: 1},
    {id: "JT-003", content: "Configure sprint ceremonies", status: "pending", priority: "high", points: 3, sprint: 1},
    {id: "JT-004", content: "Setup job story templates", status: "pending", priority: "medium", points: 2, sprint: 1},
    {id: "JT-005", content: "Implement cooperative decomposition", status: "pending", priority: "medium", points: 5, sprint: 1}
  ]}

  // Sprint-aware file operations
  Bash "mkdir -p jt_site/{content,layouts,static,config}/sprint-1"
  Write "jt_site/config/sprint-1/agile-config.yaml"
  Write "jt_site/content/sprint-1/job-stories.md"
  Write "jt_site/layouts/sprint-1/sprint-board.html"
```

### ❌ WRONG (Multiple Messages):
```javascript
Message 1: mcp__claude-flow__swarm_init
Message 2: Task("agent 1")
Message 3: TodoWrite { todos: [single todo] }
Message 4: Write "file.js"
// This breaks parallel coordination!
```

## Performance Benefits

- **84.8% SWE-Bench solve rate**
- **32.3% token reduction**
- **2.8-4.4x speed improvement**
- **27+ neural models**

## Hooks Integration

### Pre-Operation
- Auto-assign agents by file type
- Validate commands for safety
- Prepare resources automatically
- Optimize topology by complexity
- Cache searches

### Post-Operation
- Auto-format code
- Train neural patterns
- Update memory
- Analyze performance
- Track token usage

### Session Management
- Generate summaries
- Persist state
- Track metrics
- Restore context
- Export workflows

## Advanced Features (v2.0.0)

- 🚀 Automatic Topology Selection
- ⚡ Parallel Execution (2.8-4.4x speed)
- 🧠 Neural Training
- 📊 Bottleneck Analysis
- 🤖 Smart Auto-Spawning
- 🛡️ Self-Healing Workflows
- 💾 Cross-Session Memory
- 🔗 GitHub Integration

## Integration Tips

1. Start with basic swarm init
2. Scale agents gradually
3. Use memory for context
4. Monitor progress regularly
5. Train patterns from success
6. Enable hooks automation
7. Use GitHub tools first

## Support

- Documentation: https://github.com/ruvnet/claude-flow
- Issues: https://github.com/ruvnet/claude-flow/issues

---

### 🔧 Agile Enforcement Hooks (Pre/During/Post Sprint Validation)

#### Pre-Sprint Quality Gates

```yaml
pre_sprint_validation:
  mandatory_gates:
    backlog_readiness:
      validation: "All sprint stories meet Definition of Ready"
      criteria:
        - acceptance_criteria_complete: "Clear, testable acceptance criteria"
        - story_estimation_complete: "Relative sizing using story points"
        - dependencies_identified: "External dependencies documented"
        - technical_approach_defined: "High-level technical approach agreed"
      enforcement: "Sprint cannot start without ready backlog"

    team_capacity_validation:
      validation: "Team capacity accurately calculated and realistic"
      criteria:
        - availability_confirmed: "Team member availability verified"
        - velocity_data_reviewed: "Historical velocity data considered"
        - capacity_buffer_included: "Buffer for unforeseen work included"
        - wip_limits_planned: "WIP limits integrated into planning"
      enforcement: "Sprint commitment must align with capacity"

    sprint_goal_definition:
      validation: "Clear, measurable sprint goal established"
      criteria:
        - business_value_clear: "Business value articulated"
        - success_criteria_defined: "Measurable success criteria"
        - stakeholder_alignment: "Key stakeholders aligned on goal"
        - single_goal_focus: "One primary goal per sprint (WIP limit)"
      enforcement: "Sprint requires single, clear goal"

  pre_sprint_hooks:
    research_validation:
      - pattern_research: "Research existing implementation patterns"
      - framework_validation: "Validate framework capabilities"
      - knowledge_consultation: "Consult knowledge base practices"
      - dependency_analysis: "Analyze technical dependencies"

    quality_preparation:
      - testing_strategy: "Define testing approach for sprint stories"
      - performance_criteria: "Establish performance acceptance criteria"
      - accessibility_requirements: "Define accessibility compliance requirements"
      - security_considerations: "Identify security requirements and validations"
```

#### During-Sprint Monitoring Hooks

```yaml
during_sprint_monitoring:
  daily_validation_hooks:
    wip_compliance_check:
      frequency: "Every daily standup"
      validation: "WIP limits maintained across team"
      alerts:
        - multiple_active_tasks: "Team member working on multiple tasks"
        - story_overflow: "More than one story active per person"
        - goal_drift: "Work not aligned with sprint goal"
      enforcement: "Immediate correction required"

    progress_tracking:
      frequency: "Daily after standup"
      validation: "Progress toward sprint goal measurable"
      metrics:
        - story_completion_rate: "Stories completed vs planned"
        - task_burndown: "Task hours remaining vs ideal"
        - impediment_resolution: "Time to resolve impediments"
        - velocity_tracking: "Actual vs planned story points"
      enforcement: "Corrective action for significant deviations"

    quality_gate_monitoring:
      frequency: "After each story completion"
      validation: "All quality gates passed before story acceptance"
      gates:
        - definition_of_done: "All DoD criteria met"
        - acceptance_criteria: "All acceptance criteria satisfied"
        - code_review_complete: "Code review completed and approved"
        - testing_complete: "All testing levels completed"
      enforcement: "Story not accepted until all gates passed"

  continuous_improvement_hooks:
    impediment_escalation:
      trigger: "Impediment blocks work for >24 hours"
      action: "Automatic escalation to Scrum Master"
      tracking: "Impediment resolution time monitoring"

    capacity_adjustment:
      trigger: "Significant capacity change during sprint"
      action: "Sprint scope adjustment with stakeholder communication"
      validation: "Revised commitment still achieves sprint goal"

    early_warning_system:
      trigger: "Sprint goal at risk based on current progress"
      action: "Stakeholder communication and mitigation planning"
      options: "Scope adjustment, resource reallocation, or impediment resolution"
```

#### Post-Sprint Validation Hooks

```yaml
post_sprint_validation:
  sprint_completion_gates:
    goal_achievement_assessment:
      validation: "Sprint goal achievement objectively measured"
      criteria:
        - success_metrics_met: "All sprint goal metrics achieved"
        - stakeholder_satisfaction: "Stakeholder acceptance of deliverables"
        - quality_standards_met: "All quality gates passed"
        - technical_debt_addressed: "No new technical debt introduced"
      outcome: "Clear success/failure determination with lessons learned"

    deliverable_validation:
      validation: "All completed work meets Definition of Done"
      criteria:
        - functional_completeness: "All functionality working as specified"
        - testing_completeness: "All testing levels completed successfully"
        - documentation_complete: "User and technical documentation updated"
        - deployment_ready: "Work ready for production deployment"
      outcome: "Only fully completed work considered done"

    process_effectiveness_review:
      validation: "Sprint process effectiveness evaluated"
      metrics:
        - commitment_accuracy: "Planned vs actual story completion"
        - estimation_accuracy: "Estimated vs actual effort"
        - impediment_impact: "Time lost to impediments"
        - wip_compliance_rate: "WIP limits adherence percentage"
      outcome: "Process improvement recommendations for next sprint"

  post_sprint_hooks:
    retrospective_preparation:
      - metrics_compilation: "Compile sprint metrics and data"
      - feedback_collection: "Collect team and stakeholder feedback"
      - improvement_analysis: "Analyze improvement opportunities"
      - action_item_review: "Review previous retrospective actions"

    knowledge_capture:
      - pattern_documentation: "Document successful patterns"
      - lesson_learned_storage: "Store lessons learned in knowledge base"
      - best_practice_updates: "Update team best practices"
      - failure_analysis: "Analyze and document failures for prevention"

    next_sprint_preparation:
      - backlog_prioritization: "Update and prioritize product backlog"
      - capacity_planning: "Plan capacity for next sprint"
      - impediment_resolution: "Resolve outstanding impediments"
      - process_adjustments: "Implement process improvements"
```

#### Agile Enforcement Coordination Commands

```bash
# Pre-sprint validation (mandatory before sprint start)
echo "✅ Pre-Sprint Validation Gates"
Task("Backlog Validator", "Validate all stories meet Definition of Ready and have complete acceptance criteria", "product-owner")
Task("Capacity Planner", "Calculate realistic team capacity with historical velocity and availability data", "scrum-master")
Task("Sprint Goal Validator", "Ensure single, clear, measurable sprint goal with stakeholder alignment", "product-owner")

# During-sprint monitoring hooks (automated daily)
echo "📊 During-Sprint Monitoring Hooks"
npx claude-flow@alpha hooks daily-wip-check \
  --validate-limits \
  --alert-violations \
  --track-progress

npx claude-flow@alpha hooks quality-gate-monitor \
  --check-dod \
  --validate-acceptance \
  --enforce-standards

# Post-sprint validation (mandatory after sprint end)
echo "🎯 Post-Sprint Validation Gates"
Task("Goal Achievement Assessor", "Objectively measure sprint goal achievement against defined success criteria", "scrum-master")
Task("Quality Validator", "Validate all completed work meets Definition of Done and quality standards", "qa-engineer")
Task("Process Analyzer", "Analyze sprint process effectiveness and identify improvement opportunities", "scrum-master")

# Store validation results in memory
npx claude-flow@alpha hooks memory-store \
  --key "sprint-validation/pre-sprint/$(date +%s)" \
  --value "$PRE_SPRINT_VALIDATION"
  
npx claude-flow@alpha hooks memory-store \
  --key "sprint-validation/post-sprint/$(date +%s)" \
  --value "$POST_SPRINT_VALIDATION"
```

### 🤝 Cross-Agent Collaboration (Story Handoff Protocols)

#### Agent Collaboration Framework

```yaml
cross_agent_collaboration:
  story_handoff_protocol:
    research_to_development:
      handoff_criteria:
        - pattern_analysis_complete: "Existing patterns analyzed and documented"
        - framework_validation_done: "Framework capabilities validated"
        - technical_approach_defined: "High-level technical approach documented"
        - dependency_map_created: "All dependencies identified and mapped"
      handoff_artifacts:
        - research_summary: "Summary of findings and recommendations"
        - pattern_library: "Relevant patterns and examples"
        - technical_specifications: "Detailed technical requirements"
        - risk_assessment: "Identified risks and mitigation strategies"
      coordination_memory: "research/handoffs/story-$STORY_ID"

    development_to_testing:
      handoff_criteria:
        - implementation_complete: "All functionality implemented according to acceptance criteria"
        - code_review_passed: "Code review completed and approved"
        - unit_tests_written: "Comprehensive unit tests created and passing"
        - documentation_updated: "Code and API documentation updated"
      handoff_artifacts:
        - implementation_summary: "Summary of implementation approach"
        - test_data_scenarios: "Test data and scenarios for validation"
        - deployment_instructions: "Instructions for testing environment setup"
        - known_limitations: "Any known limitations or edge cases"
      coordination_memory: "development/handoffs/story-$STORY_ID"

    testing_to_review:
      handoff_criteria:
        - functional_testing_complete: "All functional tests executed and passed"
        - performance_testing_done: "Performance criteria validated"
        - accessibility_testing_complete: "Accessibility compliance verified"
        - security_testing_passed: "Security validations completed"
      handoff_artifacts:
        - test_results_summary: "Comprehensive test results documentation"
        - performance_metrics: "Performance test results and analysis"
        - accessibility_report: "Accessibility compliance report"
        - defect_log: "Any defects found and resolution status"
      coordination_memory: "testing/handoffs/story-$STORY_ID"

    review_to_deployment:
      handoff_criteria:
        - quality_review_passed: "Code and implementation quality approved"
        - business_acceptance_complete: "Business stakeholders accept deliverable"
        - deployment_readiness_confirmed: "All deployment prerequisites met"
        - rollback_plan_prepared: "Rollback procedures documented and tested"
      handoff_artifacts:
        - quality_assessment: "Final quality assessment and approval"
        - business_sign_off: "Stakeholder acceptance documentation"
        - deployment_checklist: "Pre-deployment validation checklist"
        - rollback_procedures: "Detailed rollback procedures"
      coordination_memory: "review/handoffs/story-$STORY_ID"

  collaboration_coordination_hooks:
    pre_handoff_validation:
      - completion_criteria_check: "All handoff criteria met"
      - artifact_preparation: "All handoff artifacts prepared"
      - receiving_agent_readiness: "Receiving agent ready and available"
      - dependency_resolution: "All blocking dependencies resolved"

    handoff_execution:
      - context_transfer: "Complete context transferred to receiving agent"
      - knowledge_sharing: "Relevant knowledge and lessons shared"
      - collaboration_setup: "Ongoing collaboration channels established"
      - progress_tracking: "Handoff progress tracked in memory"

    post_handoff_validation:
      - understanding_confirmation: "Receiving agent confirms understanding"
      - progress_continuation: "Work continues without delays or gaps"
      - feedback_loop_established: "Feedback mechanism for clarifications"
      - coordination_success: "Successful handoff recorded in memory"
```

#### Story Handoff Coordination Commands

```bash
# Research to Development handoff
echo "🔬➡️💻 Research to Development Handoff for: $STORY_ID"
Task("Research Agent", "Complete pattern analysis, framework validation, and technical approach documentation for handoff to development", "researcher")
Task("Development Agent", "Receive research context, validate technical approach, and begin implementation planning", "hugo-developer")

# Store handoff artifacts in memory
npx claude-flow@alpha hooks memory-store \
  --key "handoffs/research-to-dev/$STORY_ID" \
  --value "$RESEARCH_HANDOFF_ARTIFACTS"

# Development to Testing handoff
echo "💻➡️🧪 Development to Testing Handoff for: $STORY_ID"
Task("Development Agent", "Complete implementation, pass code review, and prepare testing handoff artifacts", "hugo-developer")
Task("QA Agent", "Receive implementation context, validate completeness, and begin testing planning", "qa-engineer")

# Store handoff artifacts
npx claude-flow@alpha hooks memory-store \
  --key "handoffs/dev-to-test/$STORY_ID" \
  --value "$DEVELOPMENT_HANDOFF_ARTIFACTS"

# Testing to Review handoff
echo "🧪➡️👀 Testing to Review Handoff for: $STORY_ID"
Task("QA Agent", "Complete all testing levels, document results, and prepare review handoff artifacts", "qa-engineer")
Task("Review Agent", "Receive testing context, validate quality, and begin final review process", "reviewer")

# Store handoff artifacts
npx claude-flow@alpha hooks memory-store \
  --key "handoffs/test-to-review/$STORY_ID" \
  --value "$TESTING_HANDOFF_ARTIFACTS"

# Review to Deployment handoff
echo "👀➡️🚀 Review to Deployment Handoff for: $STORY_ID"
Task("Review Agent", "Complete quality and business review, confirm deployment readiness", "reviewer")
Task("DevOps Agent", "Receive deployment context, validate prerequisites, and execute deployment", "cicd-engineer")

# Store final handoff artifacts
npx claude-flow@alpha hooks memory-store \
  --key "handoffs/review-to-deploy/$STORY_ID" \
  --value "$REVIEW_HANDOFF_ARTIFACTS"
```

### 📈 Velocity Tracking (Burndown Charts and Metrics Dashboard)

#### Velocity Metrics Framework

```yaml
velocity_tracking:
  velocity_calculation:
    story_points_method:
      formula: "Completed Story Points / Sprint Duration"
      measurement: "Story points completed per sprint"
      trending: "3-sprint rolling average for stability"

    throughput_method:
      formula: "Completed Stories / Sprint Duration"
      measurement: "Number of stories completed per sprint"
      trending: "Historical throughput analysis"

    cycle_time_method:
      formula: "Average time from start to completion"
      measurement: "Days to complete average story"
      trending: "Cycle time reduction over time"

  jt_site_velocity_baseline:
    historical_data:
      sprint_1:
        planned_points: 40
        completed_points: 35
        velocity: 35
        completion_rate: 87.5%

    current_metrics:
      rolling_velocity: 38  # 3-sprint average
      velocity_trend: "stable"  # increasing, stable, decreasing
      predictability: 92%  # consistency of delivery

    capacity_factors:
      team_size: 5
      sprint_duration: 14  # days (2 iterations × 7 days)
      iteration_duration: 7  # days per iteration
      daily_capacity: 8    # hours per person per day
      weekly_capacity: 40  # hours per person per iteration
      iteration_capacity: 200  # hours per iteration (5 × 40)
      total_sprint_capacity: 400  # hours per sprint (2 × 200)
      focus_factor: 75%    # actual productive time
      effective_iteration_capacity: 150  # hours (200 × 75%)
      effective_sprint_capacity: 300  # hours (400 × 75%)

  burndown_chart_data:
    ideal_burndown:
      formula: "Total Points - (Points per Day * Days Elapsed)"
      slope: "Linear decline to zero"

    actual_burndown:
      daily_tracking: "Points remaining each day"
      completion_pattern: "Actual vs ideal comparison"

    sprint_metrics:
      total_points: 40
      daily_ideal_burn: 2.86  # points per day
      current_day: 7
      ideal_remaining: 20
      actual_remaining: 24
      variance: -4  # behind schedule

  performance_indicators:
    velocity_consistency:
      measurement: "Standard deviation of sprint velocities"
      target: "<15% variance"
      current: "12% variance"
      status: "meeting_target"

    sprint_goal_achievement:
      measurement: "Percentage of sprints achieving stated goal"
      target: ">90% achievement rate"
      current: "85% achievement"
      status: "below_target"

    story_completion_rate:
      measurement: "Stories completed vs committed"
      target: ">80% completion rate"
      current: "87% completion"
      status: "exceeding_target"
```

#### Metrics Dashboard Configuration

```yaml
metrics_dashboard:
  real_time_metrics:
    current_sprint_progress:
      - sprint_goal_progress: "Visual progress toward sprint goal"
      - story_completion_status: "Status of each story (not started, in progress, done)"
      - burndown_chart: "Actual vs ideal burndown visualization"
      - team_capacity_utilization: "Current vs planned capacity usage"

    daily_metrics:
      - velocity_tracking: "Current velocity vs historical average"
      - cycle_time_trends: "Average story completion time trends"
      - impediment_tracking: "Active impediments and resolution time"
      - wip_limits_compliance: "WIP limits adherence monitoring"

    quality_metrics:
      - defect_rate: "Defects found per story point delivered"
      - rework_percentage: "Percentage of work requiring rework"
      - technical_debt_accumulation: "Technical debt growth/reduction"
      - customer_satisfaction: "Stakeholder satisfaction scores"

  historical_analysis:
    velocity_trends:
      - 6_month_velocity: "Velocity trend over 6 months"
      - seasonal_patterns: "Velocity patterns by time period"
      - team_changes_impact: "Velocity impact of team changes"

    predictive_analytics:
      - velocity_forecasting: "Predicted velocity for next 3 sprints"
      - capacity_planning: "Projected capacity based on historical data"
      - delivery_estimation: "Estimated completion dates for epics"

  automated_reporting:
    daily_reports:
      - standup_metrics: "Key metrics for daily standup"
      - impediment_alerts: "Automated alerts for blocking issues"
      - wip_violations: "Automated WIP limit violation notifications"

    sprint_reports:
      - sprint_summary: "Complete sprint performance summary"
      - retrospective_data: "Data-driven retrospective insights"
      - improvement_tracking: "Progress on improvement initiatives"
```

#### Velocity Tracking Automation Commands

```bash
# Daily velocity and burndown updates
echo "📊 Daily Velocity Tracking Update"
npx claude-flow@alpha metrics velocity-update \
  --sprint "1" \
  --completed-points "$DAILY_COMPLETED_POINTS" \
  --remaining-points "$REMAINING_POINTS" \
  --update-burndown

# Real-time dashboard updates
npx claude-flow@alpha dashboard update \
  --sprint-progress "$SPRINT_PROGRESS" \
  --velocity-trend "$VELOCITY_TREND" \
  --impediment-count "$ACTIVE_IMPEDIMENTS" \
  --wip-compliance "$WIP_COMPLIANCE_RATE"

# Weekly velocity analysis
echo "📈 Weekly Velocity Analysis"
Task("Metrics Analyst", "Analyze weekly velocity trends, identify patterns, and update forecasting models", "performance-benchmarker")
Task("Dashboard Updater", "Update dashboard with latest metrics and generate performance reports", "scrum-master")

# Sprint velocity calculation and storage
npx claude-flow@alpha hooks memory-store \
  --key "velocity/sprint-1/final" \
  --value "completed_points:35,planned_points:40,velocity:35,completion_rate:87.5"

# Historical velocity tracking
npx claude-flow@alpha hooks memory-store \
  --key "velocity/historical/$(date +%s)" \
  --value "rolling_average:38,trend:stable,predictability:92"

# Automated reporting
npx claude-flow@alpha reporting generate \
  --type "velocity-dashboard" \
  --sprint "1" \
  --include-trends \
  --include-forecasts \
  --export-format "dashboard"
```

## 🚀 AGILE QUICK START COMMANDS

```bash
# Initialize Agile sprint with comprehensive framework
npx claude-flow@alpha agile sprint-init \
  --number 1 \
  --name "JT Foundation Sprint" \
  --enforce-wip \
  --setup-ceremonies \
  --initialize-metrics

# Daily Agile workflow with full validation
npx claude-flow@alpha agile daily \
  --standup \
  --update-board \
  --check-blockers \
  --validate-wip \
  --update-burndown \
  --collect-metrics

# Sprint ceremonies with mandatory participation
npx claude-flow@alpha agile sprint-planning \
  --estimate-stories \
  --enforce-wip-limits \
  --capacity-planning \
  --goal-setting \
  --mandatory-participation
  
npx claude-flow@alpha agile sprint-review \
  --demo \
  --collect-feedback \
  --assess-goal-achievement \
  --update-backlog
  
npx claude-flow@alpha agile retrospective \
  --identify-improvements \
  --track-action-items \
  --analyze-metrics \
  --plan-process-changes

# Job story management with templates
npx claude-flow@alpha agile story-create \
  --template "When I [situation], I want [motivation], so I can [outcome]" \
  --validate-invest \
  --estimate-complexity
  
npx claude-flow@alpha agile story-decompose \
  --cooperative \
  --research-first \
  --validate-size \
  --create-tasks

# User story mapping
npx claude-flow@alpha agile story-map \
  --create-user-journey \
  --identify-activities \
  --organize-stories \
  --prioritize-value

# Prioritization frameworks
npx claude-flow@alpha agile prioritize \
  --method "moscow" \
  --stakeholder-input \
  --validate-categories
  
npx claude-flow@alpha agile prioritize \
  --method "wsjf" \
  --calculate-scores \
  --rank-features

# WIP limits monitoring and enforcement
npx claude-flow@alpha agile wip-status \
  --goals \
  --sprints \
  --stories \
  --tasks \
  --show-violations
  
npx claude-flow@alpha agile wip-enforce \
  --block-exceeding \
  --alert-violations \
  --auto-rebalance

# Cross-agent collaboration
npx claude-flow@alpha agile handoff \
  --from "researcher" \
  --to "hugo-developer" \
  --story-id "JT-001" \
  --validate-artifacts

# Velocity tracking and metrics
npx claude-flow@alpha agile velocity \
  --calculate \
  --update-trends \
  --forecast-capacity \
  --generate-dashboard
  
npx claude-flow@alpha agile burndown \
  --update-daily \
  --compare-ideal \
  --alert-deviations
```

## 📚 AGILE KNOWLEDGE BASE INTEGRATION

### 📖 Agile-Specific Knowledge References
- `/knowledge/60.01-agile-methodology-reference.md` - Core Agile principles
- `/knowledge/60.02-scrum-framework-tutorial.md` - Scrum implementation guide
- `/knowledge/60.03-wip-limits-enforcement-how-to.md` - WIP limits best practices
- `/knowledge/60.04-job-stories-format-reference.md` - Job story templates and examples
- `/knowledge/60.05-cooperative-decomposition-explanation.md` - Story decomposition techniques
- `/knowledge/60.06-sprint-ceremonies-tutorial.md` - Sprint ceremony facilitation

Remember: **Agile principles guide, Claude Flow coordinates, Claude Code creates within sprint boundaries!**

## 🚨 MANDATORY TEST VALIDATION ENFORCEMENT (ZERO TOLERANCE)

### BLOCKING REQUIREMENTS - ALL AGENTS MUST COMPLY

#### Pre-Task Validation (MANDATORY)
```bash
# BLOCKING: ALL agents MUST run bin/test BEFORE any work begins
pre_task_test_validation() {
    echo "🧪 MANDATORY: Pre-task test validation"
    
    # Run full test suite - BLOCKING if fails
    if ! bin/test; then
        echo "❌ BLOCKED: Tests failing before task begins"
        echo "🛑 CANNOT START: Fix failing tests first"
        echo "📋 Run: bin/test to see failures"
        exit 1
    fi
    
    echo "✅ Pre-task validation passed - work can begin"
}
```

#### During-Task Validation (ENFORCED)
```bash
# AUTOMATIC ROLLBACK: Tests MUST pass after EVERY file change
during_task_test_validation() {
    local changed_file="$1"
    
    echo "🔍 ENFORCED: During-task test validation for $changed_file"
    
    # Run tests immediately after change
    if ! bin/test; then
        echo "❌ ROLLBACK: Tests failed after change to $changed_file"
        echo "🔄 AUTOMATIC ROLLBACK: git checkout -- ."
        git checkout -- .
        
        echo "❌ BLOCKED: Cannot proceed until issue resolved"
        echo "🛠️ REQUIRED: Fix the change to maintain passing tests"
        exit 1
    fi
    
    echo "✅ During-task validation passed for $changed_file"
}
```

#### Post-Task Gates (BLOCKING)
```bash
# BLOCKING: Cannot claim completion without ALL tests passing
post_task_test_validation() {
    local task_id="$1"
    
    echo "🎯 BLOCKING: Post-task test validation for $task_id"
    
    # Verify build tools still work
    if ! bin/build; then
        echo "❌ BLOCKED: Build system broken"
        echo "🛠️ REQUIRED: Fix build before completion"
        return 1
    fi
    
    if ! bin/dev --help >/dev/null 2>&1; then
        echo "❌ BLOCKED: Development tools broken"
        echo "🛠️ REQUIRED: Fix dev tools before completion"
        return 1
    fi
    
    # Run full test suite - BLOCKING for completion
    if ! bin/dtest; then
        echo "❌ BLOCKED: Cannot claim task completion"
        echo "🚫 TASK INCOMPLETE: Tests are failing"
        echo "📋 Required: ALL tests must pass"
        echo "🔧 Action: Fix failing tests before claiming done"
        return 1
    fi
    
    echo "✅ Post-task validation passed - task can be marked complete"
    return 0
}
```

### AGENT INSTRUCTION TEMPLATE (MANDATORY)

**ALL Task() calls MUST include this test enforcement:**

```javascript
Task("Agent Name", `
  MANDATORY TEST ENFORCEMENT for [TASK]:
  
  🚨 BEFORE STARTING:
  - MUST run bin/test - BLOCKED if fails
  - Cannot begin work until tests pass
  
  🚨 DURING WORK:
  - MUST run bin/test after EVERY file change
  - AUTOMATIC rollback: git checkout -- . on failure
  - Cannot proceed until tests pass
  
  🚨 BEFORE COMPLETION:
  - MUST run full test suite: bin/dtest
  - MUST verify build works: bin/build
  - BLOCKED from claiming done if ANY test fails
  
  ZERO TOLERANCE: No exceptions, no bypass, no excuses.
  
  Actual task work: [TASK DESCRIPTION]
`, "agent-type")
```

### MEMORY TRACKING ENFORCEMENT

**Track test validation status for ALL agents:**

```bash
# Store test validation results
store_test_validation_result() {
    local agent_name="$1"
    local phase="$2"  # pre-task, during-task, post-task
    local result="$3" # passed, failed, blocked
    local task_id="$4"
    
    npx claude-flow@alpha hooks memory-store \
      --key "test-validation/$task_id/$agent_name/$phase" \
      --value "result:$result,timestamp:$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
      --namespace "test-enforcement"
    
    if [ "$result" = "failed" ]; then
        echo "🚨 TEST VALIDATION FAILURE RECORDED"
        echo "📊 Agent: $agent_name, Phase: $phase, Task: $task_id"
        
        # Increment failure counter
        local failures=$(npx claude-flow@alpha hooks memory-retrieve \
          --key "test-validation/failures/$agent_name" 2>/dev/null || echo "0")
        local new_failures=$((failures + 1))
        
        npx claude-flow@alpha hooks memory-store \
          --key "test-validation/failures/$agent_name" \
          --value "$new_failures" \
          --namespace "test-enforcement"
        
        if [ "$new_failures" -ge 3 ]; then
            echo "🔒 AGENT SUSPENDED: Too many test validation failures"
            echo "📋 Required: Review and retraining before resuming work"
        fi
    fi
}
```

### TEST DELETION PREVENTION (ZERO TOLERANCE)

```bash
# BLOCKING: Prevent deletion of valid tests
prevent_test_deletion() {
    echo "🛡️ ZERO TOLERANCE: Preventing test deletion"
    
    # Check for deleted test files in git diff
    local deleted_tests=$(git diff --name-status | grep '^D.*\.test\.')
    
    if [ -n "$deleted_tests" ]; then
        echo "❌ BLOCKED: Test file deletion detected"
        echo "🚫 FORBIDDEN: Cannot delete test files to make tests pass"
        echo "📋 Deleted tests:"
        echo "$deleted_tests"
        echo ""
        echo "🔄 REQUIRED ACTION: git checkout -- [test_files]"
        echo "🛠️ ALTERNATIVE: Fix the code, not delete the tests"
        exit 1
    fi
    
    # Check for commented out test cases
    local commented_tests=$(find . -name "*.test.*" -exec grep -l "// .*it(\|// .*describe(\|/\* .*it(\|/\* .*describe(" {} \;)
    
    if [ -n "$commented_tests" ]; then
        echo "⚠️ WARNING: Commented test cases detected"
        echo "🔍 Files with commented tests:"
        echo "$commented_tests"
        echo "🛠️ REQUIRED: Fix failing tests instead of commenting them out"
    fi
}
```

### REGRESSION PREVENTION INTEGRATION

**Enhanced verification-first with test enforcement:**

```bash
# Comprehensive fix protocol with test enforcement
fix_with_test_enforcement() {
    local issue="$1"
    
    echo "🔧 Fix with mandatory test enforcement for: $issue"
    
    # Step 1: Pre-fix test validation (MANDATORY)
    if ! pre_task_test_validation; then
        echo "❌ BLOCKED: Cannot start fix - tests already failing"
        exit 1
    fi
    
    # Step 2: Create reproduction test (MANDATORY)
    if ! create_reproduction_test "$issue"; then
        echo "❌ BLOCKED: Cannot proceed without reproduction test"
        exit 1
    fi
    
    # Step 3: Comprehensive search with test safety
    comprehensive_search "$issue"
    
    # Step 4: Fix files with test validation after each
    while read -r file; do
        echo "🔧 Fixing: $file"
        
        # Apply fix
        apply_fix "$file" "$issue"
        
        # MANDATORY: Test after each fix
        if ! during_task_test_validation "$file"; then
            echo "❌ Fix broke tests - already rolled back"
            exit 1
        fi
        
        echo "✅ Fixed and validated: $file"
    done < "/tmp/fix_inventory_$issue.txt"
    
    # Step 5: Final validation (MANDATORY)
    if ! post_task_test_validation "fix-$issue"; then
        echo "❌ BLOCKED: Fix incomplete - tests still failing"
        exit 1
    fi
    
    echo "✅ Fix complete with all tests passing"
}
```

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.
Never save working files, text/mds and tests to the root folder.
- always spawn swarm to handle requests
- 🚨 MANDATORY: After each task spawn appropriate agent to run bin/test with ZERO TOLERANCE - all tests MUST pass
- 🚨 BLOCKING: If bin/test fails, agent is BLOCKED from continuing until tests pass
- 🚨 AUTOMATIC ROLLBACK: Any change that breaks tests triggers immediate git checkout -- .
- 🛡️ FORBIDDEN: Deletion of valid tests to make them pass - reviewer pre-validation MANDATORY
- 📊 TRACKED: All test validation results stored in memory for compliance monitoring
- prioritize to use claude-context for search through codebase over average search
- verify tests after each change and request to rework on found issues
- prevent deletion of valid tests to make them pass. IMPORTANT: pre-validate changes with reviewer to avoid breaking changes
- spawn swarm: prevent deletion of valid tests to make them pass. IMPORTANT: pre-validate changes with reviewer to avoid breaking changes
- always activate weekly iteration/incremental development work for significant requests, and schedule reflections at the end of each iteration.
- 🚨 ZERO TOLERANCE: bin/test, bin/dev, bin/build, bin/dtest MUST work after changes - fix or revert immediately!
- Focus on one iteration at a time. WIP: 1 milestone, 1 sprint (2 weeks), 1 active iteration (1 week), limited job stories per iteration
- Use micro-refactoring (3-line changes) as a QUALITY TECHNIQUE within iteration development, not as iteration definition
- do not left one time verification scripts just to test one regression, or it should be minitests or it should be removed after task completed
- do not add custom scripts hooks for agents and use only native claude and caude-flow npx invocations.

## 🚨 CRITICAL FAILURE PREVENTION SAFEGUARDS

### 🛡️ REFACTORING SAFEGUARD (ZERO TOLERANCE)
- 🚨 BLOCKING: NEVER accept broken functionality as "solution" when task is refactoring
- 🛡️ REFACTORING RULE: Must maintain EXACT same functionality while fixing issues
- ⚠️ WARNING SIGNS: If changing test baselines/expectations, you're breaking not refactoring
- ✅ VALIDATION: Original functionality preserved + issue fixed = successful refactoring
- ❌ VIOLATION: Accepting different output/behavior violates refactoring requirement

### 🔒 BRANCH SAFETY PROTOCOL (MANDATORY)  
- 🚨 BLOCKING: NEVER use git stash + git checkout without explicit preservation plan
- 🛡️ SAFE BRANCH SWITCHING: Always commit or create explicit backup before switching
- ⚠️ WARNING SIGNS: Using git stash means risking work loss
- ✅ VALIDATION: Work preserved through commits or explicit user-approved backup strategy
- ❌ VIOLATION: Any git operation that risks losing uncommitted work

### 📋 REQUIREMENT COMPLIANCE VALIDATION
- 🚨 MANDATORY: Before accepting any solution, verify it meets original requirements
- 🛡️ COMPLIANCE CHECK: "Does this maintain the original request parameters?"
- ⚠️ ESCALATION: If cannot fix within requirements, escalate rather than violate
- ✅ SUCCESS CRITERIA: Original requirements met + issue resolved
- ❌ FAILURE PATTERN: Changing requirements to fit solution instead of fixing solution
- For hugo code use hugo idiomatic way; for ruby use ruby, minitest and rails idiomatic ways