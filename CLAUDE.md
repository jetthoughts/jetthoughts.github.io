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

```
# Step 1: Global standards FIRST (inherited by jt_site)
Search the codebase at "/knowledge/" for: "[topic]"

# Step 2: jt_site adaptations SECOND
Search the codebase at "/projects/jt_site/docs/" for: "[topic]"

# Step 3: Framework validation
Get library docs for "[framework]" — topic: "[feature]"

# Step 4: Package analysis
Search npm packages for: "[package]" on registry "[registry]"
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

  tolerance_policy:
    refactoring: "tolerance: 0.0 (ZERO tolerance - maintaining exact functionality AND appearance)"
    new_features: "tolerance: ≤0.03 (up to 3% acceptable for NEW visual features only)"
    clarification: "Default bin/test uses 0.03, but refactoring MUST override to 0.0"

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
      - "MUST use tolerance: ≤0.03 only for NEW visual features (not refactoring)"

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
  - "git rev-parse --is-inside-work-tree"           # ✅ Read-only VCS status
  - "git diff --name-only"                          # ✅ Read-only diffs
  - "rg -nP | grep -nP"                             # ✅ Read-only search (pattern matching)
  - "fd -t f"                                       # ✅ Read-only file discovery
  - "shasum -a 256 | sha256sum"                     # ✅ Checksum generation (validation)

forbidden_everything_else:
  - "ALL npm commands"                              # ❌ Use claude-flow build tools
  - "ALL write operations (>, >>, tee)"            # ❌ Use claude-flow file tools
  - "ALL custom bash functions"                    # ❌ Use claude-flow coordination
  - "ALL modification commands (rm, mv, cp)"       # ❌ Use claude-flow file tools
```

---

## 🌐 CHROME DEVTOOLS RENDERING VALIDATION

**Purpose**: Use Chrome DevTools Protocol (CDP) to validate that pages render correctly — not just visually, but structurally and performance-wise.

### When to Apply Chrome DevTools Validation

Chrome DevTools validation is **MANDATORY** after:
- ANY HTML/template changes (layout, structure, content)
- ANY CSS changes (styling, responsiveness)
- ANY JavaScript changes (interactivity, dynamic content)
- ANY Hugo build output changes
- New blog post publishing (verify rendering)

### Chrome DevTools Validation Protocol

```yaml
chrome_devtools_validation:
  # Step 1: Start Hugo dev server
  preconditions:
    - "Start Hugo dev server (run: bin/hugo server -D)"

  # Step 2: Navigate and validate
  validation_steps:
    page_load:
      - "Navigate to target page URL"
      - "Wait for network idle (no pending requests)"
      - "Verify HTTP 200 status"

    rendering:
      - "Capture full-page screenshot"
      - "Compare with baseline (pixel diff if refactoring)"
      - "Verify no layout shift (CLS < 0.1)"

    console_errors:
      - "Check DevTools Console"
      - "Check for JavaScript errors (ZERO tolerance)"
      - "Check for 404 network requests (broken assets)"
      - "Check for CORS errors"

    performance:
      - "Record performance metrics"
      - "LCP (Largest Contentful Paint): < 2.5s"
      - "FID (First Input Delay): < 100ms"
      - "CLS (Cumulative Layout Shift): < 0.1"

    accessibility:
      - "Run Lighthouse accessibility audit"
      - "Score ≥ 90 required"
      - "Check ARIA attributes, contrast, focus order"

    mobile_responsive:
      - "Switch to mobile viewport (375x812)"
      - "Capture mobile screenshot"
      - "Verify no horizontal scroll"
      - "Verify touch targets ≥ 44x44px"

  # Step 3: Validation gates
  quality_gates:
    zero_js_errors: "Console must show zero errors"
    zero_broken_assets: "No 404s for CSS/JS/images"
    visual_stability: "Screenshot diff ≤ 0% for refactoring, ≤3% for new features"
    performance_pass: "Core Web Vitals all in 'good' range"
    accessibility_pass: "Lighthouse a11y score ≥ 90"
```

### Chrome DevTools Workflow Integration

```
┌─────────────────────────────────────────────┐
│ After ANY code change                       │
├─────────────────────────────────────────────┤
│ 1. Run: bin/hugo-build (structural check)   │
│ 2. Run: bin/rake test:critical (tests)      │
│ 3. Start Hugo dev server, open page in DevTools │
│ 4. Check DevTools Console (zero errors)     │
│ 5. Check Network tab (zero 404s)            │
│ 6. Capture desktop + mobile screenshots     │
│ 7. Verify Core Web Vitals in "good" range   │
│ 8. All gates pass → commit                  │
│    Any gate fails → investigate, fix, repeat│
└─────────────────────────────────────────────┘
```

### Chrome DevTools for Blog Posts

After publishing a new blog post:
1. Start Hugo dev server, open the post URL in Chrome DevTools
2. Verify markdown renders correctly (headings, code blocks, lists)
3. Check code block syntax highlighting renders properly
4. Verify images load (no broken image icons)
5. Check table rendering (if present)
6. Verify external links render as clickable
7. Switch to mobile viewport — verify readability on small screens

### Integration with Existing Visual Tests

Chrome DevTools **complements** existing Minitest/Capybara screenshot tests:
- **Minitest**: Behavioral validation, page structure
- **Chrome DevTools**: Rendering quality, performance metrics, console errors
- **Both required**: Neither alone is sufficient for full validation

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

### 🎯 Pre-Approval Detection & Continuous Execution

**Agents MUST detect user pre-approval signals and activate Continuous Execution Mode**:

**Explicit Pre-Approval Signals** (HIGH CONFIDENCE):
- "Do everything needed"
- "Complete all items"
- "Keep going, don't stop"
- "Work through the entire list"
- "Continue until done"
- "Make all necessary changes"

**Implicit Pre-Approval Signals** (MEDIUM CONFIDENCE):
- User provides numbered task list (implies: do all items)
- User says "same approach for remaining items" (implies: continue pattern)
- User expresses frustration with stopping (implies: want continuous work)
- User references "goal completion" (implies: work until goal achieved)

**Correct Agent Response to Pre-Approval**:
```yaml
continuous_execution_response: |
  "✅ Entering Continuous Execution Mode:
  - Working through [N] items with test-commit-continue pattern
  - Testing after each change with bin/rake test:critical
  - Committing on green tests with descriptive messages
  - Only stopping for critical test failures

  Proceeding with first item: [specific description]..."
```

### 🔄 Micro-Commit Enforcement (XP/Agile Compliance)

**Agents are neurologically wired to commit after EVERY successful micro-change**:

**Micro-Commit Triggers** (AUTOMATIC, NO OVERRIDE):
1. Test suite passes after code change → MUST commit before next change
2. Visual regression tests pass → MUST commit screenshot baseline
3. Single refactoring micro-step completes → MUST commit
4. Single CSS consolidation completes → MUST commit
5. Time since last commit > 10 minutes → MUST commit work in progress

**Commit Message Format** (MANDATORY):
- Pattern: `[Action] [What] [Where]`
- Examples:
  - "Extract .fl-row padding rules to fl-foundation.css"
  - "Remove duplicated box-sizing reset from about-critical.css"
  - "Consolidate button hover states into style.css"
- Focus: WHAT changed (not WHY - that's in task description)
- Length: 50-72 characters (one line)

**Commit Workflow** (NEUROLOGICAL ENFORCEMENT):
```yaml
1. Code change made (< 10 lines)
2. Run bin/rake test:critical
3. Tests pass → IMMEDIATE commit trigger fires
4. Write descriptive commit message
5. Execute: git add [files] && git commit -m "[message]"
6. Verify commit succeeded
7. Continue to next micro-step (NO APPROVAL GATE)
```

**Violations to Prevent**:
- ❌ Proceeding to next change without committing current change
- ❌ Bundling multiple micro-changes into single commit
- ❌ Skipping commit step because changes seem "related"
- ❌ Committing with failing tests

### 🔁 Iterative Workflow Enforcement

**Agents enforce micro-step iterative workflow for ALL repetitive tasks**:

**Workflow Pattern** (MANDATORY SEQUENCE):
```yaml
Step 1: IDENTIFY next smallest change candidate
  - Example: "Next: Extract .fl-row padding from about-layout.css"
  - Scope: Single CSS rule set, single function, single class
  - Complexity: Change can be validated in < 30 seconds

Step 2: MAKE micro-change
  - Edit files (use Edit tool, NOT bulk write)
  - Change < 10 lines production code
  - Preserve all functionality and appearance

Step 3: TEST immediately
  - Run: bin/rake test:critical
  - Validate: All tests pass, no visual regressions
  - On failure: Investigate immediately, fix or revert

Step 4: COMMIT on green
  - Write descriptive commit message
  - Commit ONLY this micro-change
  - Verify commit succeeded

Step 5: CONTINUE to next item
  - NO approval gate
  - NO stopping for effort assessment
  - NO asking "should I continue?"
  - Proceed directly to Step 1 with next candidate
```

**Stopping Conditions** (ONLY):
- Critical test failure requiring investigation
- Visual regression requiring user decision
- Goal completion (all items processed)
- Error pattern detected requiring reflection

### 🛑 Stopping Decision Matrix

**MUST STOP** (Critical Failures Only):
- Critical test failure requiring investigation (not simple fixes)
- Visual regression requiring user decision (tolerance violations)
- Security vulnerability detected
- Build break that can't be quickly resolved
- Goal completion (all items successfully processed)

**MUST CONTINUE** (NO STOP - When Pre-Approved):
- Effort assessment (user pre-approved unlimited scope)
- Scope questions (user-defined scope already)
- Permission requests (user granted blanket permission)
- Simple test failures with obvious fix
- Repetitive pattern work with established approach

**Decision Override Rule**:
```yaml
IF user_pre_approval_detected:
  IGNORE all non-critical stopping triggers
  CONTINUE until goal_completion OR critical_failure
  COMMIT after EVERY green test
  PROVIDE periodic progress updates (every 3-5 commits)
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

**FORBIDDEN documentation creation** (CRITICAL INCIDENT LEARNING):
- ❌ NEVER create new `.md` files proactively
- ❌ NEVER create `README.md`, `GUIDE.md`, or any documentation files
- ❌ NEVER create directories for "behavioral configurations" or similar
- ✅ ALWAYS consolidate into existing CLAUDE.md or docs/ files
- ✅ ALWAYS prefer editing existing documentation over creating new files

**Agent Pre-File-Creation Validation** (MANDATORY):
```yaml
before_creating_any_file:
  ask: "Does a similar file already exist?"
  ask: "Can this content be added to existing CLAUDE.md or docs/?"
  ask: "Am I creating documentation (.md) proactively?"

  if_documentation_file:
    action: "❌ STOP - Consolidate into existing files instead"
    reason: "Zero-duplication policy - NEVER create redundant documentation"

  if_duplicate_likely:
    action: "❌ STOP - Search for existing file, edit instead"
    reason: "File duplication violates zero-tolerance policy"
```

**MANDATORY validation**:
- Pre-Write validation: Check file existence, BLOCK duplicates
- Pre-Documentation validation: BLOCK all new .md file creation (edit existing instead)
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

### 🚨 CSS CONSOLIDATION BLOCK LIST (CSS Migration Project)

**Reference**: `docs/projects/2509-css-migration/css-loading-order-analysis.md` (Comprehensive CSS cascade analysis)
**Project**: CSS Duplication Elimination (2509-css-migration)

#### ABSOLUTE BLOCKS - NEVER CONSOLIDATE (Zero Tolerance)

**Vendor Dependencies** (External Libraries):
- ❌ `css/vendors/base-4.min.css` - Foundation framework providing grid system (.fl-row, .fl-col, .fl-col-group)
  - **Used by**: 5+ pages (use-cases, blog list/single, contact-us, services)
  - **Must load**: BEFORE page-specific layout CSS (cascade dependency)
  - **Impact if removed**: Complete layout breakage across multiple pages
  - **Future consideration**: Foundation → CSS Grid migration (separate initiative)

- ❌ `css/vendors/swiper.min.css` - Swiper carousel library
  - **Status**: May be unused, requires audit before removal

**FL-Builder Layout Files** (Can Consolidate - Extract Common Patterns):
- ✅ `css/*-layout.css` - FL-builder layout files contain MASSIVE duplication
  - **Contains**: Page-specific `.fl-node-{12-char-hash}` selectors PLUS shared patterns
  - **Strategy**: Extract common rule sets (.fl-row, .fl-col, .fl-module patterns) to foundation
  - **Preserve**: Page-specific `.fl-node-{hash}` selectors (keep in original files)
  - **Consolidate**: Shared .fl-row, .fl-col, .fl-module, .fl-visible patterns (~70-80% duplication)
  - **Impact**: 1,900-2,900 lines can be extracted to fl-foundation.css

- ✅ `css/bf72bba397177a0376baed325bffdc75-layout-bundle.css` - Shared FL-builder layout bundle
  - **Used by**: Multiple pages (about, use-cases, blog, services)
  - **Strategy**: Consolidate shared patterns across pages

**Template-Generated CSS** (Hugo Dynamic Execution):
- ❌ `css/dynamic-icons.css` - Icon styles using Hugo template variables
- ❌ `css/dynamic-404-590.css` - Dynamic FL-builder styles
- ❌ `css/use-cases-dynamic.css` - Use cases section with dynamic content
  - **Requires**: Hugo template execution (`resources.ExecuteAsTemplate`)
  - **Cannot extract**: To static components without losing dynamic functionality

**Critical CSS** (Can Consolidate - Extract Common Patterns):
- ✅ `css/critical/base.css` - Global critical CSS (consolidate common resets, typography)
- ✅ `css/critical/*-critical.css` - Page-specific critical CSS files
  - **Contains**: MASSIVE duplication across 12+ critical CSS files
  - **Strategy**: Extract common patterns (resets, typography, utilities) to shared critical base
  - **Preserve**: Page-specific above-the-fold styles (keep in original files)
  - **Consolidate**: Shared resets, font-family, box-sizing, utilities (~300-400 lines)
  - **Load order**: Consolidated critical MUST still load FIRST
  - **Impact**: Faster initial render with smaller critical CSS footprint

#### CSS Cascade Layers (MUST Preserve Order)

**5-Layer Cascade Architecture**:
1. **Base Layer** (FIRST): Critical CSS (resets, typography, normalize)
2. **Layout Layer** (SECOND): Foundation grid + FL-builder layouts
3. **Component Layer** (THIRD): Icons, modules, component bundles
4. **Theme Layer** (FOURTH): style.css, skin.css (theme overrides)
5. **Footer Layer** (LAST): footer.css (loads last in DOM)

**Validation Protocol for CSS Changes**:
- ✅ Verify CSS load order preserved during extraction
- ✅ NO modifications to Foundation framework files
- ✅ NO modifications to FL-builder layout files
- ✅ NO modifications to template-generated CSS
- ✅ Visual regression tolerance: **0.0 for refactoring** (MANDATORY - zero visual changes), ≤0.003 only for NEW visual features (bin/test default for non-refactor changes)
- ✅ Test after EACH change: `bin/rake test:critical`

#### HIGH RISK - Consolidate with Extreme Caution

**Complex Dependencies**:
- ⚠️ `css/style.css` - General styles with complex cross-page dependencies
- ⚠️ `css/skin-65eda28877e04.css` - Theme skin affecting ALL pages (global overrides)

#### CONSOLIDATION STRATEGY - Extract Whole Rule Sets

**Phase 1: FL-Builder Foundation Extraction** (BIGGEST IMPACT - ~1,900-2,900 lines):
1. ✅ Extract `.fl-row` patterns from ALL 32 layout files → `fl-foundation.css`
2. ✅ Extract `.fl-col` grid patterns → `fl-foundation.css`
3. ✅ Extract `.fl-module` wrapper patterns → `fl-foundation.css`
4. ✅ Extract `.fl-visible-*` responsive patterns → `fl-foundation.css`
5. ✅ Preserve page-specific `.fl-node-{hash}` selectors in original files

**Phase 2: Critical CSS Consolidation** (MEDIUM IMPACT - ~300-400 lines):
1. ✅ Extract common resets (box-sizing, margin:0, padding:0) → `critical/shared-base.css`
2. ✅ Extract typography foundation (font-family, line-height) → `critical/shared-base.css`
3. ✅ Extract screen reader utilities (.sr-only) → `critical/shared-base.css`
4. ✅ Preserve page-specific above-the-fold styles in original critical files

**Phase 3: Component Extraction** (SMALLER IMPACT - ~1,200-1,700 lines):
- ✅ `css/companies.css`, `css/technologies.css`, `css/pagination.css`
- ✅ Shared utilities from `style.css` (buttons, forms, typography)

**Consolidation Approach**: Extract WHOLE rule sets, not individual properties
- ✅ Move entire `.fl-row { ... }` block to foundation
- ✅ Move entire `.fl-col { ... }` block to foundation
- ✅ Keep page-specific selectors in original files
- ✅ Test after EACH extraction with `bin/rake test:critical`
- ✅ Visual regression tolerance: 0.003

---

## 📝 CONTENT GENERATION SWARM (7-Phase Blog Production)

**Global Reference**: `/knowledge/00-09_Global_Handbooks/07_Cross_Project_Operations/07.01-content-generation-best-practices.md` (SUPREME AUTHORITY)
**Integration**: Hugo static site + jt_site technical audience + TDD visual testing
**Coordination**: Blog-coordinator orchestrates 7 specialized agents through memory coordination

### 🎯 Content Generation Agent Ecosystem

jt_site uses a **hierarchical supervisor-worker pattern** for blog production with **7 specialized agents** coordinated through memory-based handoffs:

```yaml
content_generation_hierarchy:
  supervisor_coordinator:
    agent: "blog-coordinator"
    type: "coordination-expert"
    authority: "Orchestrates full 7-phase workflow with quality gate enforcement"
    memory_coordination: "blog/production/workflow/[trace_id]"

  phase_1_strategy:
    agent: "content-strategist"
    type: "analyst"
    focus: "Technical audience analysis, topic ideation, shareability prediction"
    quality_gates: ["shareability ≥7/10", "3-5 takeaways", "Hugo outline"]
    handoff_to: "research-agent via blog/strategy/"

  phase_2_research:
    agent: "research-agent"
    type: "researcher"
    focus: "Technical research, citation gathering, case studies"
    quality_gates: ["≥8 citations", "≥1 case study", "all stats sourced"]
    handoff_to: "blog-writer via blog/research/"

  phase_3_content_creation:
    agent: "blog-writer"
    type: "coder"
    focus: "Hugo markdown creation with TDD visual testing"
    quality_gates: ["Hugo build passes", "visual tests pass", "no AI phrases"]
    handoff_to: "seo-optimizer via blog/writing/"
    tdd_integration: "RED (visual test) → GREEN (content) → REFACTOR (polish)"

  phase_4_seo:
    agent: "seo-optimizer"
    type: "qa-expert"
    focus: "Metadata optimization, keyword integration, readability"
    quality_gates: ["Flesch ≥60", "Hugo frontmatter complete", "no readability compromise"]
    handoff_to: "content-editor via blog/seo/"

  phase_5_editorial:
    agent: "content-editor"
    type: "reviewer"
    focus: "Voice consistency, citation validation, engagement assessment"
    quality_gates: ["engagement ≥8/10", "shareability ≥7/10", "all claims cited"]
    handoff_to: "ideal-reader-representative via blog/editorial/"

  phase_6_reader_validation:
    agent: "ideal-reader-representative"
    type: "qa-expert"
    focus: "Target audience simulation, authentic reader feedback"
    quality_gates: ["reader score ≥8/10", "would share: Yes/Likely", "actionable value"]
    handoff_to: "blog-coordinator for publication"

  phase_7_publication:
    agent: "blog-coordinator"
    responsibility: "Final Hugo build validation, publication package compilation"
    success_criteria: "All 7 phases complete + all quality gates passed"
```

### 🔄 7-Phase Content Workflow with Memory Coordination

**Phase Sequence** (Coordinated by blog-coordinator):

1. **Strategy & Planning** → content-strategist analyzes audience, predicts shareability
2. **Research & Evidence** → research-agent gathers citations, case studies, expert quotes
3. **Content Creation** → blog-writer creates Hugo markdown with TDD visual testing
4. **SEO Optimization** → seo-optimizer enhances discoverability while maintaining credibility
5. **Editorial Review** → content-editor validates voice, engagement, citations
6. **Reader Validation** → ideal-reader-representative simulates target audience reaction
7. **Hugo Publication** → blog-coordinator compiles publication-ready package

**Memory Handoff Pattern**:
```yaml
phase_handoffs:
  strategy_to_research: "blog/strategy/outlines/[topic_id] → blog/research/citations/[topic_id]"
  research_to_writer: "blog/research/citations/[topic_id] → blog/writing/drafts/[post_id]"
  writer_to_seo: "blog/writing/drafts/[post_id] → blog/seo/optimization/[post_id]"
  seo_to_editorial: "blog/seo/optimization/[post_id] → blog/editorial/reviews/[post_id]"
  editorial_to_reader: "blog/editorial/reviews/[post_id] → blog/validation/reader/[trace_id]"
  reader_to_publication: "blog/validation/reader/[trace_id] → blog/production/final/[post_id]"
```

### 🎯 jt_site Technical Audience Specialization

**Target Audience** (All content generation agents use this context):
- **Demographics**: CTOs, Engineering Managers, Senior Developers, Tech Entrepreneurs
- **Pain Points**: Team efficiency, technical debt, agile adoption, hiring, remote management
- **Goals**: Build better products faster, improve teams, adopt best practices
- **Content Preferences**: Technical depth + practical examples, 5-10 min reading time

**Voice and Quality Standards**:
- ✅ Professional credibility > engagement tricks
- ✅ Technical accuracy non-negotiable
- ✅ Real-world applicability > theoretical perfection
- ✅ Zero generic AI language
- ✅ All claims properly cited

### 🧪 TDD Integration for Blog Content

**blog-writer TDD Cycle**:
```yaml
red_phase_visual_testing:
  action: "Create failing Hugo build test + visual regression baseline"
  validation: "Test fails (post doesn't exist yet)"
  memory: "blog/writing/tdd/[test_id]/visual_baselines"

green_phase_content_creation:
  action: "Write minimal Hugo markdown to make tests pass"
  validation: "`bin/hugo-build` succeeds + `bin/rake test:snap_diff` passes"
  memory: "blog/writing/drafts/[post_id]/versions"

refactor_phase_engagement:
  action: "Enhance opening hook, add stories, optimize paragraphs ≤3 sentences"
  validation: "Visual tests still passing, no regressions"
  memory: "blog/writing/quality/[check_type]/results"
```

### 📋 Content Generation Swarm Pattern (Copy-Paste Ready)

```javascript
// Standard blog production workflow (supervised by blog-coordinator)
[Blog Production - 7 Phase Workflow]:
  // Phase 1: Strategy
  Task("Content Strategist", "Analyze target audience (CTOs/Engineering Managers), identify high-value topic, design Hugo-compatible outline. Store strategy in blog/strategy/. Shareability target ≥7/10.", "analyst")

  // Phase 2: Research
  Task("Research Agent", "Gather ≥8 credible citations, ≥1 case study, expert quotes. Validate all technical claims. Store research in blog/research/. Reference content-strategist's outline.", "researcher")

  // Phase 3: Content Creation with TDD
  Task("Blog Writer", "Create Hugo markdown with TDD visual testing. RED: failing visual test. GREEN: minimal content. REFACTOR: enhance engagement. Paragraphs ≤3 sentences. Zero AI phrases. Store in blog/writing/.", "coder")

  // Phase 4: SEO Optimization
  Task("SEO Optimizer", "Optimize Hugo frontmatter, integrate keywords naturally, ensure Flesch ≥60. Never compromise readability or technical credibility. Store in blog/seo/.", "qa-expert")

  // Phase 5: Editorial Review
  Task("Content Editor", "Validate voice consistency, verify all citations, assess engagement ≥8/10 and shareability ≥7/10. Provide detailed feedback. Store in blog/editorial/.", "reviewer")

  // Phase 6: Reader Validation
  Task("Ideal Reader Representative", "Simulate jt_site's technical audience (CTOs/Engineering Managers). Provide authentic feedback, score engagement ≥8/10. Would share: Yes/Likely required. Store in blog/validation/.", "qa-expert")

  // Phase 7: Publication Preparation (Coordinator)
  Task("Blog Coordinator", "Compile Hugo publication package, validate all quality gates passed, final Hugo build test. Prepare for publication.", "coordination-expert")

  // Memory coordination todos
  TodoWrite { todos: [
    "Content Strategist: Analyze jt_site technical audience, predict shareability ≥7/10",
    "Research Agent: Gather ≥8 citations + ≥1 case study, validate technical claims",
    "Blog Writer: Hugo markdown with TDD (RED→GREEN→REFACTOR), visual testing",
    "SEO Optimizer: Hugo frontmatter + keywords, maintain Flesch ≥60",
    "Content Editor: Voice consistency + citation validation + engagement ≥8/10",
    "Ideal Reader Representative: Simulate CTOs/Engineering Managers, score ≥8/10",
    "Blog Coordinator: Validate all phases + quality gates, compile publication package",
    "Memory Coordination: Track handoffs via blog/* namespaces",
    "Quality Gates: Enforce zero-tolerance (no AI phrases, all claims cited)",
    "Hugo Integration: Validate build + visual regression tests at each phase",
    "Final Validation: All 7 phases complete + reader validation ≥8/10"
  ] }
```

### 🚨 Zero-Tolerance Quality Gates (Blog Production)

**Content Generation Enforcement**:
- ❌ **Generic AI Language**: Immediate rejection, must be rewritten
- ❌ **Unsupported Claims**: All assertions must have credible citations
- ❌ **Readability Compromises**: SEO never sacrifices human readability
- ❌ **Hugo Build Failures**: Content must render correctly with Hugo
- ❌ **Visual Regression**: Zero pixel differences allowed in visual testing

**Success Criteria for Publication**:
- ✅ All 7 phases completed successfully
- ✅ Reader engagement score ≥ 8/10
- ✅ Shareability prediction ≥ 7/10
- ✅ Hugo build validation successful
- ✅ Complete Hugo frontmatter with all metadata
- ✅ All citations properly formatted
- ✅ Zero generic AI language detected

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
  step_1_global_standards:    "Search the codebase at '/knowledge/' for: '[task]'"
  step_2_project_adaptations: "Search the codebase at '/projects/jt_site/docs/' for: '[task]'"
  step_3_complexity_check:    "Determine: Team structures, agent roles, implementation strategies"
  step_4_tdd_phase_check:     "Determine TDD phase (RED/GREEN/REFACTOR) if applicable"
  step_5_test_smell_check:    "Validate behavioral focus, reject implementation tests"
  step_6_swarm_coordination:  "Spawn XP team ONLY for complex >3 component changes"
  step_7_reflection_readiness: "HALT and REFLECT ONLY for actual violations (not user frustration)"
  step_8_visual_validation:   "FOR REFACTORING: Capture baseline screenshots, validate tolerance: 0.0"
  step_9_chrome_devtools:     "For HTML/CSS/JS changes: validate rendering via Chrome DevTools"
  step_10_local_patterns:     "Search the codebase at '/Users/pftg/dev/jetthoughts.github.io' for: '[pattern I need]'"

# Chrome DevTools validation (MANDATORY for rendering)
chrome_devtools_validation:
  trigger: "ANY HTML/CSS/JS change or new blog post"
  steps:
    - "Start Hugo dev server"
    - "Open page URL in Chrome DevTools"
    - "Check DevTools Console — zero errors (ZERO tolerance)"
    - "Check Network tab — zero 404s (ZERO tolerance)"
    - "Capture desktop + mobile screenshots"
    - "Verify Core Web Vitals in 'good' range"
  blocking: "ANY console error, ANY broken asset → STOP, fix"

# Autonomous execution mode (for repetitive goals)
autonomous_mode:
  pre_approval_signals:
    explicit: ["do everything needed", "keep going, don't stop", "complete all items"]
    implicit: ["numbered task list", "same approach for remaining", "frustration with stopping"]

  activation_response: "✅ Entering Continuous Execution Mode: test-commit-continue pattern, only stopping for critical failures"

  micro_commit_protocol:
    trigger: "After EVERY successful test run"
    frequency: "Every 5-15 minutes (typically 5-15 commits per task)"
    message_format: "[Action] [What] [Where]"
    workflow: "Change (< 10 lines) → Test → Commit → Continue (NO STOP)"

  iterative_workflow:
    pattern: "Identify → Change → Test → Commit → Continue"
    stopping_only: "Critical test failures, visual regressions, goal completion"
    no_stopping_for: "Effort assessment, scope questions, permission requests"

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

### 🎯 Ultimate Mandates

**Core TDD Mandate**: "Follow official claude-flow TDD methodology with specialized agent roles (test-writer, minimal-implementer, refactor-specialist). Implement RED-GREEN-REFACTOR cycle with shameless green acceptance. Use Fake It/Obvious/Triangulation strategies. Behavior-focused testing ONLY - refuse implementation/existence/configuration tests. Use claude-flow tools exclusively. HALT and REFLECT on ACTUAL violations (not user frustration). Coordinate via XP teams ONLY for complex work. Memory-based phase coordination. Target >95% coverage. Zero test smells."

**Visual Regression Validation Mandate**: "For ALL refactoring work: Capture baseline screenshots BEFORE changes with tolerance: 0.0. Preserve ALL page-specific CSS (.fl-node-* styles, layout rules). Compare screenshots AFTER changes - MUST show 0% difference. ANY visual change > 0% = IMMEDIATE BLOCK, revert, investigate. Four-eyes approval REQUIRED: Coder → Reviewer → Screenshot Guardian → Tester. Screenshot Guardian has ABSOLUTE blocking authority. Refactoring definition: Code restructuring maintaining EXACT functionality AND appearance. Breaking this mandate is FAILURE."

**Autonomous Execution Mandate**: "For repetitive goal-driven work (CSS consolidation, duplication removal), execute autonomously in solo mode. Test after each change with bin/rake test:critical. Commit on green. Continue to next item. NO approval gates. NO swarm spawning for simple patterns. ONLY stop on critical test failures. When user says 'keep going, don't stop', respect continuous execution request."

---

## 🤖 AUTONOMOUS BLOG MANAGEMENT PIPELINE

**Purpose**: Fully self-organized, self-managed blog workflow with high autonomy and minimal human interaction.
**Skill Foundation**: Built on installed external skills from the agent skills ecosystem.
**Authority**: Extends existing TDD/testing mandates — blog pipeline runs parallel to code pipeline.

### 📚 Installed Skills Integration

| Skill | Package@Name | Role in Pipeline |
|-------|-------------|------------------|
| Self-Improving Agent | `charon-fan/agent-playbook@self-improving-agent` | Continuous learning & adaptation |
| Blog Page Generator | `kostja94/marketing-skills@blog-page-generator` | Automated blog page creation |
| Content Strategy | `guia-matthieu/clawfu-skills@content-strategy` | Strategic content planning |
| Content Calendar | `eddiebe147/claude-settings@content-calendar-planner` | Editorial calendar automation |
| Content Production | `borghei/claude-skills@content-production` | End-to-end content creation |
| Content Publisher | `geoly-ai/geo-skills@geo-content-publisher` | Automated publishing pipeline |
| Workflow Execute | `catlog22/claude-code-workflow@workflow-execute` | Autonomous workflow runner |
| Agentic Automation | `samarv/shanon@agentic-workflow-automation` | Multi-step task automation |
| Social Trends | `drshailesh88/integrated_content_os@social-media-trends-research` | Trend discovery |
| Content Trends | `alirezarezvani/claude-code-skill-factory@content-trend-researcher` | Content trend analysis |
| Keyword Research | `kostja94/marketing-skills@keyword-research` | SEO opportunity discovery |
| Market Research | `manojbajaj95/claude-gtm-plugin@market-research-analysis` | Market context |
| Competitor Intel | `ognjengt/founder-skills@competitor-intel` | Competitive landscape |
| Web Research | `yonatangross/orchestkit@web-research-workflow` | Structured research workflow |
| SEO | `addyosmani/web-quality-skills@seo` | SEO best practices |
| Landing Page Opt. | `manojbajaj95/claude-gtm-plugin@landing-page-optimization` | Landing page conversion |
| SEO/AEO Audit | `warpdotdev/oz-skills@seo-aeo-audit` | SEO & AEO audits |
| Web Performance | `sickn33/antigravity-awesome-skills@web-performance-optimization` | Core Web Vitals |
| PageSpeed Insights | `enderpuentes/ai-agent-skills@pagespeed-insights` | Performance analysis |
| Best Practices | `addyosmani/web-quality-skills@best-practices` | HTML/CSS quality |
| PostCSS Best | `mindrally/skills@postcss-best-practices` | PostCSS patterns |
| HTML/CSS Best | `hack23/homepage@html-css-best-practices` | HTML/CSS fundamentals |
| Web Design Guide | `ehmo/platform-design-skills@web-design-guidelines` | Design & accessibility |
| Blog Post | `langchain-ai/deepagents@blog-post` | Blog post generation |
| Blog Writing Guide | `getsentry/skills@blog-writing-guide` | Blog writing process |
| Technical Writing | `mindrally/skills@technical-writing` | Technical content clarity |
| Copywriting Core | `manojbajaj95/claude-gtm-plugin@copywriting-core` | Persuasive copy |
| Copy Editing | `borghei/claude-skills@copy-editing` | Proofreading & polish |
| Obsidian Markdown | `kepano/obsidian-skills@obsidian-markdown` | Markdown file handling |
| Markdown to HTML | `jimliu/baoyu-skills@baoyu-markdown-to-html` | Markdown conversion |
| Hugo | `jackspace/claudeskillz@hugo` | Hugo static site guidance |
| Agent Config | `supercent-io/skills-template@agent-configuration` | Agent setup patterns |
| Bootstrap | `buiducnhat/agent-skills@bootstrap` | Project initialization |
| Skill Integrator | `jwynia/agent-skills@skill-integrator` | Skill integration |
| Project Memory | `vasilyu1983/ai-agents-public@agents-project-memory` | Persistent context |
| Context Fundamentals | `guanyang/antigravity-skills@context-fundamentals` | Context engineering |

### 🔄 Autonomous Blog Pipeline — 9-Phase Workflow

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ Phase 1     │───▶│ Phase 2     │───▶│ Phase 3     │───▶│ Phase 4     │
│ Trend       │    │ Strategy &  │    │ Research &  │    │ Ideation &  │
│ Discovery   │    │ Planning    │    │ Intelligence│    │ Outline     │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
                                                                │
                                                                ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ Phase 9     │◀───│ Phase 8     │◀───│ Phase 7     │◀───│ Phase 5     │
│ Continuous  │    │ Publishing  │    │ Hugo Build  │    │ Draft &     │
│ Improvement │    │ & Deploy    │    │ Validation  │    │ Editing     │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
                                          ▲
                                          │
                                    ┌─────────────┐
                                    │ Phase 6     │
                                    │ SEO &       │
                                    │ Performance │
                                    └─────────────┘
```

#### Phase 1: Trend Discovery (Autonomous)
**Skills**: `social-media-trends-research` + `content-trend-researcher` + `keyword-research`
**Trigger**: Scheduled (weekly) or manual `/blog-research`
**Output**: Trend report with keyword opportunities and content gaps
**Quality Gate**: ≥5 viable topic opportunities identified

#### Phase 2: Strategy & Planning (Autonomous)
**Skills**: `content-strategy` + `content-calendar-planner` + `market-research-analysis`
**Trigger**: Trend Discovery output available
**Output**: Content calendar with scheduled topics, target keywords, deadlines
**Quality Gate**: Each topic has target keyword, audience, shareability score ≥7/10

#### Phase 3: Research & Intelligence (Autonomous)
**Skills**: `competitor-intel` + `web-research-workflow` + `blog-writing-guide`
**Trigger**: Topic from content calendar is due
**Output**: Research dossier with citations, competitor analysis, data points
**Quality Gate**: ≥8 credible sources, ≥1 expert quote, no research gaps

#### Phase 4: Ideation & Outline (Autonomous)
**Skills**: `blog-post` + `copywriting-core` + `technical-writing`
**Trigger**: Research dossier complete
**Output**: Detailed outline with hooks, sections, code example placeholders
**Quality Gate**: 3-5 concrete takeaways, compelling hook defined, structure validated

#### Phase 5: Draft & Edit (Autonomous)
**Skills**: `blog-writer` (existing agent) + `content-production` + `copy-editing`
**Trigger**: Outline approved
**Output**: Complete Hugo markdown draft with frontmatter
**Quality Gate**: Zero AI phrases, paragraphs ≤3 sentences, all citations integrated

#### Phase 6: SEO & Performance (Autonomous)
**Skills**: `seo` + `seo-aeo-audit` + `landing-page-optimization` + `pagespeed-insights`
**Trigger**: Draft complete
**Output**: SEO-optimized draft with metadata, structured data, performance report
**Quality Gate**: Flesch Reading Ease ≥60, primary keyword integrated, metadata complete

#### Phase 7: Hugo Build Validation (Autonomous)
**Skills**: `hugo` + `blog-page-generator` + `obsidian-markdown`
**Trigger**: SEO-optimized draft ready
**Output**: Hugo-compatible content, validated frontmatter, asset references checked
**Quality Gate**: `bin/hugo-build` passes, frontmatter YAML valid, all links resolve

#### Phase 8: Publishing & Deploy (Autonomous)
**Skills**: `geo-content-publisher` + `workflow-execute` + `agentic-workflow-automation`
**Trigger**: Hugo build validation passes
**Output**: Published blog post, deployed site, social sharing assets
**Quality Gate**: Post live, URL accessible, social meta tags rendering correctly

#### Phase 9: Continuous Improvement (Autonomous)
**Skills**: `self-improving-agent` + `project-memory` + `context-fundamentals`
**Trigger**: Post-publish (ongoing)
**Output**: Performance metrics, engagement analysis, workflow refinements
**Quality Gate**: Lessons stored in memory, agent configurations updated

### 🧠 Memory Coordination for Blog Pipeline

```yaml
blog_autonomous_pipeline:
  # Workflow state
  workflow_state: "blog/pipeline/workflow/{trace_id}"
  phase_tracking: "blog/pipeline/phase/{phase_number}/{timestamp}"
  quality_gates: "blog/pipeline/quality/{gate_type}/{result}"

  # Content tracking
  topic_pipeline: "blog/content/topics/{topic_slug}/status"
  research_dossier: "blog/research/{topic_slug}/sources"
  draft_versions: "blog/drafts/{post_slug}/v{version}"

  # SEO & Performance
  seo_metrics: "blog/seo/{post_slug}/{metric_type}"
  performance_data: "blog/performance/{post_slug}/{date}"

  # Learning & Improvement
  pipeline_learnings: "blog/improvement/{lesson_type}/{timestamp}"
  agent_refinements: "blog/agents/{agent_name}/config_updates"

  # Publishing
  publish_log: "blog/publish/{post_slug}/{timestamp}"
  deploy_status: "blog/deploy/{environment}/{status}"
```

### 🚨 Autonomous Blog Pipeline Behavioral Constraints

```yaml
blog_pipeline_constraints:
  # Zero tolerance policies
  zero_generic_ai_language: "All AI-sounding phrases flagged and rejected"
  zero_unsupported_claims: "All assertions must have citations"
  zero_hugo_build_breaks: "All content validated for Hugo compatibility"
  zero_readability_compromise: "SEO never sacrifices human readability"

  # Visual validation (inherits screenshot-guardian mandate)
  visual_regression: "Zero tolerance — any visual change blocks publish"

  # Autonomy boundaries
  human_review_points:
    - "Phase 4 outline approval (optional, can be fully autonomous)"
    - "Phase 5 draft approval (optional, can be fully autonomous)"
  fully_autonomous_from: "Phase 6 onward once human approves outline OR fully autonomous mode enabled"

  # Stopping conditions
  stop_triggers:
    - "Hugo build failure"
    - "Visual regression detected"
    - "Quality gate failure (unrecoverable)"
    - "Research gaps cannot be filled"
    - "Self-improving agent detects systemic failure pattern"
```

### 📋 Autonomous Blog Pipeline Quick Start

```bash
# Full autonomous pipeline from trend to publish
# Trigger via command or natural language request

# Manual trigger: "Create a blog post about [topic]"
# Autonomous trigger: Content calendar scheduled topic is due

# Pipeline execution (handled by blog-coordinator):
# 1. Spawn research agents → gather trends, keywords, competitor data
# 2. Spawn strategy agent → plan content calendar, topics
# 3. Spawn research agent → gather citations, data, quotes
# 4. Spawn writing agents → draft content with Hugo markdown
# 5. Spawn SEO agents → optimize metadata, readability
# 6. Validate Hugo build → bin/hugo-build
# 7. Visual regression test → bin/rake test:critical
# 8. Publish → deploy to production
# 9. Store learnings → self-improving agent updates configurations
```

### 🤖 Agent Team for Autonomous Blog Pipeline

| Phase | Primary Agent | Supporting Agents | Skills Used |
|-------|--------------|-------------------|-------------|
| 1. Trend | `content-strategist` | `research-agent` | social-trends, content-trends, keyword-research |
| 2. Strategy | `content-strategist` | `blog-coordinator` | content-strategy, calendar-planner, market-research |
| 3. Research | `research-agent` | `seo-specialist` | competitor-intel, web-research, blog-writing-guide |
| 4. Ideation | `blog-coordinator` | `content-creator` | blog-post, copywriting-core, technical-writing |
| 5. Draft | `blog-writer` | `content-editor` | content-production, copy-editing, blog-writing-guide |
| 6. SEO | `seo-optimizer` | `hugo-expert` | seo, seo-aeo-audit, landing-page-opt, pagespeed |
| 7. Hugo | `hugo-expert` | `blog-coordinator` | hugo, blog-page-generator, obsidian-markdown |
| 8. Publish | `blog-coordinator` | `hugo-expert` | geo-content-publisher, workflow-execute |
| 9. Improve | `self-improving-agent` | `blog-coordinator` | self-improving, project-memory, context-fundamentals |

---

## 🛠️ HUGO + CSS/HTML/MD BEST PRACTICES INTEGRATION

**Purpose**: Integrate best practice skills for maintaining Hugo site, legacy CSS, HTML, PostCSS, and Markdown content.

### CSS/HTML/PostCSS Skills

| Skill | Package | Use Case |
|-------|---------|----------|
| Web Quality Best | `addyosmani/web-quality-skills@best-practices` | Overall web quality audit |
| PostCSS Best | `mindrally/skills@postcss-best-practices` | PostCSS config & patterns |
| HTML/CSS Best | `hack23/homepage@html-css-best-practices` | HTML/CSS fundamentals |
| Web Design Guide | `ehmo/platform-design-skills@web-design-guidelines` | Design & accessibility |
| Web Performance | `sickn33/antigravity-awesome-skills@web-performance-optimization` | Performance optimization |

**When to apply**:
- ANY CSS changes → apply `html-css-best-practices` + `postcss-best-practices`
- ANY HTML changes → apply `html-css-best-practices` + `best-practices`
- PostCSS config → apply `postcss-best-practices`
- Performance audit → apply `web-performance-optimization` + `pagespeed-insights`
- Accessibility review → apply `web-design-guidelines`

### Markdown Skills

| Skill | Package | Use Case |
|-------|---------|----------|
| Obsidian Markdown | `kepano/obsidian-skills@obsidian-markdown` | Creating/editing .md files |
| Markdown to HTML | `jimliu/baoyu-skills@baoyu-markdown-to-html` | MD → HTML conversion |
| Format Markdown | `jimliu/baoyu-skills@baoyu-format-markdown` | Markdown formatting |
| URL to Markdown | `jimliu/baoyu-skills@baoyu-url-to-markdown` | Web clipping to MD |

**When to apply**:
- ANY `.md` file creation/editing → apply `obsidian-markdown`
- Markdown formatting needed → apply `baoyu-format-markdown`
- Converting web content → apply `baoyu-url-to-markdown`
- Preview as HTML → apply `baoyu-markdown-to-html`

### Hugo Skills

| Skill | Package | Use Case |
|-------|---------|----------|
| Hugo | `jackspace/claudeskillz@hugo` | Hugo static site guidance |

**When to apply**:
- ANY Hugo configuration changes → apply `hugo` skill
- Template architecture → apply `hugo` + existing `hugo-expert` agent
- Content structure → apply `hugo` + existing `hugo-expert` agent

### Agent Configuration & Setup Skills

| Skill | Package | Use Case |
|-------|---------|----------|
| Agent Config | `supercent-io/skills-template@agent-configuration` | Agent setup patterns |
| Bootstrap | `buiducnhat/agent-skills@bootstrap` | Project initialization |
| Skill Integrator | `jwynia/agent-skills@skill-integrator` | Skill integration |
| Project Memory | `vasilyu1983/ai-agents-public@agents-project-memory` | Persistent context |
| Context Fundamentals | `guanyang/antigravity-skills@context-fundamentals` | Context engineering |

**When to apply**:
- New agent creation → apply `agent-configuration` + `bootstrap`
- Skill integration → apply `skill-integrator`
- Project context setup → apply `project-memory` + `context-fundamentals`

---

## 📊 AUTONOMOUS BLOG METRICS & KPIs

```yaml
blog_pipeline_metrics:
  # Content production
  posts_per_month: "Target: 4-8 posts/month (autonomous)"
  pipeline_velocity: "Target: ≤3 days from trend to publish"
  quality_score: "Target: All quality gates ≥ 8/10"

  # SEO & Performance
  organic_traffic: "Track via analytics, target: +10% month-over-month"
  keyword_rankings: "Target: 3+ posts ranking on page 1 for target keywords"
  page_speed: "Target: Lighthouse score ≥ 90, Core Web Vitals pass"

  # Engagement
  shareability: "Target: ≥7/10 shareability score"
  reading_time: "Target: 5-10 minutes per post"
  reader_engagement: "Target: ≥8/10 reader validation score"

  # Autonomous operation
  human_intervention_rate: "Target: <10% of posts require human review"
  pipeline_failure_rate: "Target: <5% pipeline failures"
  self_improvement_rate: "Target: Monthly agent configuration updates"
```

---

### AI Detection & Humanization

| Skill | Package | Use Case |
|-------|---------|----------|
| Humanizer | `brandonwise/humanizer@humanizer` | Humanizing AI-generated text |
| Slop Detector | `athola/claude-night-market@slop-detector` | Detecting AI-generated content |

**When to apply**:
- AFTER Phase 5 (Draft & Edit) → run `slop-detector` to scan for AI patterns
- IF slop detected → run `humanizer` to rewrite flagged sections
- BEFORE Phase 6 (SEO) → re-scan to confirm human-like quality
- **MANDATORY**: All blog content MUST pass slop-detector before publishing

**Quality Gate Addition**:
- Phase 5.5 (AI Quality Check): `slop-detector` scan → zero AI patterns → `humanizer` if needed
- Blocking: Any text flagged by slop-detector MUST be humanized before proceeding

---

**Remember**: This comprehensive configuration enforces unified handbook system compliance with Hugo/JAMstack specializations AND autonomous blog management pipeline. All agents MUST follow the dual-source handbook system (global standards FIRST, project adaptations SECOND) and maintain zero-tolerance policies for duplication, quality, and security violations. The autonomous blog pipeline runs in parallel to TDD/code pipeline, with both pipelines sharing visual regression validation and quality gate enforcement.
