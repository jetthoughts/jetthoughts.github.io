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
```
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
```
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
```
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
```
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
```
// Directly implement the real solution when obvious
class Calculator {
  add(a, b) {
    return a + b; // Obvious implementation
  }
}
```

#### **Strategy 3: Triangulation (Complex Business Rules)**
```
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

```
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

### 🛑 VISUAL REGRESSION VALIDATION GATES (MANDATORY - BLOCKING AUTHORITY)

**CRITICAL INCIDENT LEARNING**: Visual regressions (footer broken, core values changed) went undetected during refactoring. This CANNOT happen again.

**Screenshot Guardian Mandate** (ABSOLUTE BLOCKING AUTHORITY):
```yaml
screenshot_guardian:
  mandate: "BLOCK ALL commits with ANY visual changes during refactoring"
  blocking_authority: "ABSOLUTE - override all other agents including coder and reviewer"
  validation_protocol:
    pre_refactoring:
      - "MUST capture baseline screenshots BEFORE any code changes"
      - "MUST store baseline checksums for pixel-perfect comparison"
      - "MUST validate ALL critical pages (home, about, services, use-cases, contact)"

    post_refactoring:
      - "MUST capture new screenshots AFTER changes"
      - "MUST perform pixel-by-pixel comparison using assert_stable_screenshot"
      - "MUST calculate exact percentage difference per page"
      - "MUST provide detailed diff report showing ALL visual changes"
      - "MUST use tolerance: 0.0 for refactoring (ZERO tolerance for visual changes)"

    blocking_conditions:
      - "ANY difference > 0% during refactoring → BLOCK commit"
      - "Footer layout changes → IMMEDIATE BLOCK"
      - "Text content changes → IMMEDIATE BLOCK"
      - "Missing elements → IMMEDIATE BLOCK"
      - "Styling regressions → IMMEDIATE BLOCK"

    validation_evidence:
      - "MUST provide screenshot comparison images"
      - "MUST report exact pixel differences per page"
      - "MUST list ALL detected visual changes"
      - "MUST verify zero visual changes before approving commit"
```

**Refactoring Definition Enforcement** (ZERO TOLERANCE):
```yaml
refactoring_rules:
  definition: "Code restructuring maintaining EXACT functionality AND appearance"

  zero_tolerance_violations:
    visual_changes:
      - "ANY footer layout modification = NOT refactoring = FAILURE"
      - "ANY text content change = NOT refactoring = FAILURE"
      - "ANY element positioning change = NOT refactoring = FAILURE"
      - "ANY color/styling change = NOT refactoring = FAILURE"
      - "Changing test baselines = VIOLATION"

    behavioral_changes:
      - "ANY user interaction change = NOT refactoring = FAILURE"
      - "ANY navigation flow change = NOT refactoring = FAILURE"
      - "ANY page functionality change = NOT refactoring = FAILURE"

  enforcement:
    - "MANDATORY pre-commit visual validation (tolerance: 0.0)"
    - "MANDATORY screenshot comparison for ALL pages"
    - "MANDATORY test baseline preservation"
    - "MANDATORY cross-agent validation (tester + reviewer + screenshot-guardian)"
```

**Coder Refactoring Behavioral Constraints** (NEUROLOGICAL WIRING):
```yaml
coder_refactoring_mode:
  behavioral_constraint: "MUST preserve ALL page-specific CSS and layout rules"

  pre_refactoring_checklist:
    css_preservation:
      - "Did I identify ALL page-specific .fl-node-* styles?"
      - "Did I preserve ALL page-specific overrides?"
      - "Did I maintain ALL layout-critical CSS rules?"
      - "Did I validate footer CSS preservation?"

    testing_validation:
      - "Did I capture baseline screenshots? → NO = STOP, CAPTURE FIRST"
      - "Did I test footer layout? → NO = STOP, TEST FIRST"
      - "Did I test ALL page sections? → NO = STOP, TEST FIRST"
      - "Did I verify zero visual changes? → NO = STOP, VERIFY FIRST"

  during_refactoring_blocks:
    immediate_stop_triggers:
      - "Removing .fl-node-* styles → STOP, REVERT"
      - "Removing page-specific overrides → STOP, REVERT"
      - "Consolidating layout-critical CSS → STOP, REVERT"
      - "Screenshot test failures → STOP, INVESTIGATE"

  post_refactoring_validation:
    mandatory_checks:
      - "Run bin/rake test:critical → MUST PASS"
      - "Compare screenshots with tolerance: 0.0 → MUST MATCH"
      - "Visual diff review → MUST show zero changes"
      - "Screenshot guardian approval → MUST OBTAIN"
```

**Four-Eyes Visual Validation Protocol** (MANDATORY):
```yaml
four_eyes_visual_protocol:
  step_1_coder:
    actions:
      - "Coder captures baseline screenshots BEFORE changes"
      - "Coder implements refactoring preserving ALL CSS"
      - "Coder captures new screenshots AFTER changes"
      - "Coder performs self-review of visual diffs"
    blocking_conditions:
      - "ANY visual changes detected → STOP, investigate CSS preservation"

  step_2_reviewer:
    actions:
      - "Reviewer validates CSS pattern preservation"
      - "Reviewer checks for removed .fl-node-* styles"
      - "Reviewer verifies page-specific override preservation"
      - "Reviewer validates screenshot comparison methodology"
    blocking_conditions:
      - "CSS preservation violations detected → BLOCK, require coder fix"

  step_3_screenshot_guardian:
    actions:
      - "Screenshot Guardian performs independent visual validation"
      - "Screenshot Guardian runs assert_stable_screenshot with tolerance: 0.0"
      - "Screenshot Guardian provides detailed diff report"
      - "Screenshot Guardian verifies ZERO visual changes"
    blocking_conditions:
      - "ANY visual difference > 0% → ABSOLUTE BLOCK"
      - "Missing screenshot comparisons → ABSOLUTE BLOCK"
      - "Tolerance > 0.0 used → ABSOLUTE BLOCK"

  step_4_tester:
    actions:
      - "Tester runs bin/rake test:critical"
      - "Tester validates ALL tests pass"
      - "Tester verifies test baselines unchanged"
      - "Tester confirms behavioral integrity"
    blocking_conditions:
      - "ANY test failures → BLOCK, fix code not tests"
      - "Test baseline changes → BLOCK, preserve baselines"

  final_approval:
    requirements:
      - "Coder approval: CSS preservation validated ✓"
      - "Reviewer approval: Pattern compliance validated ✓"
      - "Screenshot Guardian approval: Zero visual changes validated ✓"
      - "Tester approval: Tests pass and baselines preserved ✓"
    blocking_rule: "ALL four approvals required. ANY agent BLOCKS → STOP, investigate, fix, re-validate"
```

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

## ⚡ AUTONOMOUS EXECUTION MODE (Goal-Driven Work)

**Purpose**: Enable continuous, goal-driven work without unnecessary approval stops for repetitive tasks.

### 🔄 Reflection Protocol Calibration

**Reflection triggers ADJUSTED for goal-driven work**:

**DO trigger reflection**:
- ✅ Actual handbook violations (test smells, implementation testing)
- ✅ Breaking changes or test failures
- ✅ Critical security issues

**DO NOT trigger reflection**:
- ❌ User reports frustration with agent stopping behavior
- ❌ User requests continuous execution multiple times
- ❌ Simple pattern-based work (CSS consolidation)
- ❌ Mechanical repetitive tasks with established approach

**Correct Agent Response to "Keep going, don't stop"**:
```yaml
continuous_execution_response: |
  "✅ Understood: Entering autonomous execution mode.
  - Working through goal items continuously
  - Testing after each change with bin/rake test:critical
  - Committing on green tests
  - Continuing to next item
  - Will ONLY stop on critical test failures

  Proceeding with [next item from goal]..."
```

---

## 🐝 SWARM DELEGATION & XP TEAM PATTERNS

**Reference**: `/knowledge/30.01-agent-coordination-patterns.md` (Global coordination patterns)
**Reference**: `/knowledge/42.06-pair-programming-enforcement-how-to.md` (Pair programming enforcement)

### 🚨 MANDATORY XP TEAM DELEGATION with TDD Specialists

- TDD cycles requiring specialized agent coordination
- Performance-critical optimizations requiring triangulation strategy
- New test quality validation requiring expert review (NOT established patterns)

### 📋 Enhanced XP Team Pattern with TDD Agents (Copy-Paste Ready)

```
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

## 🤖 AUTONOMOUS SWARM COORDINATION (Agent Self-Direction)

**Purpose**: Enable agents to autonomously spawn appropriate teams when complexity thresholds detected.

### 🧠 CRITICAL: Agent Swarm Spawning Knowledge

**ALL agents MUST understand this distinction**:

```yaml
tool_responsibilities:
  mcp_tools_role:
    purpose: "Coordination metadata, topology setup, memory management"
    limitation: "DO NOT spawn actual working agents"
    usage: "Optional pre-coordination, swarm initialization"
    tools: "swarm_init, agent_spawn (metadata only), task_orchestrate (planning)"

  claude_code_task_tool_role:
    purpose: "Spawn ACTUAL WORKING AGENTS that execute tasks"
    requirement: "MANDATORY for all agent spawning"
    usage: "Primary tool for team formation and parallel execution"
    pattern: "Task('Agent Name', 'Task description with handbook refs', 'agent-type')"
```

**Autonomous Spawning Rule**:
- When complexity detected → Agent MUST use Claude Code's Task tool
- MCP coordination tools are OPTIONAL (metadata only)
- Task tool invocation is MANDATORY (actual agent execution)

### 🎯 Complexity Threshold Detection (Autonomous Triggers)

**Agents should autonomously spawn swarms when they detect**:

#### **CSS Migration Work** (80% of jt_site work)
```yaml
trigger_keywords: ["CSS consolidation", "style migration", "class refactoring", "design system", "duplicate styles"]
threshold: ">3 template files affected OR >50 lines CSS changes"
autonomous_pattern: "CSS Migration Team"
team_composition:
  - "architecture-expert (CSS strategy, pattern identification)"
  - "hugo-expert (Template preservation, .fl-node-* protection)"
  - "tester (Visual regression guardian, screenshot validation)"
  - "coder (CSS refactor driver, flocking rules implementation)"
  - "reviewer (CSS refactor navigator, continuous validation)"
```

#### **Hugo Build/Deployment** (15% of jt_site work)
```yaml
trigger_keywords: ["build pipeline", "deployment", "CI/CD", "Hugo optimization", "build configuration"]
threshold: "Build configuration changes OR build time >30s"
autonomous_pattern: "Hugo Deployment Team"
team_composition:
  - "hugo-expert (Build lead, configuration management)"
  - "performance-expert (Build profiling, optimization targets)"
  - "tester (Build validation via bin/hugo-build)"
  - "cicd-engineer (CI/CD integration, deployment pipeline)"
```

#### **Visual Testing Scenarios** (5% of jt_site work, CRITICAL)
```yaml
trigger_keywords: ["screenshot", "visual regression", "layout validation", "appearance test", "visual diff"]
threshold: "ANY visual validation requirement"
autonomous_pattern: "Visual Testing Team"
team_composition:
  - "tester (Screenshot Guardian - ABSOLUTE blocking authority)"
  - "tester (Capybara Test Specialist - Minitest + assert_stable_screenshot)"
  - "reviewer (Visual Validator - screenshot comparison review)"
```

#### **Content Structure Changes**
```yaml
trigger_keywords: ["content type", "taxonomy", "front matter", "Hugo archetypes", "content model"]
threshold: ">2 content types OR new taxonomy"
autonomous_pattern: "Content Architecture Team"
team_composition:
  - "hugo-expert (Content architecture lead)"
  - "seo-specialist (SEO optimization, metadata)"
  - "coder (Implementation specialist)"
```

### 📋 Copy-Paste Ready Swarm Patterns for jt_site

#### **Pattern 1: CSS Migration Team** (MOST COMMON - Use This!)
```javascript
// Autonomous spawning when CSS consolidation work detected
[CSS Migration Team - Autonomous]:
  // Core specialists for CSS work
  Task("CSS Architecture Expert",
    "Lead CSS consolidation strategy, identify page-specific preservation patterns. Reference /knowledge/50.01-global-file-management.md for anti-duplication standards. Store findings in memory: hugo/css/architecture-decisions/[timestamp]",
    "architecture-expert")

  Task("Hugo Template Specialist",
    "Preserve .fl-node-* styles, maintain layout-critical CSS. Reference docs/visual_testing_delegation_workflows.md for visual testing protocols. Coordinate via memory: hugo/css/template-preservation/[timestamp]",
    "hugo-expert")

  Task("Visual Regression Guardian",
    "Capture baseline screenshots (tolerance: 0.0), validate ZERO visual changes post-refactoring. Use assert_stable_screenshot from Minitest. BLOCKING authority on visual changes. Store results: visual-testing/screenshots/[timestamp]",
    "tester")

  // Implementation pair (XP pattern)
  Task("CSS Refactor Driver",
    "Implement CSS consolidation using flocking rules from /knowledge/20.05-shameless-green-flocking-rules-methodology.md. Micro-commits after each change. Test after EACH change via bin/rake test:critical. Coordinate with navigator via memory: xp/css-refactor/driver/[timestamp]",
    "coder")

  Task("CSS Refactor Navigator",
    "Navigate refactoring, ensure preservation of page-specific overrides, continuous validation. Monitor driver work, provide real-time feedback. Reference /knowledge/40-49_Knowledge/42.06-pair-programming-enforcement-how-to.md. Coordinate via memory: xp/css-refactor/navigator/[timestamp]",
    "reviewer")

  TodoWrite { todos: [
    {content: "CSS Expert: Analyze CSS duplication patterns, define consolidation strategy", status: "in_progress", activeForm: "Analyzing CSS patterns"},
    {content: "Hugo Specialist: Identify page-specific CSS that MUST be preserved (.fl-node-*, layout rules)", status: "in_progress", activeForm: "Identifying preservation needs"},
    {content: "Visual Guardian: Capture baseline screenshots BEFORE any changes (tolerance: 0.0)", status: "pending", activeForm: "Capturing baselines"},
    {content: "Refactor Pair: Apply flocking rules systematically, test after EACH micro-change", status: "pending", activeForm: "Refactoring CSS"},
    {content: "Visual Guardian: Validate 0% visual difference post-refactoring (BLOCKING authority)", status: "pending", activeForm: "Validating visual integrity"},
    {content: "ALL: Commit on green tests, continue to next consolidation candidate", status: "pending", activeForm: "Committing changes"},
    {content: "Memory: Store CSS consolidation patterns in hugo/css/consolidation/[timestamp]", status: "pending", activeForm: "Storing patterns"}
  ]}
```

#### **Pattern 2: Hugo Build/Deployment Team**
```javascript
// Autonomous spawning when Hugo build/deployment work detected
[Hugo Build Team - Autonomous]:
  Task("Hugo Build Expert",
    "Lead Hugo build optimization, configuration management. Use bin/hugo-build for validation. Reference docs/build-optimization-standards.md. Store decisions: hugo/build/optimization/[timestamp]",
    "hugo-expert")

  Task("Performance Analyst",
    "Profile build performance, identify bottlenecks, set optimization targets (<30s full build). Reference /knowledge/ performance standards. Store metrics: hugo/build/performance/[timestamp]",
    "performance-expert")

  Task("Build Validator",
    "Validate build integrity using bin/hugo-build, ensure zero broken links. Run full test suite. Store validation results: hugo/build/validation/[timestamp]",
    "tester")

  Task("DevOps Coordinator",
    "CI/CD integration, deployment pipeline, environment configuration. Coordinate with Netlify/deployment platform. Store pipeline config: hugo/build/cicd/[timestamp]",
    "cicd-engineer")

  TodoWrite { todos: [
    {content: "Hugo Expert: Analyze build configuration, identify optimization opportunities", status: "in_progress", activeForm: "Analyzing build config"},
    {content: "Performance Analyst: Profile current build time, set improvement targets", status: "in_progress", activeForm: "Profiling performance"},
    {content: "Build Validator: Establish baseline build metrics via bin/hugo-build", status: "pending", activeForm: "Establishing baselines"},
    {content: "DevOps: Coordinate CI/CD integration and deployment strategy", status: "pending", activeForm: "Coordinating deployment"},
    {content: "ALL: Validate improvements maintain build integrity and reduce build time", status: "pending", activeForm: "Validating improvements"}
  ]}
```

#### **Pattern 3: Visual Testing Team**
```javascript
// Autonomous spawning when visual validation required
[Visual Testing Team - Autonomous]:
  Task("Screenshot Guardian",
    "Lead visual regression testing, ABSOLUTE blocking authority on visual changes. Reference docs/60.06-test-format-requirements-reference.md. Use assert_stable_screenshot. Tolerance: 0.0 for refactoring. Store results: visual-testing/guardian/[timestamp]",
    "tester")

  Task("Capybara Test Specialist",
    "Create Minitest + Capybara behavioral tests (NO bash scripts). Use assert_stable_screenshot from test/test_helper.rb. Follow docs/visual_testing_delegation_workflows.md. Store tests: visual-testing/implementation/[timestamp]",
    "tester")

  Task("Visual Validator",
    "Review screenshot comparisons, validate tolerance: 0.0 for refactoring, approve only on 0% difference. Provide pixel-level analysis if differences detected. Store validation: visual-testing/validation/[timestamp]",
    "reviewer")

  TodoWrite { todos: [
    {content: "Screenshot Guardian: Capture baseline screenshots for ALL critical pages", status: "in_progress", activeForm: "Capturing baselines"},
    {content: "Test Specialist: Create Minitest visual regression tests using assert_stable_screenshot", status: "in_progress", activeForm: "Creating tests"},
    {content: "Visual Validator: Compare screenshots, report exact pixel differences", status: "pending", activeForm: "Validating screenshots"},
    {content: "Screenshot Guardian: BLOCK any commits with visual changes >0% during refactoring", status: "pending", activeForm: "Blocking changes"},
    {content: "Memory: Store visual validation results in visual-testing/screenshots/[timestamp]", status: "pending", activeForm: "Storing results"}
  ]}
```

### 🔍 How Agents Detect Complexity Autonomously

**Agent Behavioral Pattern**:
1. **Read task description** and analyze for trigger keywords
2. **Measure complexity**: file count, line count, domain breadth
3. **Compare against thresholds**: Does this exceed solo capability?
4. **Autonomous decision**: If YES → spawn appropriate team using Task tool
5. **Coordinate via memory**: Store team formation decision and rationale

**Example Agent Self-Talk**:
> "I see keywords 'CSS consolidation' and task affects >3 template files. This exceeds my solo threshold of 50 lines. I autonomously spawn CSS Migration Team using Claude Code's Task tool. Storing decision in memory: hugo/css/team-formation/[timestamp] for cross-agent intelligence."

### 🧠 Agent Behavioral Embedding (Natural Language)

**How agents should describe autonomous swarm spawning capability in their configurations**:

```yaml
autonomous_swarm_behavioral_description: |
  I autonomously detect when work complexity exceeds my solo capabilities by analyzing
  trigger keywords and measuring complexity thresholds (file count, line count, domain scope).

  When I detect complexity triggers, I AUTONOMOUSLY spawn appropriate specialist teams
  using Claude Code's Task tool. I understand MCP tools create metadata only; Task tool
  spawns actual working agents that execute tasks.

  I maintain knowledge of common jt_site swarm patterns:
  - CSS Migration Team for style consolidation (>3 templates OR >50 lines CSS)
  - Hugo Build Team for deployment work (build config changes OR >30s build time)
  - Visual Testing Team for screenshot validation (ANY visual validation requirement)
  - Content Architecture Team for structural changes (>2 content types OR new taxonomy)

  I coordinate team formation through memory namespaces (hugo/css/*, hugo/build/*,
  visual-testing/*), ensuring all specialists have access to research findings and
  architectural decisions. I provide clear task descriptions with handbook references
  for each spawned agent.

  I am empowered to spawn teams without waiting for user approval when complexity
  thresholds clearly exceeded. I document spawning decisions in memory for transparency
  and cross-agent learning.
```

### 📊 Success Metrics for Autonomous Coordination

**Agent Autonomy Indicators**:
- ✅ Agent spawns team autonomously (without user prompt)
- ✅ Correct team pattern selected for work type
- ✅ All spawned agents receive clear task descriptions with handbook refs
- ✅ Memory coordination established before work begins
- ✅ Team formation decision documented in memory namespace

**Quality Indicators**:
- ✅ Spawned teams complete work successfully
- ✅ Zero visual regressions (for CSS/visual work)
- ✅ All tests pass (for refactoring/build work)
- ✅ Knowledge captured in memory for future pattern improvement

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
  step_3_complexity_check:    "Determine: Team structures, agent roles, implementation strategies"
  step_4_tdd_phase_check:     "Determine TDD phase (RED/GREEN/REFACTOR) if applicable"
  step_5_test_smell_check:    "Validate behavioral focus, reject implementation tests"
  step_6_swarm_coordination:  "Spawn XP team ONLY for complex >3 component changes"
  step_7_reflection_readiness: "HALT and REFLECT ONLY for actual violations (not user frustration)"
  step_8_visual_validation:   "FOR REFACTORING: Capture baseline screenshots, validate tolerance: 0.0"

# Autonomous execution mode (for repetitive goals)
autonomous_mode:
  trigger: "User requests continuous work, repetitive pattern"
  approach: "Solo execution, test after each change, commit on green, continue"
  retry_only_on: "Critical test failures"
  no_approval_gates: "Work continuously to goal completion"

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

# Refactoring visual validation (MANDATORY)
refactoring_validation:
  definition: "Code restructuring maintaining EXACT functionality AND appearance"
  pre_refactoring: "Capture baseline screenshots with tolerance: 0.0"
  during_refactoring: "Preserve ALL page-specific CSS (.fl-node-*, layout rules)"
  post_refactoring: "Compare screenshots - MUST show 0% difference"
  blocking_rule: "ANY visual change > 0% → STOP, revert, investigate"
  four_eyes_approval: "Coder → Reviewer → Screenshot Guardian → Tester (ALL required)"
```

---

**Remember**: This comprehensive configuration enforces unified handbook system compliance with Hugo/JAMstack specializations. All agents MUST follow the dual-source handbook system (global standards FIRST, project adaptations SECOND) and maintain zero-tolerance policies for duplication, quality, and security violations.

### 📝 Operational Principles

- Each new learning after each incident should be tracked in CLAUDE.md
- Do not mask bugs with exception handlers at all. Only if it requested then add exception handler!
- Use the most conservative way, through cooperation and following xp practices.
- **Graduated spawning**: Solo for simple repetitive work, Pair for moderate complexity, Team for complex architecture
- DO NOT ADD NEW SCRIPTS FOR DEVELOPERS TO USE! All ad hoc scripts need to be deleted after task completion!
- FOR MICRO REFACTORING IT WILL BE ENOUGH TO USE `bin/rake test:critical`
- IMPORTANT: After each micro changes (< 10 lines) of the production code run `bin/rake test:critical`. After changes others code review and validate the changes with following four-eyes principle

### 🚨 CRITICAL CSS CONSOLIDATION LEARNINGS (INCIDENT: 404 & Blog Pages)

**Date**: 2025-10-13
**Incident**: CSS consolidation of 404.css caused 9.5% desktop / 15.4% mobile visual regression
**Root Cause**: 404 page and blog pages do NOT load critical CSS infrastructure (base-critical.html)
**Impact**: Removing duplicate FL-Builder CSS broke page layouts

**MANDATORY BLOCK LIST** (ZERO TOLERANCE):
```yaml
css_consolidation_blockers:
  pages_without_critical_css:
    - "404.css" # No themes/beaver/layouts/partials/header/critical/404.html
    - "3114-layout.css" # Blog pages - no blog-critical.html infrastructure

  blocking_rule: "NEVER consolidate CSS from these files until critical CSS infrastructure created"

  validation_protocol:
    pre_consolidation: "Verify page loads themes/beaver/layouts/partials/header/critical/base-critical.html"
    post_consolidation: "Run bin/rake test:critical with tolerance: 0.03"
    visual_validation: "Compare screenshots - MUST show 0% difference for refactoring"

  rollback_triggers:
    - "Visual regression > 3% (tolerance threshold)"
    - "Test failures on affected pages"
    - "Layout breakage in manual inspection"
```

**SAFE CONSOLIDATION CRITERIA**:
1. ✅ Page loads base-critical.html (most pages)
2. ✅ Page-specific CSS (.fl-node-*) preserved
3. ✅ Visual regression tests pass with tolerance: 0.03
4. ✅ bin/rake test:critical shows 0 failures

**RESOLUTION OPTIONS**:
- Option A: Create 404-critical.html and blog-critical.html infrastructure
- Option B: Keep duplicates in 404.css and 3114-layout.css (current approach)
- Option C: Inline critical CSS directly in 404 and blog templates

### 🎯 Ultimate Mandates

**Core TDD Mandate**: "Follow official claude-flow TDD methodology with specialized agent roles (test-writer, minimal-implementer, refactor-specialist). Implement RED-GREEN-REFACTOR cycle with shameless green acceptance. Use Fake It/Obvious/Triangulation strategies. Behavior-focused testing ONLY - refuse implementation/existence/configuration tests. Use claude-flow tools exclusively. HALT and REFLECT on ACTUAL violations (not user frustration). Coordinate via XP teams ONLY for complex work. Memory-based phase coordination. Target >95% coverage. Zero test smells."

**Visual Regression Validation Mandate**: "For ALL refactoring work: Capture baseline screenshots BEFORE changes with tolerance: 0.0. Preserve ALL page-specific CSS (.fl-node-* styles, layout rules). Compare screenshots AFTER changes - MUST show 0% difference. ANY visual change > 0% = IMMEDIATE BLOCK, revert, investigate. Four-eyes approval REQUIRED: Coder → Reviewer → Screenshot Guardian → Tester. Screenshot Guardian has ABSOLUTE blocking authority. Refactoring definition: Code restructuring maintaining EXACT functionality AND appearance. Breaking this mandate is FAILURE."

**Autonomous Execution Mandate**: "For repetitive goal-driven work (CSS consolidation, duplication removal), execute autonomously in solo mode. Test after each change with bin/rake test:critical. Commit on green. Continue to next item. NO approval gates. NO swarm spawning for simple patterns. ONLY stop on critical test failures. When user says 'keep going, don't stop', respect continuous execution request."
