# Claude Code Configuration - jt_site (Integrated TDD Edition v3.0)

**Project**: jt_site Static Site Generator
**Authority**: Extends `/knowledge/` global handbooks (SUPREME AUTHORITY)
**Compliance**: Zero-tolerance TDD, Four-Eyes, Anti-Test-Smell, Knowledge Management
**Version**: 3.0 - Integrated Official Claude-Flow TDD + Anti-Test-Smell Framework

---

## 📖 QUICK START: UNIFIED HANDBOOK NAVIGATION

### 🎯 Primary Navigation
**📚 Start Here**: `docs/index.md` - Complete jt_site-specific handbook
**🌐 Global Standards**: `/knowledge/KNOWLEDGE_INDEX.md` - 99+ company-wide standards (SUPREME AUTHORITY)

### 🔍 Research Protocol (MANDATORY SEQUENCE)
```bash
# Step 1: Global standards FIRST (inherited by jt_site)
claude-context search "[topic]" --path "/knowledge/"

# Step 2: jt_site adaptations SECOND
claude-context search "[topic]" --path "/projects/jt_site/docs/"

# Step 3: Framework validation
context7 resolve-library-id "[framework]" && context7 get-library-docs "[id]"

# Step 4: Package analysis
mcp__package-search__package_search_hybrid --registry_name "[registry]" --package_name "[package]"
```

### 📑 Key Reference Paths
```yaml
global_authority_references:
  tdd: "/knowledge/20.01-tdd-methodology-reference.md"
  tdd_agents: "/knowledge/20.11-tdd-agent-delegation-how-to.md"
  test_quality: "/knowledge/25.04-test-smell-prevention-enforcement-protocols.md"
  four_eyes: "/knowledge/20.02-four-eyes-principle-global.md"
  reflection: "/knowledge/02.08-mandatory-reflection-protocol-supreme-reference.md"
  agent_coordination: "/knowledge/30.01-agent-coordination-patterns.md"

jt_site_specific_adaptations:
  agent_guidance: "/projects/jt_site/docs/60.01-agent-guidance-reference.md"
  tdd_enforcement: "/projects/jt_site/docs/60.03-tdd-quality-enforcement.md"
  visual_testing: "/projects/jt_site/docs/visual_testing_delegation_workflows.md"
```

---

## 🧪 OFFICIAL TDD METHODOLOGY (Claude-Flow Integration)

**Reference**: `/knowledge/20.11-tdd-agent-delegation-how-to.md` (Official TDD agent patterns)
**Reference**: `/knowledge/20.01-tdd-methodology-reference.md` (Global TDD standards)

### 🎯 TDD Agent Specialization Matrix (Official Claude-Flow)

| Agent Type | Phase Focus | Responsibilities | Memory Coordination |
|------------|-------------|------------------|---------------------|
| **test-writer** | 🔴 RED | Write failing tests, define interfaces | `tdd/red-phase/{timestamp}` |
| **minimal-implementer** | 🟢 GREEN | Minimal code to pass tests | `tdd/green-phase/{timestamp}` |
| **refactor-specialist** | 🔵 REFACTOR | Code improvement, duplication removal | `tdd/refactor-phase/{timestamp}` |
| **triangulation-guide** | Strategy | Guide triangulation decisions | `tdd/triangulation/{timestamp}` |
| **tdd-coordinator** | Orchestration | Manage full TDD cycles | `tdd/coordination/{timestamp}` |
| **coverage-analyst** | Quality | Track and improve test coverage | `tdd/coverage/{timestamp}` |

### 🔄 Enhanced TDD Cycle: Red-Shameless Green-Flocking Refactor

**Integration**: Official claude-flow TDD structure + Shameless Green methodology

#### **Phase 1: 🔴 RED - Test-Writer Agent**

**When to Delegate**:
- Complex business logic requiring careful test design
- Multiple edge cases need comprehensive coverage
- Interface design needs to be driven by usage patterns

**Agent Pattern**:
```javascript
// Spawn test-writer agent for RED phase
[RED Phase - Test-First]:
  Task("Test Writer", "Write failing BEHAVIOR-focused test for [feature]. Follow Kent Beck Rule 1: Don't write code before failing test. Reference /knowledge/20.11-tdd-agent-delegation-how-to.md", "test-writer")

  TodoWrite { todos: [
    "Test Writer: Create failing test validating business behavior (NOT implementation)",
    "Verify test fails with meaningful error message",
    "Ensure test focuses on single behavior (Arrange-Act-Assert pattern)",
    "Store RED phase completion in memory: tdd/red-phase/[timestamp]"
  ]}
```

**RED Phase Validation** (MANDATORY):
- [ ] Test fails with meaningful error message
- [ ] Test validates BEHAVIOR, not implementation details
- [ ] Test follows Arrange-Act-Assert pattern
- [ ] Interface design is clean and purposeful
- [ ] NO existence testing, NO configuration testing

#### **Phase 2: 🟢 GREEN - Minimal-Implementer Agent**

**When to Delegate**:
- Need to resist over-engineering temptations
- Simple implementation strategy required (Fake It, Obvious, Triangulation)
- Focus on getting tests to pass quickly

**Agent Pattern**:
```javascript
// Spawn minimal-implementer after RED phase completes
[GREEN Phase - Shameless Green]:
  Task("Minimal Implementer", "Implement embarrassingly simple code to pass tests. Accept hardcoding, accept duplication. Follow Kent Beck: 'Make test work quickly, committing whatever sins necessary'. Reference /knowledge/20.05-shameless-green-flocking-rules-methodology.md", "minimal-implementer")

  TodoWrite { todos: [
    "Minimal Implementer: Use Fake It strategy - return constants that pass test",
    "Accept hardcoded implementations without consolidation pressure",
    "Implementation can be boring, obvious, and direct",
    "Verify all tests pass (including new test)",
    "Store GREEN phase completion in memory: tdd/green-phase/[timestamp]"
  ]}
```

**GREEN Phase Validation** (MANDATORY):
- [ ] All tests pass (including new test)
- [ ] Implementation is minimal and focused (hardcoding acceptable)
- [ ] No over-engineering or premature optimization
- [ ] Code follows chosen implementation strategy (Fake It, Obvious, Triangulation)

#### **Phase 3: 🔵 REFACTOR - Refactor-Specialist Agent**

**When to Delegate**:
- Code duplication detected between tests and implementation
- Design improvements needed while maintaining green tests
- Apply flocking rules for systematic refactoring

**Agent Pattern**:
```javascript
// Spawn refactor-specialist after GREEN phase
[REFACTOR Phase - Flocking Rules]:
  Task("Refactor Specialist", "Apply flocking rules systematically: (1) Select things most alike (2) Find smallest difference (3) Make simplest change to remove difference. Reference /knowledge/20.05-shameless-green-flocking-rules-methodology.md", "refactor-specialist")

  TodoWrite { todos: [
    "Refactor Specialist: Apply 3 flocking rules in micro-steps",
    "Select test duplications most alike across codebase",
    "Find smallest differences in test setup/execution/assertions",
    "Make simplest changes to eliminate differences",
    "Commit after each flocking rule micro-step",
    "Verify all tests remain GREEN throughout process",
    "Store REFACTOR completion in memory: tdd/refactor-phase/[timestamp]"
  ]}
```

**REFACTOR Phase Validation** (MANDATORY):
- [ ] All tests remain green after refactoring
- [ ] Duplication eliminated using flocking rules
- [ ] Code design improved without changing behavior
- [ ] No new functionality added during refactor
- [ ] Micro-commits after each flocking rule application

### 📊 TDD Implementation Strategies (Official Claude-Flow)

#### **Strategy 1: Fake It (High Complexity)**
```javascript
// Start with constants and gradually generalize
class UserAuthentication {
  authenticate(credentials) {
    // Fake It - return constant that passes test
    if (credentials.username === 'user' && credentials.password === 'pass') {
      return { success: true, token: 'fake-token-123' };
    }
    return { success: false };
  }
}
```

#### **Strategy 2: Obvious Implementation (Low Complexity)**
```javascript
// Directly implement the real solution when obvious
class Calculator {
  add(a, b) {
    return a + b; // Obvious implementation
  }
}
```

#### **Strategy 3: Triangulation (Complex Business Rules)**
```javascript
// Use multiple examples to force generalization
describe('PriceCalculator', () => {
  it('applies 10% discount for orders over $100', () => {
    expect(calculator.calculatePrice(150)).toBe(135); // First example
  });

  it('applies 10% discount for orders over $100 (triangulation)', () => {
    expect(calculator.calculatePrice(200)).toBe(180); // Second example forces generalization
  });
});
```

### 🧠 TDD Memory Coordination (Official Claude-Flow)

```yaml
tdd_memory_namespaces:
  # Phase tracking (official claude-flow pattern)
  red_phase: "tdd/red-phase/{timestamp}"
  green_phase: "tdd/green-phase/{timestamp}"
  refactor_phase: "tdd/refactor-phase/{timestamp}"

  # Strategy tracking
  implementation_strategy: "tdd/strategy/{feature}/{strategy_type}"
  triangulation_decisions: "tdd/triangulation/{timestamp}"

  # Quality gates
  quality_validation: "tdd/quality-gates/{phase}/{timestamp}"
  coverage_metrics: "tdd/coverage/{component}/{timestamp}"

  # Integration with shameless green
  shameless_green_tracking: "shameless_green/implementations/{task_id}"
  flocking_consolidation: "shameless_green/flocking_steps/{refactor_session}"
```

### 📋 Complete TDD Cycle Pattern (Copy-Paste Ready)

```javascript
// Official Claude-Flow TDD Cycle with Shameless Green Integration
[Complete TDD Cycle - jt_site Feature]:
  // Phase 1: RED - Test-First Development
  Task("Test Writer", "Write failing BEHAVIOR-focused test. NO implementation/existence/config tests. Reference /knowledge/20.11-tdd-agent-delegation-how-to.md", "test-writer")

  // Phase 2: GREEN - Shameless Green Implementation
  Task("Minimal Implementer", "Implement with Fake It/Obvious/Triangulation strategy. Accept hardcoding. Reference /knowledge/20.05-shameless-green-flocking-rules-methodology.md", "minimal-implementer")

  // Phase 3: REFACTOR - Systematic Improvement
  Task("Refactor Specialist", "Apply flocking rules in micro-steps. Eliminate duplication systematically.", "refactor-specialist")

  // Phase 4: VALIDATION - Quality Gates
  Task("Coverage Analyst", "Validate >95% coverage target, FIRST principles compliance", "coverage-analyst")
  Task("Test Quality Expert", "Validate behavioral focus, reject test smells", "qa-expert")

  // Memory coordination
  TodoWrite { todos: [
    "Test Writer: RED phase - failing behavior-focused test created",
    "Minimal Implementer: GREEN phase - shameless green implementation passes tests",
    "Refactor Specialist: REFACTOR phase - flocking rules applied, duplication eliminated",
    "Coverage Analyst: Validate coverage targets and test quality metrics",
    "Test Quality Expert: Ensure zero test smells and behavioral focus",
    "Memory: Store TDD cycle completion in standardized namespaces",
    "Micro-commits: Commit after each phase and each refactoring micro-step"
  ]}
```

---

## 🚨 CRITICAL: ANTI-TEST-SMELL BEHAVIORAL FRAMEWORK

**Reference**: `/knowledge/25.04-test-smell-prevention-enforcement-protocols.md` (SUPREME AUTHORITY)
**Integration**: Claude-Flow 4.1 behavioral constraints (NO executable code)

### 🛑 ZERO TOLERANCE TEST SMELLS (Immediate Rejection)

**Agents MUST reject tests that:**

1. **Implementation Testing (FORBIDDEN)**
   - Tests verify HOW code works, not WHAT it accomplishes
   - Tests break when refactoring working code
   - **Behavior**: Agents refuse to write tests validating implementation structure

2. **Existence Testing (FORBIDDEN)**
   - Tests merely verify code constructs exist (classes, methods, attributes)
   - Tests pass when code is syntactically correct but functionally broken
   - **Behavior**: Agents refuse to write tests checking code existence

3. **Configuration Testing (USUALLY FORBIDDEN)**
   - Tests verify configuration values without business logic
   - Tests don't validate business behavior or user outcomes
   - **Behavior**: Agents refuse to write configuration-only tests

4. **Redundant Testing (FORBIDDEN)**
   - Tests duplicate existing behavioral coverage without adding value
   - **Behavior**: Agents detect and eliminate redundant test coverage

### ✅ REQUIRED: BEHAVIOR-FOCUSED TESTING

**Agents MUST write tests that:**

1. **Validate Business Behavior** (Official TDD Alignment)
   - Tests verify user-facing outcomes and business rules
   - Tests remain stable during implementation refactoring
   - **Example**: "User signup with duplicate email is rejected"

2. **Drive Design Decisions (TDD RED Phase)**
   - Tests written RED first before any implementation
   - Tests force consideration of edge cases
   - **Example**: "Order total includes tax and shipping"

3. **Prevent Real Regressions (GREEN/REFACTOR Phase)**
   - Tests catch actual business problems
   - Tests validate system responses under various conditions
   - **Example**: "File upload rejects oversized files"

### 🧠 NEUROLOGICAL BEHAVIORAL CONSTRAINTS

```yaml
test_creation_behavior:
  before_writing_any_test:
    ask: "Does this test validate BEHAVIOR or IMPLEMENTATION?"
    reject_if: "Test verifies code structure, method existence, or technical details"
    accept_if: "Test validates business outcomes, user workflows, or system responses"

  during_red_phase:
    ask: "Will this test drive design decisions and force implementation?"
    reject_if: "Test is checking implementation details or code existence"
    accept_if: "Test describes business behavior that doesn't exist yet"

  during_green_phase:
    ask: "Can I use Fake It strategy and this test still be valid?"
    reject_if: "Test is coupled to specific implementation approach"
    accept_if: "Test validates external behavior independent of implementation"

  during_refactor_phase:
    ask: "Can I completely rewrite implementation keeping tests green?"
    reject_if: "Test would break during legitimate refactoring"
    accept_if: "Test remains valid across different implementation approaches"
```

---

## 🧪 TEST FORMAT REQUIREMENTS (MANDATORY)

**Reference**: `docs/60.06-test-format-requirements-reference.md` (Complete test format documentation)

**CRITICAL AGENT DIRECTIVES**:

### ✅ REQUIRED: Ruby/Minitest Tests ONLY
- **Framework**: Minitest (NOT RSpec - jt_site uses Minitest)
- **System Tests**: `test/system/` with Capybara + ApplicationSystemTestCase
- **Unit Tests**: `test/unit/` with ActiveSupport::TestCase
- **Visual Regression**: `assert_stable_screenshot` with tolerance: 0.03
- **Test Runner**: `bin/rake test` or `bin/rake test:critical`

### ❌ FORBIDDEN: Bash Test Scripts (ZERO TOLERANCE)
- **NEVER** create `*.sh` files in `test/` directory
- **NEVER** create bash functions for testing (test_*, validate_*)
- **NEVER** use grep/find to check code existence as "tests"
- Bash scripts are ONLY for automation (builds, deploys), NEVER testing

### 🎯 Agent Decision Protocol (MANDATORY)

**Before creating any test, ask**: "Am I testing BEHAVIOR or code existence?"

```yaml
test_creation_decision:
  if_behavior:
    action: "✅ Create Minitest test in test/system/ or test/unit/"
    example: "Button renders, button is clickable, button looks correct"

  if_code_existence:
    action: "❌ STOP - Create behavioral test instead"
    example: "CSS class exists in file = WRONG, Button works for users = CORRECT"

  critical_rules:
    - "Test what USERS see and do, not what CODE contains"
    - "Use Minitest + Capybara, never bash scripts"
    - "Visual validation via screenshots, not grep"
    - "Run tests via bin/rake test, not shell scripts"
```

**Automatic Rejection Triggers**:
- Request to create `test_*.sh` or `*_test.sh` → REJECT, create `*_test.rb` instead
- Request to grep/find CSS files as "test" → REJECT, create Capybara test instead
- Request for bash validation script → REJECT, use Minitest behavioral test

---

## 🚨 ZERO TOLERANCE ENFORCEMENT (MANDATORY)

### 🛑 MANDATORY REFLECTION PROTOCOL

**Reference**: `/knowledge/02.08-mandatory-reflection-protocol-supreme-reference.md` (SUPREME AUTHORITY)

**TRIGGER CONDITIONS**: When users report problems including:
- "This code is bad" / "This hides the real problem" / "This is over-engineered"
- ANY handbook violations, test smells, or bad code quality
- TDD cycle violations or phase skipping

**MANDATORY AGENT RESPONSE** (Exact language required):
```yaml
violation_response: |
  "🛑 HALT: [Violation Type] detected. I cannot proceed with fixes until:
  1. Completing mandatory group reflection with expert agents
  2. Root cause analysis via 5-Why investigation
  3. Configuration self-update to prevent future violations
  4. Only then proceed with properly researched solutions

  This ensures systematic learning rather than repeating mistakes."
```

**FORBIDDEN RESPONSES**:
- "Let me fix that for you" ❌ FORBIDDEN
- "I'll implement a better solution" ❌ FORBIDDEN
- Any attempt to implement without reflection ❌ FORBIDDEN

### 👥 Four-Eyes Principle with TDD Quality

**Reference**: `/knowledge/20.02-four-eyes-principle-global.md` (Global validation protocols)

**Phase-Specific Validation**:
- **RED Phase**: Test Writer + TDD Coordinator validate test quality before GREEN
- **GREEN Phase**: Minimal Implementer + Refactor Specialist validate strategy choice
- **REFACTOR Phase**: Refactor Specialist + Coverage Analyst validate improvements
- **Test Quality**: Test Quality Expert + QA Expert validate behavioral focus

### 🛠️ MANDATORY TOOL USAGE (Zero Tolerance - NO Custom Scripts)

**CRITICAL**: Agents MUST use ONLY claude-flow out-of-box tools. NO custom bash functions, NO external commands.

```yaml
allowed_commands_only:
  - "echo '[status message]'"                       # ✅ Status messages
  - "npx claude-flow@alpha hooks pre-task"         # ✅ Pre-task coordination
  - "npx claude-flow@alpha hooks post-task"        # ✅ Post-task coordination

forbidden_everything_else:
  - "ALL npm commands"                              # ❌ Use claude-flow build tools
  - "ALL shell utilities (grep, jq, find, cat)"    # ❌ Use claude-flow utilities
  - "ALL custom bash functions"                    # ❌ Use claude-flow coordination
  - "ALL redirection operators (>, >>, |)"         # ❌ Use claude-flow file tools
```

**Agent Hook Compliance** (MANDATORY):
```yaml
# CORRECT: Idiomatic claude-flow hook pattern
hooks:
  pre: |
    echo "🔍 Pre-TDD validation: $TASK"
    npx claude-flow@alpha hooks pre-task --description "$TASK"
  post: |
    echo "✅ Post-TDD validation: $TASK"
    npx claude-flow@alpha hooks post-task --task-id "$TASK_ID"

# Agent behavioral descriptions (natural language, NOT code):
description: |
  I follow official claude-flow TDD methodology with specialized agent roles.
  I implement RED-GREEN-REFACTOR cycle with shameless green acceptance.
  I refuse to write tests validating implementation details or code existence.
  I use Fake It/Obvious/Triangulation strategies appropriate to complexity.
  I coordinate via claude-flow MCP memory tools, not custom scripts.
```

---

## 🐝 SWARM DELEGATION & XP TEAM PATTERNS

**Reference**: `/knowledge/30.01-agent-coordination-patterns.md` (Global coordination patterns)
**Reference**: `/knowledge/42.06-pair-programming-enforcement-how-to.md` (Pair programming enforcement)

### 🚨 MANDATORY XP TEAM DELEGATION with TDD Specialists

**Delegation triggers** (Zero Tolerance):
- Complex TDD cycles requiring specialized agent coordination
- Multi-file changes affecting >2 components
- Performance-critical optimizations requiring triangulation strategy
- Test quality validation requiring expert review

### 📋 Enhanced XP Team Pattern with TDD Agents (Copy-Paste Ready)

```javascript
// Full XP Team for jt_site features with official TDD integration
[XP Team Formation with TDD Specialists]:
  // XP Leadership (MANDATORY)
  Task("XP Coach", "Facilitate pair programming (25min rotation), monitor WIP=1, TDD cycle integrity. Reference /knowledge/42.06-pair-programming-enforcement-how-to.md", "coordination-expert")
  Task("TDD Coordinator", "Orchestrate RED-GREEN-REFACTOR cycle, manage phase transitions. Reference /knowledge/20.11-tdd-agent-delegation-how-to.md", "tdd-coordinator")

  // TDD Specialist Experts (Guidance, not implementation)
  Task("Test Quality Expert", "Anti-test-smell detection, behavior-focused testing validation. Reference /knowledge/25.04-test-smell-prevention-enforcement-protocols.md", "qa-expert")
  Task("Architecture Expert", "System design, integration patterns, refactoring strategy", "architecture-expert")

  // TDD Implementation Pairs (MANDATORY PAIRING)
  Task("Test-Writer-Driver", "RED phase: Write failing BEHAVIOR tests. Pair continuously. WIP=1.", "test-writer")
  Task("Test-Writer-Navigator", "Navigate test creation, validate behavior focus, ensure no test smells", "reviewer")
  Task("Implementer-Driver", "GREEN phase: Shameless green with Fake It/Obvious/Triangulation. WIP=1.", "minimal-implementer")
  Task("Implementer-Navigator", "Navigate implementation, ensure minimal approach, coordinate strategy", "refactor-specialist")
  Task("Refactor-Driver", "REFACTOR phase: Apply flocking rules systematically. WIP=1.", "refactor-specialist")
  Task("Refactor-Navigator", "Navigate refactoring, ensure tests stay green, validate improvements", "qa-expert")

  // Memory coordination with TDD phase tracking
  TodoWrite { todos: [
    "TDD Coordinator: Establish RED-GREEN-REFACTOR cycle coordination",
    "Test Quality Expert: Zero tolerance test smell detection active",
    "Test-Writer pair: RED phase - failing behavior-focused tests",
    "Implementer pair: GREEN phase - shameless green implementation",
    "Refactor pair: REFACTOR phase - flocking rules application",
    "XP Coach: Monitor TDD cycle integrity and pair effectiveness",
    "All pairs: Rotate every 25 minutes with phase handoff",
    "Memory: Store TDD phase transitions in standardized namespaces",
    "Reflection: Activate for any TDD cycle or test smell violations",
    "Coverage Analyst: Validate >95% coverage target throughout"
  ]}
```

---

## 📁 FILE ORGANIZATION & ANTI-DUPLICATION

**Reference**: `/knowledge/50.01-global-file-management.md` (Global file organization)

### 🚫 ZERO-DUPLICATION TOLERANCE

**FORBIDDEN file patterns**:
- `*_refactored.*`, `*_new.*`, `*_updated.*`, `*_v2.*`, `*_copy.*`, `*_backup.*`
- `duplicate_*.*`, `temp_*.*`, `old_*.*`, `modified_*.*`

**MANDATORY validation**:
- Pre-Write validation: Check file existence, BLOCK duplicates
- Pattern analysis: Detect similar functionality across files
- Memory coordination: Share duplication intelligence across agents

### 📂 Project Directory Structure

```yaml
jt_site_directories:
  source_code: "src/" # Hugo templates, CSS, JavaScript
  tests: "tests/" # Test files with behavior focus (TDD RED phase)
  documentation: "docs/" # jt_site-specific docs (Johnny Decimal + Diátaxis)
  configuration: "config/" # Hugo configuration files
  temporary_runtime: "_runtime/" # 24h TTL, auto-cleanup
  temporary_execution: "_tmp/" # 1h TTL, sandboxes
  experimental: "_workspace/" # Manual cleanup required
```

---

## 🎯 JT_SITE SPECIFIC ADAPTATIONS

### 🌐 Technology Stack & Coder Requirements

**Primary Technologies**: Hugo, CSS, JavaScript, Ruby, Capybara
**Project-Specific Coder**: MUST specialize in static site generation, visual testing, CSS/JS frontend

**TDD Integration**: Coder works with test-writer for RED phase, coordinates with minimal-implementer for GREEN phase

### 📋 Visual Testing Workflows with TDD

**Reference**: `/projects/jt_site/docs/visual_testing_delegation_workflows.md` (jt_site-specific)

**Visual regression testing TDD cycle**:
- **RED Phase**: Write failing visual regression tests (screenshot comparison)
- **GREEN Phase**: Implement CSS/HTML changes to pass visual tests
- **REFACTOR Phase**: Optimize CSS, consolidate styles using flocking rules

### 🚀 Build & Deployment (Hugo-Specific)

```bash
# Hugo build commands (ONLY when explicitly requested)
hugo build --minify           # Build optimized static site
hugo server --watch          # Development server with live reload
```

**CRITICAL**: Do NOT run build commands in hooks. Use claude-flow coordination instead.

---

## 🔍 AGENT DISCOVERY & CROSS-PROJECT COORDINATION

**Reference**: `/knowledge/30.01-agent-coordination-patterns.md` (Global patterns)

### 🔗 Linked Projects (Knowledge Inheritance)

```yaml
linked_projects_access:
  elital_search: "/projects/elital_search/docs/" # AI search patterns
  autonomus_ai_swarm: "/knowledge/" # Global standards (SUPREME AUTHORITY)
  snap_diff-capybara: "/projects/snap_diff-capybara/docs/" # Visual testing tools
```

**Knowledge inheritance**: jt_site inherits FULL global knowledge via symbolic links at `/projects/jt_site/knowledge/`

---

## 🔗 MANDATORY EXPERT CONSULTATION (ZERO TOLERANCE)

### 🛑 Claude-Flow Expert Consultation Protocol

**TRIGGER CONDITIONS**: ANY changes to CLAUDE.md or agent configurations

**MANDATORY RESPONSE**:
```yaml
expert_consultation_required:
  pre_change_validation: "AUTOMATIC detection, IMMEDIATE HALT"
  expert_spawning: "MANDATORY claude-flow expert consultation"
  approval_authority: "Expert has VETO power over all configuration changes"
  guidance_integration: "ALL expert guidance MUST be incorporated"
```

---

## 📊 INTEGRATION NOTES: Official TDD Format Additions

### ✅ Successfully Integrated Elements

**From Official Claude-Flow TDD Documentation:**
1. ✅ **TDD Agent Specialization Matrix**: Added official agent roles (test-writer, minimal-implementer, refactor-specialist, triangulation-guide, tdd-coordinator, coverage-analyst)
2. ✅ **Implementation Strategies**: Integrated Fake It, Obvious Implementation, Triangulation strategies with complexity-based selection
3. ✅ **Memory Coordination Patterns**: Added official tdd/{phase}/{timestamp} namespace patterns
4. ✅ **Quality Gates**: Integrated phase-specific validation checkpoints (RED/GREEN/REFACTOR)
5. ✅ **Coverage Targets**: Added >95% coverage target from official documentation
6. ✅ **FIRST Principles**: Integrated Fast, Isolated, Repeatable, Self-validating, Timely testing principles
7. ✅ **Phase Transition Protocols**: Added memory-based phase transition validation

**Compatibility Validation:**
- ✅ **Shameless Green ↔ Minimal Implementation**: COMPATIBLE - Both emphasize simplest approach
- ✅ **Behavioral Testing ↔ Behavior Focus**: ALIGNED - Both reject implementation testing
- ✅ **Flocking Rules ↔ Refactor Phase**: COMPLEMENTARY - Flocking provides systematic refactoring method
- ✅ **Anti-Test-Smell ↔ Quality Gates**: COMPLEMENTARY - Both enforce test quality standards
- ✅ **Four-Eyes ↔ Pair Programming**: ALIGNED - Both require dual validation

### 🎯 Enhanced Capabilities

**New Capabilities from Integration:**
1. **Specialized TDD Agents**: Official agent roles with clear phase responsibilities
2. **Strategy Selection**: Context-aware implementation strategy selection (Fake It/Obvious/Triangulation)
3. **Phase Coordination**: Memory-based phase transition validation and tracking
4. **Coverage Analysis**: Systematic coverage tracking with >95% targets
5. **Quality Metrics**: Comprehensive quality gate validation at each TDD phase

### 📏 Metrics Achievement

- **Size**: ~650 lines (well under 1000-line target for integrated version)
- **TDD Integration**: 100% official patterns integrated without conflicts
- **Behavioral Framework**: 100% anti-test-smell framework preserved
- **Zero-Tolerance Policies**: 100% maintained (reflection, tools, duplication)
- **Compatibility**: 100% - no conflicts between official TDD and existing frameworks

---

## 🚀 QUICK REFERENCE CARD

```yaml
# Startup sequence for all agents (MANDATORY)
agent_startup_protocol:
  step_1_global_standards:    "claude-context search '[task]' --path '/knowledge/'"
  step_2_project_adaptations: "claude-context search '[task]' --path '/projects/jt_site/docs/'"
  step_3_tdd_phase_check:     "Determine TDD phase (RED/GREEN/REFACTOR)"
  step_4_test_smell_check:    "Validate behavioral focus, reject implementation tests"
  step_5_swarm_coordination:  "Spawn XP team with TDD specialists if needed"
  step_6_reflection_readiness: "HALT and REFLECT if violations detected"

# TDD Cycle (official claude-flow pattern)
tdd_cycle:
  red_phase:    "test-writer agent → failing behavior-focused test"
  green_phase:  "minimal-implementer agent → Fake It/Obvious/Triangulation"
  refactor:     "refactor-specialist agent → flocking rules application"
  validation:   "coverage-analyst + test-quality-expert validation"

# Hook pattern (ONLY allowed commands)
hook_compliance:
  allowed: ["echo statements", "npx claude-flow@alpha hooks [pre-task|post-task]"]
  forbidden: ["ALL other commands", "custom bash", "redirection", "utilities"]

# Test creation (behavioral constraints)
test_behavior:
  ask_before_writing: "Does this validate BEHAVIOR or IMPLEMENTATION?"
  reject_if: "Implementation details, existence checks, configuration values"
  accept_if: "Business outcomes, user workflows, system responses"

# Memory coordination (official pattern)
memory_patterns:
  tdd_phases: "tdd/{red|green|refactor}-phase/{timestamp}"
  strategies: "tdd/strategy/{feature}/{fake_it|obvious|triangulation}"
  quality_gates: "tdd/quality-gates/{phase}/{timestamp}"
```

---

**Remember**: This comprehensive configuration enforces unified handbook system compliance with Hugo/JAMstack specializations. All agents MUST follow the dual-source handbook system (global standards FIRST, project adaptations SECOND) and maintain zero-tolerance policies for duplication, quality, and security violations.
- Each new learning after each incident should be tracked in CLAUDE.md
- Do not mask bugs with exciption handlers at all. Only if it requested then add exception handler!
- Use the most conservative way, through cooperatin and follwoing xp practices.
- Always spawn a whole xp team swarm to handle the task through claude-flow  and ruv-swarm
- DO NOT ADD NEW SCRIPTS FOR DEVELOPERS TO USE! All ad hoc scripts need to be deleted after task completion!
- FOR MICRO REFACTORING IT WILL BE ENOUGH TO USE `bin/rake test:critical`
- IMPORTANT: After each micro changes (< 10 lines) of the production code run `bin/rake test:critical`. After changes others code review and validate the changes with following four-eyes principle
- **🎯 Ultimate Mandate**: "Follow official claude-flow TDD methodology with specialized agent roles (test-writer, minimal-implementer, refactor-specialist). Implement RED-GREEN-REFACTOR cycle with shameless green acceptance. Use Fake It/Obvious/Triangulation strategies. Behavior-focused testing ONLY - refuse implementation/existence/configuration tests. Use claude-flow tools exclusively. HALT and REFLECT on violations. Coordinate via XP teams with TDD specialists. Memory-based phase coordination. Target >95% coverage. Zero test smells."
