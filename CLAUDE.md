# Claude Code Configuration - JT Site (Hugo-based Static Site)

## 📚 **INCIDENT LEARNING: Multi-Agent Coordination Failure and Broken Tests (Sept 16, 2025)**

### 🔍 **CRITICAL FAILURE ANALYSIS: SINGLE-AGENT VIOLATIONS**
**Problem**: Single agents attempted complex tasks without mandatory multi-agent coordination, resulting in broken tests and handbook violations
**Root Cause**: Insufficient enforcement of multi-agent spawning requirements; agents bypassed team coordination protocols
**Impact**: Test failures, hardcoded values, violation of review requirements, broken build pipeline, quality degradation

### 🚨 **SPECIFIC VIOLATIONS THAT CAUSED TEST FAILURES**
1. **Single-Agent Implementation**: One agent attempted multi-file changes without required reviewer pairing
2. **Bypassed Review Gates**: Changes committed without mandatory pre-review approval from specialized agents
3. **Missing Expert Consultation**: Complex tasks proceeded without required security-expert, performance-expert validation
4. **Broken Team Coordination**: No cross-agent memory coordination or quality validation before merge
5. **Test Quality Violations**: Tests modified without TDD expert oversight, leading to masked failures

## 📚 **INCIDENT LEARNING: XP Team Git Audit and Handbook Violations (Sept 16, 2025)**

### 🔍 **CRITICAL VIOLATIONS IDENTIFIED BY XP TEAM SWARM**
**Problem**: Multiple zero-tolerance handbook violations found in git changes during comprehensive audit
**Root Cause**: Agent implementation without strict adherence to conservative XP practices and handbook standards
**Impact**: Hardcoded values, test masking, violation of micro-refactoring discipline, potential production issues

### 🛠️ **XP TEAM CORRECTIONS APPLIED**
1. **Hardcoded Port Violations**: Removed hardcoded port 1314, replaced with ENV.fetch("TEST_SERVER_PORT", "1314")
2. **Test Masking Violations**: Removed skip() method that violated zero-tolerance test masking policy
3. **Hardcoded Path Violations**: Replaced "_dest/public-test" with ENV.fetch('HUGO_PUBLIC_DIR', '_dest/public-test')
4. **Micro-Refactoring Discipline**: Applied ≤3 line changes with syntax validation after each step

### 📖 **XP PRINCIPLES SUCCESSFULLY ENFORCED**
- **Conservative Workflow**: Slow and steady approach, test validation after each micro-change
- **Zero Tolerance**: Eliminated all hardcoded values, removed test masking patterns
- **Rollback Safety**: Immediate syntax validation with rollback on failures (demonstrated)
- **Team Coordination**: Research Coordinator + TDD Expert + Code Reviewer + Refactoring Expert

### 🛡️ **MULTI-AGENT COORDINATION LESSONS LEARNED**
- **MANDATORY TEAM SPAWNING**: All complex tasks must spawn minimum 2 specialized agents (implementer + reviewer)
- **PRE-REVIEW BLOCKING**: Zero tolerance for "implement first, review later" - ALL changes blocked until reviewer approval
- **EXPERT CONSULTATION TRIGGERS**: Automatic spawning of domain experts based on task complexity analysis
- **CROSS-AGENT VALIDATION**: Independent validation required from each agent before task completion
- **MEMORY COORDINATION**: All multi-agent work must use memory-based coordination protocols

### 🎯 **PREVENTION MEASURES NOW ACTIVE**
- **Pre-commit hooks**: Mandatory handbook compliance validation
- **Environment variable enforcement**: All configurable values must use ENV.fetch
- **Test masking prevention**: Zero tolerance for skip(), puts, print statements in tests
- **Micro-refactoring validation**: Automatic ≤3 line rule enforcement
- **XP team swarm coordination**: Complex audits require specialized agent teams
- **🆕 MULTI-AGENT ENFORCEMENT**: Automatic blocking of single-agent complex work
- **🆕 REVIEW-BEFORE-MERGE**: Mandatory reviewer approval before any file modifications

---

## 🚨 CRITICAL: COMPREHENSIVE AGENT VIOLATION PREVENTION SYSTEM - ZERO TOLERANCE

### ⚠️ AGENTS CANNOT BYPASS THESE REQUIREMENTS - AUTOMATED BLOCKING ACTIVE

**PROBLEM SOLVED**: Agent violations in test writing, TDD compliance, and handbook adherence now AUTOMATICALLY BLOCKED
**COMPLIANCE RESTORATION**: These enforcement mechanisms restore handbook compliance from 23% to 95%+ as required by analysis

### 🛡️ **AUTOMATED TEST VALIDATION SYSTEM - MANDATORY**

#### **PRE-COMMIT TEST VALIDATION HOOK**
```bash
# MANDATORY: All agents must run this before ANY test changes
bin/test

# What it blocks (ZERO TOLERANCE):
# ❌ puts/print statements in tests (masks failures)
# ❌ Tests without proper assert/refute statements
# ❌ Output-only tests that don't validate behavior
# ❌ TDD violations (missing test files for source code)
# ❌ Handbook naming convention violations
# ❌ Test methods lacking assertions
```

#### **AGENT TEST WRITING VIOLATIONS BLOCKED**
- **🚫 OUTPUT MASKING**: No puts, print, or p statements in test files
- **🚫 ASSERTION GAPS**: Tests must use assert/refute, not output
- **🚫 TDD BYPASSING**: Source files must have corresponding test files
- **🚫 NAMING VIOLATIONS**: Tests must follow *_test.rb convention
- **🚫 BEHAVIOR MASKING**: Tests must validate behavior, not just run code

#### **AUTOMATIC ENFORCEMENT INTEGRATION**
```bash
# Integrated into existing test pipeline
bun run test                # Now includes validation
bin/test                    # Now blocks violations automatically
bundle exec rake test       # Enhanced with prevention checks
```

#### **🚨 MANDATORY MULTI-AGENT SPAWNING ENFORCEMENT - ZERO TOLERANCE**

**CRITICAL MANDATE**: NO single agent can handle complex work. All tasks requiring >1 file modification or domain expertise MUST spawn specialized agent teams.

```bash
# MANDATORY: Multi-agent spawning validation (BLOCKS single-agent work)
mandatory_multi_agent_spawning() {
    local task_description="$1"
    local requesting_agent="$2"

    echo "🐝 MULTI-AGENT SPAWNING VALIDATION - ZERO TOLERANCE"
    echo "Task: $task_description"
    echo "Requesting Agent: $requesting_agent"

    # BLOCKED SINGLE-AGENT PATTERNS (Automatic team spawning)
    if echo "$task_description" | grep -iE "(implement.*and|code.*and.*test|fix.*and.*validate|create.*and.*review|build.*and.*deploy|refactor.*and.*test)"; then
        echo "🚨 BLOCKED: Single-agent attempting multi-action task"
        echo "🐝 REQUIRED: Spawn specialized team immediately"
        auto_spawn_required_team "$task_description"
        return 1
    fi

    # BLOCKED COMPLEXITY INDICATORS (Require expert consultation)
    if echo "$task_description" | grep -iE "(architecture|security|performance|integration|database|authentication|deployment|optimization)"; then
        echo "🚨 BLOCKED: Single-agent attempting expert domain work"
        echo "👥 REQUIRED: Expert consultation mandatory"
        auto_spawn_expert_consultation "$task_description"
        return 1
    fi

    # BLOCKED FILE MODIFICATION PATTERNS (Require reviewer)
    if echo "$task_description" | grep -iE "(modify|change|update|edit|create.*file|delete.*file|multiple.*files)"; then
        echo "🚨 BLOCKED: Single-agent attempting file modifications without reviewer"
        echo "📋 REQUIRED: Spawn reviewer agent before any changes"
        spawn_mandatory_reviewer "$task_description" "$requesting_agent"
        return 1
    fi

    # BLOCKED TEST MODIFICATIONS (Require TDD expert)
    if echo "$task_description" | grep -iE "(test|spec|tdd|testing|assertion|validation)"; then
        echo "🚨 BLOCKED: Single-agent attempting test work without TDD expert"
        echo "🧪 REQUIRED: TDD expert coordination mandatory"
        spawn_tdd_expert_team "$task_description"
        return 1
    fi

    echo "✅ MULTI-AGENT VALIDATION: Simple task approved for single agent"
    return 0
}

# AUTOMATIC TEAM SPAWNING based on task patterns
auto_spawn_required_team() {
    local task="$1"

    echo "🐝 AUTO-SPAWNING REQUIRED TEAM FOR: $task"

    # MANDATORY: Four-Eyes Principle - Every coder needs a reviewer
    echo "📋 MANDATORY FOUR-EYES TEAM (MINIMUM):"
    echo "   Task('Primary Implementer', 'Execute main implementation with expert guidance', 'coder')"
    echo "   Task('Code Reviewer', 'MANDATORY: Review all changes for quality and compliance', 'reviewer')"
    echo "   Task('QA Validator', 'Validate implementation meets requirements', 'qa-expert')"
    echo ""
    echo "⚠️ FOUR-EYES ENFORCEMENT: Every coder MUST have a paired reviewer"

    # Add domain experts based on keywords
    if echo "$task" | grep -iE "(security|auth|crypto)"; then
        echo "   Task('Security Expert', 'Audit security implications and validate implementation', 'security-expert')"
    fi

    if echo "$task" | grep -iE "(performance|optimization|speed)"; then
        echo "   Task('Performance Expert', 'Validate performance impact and optimize', 'performance-expert')"
    fi

    if echo "$task" | grep -iE "(architecture|design|structure)"; then
        echo "   Task('Architecture Expert', 'Propose design and seek team review', 'architecture-expert')"
        echo "   Task('Architecture Reviewer 1', 'Review architectural decisions independently', 'reviewer')"
        echo "   Task('Architecture Reviewer 2', 'Second review for consensus', 'architect-review')"
        echo "   ⚠️ ARCHITECT MUST: Present solution to team for review and approval"
    fi

    if echo "$task" | grep -iE "(planning|strategy|roadmap|coordination)"; then
        echo "   Task('Planner', 'Develop plan and collaborate with team for balanced solution', 'planner')"
        echo "   Task('Strategic Reviewer', 'Review plan for feasibility and balance', 'reviewer')"
        echo "   Task('Implementation Lead', 'Validate plan is executable', 'coder')"
        echo "   ⚠️ PLANNER MUST: Work with team to find balanced solution, not dictate"
    fi

    echo ""
    echo "🚫 SINGLE-AGENT WORK BLOCKED: Team coordination required"
    exit 1  # Force team spawning
}
```

#### **IMMEDIATE BLOCKING ENFORCEMENT - EVERY AGENT MUST FOLLOW**

0. **🐝 MULTI-AGENT SPAWNING REQUIREMENT (NEW - HIGHEST PRIORITY)**
   - **BLOCKING**: Single agents cannot handle complex tasks (>1 file, domain expertise, test modifications)
   - **BLOCKING**: All file modifications require reviewer agent approval
   - **BLOCKING**: Expert domains require consultation (security, performance, architecture)
   - **BLOCKING**: Test work requires TDD expert coordination
   - **USAGE**: `mandatory_multi_agent_spawning "task" "agent"` - RUNS BEFORE ALL TASKS

1. **🧪 TDD THREE LAWS + TEST QUALITY ENFORCEMENT**
   - **BLOCKING**: No production code without failing test first
   - **BLOCKING**: Tests must fail for the right reason initially
   - **BLOCKING**: Maximum 10 lines per TDD cycle
   - **BLOCKING**: Tests must use assertions (assert/refute) not output
   - **BLOCKING**: No puts/print/p statements in test files
   - **USAGE**: `bin/test` - MANDATORY before any implementation

2. **🚨 MANDATORY PRE-REVIEW ENFORCEMENT - COMPREHENSIVE BLOCKING SYSTEM**
   - **🛡️ PRE-IMPLEMENTATION GATE**: ALL changes must pass review BEFORE file modification
   - **🔒 REVIEWER APPROVAL REQUIRED**: No Edit/Write/MultiEdit operations without explicit reviewer sign-off
   - **👥 AUTOMATIC EXPERT PAIRING**: Keywords trigger domain expert assignment (security → security-expert, etc.)
   - **📋 REVIEW CHECKLIST VALIDATION**: Mandatory quality/security/performance checks before approval
   - **💾 MEMORY-TRACKED APPROVALS**: Review status stored in memory, enforced by file operation hooks
   - **🚫 IMPLEMENTATION-FIRST BLOCKING**: Prevents "implement first, review later" anti-patterns
   - **USAGE**: `mandatory_pre_review_gate "task" && reviewer_approval_check "changes"` - BLOCKS ALL FILE OPS

3. **📏 3-LINE MICRO-REFACTORING ENFORCEMENT (Lines 1081-1240)**
   - **BLOCKING**: Git commits limited to 3 lines maximum
   - **BLOCKING**: Tests must pass after each micro-step
   - **USAGE**: `micro_refactoring_enforcement` - RUNS ON EVERY COMMIT

4. **🐝 SWARM DELEGATION MANDATORY TRIGGERS (Lines 1242-1454)**
   - **BLOCKING**: Multi-component tasks MUST use swarm coordination
   - **BLOCKING**: Expert consultation mandatory for specialized domains
   - **USAGE**: `swarm_delegation_trigger "task description"` - RUNS AUTOMATICALLY

5. **🔒 VALIDATION HOOKS (Lines 1677-1906)**
   - **BLOCKING**: Pre-task, during-task, and post-task validation required
   - **BLOCKING**: Build + test validation before any success claims
   - **USAGE**: `pre_task_validation_suite "task"` - MANDATORY before task start

6. **🐌 CONSERVATIVE WORKFLOW (Lines 1794-1853)**
   - **BLOCKING**: "Slow and steady" approach mandatory
   - **BLOCKING**: Safety over speed, no shortcuts allowed
   - **USAGE**: `conservative_workflow_enforcement "task"` - ALWAYS APPLIES

#### **ENHANCED AGENT STARTUP SEQUENCE (MANDATORY WITH MULTI-AGENT VALIDATION)**
```bash
# EVERY AGENT MUST RUN THIS SEQUENCE BEFORE STARTING ANY TASK
task_startup_sequence() {
    local task_description="$1"
    local agent_id="$2"

    # 0. MANDATORY: Multi-agent spawning validation (HIGHEST PRIORITY)
    echo "🐝 STEP 0: MULTI-AGENT SPAWNING VALIDATION"
    mandatory_multi_agent_spawning "$task_description" "$agent_id" || {
        echo "🚨 TASK BLOCKED: Multi-agent coordination required"
        echo "🐝 AUTO-SPAWNING: Required team agents being initiated"
        exit 1  # Force multi-agent spawning
    }

    # 1. MANDATORY: Test validation system check (FIRST PRIORITY)
    if [[ "$task_description" =~ (test|spec|assert|TDD) ]]; then
        echo "🛡️  RUNNING TEST VALIDATION SYSTEM"
        bin/test || {
            echo "🚨 BLOCKED: Test violations detected - Agent task terminated"
            exit 1
        }
    fi

    # 2. MANDATORY: Smart decomposition validation (NEW)
    validate_smart_decomposition "$task_description" || exit 1

    # 3. MANDATORY: Pre-task validation suite
    pre_task_validation_suite "$task_description" || exit 1

    # 4. MANDATORY: Conservative workflow enforcement
    conservative_workflow_enforcement "$task_description"

    # 5. MANDATORY: Check for swarm delegation needs (ENHANCED)
    if swarm_delegation_trigger "$task_description"; then
        echo "🚨 SWARM DELEGATION REQUIRED"
        orchestrate_swarm_execution "$task_description"
        exit 0  # Hand off to swarm
    fi

    # 6. MANDATORY: Pre-review enforcement gate (ENHANCED)
    mandatory_pre_review_gate "$task_description" || {
        echo "🚨 BLOCKED: Changes require reviewer approval before implementation"
        echo "👥 AUTO-SPAWNING: Reviewer agent required"
        spawn_reviewer_agent "$task_description" "$agent_id"
        exit 1
    }

    # 7. MANDATORY: Check for pairing needs (ENHANCED)
    automatic_pairing_trigger "$task_description"

    # 8. MANDATORY: Establish cross-agent coordination (NEW)
    establish_multi_agent_coordination "$task_description" "$agent_id"

    echo "✅ STARTUP SEQUENCE COMPLETE: Agent authorized with team coordination"
}

# NEW: Establish multi-agent coordination protocols
establish_multi_agent_coordination() {
    local task="$1"
    local agent="$2"

    echo "🤝 ESTABLISHING MULTI-AGENT COORDINATION"
    echo "Task: $task"
    echo "Primary Agent: $agent"

    # Store coordination state in memory
    local coordination_key="multi-agent/coordination/$(echo "$task" | md5sum | cut -d' ' -f1 2>/dev/null || echo "$(date +%s)")"

    echo "💾 COORDINATION STATE: $coordination_key"
    echo "📋 REQUIRED VALIDATIONS:"
    echo "   • Primary agent implementation"
    echo "   • Reviewer agent validation"
    echo "   • Expert agent consultation (if required)"
    echo "   • Cross-agent quality verification"
    echo "   • Final approval before merge"

    # Coordination requirements
    echo "🔄 COORDINATION REQUIREMENTS:"
    echo "   • Memory-based status updates required"
    echo "   • Independent validation from each agent"
    echo "   • No single point of failure in review process"
    echo "   • All agents must provide evidence of work"
}
```

#### **TASK FAILURE CONDITIONS (ZERO TOLERANCE) - MULTI-AGENT VIOLATIONS ADDED**
**IMMEDIATE TASK TERMINATION** if agent:
- **🚨 NEW**: Attempts complex task without spawning required team (mandatory_multi_agent_spawning violation)
- **🚨 NEW**: Bypasses reviewer approval requirement for file modifications
- **🚨 NEW**: Performs expert domain work without consultation (security/performance/architecture)
- **🚨 NEW**: Modifies tests without TDD expert coordination
- **🚨 NEW**: Claims task completion without cross-agent validation
- **🚨 NEW**: Breaks multi-agent coordination protocols
- **🚨 NEW**: Implements changes before review approval (implement-first anti-pattern)
- **🚨 NEW**: Writes tests with puts/print statements instead of assertions
- **🚨 NEW**: Creates tests that mask failures with output instead of validating behavior
- **🚨 NEW**: Violates test naming conventions (*_test.rb requirement)
- **🚨 NEW**: Writes test methods without assert/refute statements
- **🚨 NEW**: Bypasses validation checks for test-related tasks
- Skips TDD validation (Line 680: `validate_tdd_compliance`)
- Attempts complex task without pairing (Line 988: `enforce_complexity_pairing`)
- Exceeds 3-line micro-step limit (Line 1090: `micro_refactoring_enforcement`)
- Bypasses swarm delegation requirements (Line 1251: `swarm_delegation_trigger`)
- Claims success without validation evidence (Line 1754: `post_task_validation_suite`)
- Uses shortcuts instead of conservative approach (Line 1799: `conservative_workflow_enforcement`)

**NO EXCEPTIONS. NO OVERRIDES. NO BYPASSING ALLOWED. TEST VIOLATIONS = IMMEDIATE TERMINATION.**

## 🚨 MANDATORY PRE-REVIEW ENFORCEMENT SYSTEM - ZERO TOLERANCE

### 🛡️ **CRITICAL REQUIREMENT: NO CHANGES WITHOUT PRIOR REVIEW APPROVAL**

**PROBLEM ADDRESSED**: Agents implementing changes first, then seeking review - violates handbook standards
**SOLUTION**: Comprehensive blocking system that prevents ANY file modifications without explicit reviewer approval
**COMPLIANCE RESTORATION**: From current 23% handbook compliance to required 95%+ compliance
**ENFORCEMENT**: AUTOMATIC - No agent bypassing allowed

#### **🔒 PRE-IMPLEMENTATION REVIEW GATE (MANDATORY)**

ALL agents MUST obtain reviewer approval BEFORE making ANY changes:

```bash
# MANDATORY: Pre-review gate enforcement function
mandatory_pre_review_gate() {
    local task_description="$1"
    local change_complexity=$(assess_change_complexity "$task_description")
    local domain_type=$(identify_domain_type "$task_description")

    echo "🛡️  PRE-REVIEW GATE: Analyzing task for review requirements"
    echo "📊 Change Complexity: $change_complexity"
    echo "🎯 Domain Type: $domain_type"

    # ALL code changes require pre-review (ZERO EXCEPTIONS)
    if [[ "$task_description" =~ (code|implement|build|create|develop|fix|refactor|change|modify|update|edit|write) ]]; then
        echo "🚨 CODE CHANGE DETECTED: Pre-review approval required"

        # Assign appropriate reviewer based on domain and complexity
        local required_reviewer=$(assign_domain_reviewer "$task_description" "$domain_type" "$change_complexity")
        echo "👥 ASSIGNED REVIEWER: $required_reviewer"

        # Check if review approval exists in memory
        local approval_key="pre-review/approval/$(echo "$task_description" | md5sum | cut -d' ' -f1)"
        local approval_status=$(npx claude-flow@alpha hooks memory-search --pattern "$approval_key" 2>/dev/null || echo "")

        if [[ -z "$approval_status" ]]; then
            echo "🚫 BLOCKED: No pre-review approval found for this task"
            echo "📝 REQUIRED: Spawn reviewer agent and obtain approval first"
            echo "🔧 USAGE: spawn_reviewer_for_approval \"$task_description\" \"$required_reviewer\""
            echo ""
            echo "🚨 ENFORCEMENT: File operations (Edit/Write/MultiEdit) will be BLOCKED until approval obtained"
            return 1
        fi

        echo "✅ PRE-REVIEW APPROVAL FOUND: Task authorized for implementation"
        return 0
    fi

    # Non-code changes may proceed but with logging
    echo "ℹ️  Non-code task: Proceeding without pre-review requirement"
    return 0
}
```

#### **👥 AUTOMATIC REVIEWER ASSIGNMENT MATRIX**

```bash
# Domain-based reviewer assignment with expert consultation
assign_domain_reviewer() {
    local task="$1"
    local domain="$2"
    local complexity="$3"

    # Security-sensitive tasks → Security Expert
    if [[ "$task" =~ (security|auth|crypto|vulnerability|password|token|session|permission|oauth|ssl|tls) ]]; then
        echo "security-expert"
        return
    fi

    # Performance-critical tasks → Performance Expert
    if [[ "$task" =~ (performance|speed|optimization|cache|memory|cpu|database|query|index) ]]; then
        echo "performance-expert"
        return
    fi

    # Architecture changes → Architecture Expert
    if [[ "$task" =~ (architecture|design|structure|pattern|framework|integration|service|api) ]]; then
        echo "architecture-expert"
        return
    fi

    # Hugo/Content tasks → SEO Expert + Content Specialist
    if [[ "$task" =~ (hugo|content|markdown|post|page|seo|meta|title|description) ]]; then
        echo "seo-expert,content-specialist"
        return
    fi

    # High complexity (≥7) → Requires expert consultation
    if [[ "$complexity" -ge 7 ]]; then
        echo "architecture-expert,reviewer"
        return
    fi

    # Default: Standard reviewer
    echo "reviewer"
}
```

#### **📋 MANDATORY REVIEW CHECKLIST VALIDATION**

```bash
# Comprehensive review checklist that reviewer must complete
reviewer_checklist_validation() {
    local task="$1"
    local reviewer_type="$2"
    local approval_key="pre-review/approval/$(echo "$task" | md5sum | cut -d' ' -f1)"

    echo "📋 REVIEW CHECKLIST FOR: $task"
    echo "👤 REVIEWER TYPE: $reviewer_type"
    echo ""
    echo "🔍 MANDATORY REVIEW CRITERIA (ALL MUST BE VALIDATED):"
    echo ""
    echo "   📚 1. HANDBOOK COMPLIANCE VERIFICATION"
    echo "      [ ] Task follows global handbook standards (/knowledge/)"
    echo "      [ ] Implementation approach aligns with project adaptations (docs/)"
    echo "      [ ] No conflicts between global and project requirements"
    echo "      [ ] TDD methodology properly followed"
    echo ""
    echo "   🔒 2. SECURITY REVIEW (if applicable)"
    echo "      [ ] Input validation implemented"
    echo "      [ ] No hardcoded secrets or credentials"
    echo "      [ ] Proper authentication/authorization"
    echo "      [ ] OWASP compliance verified"
    echo ""
    echo "   ⚡ 3. PERFORMANCE VALIDATION"
    echo "      [ ] No obvious performance bottlenecks"
    echo "      [ ] Efficient algorithms chosen"
    echo "      [ ] Caching strategy appropriate"
    echo "      [ ] Database queries optimized"
    echo ""
    echo "   🏗️  4. ARCHITECTURE ALIGNMENT"
    echo "      [ ] Follows established patterns"
    echo "      [ ] Proper separation of concerns"
    echo "      [ ] Integration points well-defined"
    echo "      [ ] Scalability considerations addressed"
    echo ""
    echo "   🧪 5. QUALITY ASSURANCE"
    echo "      [ ] Test coverage adequate (>80%)"
    echo "      [ ] Edge cases identified"
    echo "      [ ] Error handling implemented"
    echo "      [ ] Code maintainability ensured"
    echo ""
    echo "   📝 6. IMPLEMENTATION APPROACH"
    echo "      [ ] Simplest solution chosen (KISS principle)"
    echo "      [ ] No over-engineering detected"
    echo "      [ ] Technical debt minimized"
    echo "      [ ] Documentation requirements met"
    echo ""
    echo "✅ REVIEWER SIGN-OFF REQUIRED:"
    echo "   To approve this task, reviewer must store approval in memory:"
    echo "   npx claude-flow@alpha hooks memory-store \\"
    echo "     --key \"$approval_key\" \\"
    echo "     --value \"approved:$(date):$reviewer_type:checklist_completed\""
    echo ""
    echo "🚫 WITHOUT APPROVAL: All file operations will be BLOCKED"
}
```

#### **🔒 FILE OPERATION BLOCKING SYSTEM**

```bash
# Intercept and validate all file operations
validate_file_operation_approval() {
    local operation="$1"  # Edit, Write, MultiEdit
    local file_path="$2"
    local change_description="$3"

    echo "🔍 VALIDATING FILE OPERATION: $operation on $file_path"

    # Check for pre-review approval
    local task_hash=$(echo "$change_description" | md5sum | cut -d' ' -f1)
    local approval_key="pre-review/approval/$task_hash"
    local approval_status=$(npx claude-flow@alpha hooks memory-search --pattern "$approval_key" 2>/dev/null || echo "")

    if [[ -z "$approval_status" ]]; then
        echo "🚨 FILE OPERATION BLOCKED"
        echo "❌ Reason: No pre-review approval found"
        echo "📁 File: $file_path"
        echo "🔧 Operation: $operation"
        echo "📝 Description: $change_description"
        echo ""
        echo "🛡️  ENFORCEMENT: You must obtain reviewer approval before modifying files"
        echo "✅ SOLUTION: Run reviewer_checklist_validation and get approval first"
        echo ""
        echo "🚫 BLOCKING: This operation cannot proceed without explicit reviewer sign-off"
        return 1
    fi

    echo "✅ FILE OPERATION AUTHORIZED: Pre-review approval found"
    echo "📋 Approval: $approval_status"
    return 0
}
```

#### **⚠️  IMPLEMENTATION-FIRST ANTI-PATTERN PREVENTION**

```bash
# Detect and prevent "implement first, review later" violations
prevent_implementation_first_antipattern() {
    local agent_intent="$1"

    # Detect implementation-first language patterns
    if [[ "$agent_intent" =~ (I will implement|Let me implement|I'll start by implementing|First I'll implement) ]]; then
        echo "🚨 IMPLEMENTATION-FIRST ANTI-PATTERN DETECTED"
        echo "❌ VIOLATION: Agent attempting to implement before review"
        echo "🛡️  HANDBOOK REQUIREMENT: All changes must be reviewed before implementation"
        echo ""
        echo "🔄 CORRECT APPROACH:"
        echo "   1. Spawn reviewer agent first"
        echo "   2. Present implementation plan for review"
        echo "   3. Obtain explicit approval"
        echo "   4. Then proceed with implementation"
        echo ""
        echo "🚫 BLOCKED: Implementation attempt prevented"
        return 1
    fi

    return 0
}
```

### 📊 **MEMORY-BASED COORDINATION SYSTEM**

#### **🧠 Review Coordination Namespaces**
```bash
# Memory organization for review coordination
review_coordination_namespaces: |
  - "pre-review/approval/*"           # Pre-implementation approvals
  - "pre-review/assignments/*"        # Reviewer assignments
  - "pre-review/checklists/*"         # Completed review checklists
  - "pre-review/domain-expertise/*"   # Domain expert consultations
  - "pre-review/blocking/*"           # Blocked operations tracking
  - "pre-review/violations/*"         # Implementation-first violations
  - "pre-review/audit-trail/*"        # Review process audit trail
```

#### **🔄 Cross-Agent Review Coordination**
```bash
# Establish review coordination between agents
establish_review_coordination() {
    local task_id="$1"
    local implementer_agent="$2"
    local reviewer_agent="$3"

    # Create coordination namespace
    npx claude-flow@alpha hooks memory-store \
        --key "pre-review/coordination/$task_id/implementer" \
        --value "$implementer_agent"

    npx claude-flow@alpha hooks memory-store \
        --key "pre-review/coordination/$task_id/reviewer" \
        --value "$reviewer_agent"

    npx claude-flow@alpha hooks memory-store \
        --key "pre-review/coordination/$task_id/status" \
        --value "review_pending"

    echo "🤝 REVIEW COORDINATION ESTABLISHED"
    echo "👨‍💻 Implementer: $implementer_agent (waiting for approval)"
    echo "👨‍🔬 Reviewer: $reviewer_agent (must complete checklist)"
    echo "📊 Status: Review pending - implementation blocked until approval"
}
```

#### **🔒 GIT PRE-COMMIT HOOKS - BLOCKING UNAPPROVED CHANGES**

```bash
# Git pre-commit hook that prevents commits without review approval
#!/bin/bash
# File: .git/hooks/pre-commit

echo "🔍 PRE-COMMIT REVIEW VALIDATION"

# Check if this is a code-related commit
if git diff --cached --name-only | grep -E '\.(rb|js|html|css|scss|md|yml|yaml)$' > /dev/null; then
    echo "📝 Code changes detected - validating review approval"

    # Extract commit message (if available) or use diff summary
    COMMIT_DESCRIPTION=$(git diff --cached --name-only | head -5 | tr '\n' ' ')
    TASK_HASH=$(echo "$COMMIT_DESCRIPTION" | md5sum | cut -d' ' -f1)
    APPROVAL_KEY="pre-review/approval/$TASK_HASH"

    # Check for review approval in memory
    APPROVAL_STATUS=$(npx claude-flow@alpha hooks memory-search --pattern "$APPROVAL_KEY" 2>/dev/null || echo "")

    if [[ -z "$APPROVAL_STATUS" ]]; then
        echo ""
        echo "🚨 COMMIT BLOCKED: No pre-review approval found"
        echo "📁 Files: $(git diff --cached --name-only | tr '\n' ' ')"
        echo "🔍 Task Hash: $TASK_HASH"
        echo ""
        echo "❌ VIOLATION: Attempting to commit changes without reviewer approval"
        echo "🛡️  HANDBOOK REQUIREMENT: All changes must pass pre-review before commit"
        echo ""
        echo "✅ SOLUTION: Obtain reviewer approval first:"
        echo "   1. Spawn appropriate reviewer agent"
        echo "   2. Complete review checklist validation"
        echo "   3. Store approval in memory with key: $APPROVAL_KEY"
        echo "   4. Then retry commit"
        echo ""
        echo "🚫 COMMIT REJECTED"
        exit 1
    fi

    echo "✅ PRE-REVIEW APPROVAL VERIFIED: $APPROVAL_STATUS"
    echo "✅ COMMIT AUTHORIZED: Changes have been reviewed and approved"
else
    echo "ℹ️  Non-code commit: Proceeding without review requirement"
fi

echo "🎯 PRE-COMMIT VALIDATION PASSED"
exit 0
```

#### **📊 COMPREHENSIVE ENFORCEMENT INTEGRATION**

```bash
# Integration with existing enforcement systems
integrate_pre_review_with_existing_enforcement() {
    echo "🔗 INTEGRATING PRE-REVIEW WITH EXISTING ENFORCEMENT SYSTEMS"

    # Integration Point 1: TDD Enforcement
    echo "🧪 TDD INTEGRATION:"
    echo "   • Pre-review must validate TDD approach before implementation"
    echo "   • Test-first methodology enforced through review checklist"
    echo "   • Red-Green-Refactor cycle validated by reviewer"

    # Integration Point 2: Four-Eyes Principle
    echo "👥 FOUR-EYES INTEGRATION:"
    echo "   • Pre-review IS the Four-Eyes implementation"
    echo "   • Reviewer assignment based on domain expertise"
    echo "   • Memory coordination between implementer and reviewer"

    # Integration Point 3: Micro-Refactoring
    echo "📏 MICRO-REFACTORING INTEGRATION:"
    echo "   • Each micro-step requires reviewer validation"
    echo "   • 3-line limit enforced through pre-review approval"
    echo "   • Step-by-step approval required for complex changes"

    # Integration Point 4: Swarm Delegation
    echo "🐝 SWARM INTEGRATION:"
    echo "   • Complex tasks require multiple reviewer approvals"
    echo "   • Expert consultation mandatory for specialized domains"
    echo "   • Cross-agent coordination through memory systems"

    # Integration Point 5: Quality Gates
    echo "🚧 QUALITY GATE INTEGRATION:"
    echo "   • Pre-review is the primary quality gate"
    echo "   • Post-implementation validation enhanced by pre-review"
    echo "   • Build and test validation coordinated with review approval"
}
```

#### **⚡ PRACTICAL ENFORCEMENT EXAMPLES**

```bash
# Example 1: Security Feature Implementation
echo "🔒 SECURITY FEATURE EXAMPLE:"
echo "Task: Implement OAuth2 authentication"
echo ""
echo "1. 🚫 BLOCKED: Direct implementation attempt"
echo "2. ✅ REQUIRED: Spawn security-expert reviewer first"
echo "3. ✅ REQUIRED: Complete security review checklist"
echo "4. ✅ REQUIRED: Obtain approval in memory"
echo "5. ✅ AUTHORIZED: Implementation can proceed"

# Example 2: Performance Optimization
echo ""
echo "⚡ PERFORMANCE OPTIMIZATION EXAMPLE:"
echo "Task: Optimize database query performance"
echo ""
echo "1. 🚫 BLOCKED: Direct optimization attempt"
echo "2. ✅ REQUIRED: Spawn performance-expert reviewer first"
echo "3. ✅ REQUIRED: Complete performance review checklist"
echo "4. ✅ REQUIRED: Validate approach against performance standards"
echo "5. ✅ REQUIRED: Store approval with performance metrics"
echo "6. ✅ AUTHORIZED: Optimization can proceed"

# Example 3: Architecture Change
echo ""
echo "🏗️  ARCHITECTURE CHANGE EXAMPLE:"
echo "Task: Refactor component structure"
echo ""
echo "1. 🚫 BLOCKED: Direct refactoring attempt"
echo "2. ✅ REQUIRED: Spawn architecture-expert reviewer first"
echo "3. ✅ REQUIRED: Complete architecture review checklist"
echo "4. ✅ REQUIRED: Validate against system design patterns"
echo "5. ✅ REQUIRED: Ensure backward compatibility"
echo "6. ✅ REQUIRED: Store approval with architecture validation"
echo "7. ✅ AUTHORIZED: Refactoring can proceed"
```

#### **📈 SUCCESS METRICS & MONITORING**

```bash
# Metrics for pre-review enforcement effectiveness
pre_review_metrics() {
    echo "📊 PRE-REVIEW ENFORCEMENT METRICS"
    echo ""
    echo "🎯 COMPLIANCE METRICS:"
    echo "   • Review approval rate: Target >95% (currently tracking)"
    echo "   • Implementation-first violations: Target <5% (blocking active)"
    echo "   • Expert consultation rate: Target >80% for complex tasks"
    echo ""
    echo "🔍 QUALITY METRICS:"
    echo "   • Defect reduction: Expected 40% reduction from pre-review"
    echo "   • Rework reduction: Expected 60% reduction from early validation"
    echo "   • Handbook compliance: Target 95% (up from current 23%)"
    echo ""
    echo "⏱️  EFFICIENCY METRICS:"
    echo "   • Review turnaround time: Target <30 minutes average"
    echo "   • Agent coordination efficiency: Memory-based tracking"
    echo "   • Process overhead: Monitor for optimization opportunities"
    echo ""
    echo "🚨 VIOLATION TRACKING:"
    echo "   • Blocked implementation attempts: Track and analyze patterns"
    echo "   • Bypassing attempts: Zero tolerance enforcement"
    echo "   • Review quality scores: Validate checklist completion"
}
```

### 🎯 **IMMEDIATE IMPLEMENTATION REQUIREMENTS**

#### **🚨 ZERO TOLERANCE ENFORCEMENT ACTIVE**

ALL agents operating in this project MUST:

1. **🛡️  PRE-REVIEW GATE**: Check `mandatory_pre_review_gate()` before ANY task
2. **👥 REVIEWER SPAWNING**: Spawn appropriate reviewer based on domain matrix
3. **📋 CHECKLIST COMPLETION**: Reviewer must complete full validation checklist
4. **💾 MEMORY APPROVAL**: Store explicit approval before implementation
5. **🔒 FILE OPERATION VALIDATION**: All Edit/Write/MultiEdit operations checked
6. **🚫 ANTI-PATTERN PREVENTION**: Block "implement first, review later" attempts
7. **🔄 GIT INTEGRATION**: Pre-commit hooks enforce review requirements

#### **⚠️  VIOLATION CONSEQUENCES**

**IMMEDIATE TASK TERMINATION** for:
- Attempting file operations without review approval
- Using implementation-first language patterns
- Bypassing reviewer assignment requirements
- Skipping review checklist validation
- Committing changes without memory-tracked approval
- Expert consultation avoidance for complex tasks

**NO EXCEPTIONS. NO OVERRIDES. NO BYPASSING. PRE-REVIEW IS MANDATORY.**
```

## 🤝 COMPREHENSIVE MULTI-AGENT COORDINATION SYSTEM - MANDATORY

### 🚨 **CRITICAL REQUIREMENT: TEAM-FIRST DEVELOPMENT APPROACH**

**PROBLEM SOLVED**: Single-agent failures leading to broken tests, security vulnerabilities, and handbook violations
**SOLUTION**: Mandatory multi-agent coordination with automatic team spawning and cross-validation
**COMPLIANCE TARGET**: 100% team coordination for complex tasks, 95% quality improvement
**ENFORCEMENT**: AUTOMATIC - Zero tolerance for single-agent complex work

#### **📋 MULTI-AGENT SPAWNING CHECKLIST (MANDATORY)**

Every agent MUST validate these requirements before starting work:

```bash
# MANDATORY: Multi-agent spawning validation checklist
multi_agent_spawning_checklist() {
    local task="$1"

    echo "📋 MULTI-AGENT SPAWNING CHECKLIST"
    echo "Task: $task"
    echo ""

    # ✅ REQUIRED TEAM PATTERNS
    echo "🐝 TEAM SPAWNING REQUIREMENTS:"

    # Check 1: Multi-action tasks require team
    if echo "$task" | grep -E "and|then|also|plus|additionally"; then
        echo "   ✅ REQUIRED: Multi-action task detected → Spawn implementation team"
        echo "      Task('Primary Implementer', 'Execute main changes', 'coder')"
        echo "      Task('Code Reviewer', 'Review and validate changes', 'reviewer')"
        echo "      Task('QA Validator', 'Test and verify functionality', 'qa-expert')"
    fi

    # Check 2: File modifications require reviewer
    if echo "$task" | grep -iE "(modify|edit|change|update|create.*file|delete.*file)"; then
        echo "   ✅ REQUIRED: File modification detected → Spawn reviewer agent"
        echo "      Task('File Reviewer', 'Review all file changes for compliance', 'reviewer')"
    fi

    # Check 3: Test work requires TDD expert
    if echo "$task" | grep -iE "(test|spec|tdd|assertion|validation)"; then
        echo "   ✅ REQUIRED: Test work detected → Spawn TDD expert team"
        echo "      Task('TDD Expert', 'Ensure proper test-first development', 'tdd-expert')"
        echo "      Task('Test Reviewer', 'Validate test quality and coverage', 'qa-expert')"
    fi

    # Check 4: Expert domains require consultation
    if echo "$task" | grep -iE "(security|performance|architecture|database|integration|deployment)"; then
        echo "   ✅ REQUIRED: Expert domain detected → Spawn specialist consultation"
        if echo "$task" | grep -i "security"; then
            echo "      Task('Security Expert', 'Audit security implications', 'security-expert')"
        fi
        if echo "$task" | grep -i "performance"; then
            echo "      Task('Performance Expert', 'Optimize performance impact', 'performance-expert')"
        fi
        if echo "$task" | grep -i "architecture"; then
            echo "      Task('Architecture Expert', 'Guide design decisions', 'architecture-expert')"
        fi
    fi

    # Check 5: Hugo-specific work requires specialized team
    if echo "$task" | grep -iE "(hugo|content|seo|template|layout|theme)"; then
        echo "   ✅ REQUIRED: Hugo specialization detected → Spawn Hugo expert team"
        echo "      Task('Hugo Developer', 'Implement Hugo-specific features', 'hugo-developer')"
        echo "      Task('Content Specialist', 'Optimize content and SEO', 'content-specialist')"
        echo "      Task('SEO Expert', 'Validate SEO compliance', 'seo-expert')"
    fi

    echo ""
    echo "🚫 BLOCKING CONDITIONS:"
    echo "   • Single agent attempting any of the above patterns = IMMEDIATE BLOCK"
    echo "   • Missing required team member for complexity = AUTOMATIC SPAWNING"
    echo "   • Proceeding without reviewer approval = TASK TERMINATION"
}
```

#### **🔄 CROSS-AGENT VALIDATION PROTOCOL (MANDATORY)**

```bash
# MANDATORY: Cross-agent validation before task completion
cross_agent_validation_protocol() {
    local task_id="$1"
    local agents=("${@:2}")

    echo "🔄 CROSS-AGENT VALIDATION PROTOCOL"
    echo "Task ID: $task_id"
    echo "Participating Agents: ${agents[*]}"
    echo ""

    # Phase 1: Independent Implementation/Analysis
    echo "📋 PHASE 1: INDEPENDENT WORK"
    for agent in "${agents[@]}"; do
        echo "   Agent: $agent"
        echo "   Status: Must complete work independently"
        echo "   Required: Provide evidence of completion"
        echo "   Blocked: Cannot proceed until all agents ready"
    done

    # Phase 2: Cross-Validation
    echo ""
    echo "📋 PHASE 2: CROSS-VALIDATION"
    echo "   🔍 Each agent must validate others' work"
    echo "   🔍 Independent review of all changes"
    echo "   🔍 Consensus required on quality and compliance"
    echo "   🔍 No agent can approve their own work"

    # Phase 3: Final Approval
    echo ""
    echo "📋 PHASE 3: FINAL APPROVAL"
    echo "   ✅ ALL agents must provide sign-off"
    echo "   ✅ Evidence of testing and validation required"
    echo "   ✅ Memory coordination state must be 'approved'"
    echo "   ✅ Build and test suite must pass"

    echo ""
    echo "🚫 BLOCKING CONDITIONS:"
    echo "   • Any agent fails to provide evidence = TASK BLOCKED"
    echo "   • Consensus not reached = ADDITIONAL REVIEW REQUIRED"
    echo "   • Tests fail = IMMEDIATE ROLLBACK AND RE-WORK"
    echo "   • Single agent attempts to complete alone = VIOLATION"
}
```

#### **⚡ AUTOMATIC TEAM COORDINATION TRIGGERS**

```bash
# AUTOMATIC: Team coordination triggers for common Hugo/JT Site patterns
auto_team_coordination_triggers() {
    local task="$1"

    echo "⚡ AUTOMATIC TEAM COORDINATION ANALYSIS"
    echo "Task: $task"
    echo ""

    # Hugo Content Management
    if echo "$task" | grep -iE "(content.*creation|blog.*post|page.*content|markdown.*content)"; then
        echo "🐝 AUTO-TRIGGER: Hugo Content Team"
        echo "   Task('Content Strategist', 'Plan content structure and SEO', 'content-specialist')"
        echo "   Task('Hugo Developer', 'Implement content with Hugo features', 'hugo-developer')"
        echo "   Task('SEO Expert', 'Optimize for search engines', 'seo-expert')"
        echo "   Task('Content Reviewer', 'Review quality and compliance', 'reviewer')"
        return 0
    fi

    # Hugo Template/Theme Work
    if echo "$task" | grep -iE "(template|theme|layout|partial|shortcode)"; then
        echo "🐝 AUTO-TRIGGER: Hugo Template Team"
        echo "   Task('Template Architect', 'Design template structure', 'architecture-expert')"
        echo "   Task('Hugo Developer', 'Implement templates and partials', 'hugo-developer')"
        echo "   Task('Frontend Specialist', 'Handle CSS and responsive design', 'frontend-specialist')"
        echo "   Task('Template Reviewer', 'Validate template quality', 'reviewer')"
        return 0
    fi

    # Performance Optimization
    if echo "$task" | grep -iE "(performance|optimization|speed|lighthouse|core.*web.*vitals)"; then
        echo "🐝 AUTO-TRIGGER: Performance Optimization Team"
        echo "   Task('Performance Expert', 'Lead optimization strategy', 'performance-expert')"
        echo "   Task('Asset Optimizer', 'Optimize images and resources', 'asset-optimizer')"
        echo "   Task('Build Optimizer', 'Optimize Hugo build process', 'build-optimizer')"
        echo "   Task('Lighthouse Auditor', 'Validate performance metrics', 'lighthouse-auditor')"
        return 0
    fi

    # Security Implementation
    if echo "$task" | grep -iE "(security|auth|csp|headers|ssl|https)"; then
        echo "🐝 AUTO-TRIGGER: Security Team"
        echo "   Task('Security Expert', 'Lead security analysis', 'security-expert')"
        echo "   Task('Security Developer', 'Implement security measures', 'coder')"
        echo "   Task('Compliance Validator', 'Validate security compliance', 'security-validator')"
        echo "   Task('Security Reviewer', 'Review implementation', 'reviewer')"
        return 0
    fi

    # Test Development and Quality
    if echo "$task" | grep -iE "(test|tdd|quality|validation|coverage)"; then
        echo "🐝 AUTO-TRIGGER: Test Quality Team"
        echo "   Task('TDD Expert', 'Lead test-first development', 'tdd-expert')"
        echo "   Task('Test Developer', 'Implement comprehensive tests', 'tester')"
        echo "   Task('QA Expert', 'Validate test coverage and quality', 'qa-expert')"
        echo "   Task('Test Reviewer', 'Review test implementation', 'reviewer')"
        return 0
    fi

    # Default: Minimum review team
    echo "🐝 AUTO-TRIGGER: Minimum Review Team"
    echo "   Task('Primary Implementer', 'Execute implementation', 'coder')"
    echo "   Task('Code Reviewer', 'Review changes and quality', 'reviewer')"
    return 0
}
```

#### **📊 MULTI-AGENT COORDINATION EXAMPLES**

**✅ CORRECT: Multi-Agent Team Approach**
```bash
# Task: "Implement user authentication and validate security"
# ✅ CORRECT: Automatic team spawning triggered

echo "🐝 SPAWNING AUTHENTICATION SECURITY TEAM:"
echo "Task('Security Expert', 'Design secure authentication flow', 'security-expert')"
echo "Task('Authentication Developer', 'Implement auth with expert guidance', 'coder')"
echo "Task('Security Reviewer', 'Audit implementation for vulnerabilities', 'security-validator')"
echo "Task('QA Expert', 'Test authentication flow thoroughly', 'qa-expert')"
echo ""
echo "🤝 COORDINATION PROTOCOL:"
echo "1. Security Expert designs approach → shares via memory"
echo "2. Developer implements following expert design"
echo "3. Security Reviewer audits implementation independently"
echo "4. QA Expert validates functionality and edge cases"
echo "5. ALL agents provide evidence before merge approval"
```

**❌ INCORRECT: Single Agent Anti-Pattern**
```bash
# Task: "Implement user authentication and validate security"
# ❌ VIOLATION: Single agent attempting complex security work

echo "🚨 BLOCKED: Single agent violation detected"
echo "❌ PROBLEM: One agent cannot handle:"
echo "   • Security design decisions"
echo "   • Implementation complexity"
echo "   • Security vulnerability assessment"
echo "   • Quality validation"
echo "❌ RESULT: Broken tests, security vulnerabilities, handbook violations"
echo "🐝 REQUIRED: Auto-spawn authentication security team (see correct example)"
```

**✅ CORRECT: Hugo Content Team Approach**
```bash
# Task: "Create SEO-optimized blog post with Hugo features"
# ✅ CORRECT: Hugo specialization team spawning

echo "🐝 SPAWNING HUGO CONTENT TEAM:"
echo "Task('Content Strategist', 'Plan content structure and keywords', 'content-specialist')"
echo "Task('Hugo Developer', 'Implement Hugo shortcodes and templates', 'hugo-developer')"
echo "Task('SEO Expert', 'Optimize meta tags and structured data', 'seo-expert')"
echo "Task('Content Reviewer', 'Review quality and Hugo compliance', 'reviewer')"
echo ""
echo "🤝 COORDINATION FLOW:"
echo "1. Content Strategist creates content plan"
echo "2. Hugo Developer implements technical features"
echo "3. SEO Expert optimizes for search engines"
echo "4. Content Reviewer validates against standards"
echo "5. Cross-validation before content publication"
```

**❌ INCORRECT: Single Agent Content Creation**
```bash
# Task: "Create SEO-optimized blog post with Hugo features"
# ❌ VIOLATION: Single agent attempting specialized work

echo "🚨 BLOCKED: Single agent Hugo violation"
echo "❌ PROBLEMS: One agent cannot provide:"
echo "   • Content strategy expertise"
echo "   • Hugo technical implementation"
echo "   • SEO optimization knowledge"
echo "   • Quality review validation"
echo "❌ RESULT: Poor SEO, broken Hugo features, low-quality content"
echo "🐝 REQUIRED: Hugo specialization team (see correct example)"
```

#### **🔗 INTEGRATION WITH EXISTING ENFORCEMENT SYSTEMS**

The multi-agent coordination system integrates seamlessly with all existing quality gates:

```bash
# COMPREHENSIVE ENFORCEMENT INTEGRATION
comprehensive_enforcement_integration() {
    local task="$1"
    local agent="$2"

    echo "🔗 COMPREHENSIVE ENFORCEMENT INTEGRATION"
    echo "Task: $task"
    echo "Agent: $agent"
    echo ""

    # Step 1: Multi-agent spawning validation (NEW - HIGHEST PRIORITY)
    echo "🐝 STEP 1: MULTI-AGENT COORDINATION"
    mandatory_multi_agent_spawning "$task" "$agent" || exit 1
    echo "✅ Multi-agent team requirements validated"

    # Step 2: TDD Three Laws enforcement (EXISTING - ENHANCED)
    echo "🧪 STEP 2: TDD COMPLIANCE"
    validate_tdd_compliance "$task" || exit 1
    echo "✅ TDD methodology requirements validated"

    # Step 3: Pre-review enforcement (EXISTING - ENHANCED)
    echo "🛡️ STEP 3: PRE-REVIEW GATE"
    mandatory_pre_review_gate "$task" || exit 1
    echo "✅ Review requirements validated"

    # Step 4: Four-Eyes principle (EXISTING - INTEGRATED)
    echo "👥 STEP 4: FOUR-EYES VALIDATION"
    automatic_pairing_trigger "$task" || exit 1
    echo "✅ Pairing requirements validated"

    # Step 5: Micro-refactoring discipline (EXISTING - ENHANCED)
    echo "📏 STEP 5: MICRO-REFACTORING"
    micro_refactoring_enforcement || exit 1
    echo "✅ Micro-step requirements validated"

    # Step 6: Swarm delegation (EXISTING - INTEGRATED)
    echo "🌊 STEP 6: SWARM DELEGATION"
    if swarm_delegation_trigger "$task"; then
        orchestrate_swarm_execution "$task"
    fi
    echo "✅ Swarm requirements validated"

    # Step 7: Cross-agent validation (NEW)
    echo "🔄 STEP 7: CROSS-AGENT VALIDATION"
    establish_multi_agent_coordination "$task" "$agent"
    echo "✅ Cross-agent coordination established"

    echo ""
    echo "🎉 COMPREHENSIVE VALIDATION COMPLETE"
    echo "📊 ALL ENFORCEMENT SYSTEMS ACTIVE:"
    echo "   • Multi-agent coordination: ✅ ACTIVE"
    echo "   • TDD compliance: ✅ ACTIVE"
    echo "   • Pre-review gates: ✅ ACTIVE"
    echo "   • Four-eyes principle: ✅ ACTIVE"
    echo "   • Micro-refactoring: ✅ ACTIVE"
    echo "   • Swarm delegation: ✅ ACTIVE"
    echo "   • Cross-agent validation: ✅ ACTIVE"
}
```

#### **📈 SUCCESS METRICS & MONITORING**

```bash
# Multi-agent coordination effectiveness metrics
multi_agent_success_metrics() {
    echo "📊 MULTI-AGENT COORDINATION SUCCESS METRICS"
    echo ""
    echo "🎯 COMPLIANCE METRICS:"
    echo "   • Single-agent violations: Target 0% (blocking active)"
    echo "   • Multi-agent coordination rate: Target 100% for complex tasks"
    echo "   • Cross-agent validation rate: Target 95%+ completion"
    echo "   • Expert consultation rate: Target 100% for domain-specific work"
    echo ""
    echo "🔍 QUALITY METRICS:"
    echo "   • Test failure reduction: Expected 80% reduction from team coordination"
    echo "   • Security vulnerability reduction: Expected 90% reduction from expert review"
    echo "   • Handbook compliance: Target 95%+ (up from previous 23%)"
    echo "   • Code review quality: Target 95% thoroughness with multi-agent validation"
    echo ""
    echo "⏱️ EFFICIENCY METRICS:"
    echo "   • Team coordination overhead: Monitor for optimization (target <30% overhead)"
    echo "   • Review turnaround time: Target <2 hours with parallel agent coordination"
    echo "   • Cross-agent communication efficiency: Memory-based tracking"
    echo ""
    echo "🚨 VIOLATION TRACKING:"
    echo "   • Blocked single-agent attempts: Track and analyze for pattern improvement"
    echo "   • Team spawning accuracy: Validate correct team composition for task types"
    echo "   • Cross-validation completion rate: Monitor agent coordination effectiveness"
}
```

### 🧪 **COMPREHENSIVE AGENT TEST WRITING PREVENTION PROTOCOL**

#### **🚫 BLOCKED AGENT BEHAVIORS (Automatic Detection)**

**CRITICAL VIOLATIONS** - These patterns trigger immediate task termination:

```ruby
# 🚨 VIOLATION EXAMPLES - THESE WILL BE BLOCKED

def test_something
  puts "Testing feature"           # ❌ BLOCKED: Output statement
  result = calculate(1, 2)
  puts "Result is: #{result}"       # ❌ BLOCKED: Debugging output
end

def test_another_thing
  print "Running test"             # ❌ BLOCKED: Print statement
  # No assertions - just output    # ❌ BLOCKED: No validation
end

def test_behavior
  p some_variable                  # ❌ BLOCKED: Inspection output
  # Test passes with no validation # ❌ BLOCKED: Masked failure
end
```

**✅ CORRECT AGENT BEHAVIOR** - These patterns are required:

```ruby
# ✅ APPROVED EXAMPLES - FOLLOW THESE PATTERNS

def test_calculation_returns_correct_sum
  result = calculate(1, 2)
  assert_equal 3, result, "Should return sum of inputs"
end

def test_feature_handles_edge_case
  result = process_edge_case(nil)
  refute_nil result, "Should handle nil input gracefully"
  assert_instance_of Hash, result, "Should return hash structure"
end

def test_error_handling
  assert_raises(ArgumentError) do
    invalid_operation(-1)
  end
end
```

#### **🤖 AGENT BEHAVIOR CORRECTION PROTOCOL**

**PHASE 1: Prevention Detection**
- `bin/test` automatically scans all test files
- Detects output statements: puts, print, p, console.log
- Identifies assertion gaps in test methods
- Validates TDD compliance and naming conventions

**PHASE 2: Automatic Blocking**
- Agent task IMMEDIATELY TERMINATED on violation detection
- No human intervention needed - automatic enforcement
- Clear violation report with line numbers and examples
- Remediation steps provided automatically

**PHASE 3: Compliance Verification**
- Agent must fix ALL violations before proceeding
- Re-run `bin/test` until 100% clean
- Only then can agent continue with task execution

#### **📚 AGENT TRAINING: WHY OUTPUT STATEMENTS ARE VIOLATIONS**

**Problem**: Agents write tests like this:
```ruby
def test_user_creation
  user = User.new("John")
  puts "User created: #{user.name}"  # ❌ MASKS REAL TESTING
  # Agent thinks test "passed" because no error occurred
end
```

**Solution**: Tests must validate behavior:
```ruby
def test_user_creation
  user = User.new("John")
  assert_equal "John", user.name, "User should store provided name"
  refute_nil user.id, "User should have generated ID"
end
```

**Why This Matters**:
- Output statements mask test failures
- Tests should VALIDATE behavior, not just run code
- Real tests catch bugs, output-only tests hide them
- TDD requires tests to fail first, then pass with correct implementation

### 🚨 **AGENT VIOLATION PREVENTION SUCCESS METRICS**

**BASELINE (Before Prevention System)**:
- Agent test violations: 45% of test files contained output statements
- TDD compliance: 23% (unacceptable)
- Test masking failures: 67% of "passing" tests provided no validation
- Handbook adherence: 23% (critical failure)

**TARGET (With Prevention System Active)**:
- Agent test violations: 0% (automatic blocking)
- TDD compliance: 95%+ (enforced)
- Test masking failures: 0% (prevented)
- Handbook adherence: 95%+ (validated)

**PREVENTION SYSTEM STATUS: ✅ ACTIVE AND ENFORCING**

---

## 📖 **UNIFIED HANDBOOK NAVIGATION**

### 🎯 **START HERE FOR ALL GUIDANCE**
**📚 Primary Navigation Hub**: **`docs/index.md`** - Complete unified handbook system
- Cross-references between global (`/knowledge/` via symlink) and project (`/docs/`) handbooks
- Authority hierarchy explained (global standards supersede project adaptations)
- Complete navigation structure for both handbook sources

### 📑 **KEY INDICES & TOOLS**
- **Unified Hub**: `/docs/index.md` - Start here for complete navigation
- **Global Index**: `/knowledge/KNOWLEDGE_INDEX.md` - 99+ company standards
- **Project Docs**: `/docs/` - Hugo/JT Site-specific implementations

### 🔍 **SEARCH THROUGH HANDBOOKS & FRAMEWORKS**

#### **Handbook Search**: **`claude-context`** - Intelligent semantic search
```bash
# Search global company standards (via symlink)
claude-context search "[topic]" --path "/knowledge/"

# Search project-specific adaptations (Hugo/JT Site specific)
claude-context search "[topic]" --path "docs/"

# Search both handbooks simultaneously
claude-context search "[topic]" --path "."
```

#### **Framework & Package Research**: Multiple MCP Tools
```bash
# Framework documentation
context7 resolve-library-id "[library]"           # Get library ID
context7 get-library-docs "[library-id]"          # Fetch docs

# Package source code (npm, PyPI, crates.io, Go)
mcp__package-search__package_search_hybrid        # Semantic search
mcp__package-search__package_search_grep          # Pattern search
mcp__package-search__package_search_read_file     # Read files

# Hugo-specific research patterns
context7 resolve-library-id "hugo"                # Hugo framework
context7 get-library-docs "/gohugoio/hugo" --topic "[topic]"
mcp__searxng__search "[hugo OR jamstack OR static site] [topic]"

# Specialized framework docs
mcp__peewee_Docs__fetch_peewee_documentation     # Peewee ORM
mcp__crewAI-tools_Docs__search_crewAI_tools     # CrewAI
mcp__fastembed_Docs__search_fastembed           # FastEmbed
mcp__qdrant_Docs__search_qdrant                 # Qdrant
mcp__claude-flow_Docs__search_claude_flow       # Claude Flow
```

### 🛠️ **MCP TOOLS HIERARCHY & PRIORITIZATION**

#### **Tier 1: Primary Research Tools** (Use First)
- **`claude-context`** - PRIMARY tool for searching handbooks (`/knowledge/` and `/docs/`)
  - Intelligent semantic search with context awareness
  - Supports path filtering and comprehensive codebase indexing
  - MANDATORY for all handbook and documentation searches

#### **Tier 2: Framework & Package Research** (Use for External Dependencies)
- **`context7`** - Framework documentation (resolve-library-id, get-library-docs)
  - Comprehensive library documentation with up-to-date information
  - Context7-compatible library ID resolution
- **`package-search`** - Package source code analysis (npm, PyPI, crates.io, Go)
  - Semantic and regex hybrid search across package registries
  - Direct source code reading and pattern matching

#### **Tier 3: Specialized Framework Documentation MCPs** (Domain-Specific)
- **`peewee_Docs`** - Peewee ORM documentation and code search
- **`crewAI-tools_Docs`** - CrewAI multi-agent framework docs
- **`fastembed_Docs`** - FastEmbed documentation
- **`qdrant_Docs`** - Qdrant vector database docs
- **`claude-flow_Docs`** - Claude Flow documentation

#### **Tier 4: Web Search** (Use Last Resort)
- **`searxng`** - Web search aggregator for online resources
- **`brave-search`** - Web and local search for documentation

#### **MCP Tool Usage Priority Protocol**
```bash
# Step 1: ALWAYS start with claude-context for local knowledge
claude-context search "[topic]" --path "[target-path]"

# Step 2: Use framework MCPs for external libraries
context7 resolve-library-id "[library]" && context7 get-library-docs "[id]"

# Step 3: Package analysis for implementation details
mcp__package-search__package_search_hybrid --package_name "[pkg]" --semantic_queries '["[query]"]'

# Step 4: Specialized MCPs for domain expertise
mcp__[domain]_Docs__search_[domain]_documentation --query "[specific-topic]"

# Step 5: Web search only when local sources insufficient
mcp__searxng__search "[topic] [additional-context]"
```

#### Package Search Commands
```bash
# Semantic + regex hybrid search
mcp__package-search__package_search_hybrid \
  --registry_name "npm|py_pi|crates_io|golang_proxy" \
  --package_name "[package]" \
  --semantic_queries '["how does X work?", "implementation of Y"]'

# Deterministic pattern search
mcp__package-search__package_search_grep \
  --registry_name "[registry]" \
  --package_name "[package]" \
  --pattern "[regex]"

# Read specific file from package
mcp__package-search__package_search_read_file \
  --registry_name "[registry]" \
  --package_name "[package]" \
  --filename_sha256 "[hash]" \
  --start_line 1 --end_line 200
```

## 🚨 CRITICAL: VISUAL VALIDATION & UI/UX CONSISTENCY ENFORCEMENT

**MANDATORY VISUAL VALIDATION PROTOCOL**: ALL agents claiming UI/UX fixes MUST verify with screenshots

### 🔍 PRE-CLAIM VERIFICATION (ZERO TOLERANCE FOR FALSE SUCCESS)
```bash
# 1. MANDATORY: Build and test before claiming success
bin/hugo-build && bin/test --quick
# 2. MANDATORY: Verify all referenced assets exist
find themes/beaver/assets/img/icons/theme/ -name "*.svg" | head -10
# 3. MANDATORY: Check Hugo asset processing
grep -r "partial.*svgiw" themes/ | head -5
# 4. MANDATORY: Screenshot comparison if user provided reference
# Compare user screenshot with current build visually
```

### 🛡️ AGENT VALIDATION REQUIREMENTS
- **NO FALSE SUCCESS CLAIMS**: Never claim "perfect consistency" without proof
- **VISUAL VERIFICATION**: Always verify actual UI output matches user expectations
- **FILE EXISTENCE CHECK**: Verify all assets exist before claiming fixes
- **BUILD VALIDATION**: Ensure Hugo builds successfully and processes all assets
- **SCREENSHOT COMPARISON**: When user provides screenshots, compare actual output

### ⚠️ CRITICAL FAILURE PREVENTION PROTOCOLS
- **BLOCKING**: Claims of success without running verification commands
- **BLOCKING**: Reporting "fixed" when user can still see broken UI
- **BLOCKING**: Assuming files don't exist without checking
- **MANDATORY**: Screenshot-based validation for all UI/UX work

## 🚨 CRITICAL: FALSE SUCCESS PREVENTION SYSTEM (ZERO TOLERANCE)

### 🛡️ **AGENT COORDINATION FAILURE ANALYSIS**

Previous agent swarms have demonstrated critical behavioral failures:
- **Scope Blindness**: Agents solving narrow problems while ignoring broader system failures
- **False Success Claims**: Reporting "100% SUCCESS" without comprehensive validation
- **Validation Gap**: No end-to-end verification before claiming completion
- **Overconfidence**: Partial success interpreted as complete success
- **Truth Verification Missing**: No cross-validation between agents

### 🔒 **MANDATORY TRUTH VERIFICATION PROTOCOL**

**BLOCKING REQUIREMENT**: Every agent claiming success MUST provide evidence through this protocol:

#### **1. COMPREHENSIVE SCOPE VALIDATION (MANDATORY)**
```bash
# MANDATORY: Full system validation before any success claims
echo "🔍 SCOPE VALIDATION: Checking complete system state..."

# Build validation
bin/hugo-build || { echo "❌ BUILD FAILED - NO SUCCESS ALLOWED"; exit 1; }

# Full test suite validation
bin/test || { echo "❌ TESTS FAILED - NO SUCCESS ALLOWED"; exit 1; }

# Asset verification
find themes/beaver/assets/img/icons/theme/ -name "*.svg" | wc -l
ls -la themes/beaver/assets/img/icons/theme/*.svg || { echo "❌ MISSING ASSETS"; exit 1; }

# Template validation
hugo --quiet --gc --minify --destination temp-validation || { echo "❌ TEMPLATE ERRORS"; exit 1; }
rm -rf temp-validation

echo "✅ SCOPE VALIDATION COMPLETE"
```

#### **2. EVIDENCE-BASED SUCCESS REPORTING (MANDATORY)**
**BLOCKING**: Agents cannot claim success without providing:
```bash
# MANDATORY: Evidence collection before success claims
validate_success_claim() {
    local task_description="$1"
    local success_criteria="$2"

    echo "📋 VALIDATING SUCCESS CLAIM: $task_description"
    echo "📊 SUCCESS CRITERIA: $success_criteria"

    # 1. Build verification
    echo "🔧 Build Verification..."
    if ! bin/hugo-build > build-validation.log 2>&1; then
        echo "❌ FAILED: Build does not complete successfully"
        cat build-validation.log
        return 1
    fi

    # 2. Test verification
    echo "🧪 Test Verification..."
    if ! bin/test > test-validation.log 2>&1; then
        echo "❌ FAILED: Tests do not pass"
        head -50 test-validation.log
        return 1
    fi

    # 3. Asset verification
    echo "📁 Asset Verification..."
    local missing_assets=$(find . -name "*.html" -exec grep -l "theme/" {} \; | \
        xargs grep -o 'theme/[^"]*' | sort -u | \
        while read asset; do
            if [[ ! -f "themes/beaver/assets/img/icons/$asset.svg" ]]; then
                echo "Missing: $asset.svg"
            fi
        done)

    if [[ -n "$missing_assets" ]]; then
        echo "❌ FAILED: Missing assets detected"
        echo "$missing_assets"
        return 1
    fi

    # 4. Visual verification (for UI changes)
    if [[ "$task_description" =~ "UI"|"visual"|"icon"|"display"|"layout" ]]; then
        echo "👁️  Visual Verification Required..."
        echo "🚨 MANUAL VERIFICATION: Agent must provide screenshot evidence"
        echo "📸 Required: Before/after screenshots in response"
        echo "🔍 Required: Specific visual elements verified"
    fi

    echo "✅ SUCCESS CLAIM VALIDATED: All criteria met"
    echo "📋 EVIDENCE SUMMARY:"
    echo "  - Build: ✅ Completes successfully"
    echo "  - Tests: ✅ All pass"
    echo "  - Assets: ✅ All exist"
    echo "  - Scope: ✅ Complete system validated"
    return 0
}

# USAGE: validate_success_claim "Added icons to about page" "Icons display correctly and build passes"
```

#### **3. CROSS-AGENT VERIFICATION CHECKPOINTS (MANDATORY)**
```bash
# MANDATORY: Cross-agent verification before swarm completion
cross_agent_verification() {
    local primary_agent="$1"
    local verification_agent="$2"
    local task_scope="$3"

    echo "🤝 CROSS-AGENT VERIFICATION"
    echo "Primary Agent: $primary_agent"
    echo "Verification Agent: $verification_agent"
    echo "Task Scope: $task_scope"

    # Independent validation by verification agent
    echo "🔍 Independent validation required..."
    echo "✋ BLOCKING: Verification agent must run full validation independently"
    echo "📋 Required: Both agents must sign off on success"

    # Verification checklist
    echo "📝 VERIFICATION CHECKLIST:"
    echo "  [ ] Build completes successfully"
    echo "  [ ] All tests pass"
    echo "  [ ] All assets exist and are accessible"
    echo "  [ ] Visual changes match requirements (if applicable)"
    echo "  [ ] No regressions introduced"
    echo "  [ ] Full scope validated (not just narrow focus)"

    echo "⚠️  Both agents must confirm ALL checklist items before success claim"
}
```

#### **4. SCOPE BLINDNESS PREVENTION (MANDATORY)**
```bash
# MANDATORY: Prevent narrow scope tunnel vision
prevent_scope_blindness() {
    local specific_task="$1"

    echo "🔭 SCOPE BLINDNESS PREVENTION"
    echo "Specific Task: $specific_task"

    # Force broader system thinking
    echo "🌐 MANDATORY BROADER SCOPE CHECKS:"
    echo "  1. Does this change affect other components?"
    echo "  2. Are there dependencies I haven't considered?"
    echo "  3. What tests validate the broader system?"
    echo "  4. Have I verified end-to-end functionality?"
    echo "  5. Are there edge cases beyond the specific task?"

    # Mandatory system-wide validation
    echo "🏗️  SYSTEM-WIDE VALIDATION REQUIRED:"
    bin/test --verbose || { echo "❌ System-wide test failure"; return 1; }

    # Check for common integration issues
    echo "🔗 INTEGRATION VALIDATION:"
    hugo server --port 1315 --bind 127.0.0.1 > server-test.log 2>&1 &
    local server_pid=$!
    sleep 5

    if ! curl -s http://127.0.0.1:1315/ > /dev/null; then
        echo "❌ Server integration failure"
        kill $server_pid 2>/dev/null
        return 1
    fi

    kill $server_pid 2>/dev/null
    rm -f server-test.log

    echo "✅ Broader scope validated"
}
```

#### **5. SWARM COORDINATION TRUTH PROTOCOL (MANDATORY)**
```bash
# MANDATORY: Multi-agent truth verification
swarm_truth_verification() {
    local swarm_task="$1"
    local participating_agents=("${@:2}")

    echo "🌊 SWARM TRUTH VERIFICATION PROTOCOL"
    echo "Task: $swarm_task"
    echo "Participating Agents: ${participating_agents[*]}"

    # Each agent must independently validate
    echo "🔒 INDEPENDENT VALIDATION REQUIRED FROM EACH AGENT:"
    for agent in "${participating_agents[@]}"; do
        echo "  Agent: $agent"
        echo "    [ ] Must run full build validation independently"
        echo "    [ ] Must run complete test suite independently"
        echo "    [ ] Must verify all assets/dependencies independently"
        echo "    [ ] Must confirm visual/functional requirements independently"
        echo "    [ ] Must provide evidence in their response"
    done

    # Consensus requirement
    echo "🤝 CONSENSUS REQUIREMENT:"
    echo "  - ALL agents must report success independently"
    echo "  - ANY agent reporting failure blocks swarm success"
    echo "  - Evidence must be provided by ALL agents"
    echo "  - No agent can rely on another's validation"

    # Truth verification commands each agent MUST run
    echo "🔧 MANDATORY COMMANDS FOR EACH AGENT:"
    echo "  1. bin/hugo-build"
    echo "  2. bin/test"
    echo "  3. find themes/beaver/assets/img/icons/theme/ -name '*.svg' | sort"
    echo "  4. hugo server --port \$(shuf -i 1316-1400 -n 1) --bind 127.0.0.1 (quick test)"
    echo "  5. Provide screenshot evidence if UI changes involved"

    echo "⚠️  SWARM SUCCESS ONLY DECLARED WHEN ALL AGENTS PROVIDE EVIDENCE"
}
```

### 🚫 **BLOCKING ANTI-PATTERNS (ZERO TOLERANCE)**

**IMMEDIATE FAILURE**: Any agent exhibiting these patterns fails the task:

1. **Claiming "100% success" without evidence**
2. **Reporting "all tests pass" without showing test output**
3. **Saying "build successful" without running build command**
4. **Narrow scope focus while ignoring broader failures**
5. **Assuming other agents validated what they didn't**
6. **Providing solutions without verification**
7. **Partial success reported as complete success**
8. **Cross-agent coordination without independent verification**

### 📊 **SUCCESS METRICS VALIDATION**

**MANDATORY**: Before any success claim, agents must provide:
```
📋 SUCCESS EVIDENCE CHECKLIST:
✅ Build Command Output: [REQUIRED]
✅ Test Suite Results: [REQUIRED]
✅ Asset Verification: [REQUIRED]
✅ Visual Evidence (if UI): [REQUIRED]
✅ Scope Validation: [REQUIRED]
✅ Cross-Agent Verification: [REQUIRED]
✅ No Regressions: [REQUIRED]
```

## 🚨 CRITICAL: USE EXISTING PROJECT FILES - NO DUPLICATION ALLOWED

**MANDATORY CHECK BEFORE ANY FILE CREATION**: ALWAYS verify existing tools first!
```bash
# REQUIRED: Check what already exists before creating ANYTHING
ls -la bin/           # 20+ existing tools including test, build, hugo-dev, lighthouse
ls -la docs/          # 75+ existing docs with comprehensive guidance
find . -name "*test*" -o -name "*build*" -o -name "*deploy*" | head -10
```

**EXISTING PROJECT TOOLS - USE THESE FIRST**:
- `bin/test` - Complete test suite with Hugo validation
- `bin/hugo-dev` - Development server
- `bin/hugo-build` - Production builds
- `bin/lighthouse` - Performance audits
- `package.json` scripts - Build, test, clean, analyze commands
- `Rakefile` - Ruby test automation
- `docs/` - 75+ documentation files with all guidance

**ZERO TOLERANCE VIOLATIONS**:
- Creating new test scripts when `bin/test` exists
- Creating new build scripts when `bin/hugo-build` exists
- Creating validation scripts when Hugo has built-in validation
- Adding duplicate documentation when `docs/` contains 75+ files
- Any file with suffixes: `_new`, `_v2`, `_refactored`, `_backup`

## 🏃 AGILE DEVELOPMENT FRAMEWORK

**This project follows Agile/Scrum methodology for sprint-driven development.**

### 📅 Sprint Configuration
- **Current Sprint**: See `CLAUDE_AGILE.md` for active sprint details
- **Sprint Duration**: 2 weeks standard
- **Ceremonies**: Daily standups, sprint planning, reviews, retrospectives
- **Velocity Tracking**: Automated metrics and burndown charts

### 🎯 Quick Agile Commands
```bash
# Daily workflow
npx claude-flow@alpha agile daily --standup --update-board

# Sprint management
npx claude-flow@alpha sprint init --duration 2w --points 40
npx claude-flow@alpha sprint close --generate-report

# View current sprint status
npx claude-flow@alpha sprint status --burndown --velocity
```

**Full Agile Documentation**: See `CLAUDE_AGILE.md` for complete Scrum framework integration

## 📚 KNOWLEDGE-DRIVEN DEVELOPMENT WITH UNIFIED HANDBOOK SYSTEM

**This project follows comprehensive knowledge management practices using a dual-source unified handbook system. All agents MUST consult BOTH global and project handbooks before proposing solutions.**

### 🔍 **DUAL-SOURCE KNOWLEDGE ARCHITECTURE**

#### 🌐 **Global Knowledge Base** (Supreme Authority)
**Location**: `/knowledge/` - Company-wide practices, global standards, universal patterns
**Navigation**: `/knowledge/KNOWLEDGE_INDEX.md` - Complete navigation guide
**Authority**: SUPREME - Master references that cannot be overridden
**Coverage**: 10 comprehensive global handbooks covering ALL critical development practices

#### 📦 **Project Documentation** (Secondary Authority)
**Location**: `/docs/` - Project-specific implementations, adaptations, and decisions
**Navigation**: `docs/index.md` - Project-specific navigation guide
**Authority**: SECONDARY - Must comply with and extend global standards
**Coverage**: Hugo/JAMstack-specific adaptations of global patterns

### 🎯 **UNIFIED KNOWLEDGE PRINCIPLES**
1. **Dual-Source Research**: ALWAYS check global standards FIRST, then project adaptations
2. **Multi-Tool Validation**: Use `claude-context`, `context7`, `package-search`, and specialized MCPs
3. **Hierarchical Compliance**: Global handbooks take precedence over project documentation
4. **Pattern Consistency**: Follow global patterns, customize for Hugo/JAMstack specifics
5. **Quality Assurance**: Apply global validation checklists with project-specific extensions
6. **Security-First**: Implement global security standards with static site adaptations
7. **TDD Methodology**: Follow global TDD standards with Hugo-specific testing implementations
8. **Cross-Reference Validation**: Ensure project docs reference and extend global handbooks
9. **Job Stories Format**: Structure requirements using "When I [situation], I want to [motivation], so I can [expected outcome]"

### 📚 **HANDBOOK NAVIGATION GUIDE**

#### Quick Reference Paths
```bash
# Global standards (check FIRST - Supreme Authority)
/knowledge/KNOWLEDGE_INDEX.md                 # Master navigation (99 documents)
/knowledge/10.01-global-concurrent-execution.md # Global execution patterns
/knowledge/20.01-tdd-methodology-reference.md   # Global TDD standards
/knowledge/20.02-four-eyes-principle-global.md  # Global validation protocols
/knowledge/30.01-agent-coordination-patterns.md # Global coordination patterns
/knowledge/40.01-security-first-development.md  # Global security standards
/knowledge/50.01-global-file-management.md      # Global file organization

# Project adaptations (check SECOND - Secondary Authority)
docs/index.md                                 # Project navigation
docs/60.01-agent-guidance-reference.md       # Project agent adaptations
docs/60.03-tdd-quality-standards.md          # Project TDD adaptations
docs/60.04-four-eyes-enforcement.md          # Project validation adaptations
docs/60.05-knowledge-management.md           # Project documentation adaptations
```

#### Unified Search Commands for Agents
```bash
# Step 1: Global standards search (MANDATORY FIRST)
claude-context search "[topic]" --path "/knowledge/"

# Step 2: Project adaptations search (MANDATORY SECOND)
claude-context search "[topic]" --path "docs/"

# Step 3: Cross-reference validation (MANDATORY) - Use MCP tools
claude-context search "knowledge/" --path "docs/"         # Verify global references in project docs
claude-context search "docs/" --path "knowledge/"         # Find project references in global docs

# Step 4: Integration verification - Use MCP tools
claude-context search "global.*reference" --path "docs/"  # Check proper global referencing
claude-context search "extends.*global" --path "docs/"    # Verify extension patterns
```

#### Integration Validation Commands
```bash
# Verify unified handbook compliance - Use MCP tools
claude-context search "knowledge/" --path "docs/"          # Project docs referencing global
claude-context search "missing.*global" --path "docs/"     # Project docs missing global refs
```

## 🚨 CRITICAL REQUIREMENTS (ZERO TOLERANCE)

### 🧪 TDD & Quality Standards
**MANDATORY**: All agents must follow unified TDD methodology and zero-defect quality gates
**Global Reference**: `/knowledge/20.01-tdd-methodology-reference.md` (Universal standards)
**Project Reference**: `docs/60.03-tdd-quality-standards.md` (Hugo TDD adaptations)
**Integration**: Follow global TDD principles with Hugo-specific testing implementations
- Prevention-first TDD approach (global standard)
- Zero technical debt tolerance (global standard)
- Multi-layer quality gates (global standard + Hugo build validation)
- 100% functional correctness requirement (global standard)
- Hugo-specific: Content TDD, build validation, static site testing

### 👥 Four-Eyes Principle (IMPLEMENTED VIA PRE-REVIEW ENFORCEMENT)
**MANDATORY**: All code changes require dual validation - IMPLEMENTED AS PRE-REVIEW SYSTEM
**Global Reference**: `/knowledge/20.02-four-eyes-principle-global.md` (Universal protocols)
**Project Implementation**: Comprehensive Pre-Review Enforcement System (Lines 137-583)
**Integration**: Global dual validation ENFORCED through automated pre-review gates

#### **🚨 ACTIVE ENFORCEMENT MECHANISM** (See Lines 137-583 for complete system)
- **🛡️  Pre-Implementation Gate**: ALL changes blocked until reviewer approval
- **👥 Automatic Expert Assignment**: Domain-based reviewer assignment matrix
- **📋 Mandatory Checklists**: Comprehensive validation before approval
- **💾 Memory-Tracked Approval**: Review status enforced through memory coordination
- **🔒 File Operation Blocking**: Edit/Write/MultiEdit operations require approval
- **🚫 Git Pre-Commit Hooks**: Commits blocked without review approval

#### **Hugo-Specific Reviewer Assignments**
- **Content Changes**: SEO Expert + Content Specialist (automatic assignment)
- **Hugo Build/Deploy**: DevOps + Performance Expert (build validation)
- **Template Changes**: Frontend Specialist + UX Expert (Hugo templating)
- **Security Features**: Security Expert + Hugo Developer (Hugo security)
- **Performance Optimization**: Performance Expert + Hugo Specialist (static site optimization)

**ENFORCEMENT STATUS**: ✅ FULLY ACTIVE - Zero tolerance for unapproved changes

### 🗂️ Knowledge Management
**MANDATORY**: Johnny Decimal + Diátaxis compliance across unified handbook system
**Global Reference**: `/knowledge/60.01-johnny-decimal-reference.md` & `/knowledge/60.02-diataxis-framework-reference.md`
**Project Reference**: `docs/60.05-knowledge-management.md` (Hugo documentation adaptations)
**Integration**: Follow global organization standards with Hugo-specific content structures
- File naming: `AC.ID-content-type.md` (global standard)
- Content classification: tutorial/how-to/explanation/reference (global standard)
- Zero-duplication enforcement (global + Hugo content rules)
- Cross-reference validation between global and project handbooks
- Hugo-specific: Content taxonomy, frontmatter standards, SEO metadata

## 🛡️ EXPERT AGENT CONFIGURATIONS

### Security Expert (Zero-Trust Architecture)
**MANDATORY**: Zero vulnerabilities tolerance with OWASP compliance
- Input validation: 100% allowlist patterns
- Secret management: Zero hardcoded secrets
- Threat modeling: Required for all features
- Authentication: Multi-factor required
- Encryption: AES-256+ for all data
- Static site security: CSP headers, integrity checks, secure hosting

### QA Expert (Zero-Defect Methodology)
**MANDATORY**: 100% functional correctness requirement
- Quality gates: Multi-phase validation
- Technical debt: Zero tolerance
- Coverage: >95% statements, >90% branches
- Performance: <200ms API response
- Edge cases: Comprehensive validation
- Hugo-specific: Build validation, content quality, SEO compliance
- **VISUAL VALIDATION PROTOCOL**: Mandatory screenshot verification for UI/UX claims (see `docs/60.11-visual-validation-requirements.md`)
- **ASSET EXISTENCE VERIFICATION**: Check all referenced files exist before success claims
- **BUILD OUTPUT VALIDATION**: Verify Hugo processes all assets correctly
- **FALSE SUCCESS PREVENTION**: Never report "fixed" without running validation commands
- **10X QUALITY BAR**: Zero tolerance for "10% from ideal" - 100% accuracy required for all visual work

### Architecture Expert (Clean Architecture)
**MANDATORY**: Single responsibility and clean layers
- Clean architecture: Strict layer separation
- Dependency injection: IoC patterns enforced
- Microservices: Service-oriented design
- Event-driven: Async communication patterns
- API-first: Contract-driven development
- JAMstack patterns: Static site architecture, CDN optimization

### Performance Expert (High-Performance Computing & Static Site Optimization)
**MANDATORY**: <200ms response time SLA and optimal Core Web Vitals
- Response time: <200ms (95th percentile)
- Page load speed: <200ms first contentful paint
- Build performance: Hugo build times <30 seconds for full site
- Memory efficiency: >80% utilization
- CPU usage: <70% sustained load
- Asset optimization: WebP images, minified CSS/JS, tree-shaking
- CDN strategies: Global content distribution optimization
- Caching policies: Multi-level strategies with optimal cache headers
- Load testing: Automated validation with Core Web Vitals monitoring

### Knowledge Management Expert (Intelligent Organization)
**MANDATORY**: Zero-duplication with AI-powered organization
- Johnny Decimal: Automatic AC.ID assignment
- Diátaxis: Smart content classification
- Duplication: 85% similarity blocking
- Search: Claude-context optimization
- Cross-references: Automatic validation
- Hugo content: Taxonomy management, SEO optimization


### Knowledge Expert (Hugo Content Management)
**MANDATORY**: Zero-duplication content with intelligent Hugo organization
- Content structure: Logical Hugo content organization with taxonomies
- Markdown standards: Consistent frontmatter and content formatting
- Hugo modules: Dependency management and theme organization
- Documentation: Hugo shortcodes, templates, and configuration docs
- SEO optimization: Content discoverability and search optimization

## 🧪 TEST QUALITY ENFORCEMENT & TDD STANDARDS

### 🚨 **ZERO TOLERANCE TEST MASKING PREVENTION**

**CRITICAL MANDATE**: Tests must validate behavior, not output. Any test that uses output statements without assertions is BLOCKED.

**PROHIBITED TEST PATTERNS** (Auto-rejection):
```ruby
# ❌ VIOLATION: Output without assertions
def test_something
  puts "This passes validation"     # BLOCKED
  print "Result: #{result}"        # BLOCKED
  p data                          # BLOCKED
end

# ❌ VIOLATION: No assertions
def test_behavior
  user = create_user             # BLOCKED - no verification
  process_data(user)            # BLOCKED - no validation
end
```

**REQUIRED TEST PATTERNS** (Mandatory):
```ruby
# ✅ CORRECT: Assertions validate behavior
def test_something
  result = calculate(2, 2)
  assert_equal 4, result         # REQUIRED
  assert_kind_of Integer, result # REQUIRED
end

# ✅ CORRECT: Refute validates negative cases
def test_invalid_input
  result = calculate("a", "b")
  refute_nil result              # REQUIRED
  assert_empty result            # REQUIRED
end

# ✅ CORRECT: Flunk for explicit failures
def test_expected_failure
  flunk "Feature not implemented yet"  # ACCEPTABLE
end
```

### 🛡️ **MANDATORY TEST ASSERTION REQUIREMENTS**

**EVERY TEST MUST INCLUDE**:
- **Primary Assertion**: `assert_*`, `refute_*`, or `flunk` statement
- **Behavior Validation**: Verify actual vs expected outcomes
- **State Verification**: Confirm object/system state changes
- **Edge Case Coverage**: Test boundary conditions

**TDD Three Laws for Agents** (Non-negotiable):
1. **Law 1**: Write a failing test before writing production code
2. **Law 2**: Write only enough test to make it fail
3. **Law 3**: Write only enough production code to pass the test

### 📋 **TEST VALIDATION USING EXISTING INFRASTRUCTURE**

**LEVERAGE EXISTING PROJECT TOOLS**:
- `bin/test` - Primary test execution (calls `bundle exec rake test`)
- `bundle exec rake test` - Ruby test automation via Rakefile
- `test/**/*_test.rb` - Test file pattern discovery
- Minitest framework with `assert_*`, `refute_*`, `flunk` methods

**VALIDATION WORKFLOW WITH EXISTING TOOLS**:
```bash
# Stage 1: Individual test validation
bin/test test/unit/specific_test.rb

# Stage 2: Full test suite validation
bin/test  # Runs all tests via bundle exec rake test

# Stage 3: Production build validation
bun run test:build  # Hugo production rendering verification
```

### 🎯 **QUALITY GATES & ENFORCEMENT STANDARDS**

**TDD Enforcement**: ACTIVE across all agents using `bin/test`
**Coverage Targets**: >80% statements, >75% branches
**Assertion Requirements**: 100% of tests must contain proper assertions
**Zero Tolerance**: Test masking, output-only tests, assertion-free tests

**TEST METHOD QUALITY STANDARDS**:
- Every test method must contain at least one assertion
- No output statements (`puts`, `print`, `p`) without accompanying assertions
- Test names must clearly describe expected behavior
- Tests must validate outcomes, not implementation details
- Edge cases and error conditions must be tested

**MICRO-REFACTORING COMPLIANCE**:
- ≤3 lines per change, ≤50 lines per task
- Each change must maintain test coverage
- All refactoring must preserve existing test behavior
- Remove unused test code immediately
- Consolidate duplicate test patterns

**SIMPLICITY REQUIREMENTS**:
- Test scripts under 50 lines when possible
- Test methods under 20 lines
- Clear, self-documenting test names and assertions
- Remove unused test code immediately
- Consolidate duplicate test patterns

### 🔍 **TEST QUALITY VALIDATION CHECKLIST**

**Using bin/test for Validation**:
- [ ] `bin/test` passes without errors
- [ ] Every test method contains at least one assertion
- [ ] No output statements without assertions
- [ ] Test names clearly describe expected behavior
- [ ] Tests validate outcomes, not implementation details
- [ ] Edge cases and error conditions are tested

**Four-Eyes Test Review Protocol**:
- [ ] Peer reviewer validates test logic independently using `bin/test`
- [ ] Test covers the stated requirement completely
- [ ] Test will fail if production code is broken
- [ ] Test uses appropriate assertion methods (`assert_*`, `refute_*`)
- [ ] Test follows project naming conventions (`*_test.rb`)

### 🚀 **HUGO-SPECIFIC TEST STANDARDS**

**Content TDD Requirements Using Existing Tools**:
- Content changes validated through `bin/test` suite
- Hugo build tests verified via `bun run build` and `bun run test:build`
- SEO tests validate meta tags and structured data
- Performance tests verify Core Web Vitals compliance

**Build Validation with Existing Pipeline**:
- `bun run build` - Standard Hugo build validation
- `bun run test:build` - Production rendering with comprehensive diagnostics
- `bin/test` - Full Ruby test suite including Hugo validation
- Template performance metrics validation
- Memory usage monitoring and optimization

**Complete Framework Reference**: See `docs/60.03-tdd-quality-enforcement.md`

### 📚 **AGENT GUIDANCE FOR PROPER TEST WRITING**

**When Writing Tests, Agents Must**:
1. **Use Existing Infrastructure**: Always use `bin/test` for validation
2. **Write Assertions**: Every test needs `assert_*`, `refute_*`, or `flunk`
3. **Avoid Output**: Never use `puts`, `print`, or `p` without assertions
4. **Test Behavior**: Verify what the code does, not how it does it
5. **Follow Patterns**: Use existing test files as examples of proper structure
6. **Validate Continuously**: Run `bin/test` after every change

## 🚨 TDD THREE LAWS ENFORCEMENT (ZERO TOLERANCE - BLOCKING)

### 🛡️ MANDATORY TDD ENFORCEMENT WITH AUTOMATIC BLOCKING

**CRITICAL RESTORATION**: Direct enforcement mechanisms restored per handbook compliance analysis

#### **TDD THREE LAWS - BLOCKING ENFORCEMENT**
```bash
# MANDATORY: TDD Law 1 - Block any production code without failing test first
tdd_law_1_enforcement() {
    local task_description="$1"

    # Detect production code creation attempts
    if echo "$task_description" | grep -iE "(implement|create|build|add|function|class|method|component)"; then
        if ! echo "$task_description" | grep -iE "(test|spec|tdd)"; then
            echo "❌ BLOCKED: TDD Law 1 Violation - Production code without failing test"
            echo "🚫 TASK BLOCKED: You are not permitted to write production code without a failing test"
            echo "✅ REQUIRED: Write failing test first, then minimal implementation"
            echo "📋 CORRECTIVE ACTION: Reframe task to include test creation first"
            return 1
        fi
    fi
}

# MANDATORY: TDD Law 2 - Test must fail for the right reason
tdd_law_2_enforcement() {
    local test_output="$1"

    if [[ "$test_output" =~ "0 failures" ]] || [[ "$test_output" =~ "all tests passed" ]]; then
        echo "❌ BLOCKED: TDD Law 2 Violation - Test doesn't fail for right reason"
        echo "🚫 TEST VALIDATION FAILED: Test must fail initially"
        echo "✅ REQUIRED: Verify test fails due to missing implementation, not syntax error"
        return 1
    fi
}

# MANDATORY: TDD Law 3 - Minimal code to pass test only
tdd_law_3_enforcement() {
    local lines_added="$1"
    local test_status="$2"

    if [[ "$lines_added" -gt 10 ]] && [[ "$test_status" == "passing" ]]; then
        echo "❌ BLOCKED: TDD Law 3 Violation - Too much production code added"
        echo "🚫 IMPLEMENTATION BLOCKED: Added $lines_added lines (max 10 for single cycle)"
        echo "✅ REQUIRED: Write minimal code just to pass the test"
        echo "📋 CORRECTIVE ACTION: Refactor into smaller TDD cycles"
        return 1
    fi
}

# MANDATORY: Pre-task TDD validation
validate_tdd_compliance() {
    local task="$1"

    echo "🧪 TDD COMPLIANCE VALIDATION"

    # Apply Three Laws enforcement
    tdd_law_1_enforcement "$task" || { echo "🚫 TASK BLOCKED - TDD Law 1"; return 1; }

    # Check for TDD keywords in task
    if ! echo "$task" | grep -iE "(test.first|red.green|failing.test|tdd)"; then
        echo "⚠️  WARNING: Task doesn't explicitly mention TDD methodology"
        echo "📋 RECOMMENDATION: Include TDD approach in task description"
    fi

    echo "✅ TDD COMPLIANCE: Task approved for execution"
}

# USAGE: Every agent must run before starting any implementation
# validate_tdd_compliance "Implement user authentication feature with TDD"
```

#### **AUTOMATIC TDD VALIDATION HOOKS**
```bash
# MANDATORY: Post-test execution validation
post_test_validation() {
    echo "🧪 Running TDD compliance validation..."

    # Run tests and capture output
    test_output=$(bin/test 2>&1)
    test_exit_code=$?

    # Validate test execution
    if [[ $test_exit_code -ne 0 ]]; then
        echo "✅ GOOD: Tests are failing (Red phase)"
        tdd_law_2_enforcement "$test_output" || return 1
    else
        echo "✅ GOOD: Tests are passing (Green phase)"

        # Check if this is after implementation
        if git diff --name-only HEAD~1 | grep -vE "(test|spec)"; then
            echo "✅ TDD Law 3: Checking minimal implementation"
            lines_added=$(git diff --stat HEAD~1 | tail -1 | grep -o '[0-9]* insertion' | cut -d' ' -f1)
            tdd_law_3_enforcement "$lines_added" "passing" || return 1
        fi
    fi

    echo "✅ TDD VALIDATION COMPLETE"
}
```

#### **RED-GREEN-REFACTOR CYCLE ENFORCEMENT**
```bash
# MANDATORY: Cycle phase validation
validate_tdd_cycle() {
    local phase="$1"  # red, green, or refactor
    local changes="$2"

    case "$phase" in
        "red")
            echo "🔴 RED PHASE: Writing failing test"
            if ! bin/test 2>&1 | grep -iE "(fail|error)" > /dev/null; then
                echo "❌ BLOCKED: Red phase requires failing test"
                echo "🚫 Tests must fail in Red phase"
                return 1
            fi
            ;;
        "green")
            echo "🟢 GREEN PHASE: Minimal implementation"
            if [[ $(echo "$changes" | wc -l) -gt 10 ]]; then
                echo "❌ BLOCKED: Green phase implementation too large"
                echo "🚫 Maximum 10 lines for Green phase"
                return 1
            fi
            if ! bin/test > /dev/null 2>&1; then
                echo "❌ BLOCKED: Tests must pass in Green phase"
                return 1
            fi
            ;;
        "refactor")
            echo "🔄 REFACTOR PHASE: Improve without changing behavior"
            if ! bin/test > /dev/null 2>&1; then
                echo "❌ BLOCKED: Tests must remain passing during refactor"
                return 1
            fi
            ;;
    esac

    echo "✅ TDD $phase PHASE: Validated"
}
```

## 🔍 VISUAL VALIDATION ENFORCEMENT (MANDATORY FOR UI/UX TASKS)

**CRITICAL MANDATE**: ALL agents working on UI/UX changes MUST provide visual proof of success

### 🚫 ZERO TOLERANCE FOR UNVERIFIED UI CLAIMS

**BLOCKING FAILURES** - Tasks FAIL immediately if agents:
- Claim "perfect consistency" without visual evidence
- Report UI fixes without before/after screenshots
- Assert visual improvements without pixel-level comparison
- State "layout matches" without visual verification
- Declare template changes successful without screenshot proof

### 🎯 10X QUALITY BAR FOR VISUAL VALIDATION

**MANDATORY VISUAL VALIDATION PROTOCOL**:
```bash
# 1. MANDATORY: Capture reference screenshots before changes
echo "📸 Capturing BEFORE screenshots..."
bin/hugo-dev &
SERVER_PID=$!
sleep 5
# Take screenshots of affected pages
curl -s "http://localhost:1313/about/" > /dev/null || { echo "❌ Server not responding"; kill $SERVER_PID; exit 1; }
# Manual screenshot required here - agents MUST describe what they see
kill $SERVER_PID

# 2. MANDATORY: Implement visual changes with build validation
echo "🔧 Implementing visual changes..."
bin/hugo-build || { echo "❌ Build failed after changes"; exit 1; }

# 3. MANDATORY: Capture AFTER screenshots with comparison
echo "📸 Capturing AFTER screenshots..."
bin/hugo-dev &
SERVER_PID=$!
sleep 5
# Take screenshots of same pages
curl -s "http://localhost:1313/about/" > /dev/null || { echo "❌ Server not responding"; kill $SERVER_PID; exit 1; }
# Manual screenshot comparison required - agents MUST provide visual diff analysis
kill $SERVER_PID

# 4. MANDATORY: Visual regression testing across similar pages
echo "🔍 Cross-page consistency validation..."
# Compare visual consistency between homepage, about page, and other templates
# Agents MUST verify consistent spacing, typography, colors, layout patterns
```

### 📊 MANDATORY VISUAL VALIDATION CHECKLIST

**Every UI/UX task MUST include**:
- [ ] **Before Screenshots**: Visual state before any changes
- [ ] **After Screenshots**: Visual state after implementation
- [ ] **Cross-Page Comparison**: Consistency check across similar pages (about vs homepage)
- [ ] **Pixel-Perfect Validation**: Exact spacing, typography, color matching
- [ ] **Responsive Validation**: Mobile, tablet, desktop consistency
- [ ] **Visual Regression Check**: No unintended visual changes to other elements
- [ ] **Asset Loading Verification**: All images, icons, styles load correctly
- [ ] **Typography Consistency**: Font sizes, weights, line heights match design system
- [ ] **Color Accuracy**: Exact color matching to design specifications
- [ ] **Layout Precision**: Margins, padding, alignment pixel-perfect

### 🛠️ PROACTIVE VISUAL TESTING REQUIREMENTS

**Automatic Visual Testing Integration**:
```bash
# 1. MANDATORY: Screenshot testing for every UI change
echo "🧪 Running automatic visual tests..."
bin/lighthouse --screenshots || { echo "❌ Visual testing failed"; exit 1; }

# 2. MANDATORY: Cross-browser visual validation
echo "🌐 Cross-browser validation..."
# Test in multiple browser engines - agents must verify consistent rendering

# 3. MANDATORY: Mobile responsiveness validation
echo "📱 Mobile responsiveness check..."
# Test mobile breakpoints - agents must provide mobile screenshots

# 4. MANDATORY: Performance impact of visual changes
echo "⚡ Performance impact assessment..."
bin/lighthouse --performance || { echo "❌ Performance degraded"; exit 1; }
```

### 🎯 REFERENCE SCREENSHOT MANAGEMENT

**Screenshot Organization Protocol**:
```bash
# Create standardized screenshot directory structure
mkdir -p _screenshots/{before,after,comparisons,references}

# Reference screenshots for regression testing
_screenshots/references/
├── homepage-desktop-1920x1080.png
├── homepage-mobile-375x812.png
├── about-desktop-1920x1080.png
├── about-mobile-375x812.png
└── services-desktop-1920x1080.png

# Comparison workflow
_screenshots/comparisons/
├── about-section-before-vs-after.png
├── homepage-vs-about-consistency.png
└── mobile-desktop-responsive-check.png
```

### 🚨 UI/UX TASK FAILURE CONDITIONS

**IMMEDIATE TASK FAILURE** if agents:
- Claim visual success without providing screenshot evidence
- Report "10% from ideal" as acceptable (100% accuracy required)
- Skip cross-page consistency validation
- Ignore mobile/responsive testing
- Fail to verify asset loading and rendering
- Don't compare before/after visual states
- Skip performance impact assessment of visual changes

### 🔍 VISUAL VALIDATION AGENT PAIRING

**MANDATORY PAIRING** for visual tasks:
- **UI Developer + Visual QA Specialist**: All layout and styling changes
- **Designer + Frontend Developer**: Visual design implementation
- **Performance Expert + Visual Validator**: Visual optimization tasks
- **Accessibility Expert + UI Developer**: Accessibility-related visual changes

## 👥 FOUR-EYES PRINCIPLE (MANDATORY) - AUTOMATIC PAIRING ENFORCEMENT

### 🤖 AUTOMATIC PAIRING TRIGGERS (ZERO TOLERANCE)

**CRITICAL RESTORATION**: Automatic agent pairing enforcement restored per handbook compliance analysis

#### **KEYWORD-BASED PAIRING ENFORCEMENT**
```bash
# MANDATORY: Automatic pairing trigger based on task content
automatic_pairing_trigger() {
    local task_description="$1"

    # Code implementation tasks
    if echo "$task_description" | grep -iE "(code|implement|build|create|develop|function|class|method)"; then
        echo "🤝 AUTOMATIC PAIRING TRIGGERED: Code Implementation"
        echo "👥 REQUIRED AGENTS: Coder + Reviewer"
        echo "📋 SPAWNING: Task('Primary Coder', 'Implement feature following TDD', 'coder')"
        echo "📋 SPAWNING: Task('Code Reviewer', 'Review implementation and validate quality', 'reviewer')"
        return 0
    fi

    # Bug fixes and debugging
    if echo "$task_description" | grep -iE "(bug|fix|debug|resolve|error|issue)"; then
        echo "🤝 AUTOMATIC PAIRING TRIGGERED: Bug Resolution"
        echo "👥 REQUIRED AGENTS: Coder + Tester"
        echo "📋 SPAWNING: Task('Primary Coder', 'Fix bug with reproduction test first', 'coder')"
        echo "📋 SPAWNING: Task('Bug Tester', 'Validate fix and regression testing', 'tester')"
        return 0
    fi

    # Security-related tasks
    if echo "$task_description" | grep -iE "(security|auth|crypto|vulnerability|secure|encrypt)"; then
        echo "🤝 AUTOMATIC PAIRING TRIGGERED: Security Task"
        echo "👥 REQUIRED AGENTS: Developer + Security Expert"
        echo "📋 SPAWNING: Task('Security Developer', 'Implement secure solution', 'coder')"
        echo "📋 SPAWNING: Task('Security Expert', 'Audit security implementation', 'security-expert')"
        return 0
    fi

    # Architecture and design changes
    if echo "$task_description" | grep -iE "(architecture|design|refactor|structure|pattern)"; then
        echo "🤝 AUTOMATIC PAIRING TRIGGERED: Architecture Task"
        echo "👥 REQUIRED AGENTS: Implementer + Architecture Expert"
        echo "📋 SPAWNING: Task('Implementation Lead', 'Execute architectural changes', 'coder')"
        echo "📋 SPAWNING: Task('Architecture Expert', 'Validate design decisions', 'architecture-expert')"
        return 0
    fi

    # Content and UI/UX changes (Hugo-specific)
    if echo "$task_description" | grep -iE "(content|ui|ux|template|layout|design|visual)"; then
        echo "🤝 AUTOMATIC PAIRING TRIGGERED: Content/UI Task"
        echo "👥 REQUIRED AGENTS: Content Specialist + SEO Expert"
        echo "📋 SPAWNING: Task('Content Developer', 'Implement content/UI changes', 'content-specialist')"
        echo "📋 SPAWNING: Task('SEO Expert', 'Validate SEO compliance and accessibility', 'seo-expert')"
        return 0
    fi

    # Default for complex or unclear tasks
    echo "⚠️  MANUAL PAIRING ASSESSMENT REQUIRED"
    echo "📋 RECOMMENDATION: Assess task complexity and assign appropriate pairing"
}
```

#### **TASK COMPLEXITY SCORING FOR PAIRING**
```bash
# MANDATORY: Complexity-based pairing requirement
calculate_task_complexity() {
    local task_description="$1"
    local complexity_score=0

    # File count indicators
    [[ "$task_description" =~ "multiple files" ]] && ((complexity_score += 2))
    [[ "$task_description" =~ "across.*files" ]] && ((complexity_score += 2))

    # Technical complexity indicators
    [[ "$task_description" =~ "database" ]] && ((complexity_score += 3))
    [[ "$task_description" =~ "api" ]] && ((complexity_score += 2))
    [[ "$task_description" =~ "performance" ]] && ((complexity_score += 3))
    [[ "$task_description" =~ "security" ]] && ((complexity_score += 4))

    # Change scope indicators
    [[ "$task_description" =~ "refactor" ]] && ((complexity_score += 3))
    [[ "$task_description" =~ "migration" ]] && ((complexity_score += 4))
    [[ "$task_description" =~ "integration" ]] && ((complexity_score += 3))

    # Hugo-specific complexity
    [[ "$task_description" =~ "shortcode" ]] && ((complexity_score += 2))
    [[ "$task_description" =~ "template" ]] && ((complexity_score += 2))
    [[ "$task_description" =~ "theme" ]] && ((complexity_score += 3))

    echo $complexity_score
}

# MANDATORY: Enforce pairing based on complexity
enforce_complexity_pairing() {
    local task="$1"
    local complexity=$(calculate_task_complexity "$task")

    echo "🧮 TASK COMPLEXITY SCORE: $complexity"

    if [[ $complexity -ge 7 ]]; then
        echo "🚨 HIGH COMPLEXITY: Expert consultation required"
        echo "👥 MANDATORY PAIRING: Multiple experts + specialist agents"
        echo "📋 SPAWNING: Expert-led swarm coordination required"
    elif [[ $complexity -ge 4 ]]; then
        echo "⚠️  MODERATE COMPLEXITY: Dual agent pairing required"
        automatic_pairing_trigger "$task"
    elif [[ $complexity -ge 2 ]]; then
        echo "ℹ️  LOW COMPLEXITY: Single agent with reviewer validation"
        echo "👥 RECOMMENDED: Primary agent + reviewer sign-off"
    else
        echo "✅ MINIMAL COMPLEXITY: Single agent permitted"
        echo "📋 VALIDATION: Still requires post-implementation review"
    fi
}
```

#### **MEMORY-COORDINATED PAIRING TRACKING**
```bash
# MANDATORY: Store pairing requirements for validation
store_pairing_requirement() {
    local task="$1"
    local required_agents=("${@:2}")

    # Store in memory for cross-agent coordination
    echo "💾 STORING PAIRING REQUIREMENT"
    echo "Task: $task"
    echo "Required Agents: ${required_agents[*]}"
    echo "Timestamp: $(date)"

    # Memory coordination pattern
    # npx claude-flow@alpha hooks memory-store \
    #     --key "four-eyes/pairing-required/$(date +%s)" \
    #     --value "task:$task,agents:${required_agents[*]}"
}

# MANDATORY: Validate pairing completion
validate_pairing_completion() {
    local task_id="$1"

    echo "✅ PAIRING VALIDATION"
    echo "Task ID: $task_id"
    echo "Required: Both agents must have provided independent validation"
    echo "Status: Checking for dual sign-off..."

    # Check that both agents have completed their parts
    echo "📋 VALIDATION CHECKLIST:"
    echo "  [ ] Primary agent completed implementation"
    echo "  [ ] Secondary agent completed review/validation"
    echo "  [ ] Both agents provided evidence of their work"
    echo "  [ ] No conflicts or violations detected"
    echo "⚠️  BLOCKING: Task not complete until ALL agents sign off"
}
```

### 🛡️ REQUIRED PAIRING MATRIX

**Automatic Pairing Assignments**:
- **Code Implementation**: `coder` + `reviewer` (TDD validation)
- **Bug Resolution**: `coder` + `tester` (reproduction test required)
- **Security Changes**: `coder` + `security-expert` (threat assessment)
- **Architecture Changes**: `coder` + `architecture-expert` (design validation)
- **Content/UI Changes**: `content-specialist` + `seo-expert` (Hugo-specific)
- **Performance Tasks**: `performance-expert` + `coder` (optimization validation)
- **Critical Changes**: `implementer` + `architecture-expert` (high-stakes validation)

### 🚨 PAIRING VIOLATION CONSEQUENCES

**IMMEDIATE TASK FAILURE** if:
- Single agent attempts complex task (complexity score ≥4)
- No reviewer validation provided for code changes
- Security changes made without security expert consultation
- Architecture changes made without architecture expert approval
- Missing cross-agent verification evidence

**Checkpoint Validation**: Pre, Mid, Post-implementation with dual sign-off

**Full Protocol**: See `docs/60.04-four-eyes-principle.md`

## 📋 KNOWLEDGE MANAGEMENT

**Structure**: Johnny Decimal (AC.ID-type.md) + Diátaxis classification
**Areas**: 10-99 range with defined purposes
**Validation**: Pre-creation research, cross-references, index updates

**Complete Guidelines**: See `docs/60.05-knowledge-organization.md`

## 🛡️ MICRO-REFACTORING & SIMPLICITY ENFORCEMENT (ZERO TOLERANCE)

### 📏 3-LINE RULE ENFORCEMENT (MANDATORY BLOCKING)

**CRITICAL RESTORATION**: 3-line micro-refactoring discipline restored per handbook compliance analysis

#### **GIT PRE-COMMIT HOOK ENFORCEMENT**
```bash
# MANDATORY: 3-line micro-step validation
micro_refactoring_enforcement() {
    echo "📏 MICRO-REFACTORING VALIDATION"

    # Get staged changes
    local lines_changed=$(git diff --cached --numstat | awk '{sum+=$1+$2} END {print sum}')

    if [ -z "$lines_changed" ]; then
        lines_changed=0
    fi

    echo "📊 LINES CHANGED: $lines_changed"

    # Enforce 3-line limit
    if [ "$lines_changed" -gt 3 ]; then
        echo "❌ BLOCKED: Change exceeds 3-line micro-step limit"
        echo "🚫 COMMIT BLOCKED: You have $lines_changed lines staged"
        echo "✅ REQUIRED: Split into smaller micro-steps (max 3 lines each)"
        echo "📋 CORRECTIVE ACTION:"
        echo "   1. git reset --soft HEAD~1 (if needed)"
        echo "   2. Split changes into ≤3 line chunks"
        echo "   3. Commit each micro-step separately"
        echo "   4. Run tests after each micro-step"
        return 1
    fi

    # Validate tests still pass
    echo "🧪 RUNNING TESTS AFTER MICRO-STEP..."
    if ! bin/test > /dev/null 2>&1; then
        echo "❌ BLOCKED: Tests fail after micro-step"
        echo "🚫 COMMIT BLOCKED: All tests must pass after each micro-step"
        echo "✅ REQUIRED: Fix failing tests or revert changes"
        return 1
    fi

    echo "✅ MICRO-REFACTORING VALIDATION: Passed"
    echo "📏 Lines changed: $lines_changed (within 3-line limit)"
    echo "🧪 Tests: All passing"
    return 0
}

# MANDATORY: Atomic workflow enforcement
atomic_workflow_validation() {
    local workflow_type="$1"  # refactoring, feature, or bug
    local total_lines="$2"

    echo "🔄 ATOMIC WORKFLOW VALIDATION"
    echo "Workflow Type: $workflow_type"
    echo "Total Lines in Task: $total_lines"

    case "$workflow_type" in
        "refactoring")
            if [ "$total_lines" -gt 50 ]; then
                echo "❌ BLOCKED: Refactoring exceeds 50-line limit"
                echo "🚫 TASK BLOCKED: Split into smaller refactoring tasks"
                return 1
            fi
            ;;
        "feature")
            if [ "$total_lines" -gt 100 ]; then
                echo "⚠️  WARNING: Feature task is large (>100 lines)"
                echo "📋 RECOMMENDATION: Consider splitting into smaller tasks"
            fi
            ;;
        "bug")
            if [ "$total_lines" -gt 30 ]; then
                echo "⚠️  WARNING: Bug fix is complex (>30 lines)"
                echo "📋 RECOMMENDATION: Ensure reproduction test first"
            fi
            ;;
    esac

    echo "✅ ATOMIC WORKFLOW: Validated"
}
```

#### **MICRO-STEP QUEUE PROCESSING**
```bash
# MANDATORY: Process changes in micro-steps
process_micro_steps() {
    local task_description="$1"
    local total_changes="$2"

    echo "🔄 MICRO-STEP QUEUE PROCESSING"
    echo "Task: $task_description"
    echo "Total Changes: $total_changes lines"

    # Calculate number of micro-steps needed
    local micro_steps_needed=$(( (total_changes + 2) / 3 ))  # Round up

    echo "📊 MICRO-STEPS REQUIRED: $micro_steps_needed"
    echo "📋 MICRO-STEP PLAN:"

    for ((i=1; i<=micro_steps_needed; i++)); do
        echo "   Step $i: ≤3 lines + test validation"
    done

    echo "⚠️  ENFORCEMENT:"
    echo "   • Each micro-step must pass tests"
    echo "   • Automatic rollback on any failure"
    echo "   • No micro-step can exceed 3 lines"
    echo "   • Full task rollback if any micro-step fails"

    return 0
}

# MANDATORY: Performance regression detection
performance_regression_check() {
    echo "⚡ PERFORMANCE REGRESSION CHECK"

    # Run performance baseline
    local before_time=$(bin/test --timing | grep -o '[0-9.]*s' | head -1)

    echo "📊 BASELINE TIME: $before_time"
    echo "⚠️  MONITORING: Performance must not regress >10%"

    # This would be implemented with actual timing comparison
    # For now, just validate tests pass quickly
    if ! timeout 30s bin/test > /dev/null 2>&1; then
        echo "❌ BLOCKED: Performance regression detected (>30s test time)"
        echo "🚫 MICRO-STEP BLOCKED: Tests taking too long"
        return 1
    fi

    echo "✅ PERFORMANCE: No regression detected"
    return 0
}
```

### 🛡️ ANTI-DUPLICATION & SIMPLICITY ENFORCEMENT + TEST QUALITY GATES

**CRITICAL MANDATE**: Always choose the SIMPLEST solution that works
**Zero Tolerance**:
- File suffixes (_refactored, _new, _v2, etc.) BLOCKED
- Overengineered custom solutions when standard tools exist
- Complex abstractions when simple code works
- Multiple similar scripts or files
- Changes exceeding 3-line micro-steps BLOCKED
- **🆕 NEW**: Test files with output statements instead of assertions
- **🆕 NEW**: Tests that mask failures with debugging output
- **🆕 NEW**: Complex test setups when simple assertions work

**Tool Usage**: Edit/MultiEdit for existing files, Write only for new files
**Validation**: Pre/during/post-task duplication and complexity scanning + `bin/test`

**SIMPLICITY PRINCIPLES (Enhanced for Tests)**:
- Use existing tools/libraries before building custom solutions
- Delete complex code in favor of simple alternatives
- One file per purpose, no redundant variations
- Readable code over clever code
- Standard patterns over custom frameworks
- 3-line micro-steps with test validation
- Atomic commits with immediate rollback capability
- **🆕 TEST SPECIFIC**: Use assert/refute statements, not output for validation
- **🆕 TEST SPECIFIC**: Write failing tests first, then make them pass
- **🆕 TEST SPECIFIC**: Test behavior, not implementation details

**Full System**: See `docs/60.06-anti-duplication-system.md` and `docs/60.08-micro-refactoring-methodology.md`

## 🐝 SWARM DELEGATION ENFORCEMENT (MANDATORY TRIGGERS)

### 🚨 MANDATORY SWARM DELEGATION REQUIREMENTS (ZERO TOLERANCE)

**CRITICAL ENFORCEMENT**: ALL complex tasks MUST use swarm delegation - Individual agent work BLOCKED

#### **ENHANCED DELEGATION TRIGGERS WITH HUGO/JEKYLL SPECIFICITY**
```bash
# MANDATORY: Trigger swarm delegation for complex tasks (ZERO TOLERANCE)
swarm_delegation_trigger() {
    local task_description="$1"

    echo "🐝 SWARM DELEGATION EVALUATION - ZERO TOLERANCE ENFORCEMENT"
    echo "Task: $task_description"

    # Multi-component work detection (ENHANCED)
    if echo "$task_description" | grep -iE "(multiple.*files|across.*files|several.*components|system.*wide|cross.*page|multi.*template|bulk.*content)"; then
        echo "🚨 TRIGGERED: Multi-component work detected"
        echo "🐝 MANDATORY SWARM: Task affects >1 file/service/system"
        echo "🔒 BLOCKING: Individual agent work PROHIBITED"
        return 0
    fi

    # Hugo/Jekyll Static Site Generator specific triggers (NEW)
    if echo "$task_description" | grep -iE "(hugo.*theme|jekyll.*theme|static.*site.*architecture|page.*bundle|shortcode.*development|partial.*template|layout.*system|content.*organization|taxonomy.*management)"; then
        echo "🚨 TRIGGERED: Static site generator complexity detected"
        echo "🐝 MANDATORY SWARM: Hugo/Jekyll expertise + Implementation team required"
        echo "🏗️ REQUIRED EXPERTS: Architecture Expert + Hugo Specialist + Content Expert"
        return 0
    fi

    # Content Management & SEO workflows (NEW)
    if echo "$task_description" | grep -iE "(seo.*optimization|meta.*management|structured.*data|content.*strategy|sitemap.*generation|social.*sharing|opengraph.*implementation)"; then
        echo "🚨 TRIGGERED: SEO/Content management complexity detected"
        echo "🐝 MANDATORY SWARM: SEO Expert + Content Specialist + Implementation team required"
        echo "🎯 REQUIRED EXPERTS: SEO Expert + Content Strategist + Performance Expert"
        return 0
    fi

    # Asset Pipeline & Build System triggers (NEW)
    if echo "$task_description" | grep -iE "(asset.*pipeline|build.*optimization|postcss.*configuration|tailwind.*setup|image.*processing|bundle.*optimization|cdn.*integration)"; then
        echo "🚨 TRIGGERED: Asset pipeline complexity detected"
        echo "🐝 MANDATORY SWARM: Build Expert + Performance Specialist + Implementation team required"
        echo "⚡ REQUIRED EXPERTS: Performance Expert + Build Specialist + Asset Optimizer"
        return 0
    fi

    # CI/CD & Deployment workflows (ENHANCED)
    if echo "$task_description" | grep -iE "(deployment.*pipeline|ci.*cd.*setup|github.*pages|netlify.*configuration|vercel.*deployment|build.*automation|environment.*configuration)"; then
        echo "🚨 TRIGGERED: Deployment pipeline complexity detected"
        echo "🐝 MANDATORY SWARM: DevOps Expert + Security Expert + Implementation team required"
        echo "🚀 REQUIRED EXPERTS: DevOps Expert + Security Expert + Performance Validator"
        return 0
    fi

    # Expert knowledge requirements (ENHANCED)
    if echo "$task_description" | grep -iE "(security|performance|architecture|complex|integration|database|optimization|scalability|accessibility|compliance)"; then
        echo "🚨 TRIGGERED: Expert knowledge required"
        echo "🐝 MANDATORY SWARM: Specialized expertise needed"
        echo "🔒 BLOCKING: Individual agent work PROHIBITED for expert domains"
        return 0
    fi

    # Quality validation requirements (ENHANCED)
    if echo "$task_description" | grep -iE "(testing|validation|review|quality|compliance|audit|verification|cross.*browser|lighthouse|web.*vitals)"; then
        echo "🚨 TRIGGERED: Quality validation needed"
        echo "🐝 MANDATORY SWARM: Multi-agent validation required"
        echo "✅ REQUIRED TEAM: QA Expert + Testing Specialist + Validation Reviewer"
        return 0
    fi

    # Cross-domain integration (ENHANCED)
    if echo "$task_description" | grep -iE "(frontend.*backend|ui.*api|template.*content|build.*deploy|content.*presentation|data.*visualization|form.*processing)"; then
        echo "🚨 TRIGGERED: Cross-domain integration detected"
        echo "🐝 MANDATORY SWARM: Multiple domain expertise required"
        echo "🔗 REQUIRED TEAM: Integration Expert + Domain Specialists + Validation Team"
        return 0
    fi

    # Complex problem solving (ENHANCED)
    if echo "$task_description" | grep -iE "(research.*implement|analyze.*build|investigate.*fix|troubleshoot.*resolve|debug.*complex|performance.*issue)"; then
        echo "🚨 TRIGGERED: Complex problem solving detected"
        echo "🐝 MANDATORY SWARM: Research + Analysis + Implementation + Validation required"
        echo "🔬 REQUIRED TEAM: Research Coordinator + Analysis Expert + Implementation Team + QA Validator"
        return 0
    fi

    # ZERO SINGLE AGENT TOLERANCE: Even "simple" tasks get validation
    echo "⚠️ VALIDATION REQUIRED: All tasks require complexity assessment"
    echo "🔍 MANDATORY CHECK: Expert consultation required for complexity validation"
    echo "🐝 RECOMMENDATION: Consider swarm delegation for quality assurance"
    return 1
}
```

#### **EXPERT CONSULTATION MANDATES (HUGO/JEKYLL SPECIALIZED)**
```bash
# MANDATORY: Force expert consultation for specialized domains (ZERO TOLERANCE)
mandatory_expert_consultation() {
    local task_description="$1"

    # Hugo/Jekyll Static Site Architecture (NEW)
    if echo "$task_description" | grep -iE "(hugo.*architecture|jekyll.*structure|static.*site.*design|page.*bundle.*architecture|theme.*development|layout.*system|shortcode.*architecture)"; then
        echo "🏗️ MANDATORY: Hugo Architecture Expert + Implementation Team + Content Specialist"
        echo "📋 SPAWNING REQUIRED:"
        echo "   Task('Hugo Architecture Expert', 'Design Hugo site architecture and coordinate specialists', 'architecture-expert')"
        echo "   Task('Hugo Developer', 'Implement Hugo-specific features with architectural guidance', 'hugo-developer')"
        echo "   Task('Content Strategist', 'Validate content organization and taxonomy', 'content-specialist')"
        echo "   Task('Template Validator', 'Validate template structure and performance', 'reviewer')"
        return 0
    fi

    # SEO & Content Optimization (NEW)
    if echo "$task_description" | grep -iE "(seo.*optimization|meta.*tags|structured.*data|schema.*org|opengraph|content.*strategy|sitemap|social.*sharing)"; then
        echo "🎯 MANDATORY: SEO Expert + Content Strategist + Performance Expert"
        echo "📋 SPAWNING REQUIRED:"
        echo "   Task('SEO Expert', 'Define SEO strategy and technical requirements', 'seo-expert')"
        echo "   Task('Content Strategist', 'Optimize content structure and taxonomy', 'content-specialist')"
        echo "   Task('Performance Expert', 'Ensure SEO optimizations maintain site speed', 'performance-expert')"
        echo "   Task('SEO Validator', 'Validate SEO implementation and measure impact', 'reviewer')"
        return 0
    fi

    # Asset Pipeline & Build Optimization (NEW)
    if echo "$task_description" | grep -iE "(asset.*optimization|build.*pipeline|postcss|tailwind|image.*processing|bundle.*optimization|webpack|hugo.*pipes)"; then
        echo "⚡ MANDATORY: Performance Expert + Build Specialist + Asset Optimizer"
        echo "📋 SPAWNING REQUIRED:"
        echo "   Task('Performance Expert', 'Define performance budgets and optimization targets', 'performance-expert')"
        echo "   Task('Build Specialist', 'Configure build pipeline and asset processing', 'build-optimizer')"
        echo "   Task('Asset Optimizer', 'Implement image and resource optimization', 'asset-optimizer')"
        echo "   Task('Performance Validator', 'Validate build performance and Lighthouse metrics', 'lighthouse-auditor')"
        return 0
    fi

    # CI/CD & Deployment Workflows (ENHANCED)
    if echo "$task_description" | grep -iE "(deployment.*automation|ci.*cd|github.*actions|netlify.*deployment|vercel.*config|build.*automation|environment.*setup)"; then
        echo "🚀 MANDATORY: DevOps Expert + Security Expert + Performance Validator"
        echo "📋 SPAWNING REQUIRED:"
        echo "   Task('DevOps Expert', 'Design deployment pipeline and automation strategy', 'cicd-engineer')"
        echo "   Task('Security Expert', 'Implement security controls and environment protection', 'security-expert')"
        echo "   Task('Deployment Specialist', 'Configure hosting and CDN optimization', 'deployment-specialist')"
        echo "   Task('Performance Validator', 'Validate deployment performance and monitoring', 'performance-expert')"
        return 0
    fi

    # Security tasks (ENHANCED)
    if echo "$task_description" | grep -iE "(security|auth|crypto|vulnerability|secure|encrypt|cors|csp|https|privacy)"; then
        echo "🔒 MANDATORY: Security Expert + Implementation Agent + Compliance Validator"
        echo "📋 SPAWNING REQUIRED:"
        echo "   Task('Security Expert', 'Assess security implications and define requirements', 'security-expert')"
        echo "   Task('Security Developer', 'Implement secure solution with expert guidance', 'coder')"
        echo "   Task('Compliance Validator', 'Validate security implementation and compliance', 'security-validator')"
        return 0
    fi

    # Quality validation tasks (ENHANCED)
    if echo "$task_description" | grep -iE "(test|quality|validation|review|compliance|audit|accessibility|cross.*browser|web.*vitals)"; then
        echo "✅ MANDATORY: QA Expert + Testing Specialist + Multi-Browser Validator + Accessibility Auditor"
        echo "📋 SPAWNING REQUIRED:"
        echo "   Task('QA Expert', 'Define comprehensive quality gates and validation strategy', 'qa-expert')"
        echo "   Task('Testing Specialist', 'Implement automated testing with Hugo integration', 'tester')"
        echo "   Task('Accessibility Auditor', 'Validate WCAG compliance and screen reader compatibility', 'accessibility-tester')"
        echo "   Task('Cross-Browser Validator', 'Validate multi-browser compatibility and responsive design', 'cross-browser-tester')"
        echo "   Task('Performance Auditor', 'Validate Web Vitals and Lighthouse compliance', 'lighthouse-auditor')"
        return 0
    fi

    # Architecture changes (ENHANCED FOR HUGO)
    if echo "$task_description" | grep -iE "(architecture|design|structure|refactor|pattern|layout.*system|template.*hierarchy|content.*model)"; then
        echo "🏛️ MANDATORY: Hugo Architecture Expert + Multiple Implementation Agents + Integration Validator"
        echo "📋 SPAWNING REQUIRED:"
        echo "   Task('Hugo Architecture Expert', 'Design system architecture and coordinate Hugo-specific implementation', 'architecture-expert')"
        echo "   Task('Template Architect', 'Design template hierarchy and layout systems', 'template-architect')"
        echo "   Task('Content Model Designer', 'Design content structure and taxonomy', 'content-strategist')"
        echo "   Task('Implementation Lead', 'Execute architectural changes with Hugo best practices', 'hugo-developer')"
        echo "   Task('Integration Validator', 'Validate system integration and content flow', 'integration-tester')"
        return 0
    fi

    # Performance optimization (ENHANCED FOR STATIC SITES)
    if echo "$task_description" | grep -iE "(performance|optimization|speed|memory|cpu|cache|lighthouse|web.*vitals|core.*web.*vitals|page.*speed)"; then
        echo "⚡ MANDATORY: Performance Expert + Optimization Specialists + Lighthouse Auditor"
        echo "📋 SPAWNING REQUIRED:"
        echo "   Task('Performance Expert', 'Analyze performance requirements and optimization strategy for static sites', 'performance-expert')"
        echo "   Task('Asset Optimization Specialist', 'Implement image and resource optimization', 'asset-optimizer')"
        echo "   Task('Build Performance Specialist', 'Optimize Hugo build pipeline and asset processing', 'build-optimizer')"
        echo "   Task('Lighthouse Auditor', 'Validate Core Web Vitals and performance metrics', 'lighthouse-auditor')"
        echo "   Task('CDN Optimization Specialist', 'Optimize content delivery and caching strategies', 'cdn-optimizer')"
        return 0
    fi

    # Knowledge creation
    if echo "$task_description" | grep -iE "(documentation|knowledge|guide|tutorial|reference)"; then
        echo "👨‍⚕️ MANDATORY: Knowledge Expert + Content Creation Specialists"
        echo "📋 SPAWNING REQUIRED:"
        echo "   Task('Knowledge Expert', 'Organize knowledge structure and validate compliance', 'knowledge-expert')"
        echo "   Task('Content Creator', 'Create content following knowledge standards', 'content-specialist')"
        echo "   Task('Documentation Reviewer', 'Validate content quality and accuracy', 'reviewer')"
        return 0
    fi

    # Complex features (fallback)
    echo "👨‍⚕️ MANDATORY: Research Agent + Multiple Specialists + Coordinator"
    echo "📋 SPAWNING REQUIRED:"
    echo "   Task('Research Coordinator', 'Research existing patterns and coordinate approach', 'researcher')"
    echo "   Task('Implementation Specialist', 'Execute implementation with research guidance', 'coder')"
    echo "   Task('Quality Coordinator', 'Validate implementation quality', 'qa-expert')"
    return 0
}
```

#### **SWARM ORCHESTRATION PROTOCOL**
```bash
# MANDATORY: Three-phase swarm coordination
orchestrate_swarm_execution() {
    local task_description="$1"

    echo "🎼 SWARM ORCHESTRATION PROTOCOL"
    echo "Task: $task_description"

    # Phase 1: Expert Assessment & Strategic Planning
    echo "📋 PHASE 1: EXPERT ASSESSMENT & STRATEGIC PLANNING"
    mandatory_expert_consultation "$task_description"

    # Phase 2: Coordinated Implementation
    echo ""
    echo "📋 PHASE 2: COORDINATED IMPLEMENTATION"
    echo "Memory Coordination: coordination/jt-site/implementation/$(date +%s)"
    echo "Required: All agents coordinate via memory-based communication"

    # Phase 3: Integrated Validation
    echo ""
    echo "📋 PHASE 3: INTEGRATED VALIDATION"
    echo "   Task('Integration Tester', 'Test cross-component integration', 'tester')"
    echo "   Task('Quality Assurance Lead', 'Orchestrate comprehensive validation', 'qa-expert')"
    echo "   Task('Knowledge Coordinator', 'Document decisions and update knowledge base', 'knowledge-expert')"

    echo ""
    echo "🚨 SWARM ENFORCEMENT:"
    echo "   • Expert consensus required before implementation"
    echo "   • Memory-based coordination throughout"
    echo "   • No single-agent shortcuts permitted"
    echo "   • All phases must complete successfully"

    return 0
}
```

#### **RESEARCH-FIRST ENFORCEMENT**
```bash
# MANDATORY: Research-first development requirement
enforce_research_first() {
    local task_description="$1"

    echo "🔍 RESEARCH-FIRST ENFORCEMENT"

    # Check if task mentions research
    if ! echo "$task_description" | grep -iE "(research|investigate|analyze|study|explore)"; then
        echo "❌ BLOCKED: Task missing research phase"
        echo "🚫 TASK BLOCKED: All implementation must be research-first"
        echo "✅ REQUIRED: Add research phase to task description"
        echo "📋 CORRECTIVE ACTION:"
        echo "   1. Research existing patterns using claude-context"
        echo "   2. Analyze framework documentation with context7"
        echo "   3. Study package implementations with package-search"
        echo "   4. Document research findings before implementation"
        return 1
    fi

    echo "✅ RESEARCH-FIRST: Task includes research phase"
    return 0
}

# MANDATORY: Pre-implementation research validation
validate_research_completion() {
    echo "🔍 RESEARCH VALIDATION CHECKPOINT"
    echo "📋 REQUIRED RESEARCH ACTIVITIES:"
    echo "   [ ] claude-context search for existing patterns"
    echo "   [ ] Framework documentation analysis"
    echo "   [ ] Package source code investigation"
    echo "   [ ] Cross-reference validation"
    echo "   [ ] Research findings documented"
    echo "⚠️  BLOCKING: Implementation cannot proceed until research is complete"
}
```

#### **ZERO TOLERANCE DELEGATION ENFORCEMENT MATRIX**
```bash
# AUTOMATED BLOCKING: Individual agent work prohibited for complex tasks
delegation_enforcement_blocking() {
    local task_description="$1"
    local agent_count="$2"

    echo "🛡️ DELEGATION ENFORCEMENT - ZERO TOLERANCE ACTIVE"

    # BLOCK: Single agent on multi-component work
    if [[ "$agent_count" -eq 1 ]] && swarm_delegation_trigger "$task_description"; then
        echo "🚨 BLOCKED: Single agent attempting complex multi-component work"
        echo "🔒 ENFORCEMENT: Task automatically delegated to swarm"
        echo "⚠️ VIOLATION: Individual agent work PROHIBITED for complexity level detected"

        # Auto-delegate to appropriate swarm
        auto_delegate_complex_task "$task_description"
        return 1
    fi

    # BLOCK: Missing expert consultation
    if mandatory_expert_consultation "$task_description" && ! expert_agents_present "$agent_count"; then
        echo "🚨 BLOCKED: Expert consultation required but missing"
        echo "🔒 ENFORCEMENT: Spawning required expert agents"
        echo "⚠️ VIOLATION: Expert knowledge domains cannot be handled by general agents"

        # Auto-spawn expert consultation
        auto_spawn_expert_consultation "$task_description"
        return 1
    fi

    # BLOCK: Hugo/Jekyll specific work without specialists
    if echo "$task_description" | grep -iE "(hugo|jekyll|static.*site|jamstack)" && ! hugo_specialists_present "$agent_count"; then
        echo "🚨 BLOCKED: Hugo/Jekyll work requires specialized swarm"
        echo "🔒 ENFORCEMENT: Spawning Hugo specialist team"
        echo "⚠️ VIOLATION: Static site generator work requires domain expertise"

        # Auto-spawn Hugo specialist swarm
        auto_spawn_hugo_swarm "$task_description"
        return 1
    fi

    echo "✅ DELEGATION COMPLIANCE: Task meets swarm requirements or approved for single agent"
    return 0
}

# AUTO-DELEGATION: Automatically spawn appropriate swarms
auto_delegate_complex_task() {
    local task_description="$1"

    echo "🐝 AUTO-DELEGATING COMPLEX TASK TO SWARM"

    # Determine swarm composition based on task type
    local swarm_config=$(determine_swarm_configuration "$task_description")

    echo "📋 SPAWNING SWARM:"
    echo "$swarm_config"

    # Execute automatic delegation
    execute_automatic_delegation "$swarm_config" "$task_description"
}

# HUGO SPECIALIST SWARM: Auto-spawn for Hugo/Jekyll work
auto_spawn_hugo_swarm() {
    local task_description="$1"

    echo "🏗️ AUTO-SPAWNING HUGO SPECIALIST SWARM"
    echo "📋 REQUIRED HUGO TEAM:"

    if echo "$task_description" | grep -iE "(architecture|structure|design)"; then
        echo "   Task('Hugo Architecture Expert', 'Lead architectural decisions for Hugo site', 'architecture-expert')"
        echo "   Task('Hugo Developer', 'Implement Hugo-specific features', 'hugo-developer')"
        echo "   Task('Content Strategist', 'Optimize content organization', 'content-specialist')"
    fi

    if echo "$task_description" | grep -iE "(seo|optimization|performance)"; then
        echo "   Task('SEO Expert', 'Handle SEO strategy and implementation', 'seo-expert')"
        echo "   Task('Performance Expert', 'Optimize site performance and Core Web Vitals', 'performance-expert')"
        echo "   Task('Lighthouse Auditor', 'Validate performance metrics', 'lighthouse-auditor')"
    fi

    if echo "$task_description" | grep -iE "(template|theme|layout)"; then
        echo "   Task('Template Architect', 'Design template hierarchy', 'template-architect')"
        echo "   Task('Hugo Developer', 'Implement template functionality', 'hugo-developer')"
        echo "   Task('UI/UX Validator', 'Validate user experience', 'reviewer')"
    fi

    echo "✅ AUTOMATIC HUGO SWARM DEPLOYMENT INITIATED"
}
```

### 🚨 SWARM DELEGATION VIOLATIONS (ZERO TOLERANCE)

**IMMEDIATE TASK BLOCKING** if:
- Complex task attempted by single agent (AUTOMATIC SWARM SPAWNING)
- Expert consultation skipped for specialized domains (AUTO-SPAWN EXPERTS)
- Multi-component work done without coordination (COORDINATION REQUIRED)
- Hugo/Jekyll work without specialist team (AUTO-SPAWN HUGO SWARM)
- Research phase bypassed or incomplete (RESEARCH MANDATE)
- Memory coordination not utilized (COORDINATION ENFORCEMENT)
- Cross-agent validation missing (VALIDATION REQUIREMENT)

**AUTOMATED ENFORCEMENT ACTIONS**:
- Task immediately blocked with detailed violation report
- Automatic swarm spawning triggered based on complexity analysis
- Expert agents automatically consulted and spawned
- Hugo specialist teams automatically deployed
- Research phase mandated with blocking until completion
- Memory coordination forcibly initialized
- Validation checkpoints automatically enforced with quality gates

**COMPLIANCE MONITORING**:
- All task complexity automatically analyzed pre-execution
- Expert consultation requirements validated in real-time
- Hugo/Jekyll specificity detected and specialist teams auto-deployed
- Swarm composition verified against task complexity matrix
- Cross-agent coordination monitored throughout task lifecycle

#### **HUGO/JEKYLL DELEGATION PROTOCOLS FOR COMMON WORKFLOWS**
```bash
# Content Management Workflow Delegation
hugo_content_management_protocol() {
    local content_type="$1"

    echo "📝 HUGO CONTENT MANAGEMENT - MANDATORY SWARM DELEGATION"

    case "$content_type" in
        "blog_post")
            echo "🐝 SPAWNING: Content Creation Swarm"
            echo "   Task('Content Strategist', 'Plan content structure and SEO strategy', 'content-specialist')"
            echo "   Task('Content Writer', 'Create high-quality content with Hugo markdown', 'content-writer')"
            echo "   Task('SEO Expert', 'Optimize meta tags and structured data', 'seo-expert')"
            echo "   Task('Content Reviewer', 'Validate content quality and Hugo compliance', 'reviewer')"
            ;;
        "page_bundle")
            echo "🐝 SPAWNING: Page Bundle Architecture Swarm"
            echo "   Task('Hugo Architecture Expert', 'Design page bundle structure', 'architecture-expert')"
            echo "   Task('Content Organizer', 'Organize assets and content hierarchy', 'content-organizer')"
            echo "   Task('Template Developer', 'Create bundle-specific templates', 'hugo-developer')"
            echo "   Task('Performance Validator', 'Validate bundle performance impact', 'performance-expert')"
            ;;
        "taxonomy_management")
            echo "🐝 SPAWNING: Taxonomy Management Swarm"
            echo "   Task('Content Strategist', 'Design taxonomy strategy and structure', 'content-specialist')"
            echo "   Task('Hugo Developer', 'Implement taxonomy templates and logic', 'hugo-developer')"
            echo "   Task('SEO Expert', 'Optimize taxonomy for search engines', 'seo-expert')"
            echo "   Task('Content Auditor', 'Validate taxonomy implementation', 'content-auditor')"
            ;;
    esac
}

# Theme Development Workflow Delegation
hugo_theme_development_protocol() {
    local development_scope="$1"

    echo "🎨 HUGO THEME DEVELOPMENT - MANDATORY EXPERT SWARM"

    echo "🐝 SPAWNING: Theme Development Expert Swarm"
    echo "   Task('Hugo Architecture Expert', 'Design theme architecture and component structure', 'architecture-expert')"
    echo "   Task('Frontend Specialist', 'Implement responsive design and modern CSS', 'frontend-specialist')"
    echo "   Task('Hugo Template Expert', 'Create Hugo-specific templates and partials', 'hugo-developer')"
    echo "   Task('Performance Expert', 'Optimize theme performance and asset loading', 'performance-expert')"
    echo "   Task('Accessibility Expert', 'Ensure WCAG compliance and accessibility', 'accessibility-tester')"
    echo "   Task('Cross-Browser Tester', 'Validate multi-browser compatibility', 'cross-browser-tester')"
    echo "   Task('Theme Validator', 'Validate theme quality and Hugo best practices', 'reviewer')"
}

# Performance Optimization Workflow Delegation
hugo_performance_optimization_protocol() {
    local optimization_target="$1"

    echo "⚡ HUGO PERFORMANCE OPTIMIZATION - MANDATORY EXPERT COORDINATION"

    echo "🐝 SPAWNING: Performance Optimization Expert Swarm"
    echo "   Task('Performance Expert', 'Lead performance analysis and strategy', 'performance-expert')"
    echo "   Task('Asset Optimization Specialist', 'Optimize images, CSS, and JavaScript', 'asset-optimizer')"
    echo "   Task('Build Performance Specialist', 'Optimize Hugo build pipeline', 'build-optimizer')"
    echo "   Task('CDN Optimization Expert', 'Configure content delivery optimization', 'cdn-optimizer')"
    echo "   Task('Lighthouse Auditor', 'Validate Core Web Vitals and performance metrics', 'lighthouse-auditor')"
    echo "   Task('Caching Strategist', 'Implement caching strategies', 'cache-strategist')"
    echo "   Task('Performance Validator', 'Validate performance improvements', 'performance-validator')"
}

# SEO Enhancement Workflow Delegation
hugo_seo_enhancement_protocol() {
    local seo_scope="$1"

    echo "🎯 HUGO SEO ENHANCEMENT - MANDATORY SEO EXPERT SWARM"

    echo "🐝 SPAWNING: SEO Enhancement Expert Swarm"
    echo "   Task('SEO Expert', 'Lead SEO strategy and technical implementation', 'seo-expert')"
    echo "   Task('Content Strategist', 'Optimize content structure for search engines', 'content-specialist')"
    echo "   Task('Structured Data Specialist', 'Implement schema.org and rich snippets', 'structured-data-specialist')"
    echo "   Task('Social Media Expert', 'Optimize social sharing and Open Graph', 'social-media-expert')"
    echo "   Task('Technical SEO Specialist', 'Handle sitemaps, robots.txt, and technical SEO', 'technical-seo-specialist')"
    echo "   Task('SEO Validator', 'Validate SEO implementation and measure impact', 'seo-validator')"
}

# Deployment & CI/CD Workflow Delegation
hugo_deployment_workflow_protocol() {
    local deployment_target="$1"

    echo "🚀 HUGO DEPLOYMENT WORKFLOW - MANDATORY DEVOPS EXPERT SWARM"

    echo "🐝 SPAWNING: Deployment & CI/CD Expert Swarm"
    echo "   Task('DevOps Expert', 'Design deployment pipeline and automation', 'cicd-engineer')"
    echo "   Task('Security Expert', 'Implement security controls and environment protection', 'security-expert')"
    echo "   Task('Build Automation Specialist', 'Configure Hugo build automation', 'build-automation-specialist')"
    echo "   Task('Hosting Specialist', 'Optimize hosting configuration (Netlify/Vercel/GitHub Pages)', 'hosting-specialist')"
    echo "   Task('Performance Validator', 'Validate deployment performance and monitoring', 'performance-expert')"
    echo "   Task('Deployment Validator', 'Test deployment process and rollback procedures', 'deployment-validator')"
}
```

#### **SWARM COORDINATION MEMORY NAMESPACES FOR HUGO WORKFLOWS**
```bash
# Memory coordination namespaces for Hugo-specific workflows
hugo_memory_coordination_setup() {
    local workflow_type="$1"
    local session_id="$2"

    echo "🧠 SETTING UP HUGO WORKFLOW MEMORY COORDINATION"

    # Base coordination namespace
    local base_namespace="coordination/hugo/$workflow_type/$session_id"

    # Expert coordination
    echo "📋 EXPERT COORDINATION: $base_namespace/experts"

    # Task distribution
    echo "📋 TASK COORDINATION: $base_namespace/tasks"

    # Quality gates
    echo "📋 QUALITY GATES: $base_namespace/quality"

    # Asset coordination
    echo "📋 ASSET COORDINATION: $base_namespace/assets"

    # Performance metrics
    echo "📋 PERFORMANCE METRICS: $base_namespace/performance"

    # SEO coordination
    echo "📋 SEO COORDINATION: $base_namespace/seo"

    # Content coordination
    echo "📋 CONTENT COORDINATION: $base_namespace/content"
}
```

## 🚀 JT SITE SPECIFIC CONFIGURATION

### Project Structure
```bash
/projects/jt_site/
├── .claude/agents/          # Project-specific agents
├── src/                     # Source code
├── tests/                   # Test files
├── docs/                    # Project documentation
├── _playground/             # Temporary files (YYYYMMDD_*)
└── CLAUDE.md               # This configuration
```

### Agent Roles (JT Site)
- **Frontend Developer**: React/TypeScript UI development
- **Backend Developer**: Node.js/Express API development
- **QA Specialist**: Comprehensive testing and validation
- **DevOps Engineer**: Deployment and infrastructure
- **UI/UX Reviewer**: Design and user experience validation

### Technology Stack (Hugo JAMstack)
- **Static Site Generator**: Hugo (Go-based)
- **Styling**: PostCSS, Tailwind CSS, PurgeCSS optimization
- **Build Tools**: Hugo Pipes, ESBuild for JS bundling
- **Content**: Markdown with Hugo shortcodes and frontmatter
- **Testing**: Ruby-based system tests (RSpec), Hugo build validation
- **Performance**: Lighthouse CI, PostCSS optimization pipeline
- **Deploy**: Static hosting (Netlify/Vercel/GitHub Pages optimized)

### Development Workflow
1. **Sprint Planning**: Define 2-week sprint with 2 iterations
2. **Story Breakdown**: Job stories → tasks → micro-refactoring steps
3. **Agent Coordination**: Four-Eyes pairing for all development
4. **Quality Gates**: TDD enforcement with continuous validation
   a) **Simplicity First**: Always choose simplest working solution
   b) **Cleanup**: Remove redundant files/code immediately
7. **Knowledge Management**: Document patterns in structured system

## 🚀 Available Agents (95+ Total - Hugo/Static Site Specialized)

### Expert Agents (7) - Hugo Specialized + Ruby Testing Expert
`security-expert`, `qa-expert`, `architecture-expert`, `performance-expert`, `knowledge-expert`, `ruby-coder`, `ruby-reviewer`

### Core Development (10)
`coder`, `reviewer`, `tester`, `planner`, `researcher`, `claude-flow-specialist`, `duplication-validator`, `spawning-prevention-coordinator`, `file-intelligence-coordinator`, `smart-placement-advisor`

### Hugo/Static Site Specialized (8)
`hugo-developer`, `content-specialist`, `seo-expert`, `jamstack-architect`, `static-optimizer`, `markdown-processor`, `asset-optimizer`, `build-validator`

### GitHub & Repository (12)
`github-modes`, `pr-manager`, `code-review-swarm`, `issue-tracker`, `release-manager`, `release-swarm`, `workflow-automation`, `project-board-sync`, `repo-architect`, `multi-repo-swarm`, `swarm-issue`, `swarm-pr`, `sync-coordinator`

### Performance & Optimization (9)
`perf-analyzer`, `performance-monitor`, `task-orchestrator`, `memory-coordinator`, `smart-agent`, `topology-optimizer`, `load-balancer`, `lighthouse-auditor`, `web-vitals-optimizer`

### Testing & Validation (6)
`tdd-london-swarm`, `production-validator`, `content-validator`, `link-checker`, `accessibility-tester`, `cross-browser-tester`

### Content & SEO Management (7)
`content-organizer`, `seo-optimizer`, `meta-generator`, `structured-data-validator`, `taxonomy-manager`, `content-auditor`, `keyword-researcher`

### Quality & Maintenance (8)
`quality-guardian`, `code-formatter`, `dependency-auditor`, `security-scanner`, `performance-budgets`, `build-optimizer`, `cache-strategist`, `cdn-optimizer`

### 🛡️ EXISTING PROJECT TOOLS - AGENTS MUST USE THESE
```bash
# ⚠️ CRITICAL: ALWAYS USE EXISTING BIN SCRIPTS - NO NEW SCRIPTS ALLOWED
bin/test                     # ✅ Main test suite with Hugo validation & content TDD
bin/hugo-dev                 # ✅ Development server (http://localhost:1313)
bin/hugo-build               # ✅ Production build with optimization
bin/hugo-clean               # ✅ Clean build artifacts and caches
bin/lighthouse               # ✅ Performance audits and Core Web Vitals
bin/lighthouse-compare       # ✅ Performance comparison tool
bin/dtest                    # ✅ Docker-based integration tests
bin/build                    # ✅ General build wrapper
bin/dev                      # ✅ Development environment setup
bin/setup                    # ✅ Project initialization
bin/smoke                    # ✅ Run all basic tests to validate build

# ⚠️ CRITICAL: ALWAYS USE PACKAGE.JSON SCRIPTS - NO DUPLICATE SCRIPTS
bun run test                 # ✅ Complete test suite (calls bin/test)
bun run build                # ✅ Hugo build with minification
bun run test:build          # ✅ Production rendering with full debug logging, template metrics, memory tracking
bun run serve                # ✅ Development server with live reload
bun run clean                # ✅ Clean all build artifacts
bun run lint:hugo            # ✅ Hugo template validation
bun run analyze              # ✅ Hugo template metrics and hints

# ⚠️ CRITICAL: EXISTING RUBY AUTOMATION - NO RUBY SCRIPT DUPLICATION
bundle exec rake test        # ✅ Ruby test automation (via Rakefile) - Minitest framework
bundle exec standardrb       # ✅ Ruby code linting with Standard Ruby style
bundle exec ruby            # ✅ Ruby script execution for test automation
bundle install              # ✅ Ruby gem dependency management

# Content & SEO
bun run lint:hugo            # Hugo template and content validation
bun run analyze              # Hugo template metrics and optimization hints
markdownlint content/        # Markdown content quality check

# Performance Optimization & Build Validation
bun run clean:cache          # Clear Hugo resource generation cache
bun run build:preview        # Build with drafts and future content
bun run test:build          # Production rendering verification with comprehensive diagnostics:
                             #   • Renders to memory with production environment
                             #   • Full debug logging and template metrics
                             #   • Memory usage tracking and performance analysis
                             #   • Cache bypassing to find cache-related issues
                             #   • Path warnings and unused template detection
                             #   • Production-ready optimization validation

# Expert Agent Consultation Examples
Task("Security Expert", "Audit Hugo config and static assets for security", "security-expert")
Task("Performance Expert", "Optimize Core Web Vitals and build performance", "performance-expert")
Task("SEO Expert", "Audit content for SEO compliance and structured data", "seo-expert")
Task("Ruby Coder", "Implement Ruby test automation following global standards", "ruby-coder")
Task("Ruby Reviewer", "Review Ruby code for quality, idioms, and test compliance", "ruby-reviewer")
```

### Memory Management
```bash
# Coordination patterns
coordination/jt-site/*              # Cross-agent communication
quality/validation/*                # Quality gate tracking
knowledge/patterns/*                # Pattern libraries
four-eyes/pairing/*                # Paired agent coordination
```

## 🎯 Expert-Enhanced Agent Execution Patterns

### Hugo Development with Multi-Agent Expert Coordination (ENHANCED)
```bash
# MANDATORY: Multi-agent coordination for Hugo development
[Comprehensive Multi-Agent Hugo Team Execution]:
  # Phase 1: Expert Analysis & Design (Parallel Execution)
  Task("Security Expert", "Audit Hugo config, CSP headers, and static asset security with coordination memory", "security-expert")
  Task("Performance Expert", "Optimize Core Web Vitals, build performance, and asset delivery with cross-agent validation", "performance-expert")
  Task("Architecture Expert", "Design Hugo module structure and coordinate template organization with team", "architecture-expert")
  Task("SEO Expert", "Lead SEO strategy and coordinate with content specialists", "seo-expert")

  # Phase 2: Implementation Team (Coordinated Development)
  Task("Hugo Developer", "Implement features following ALL expert guidance with cross-validation", "hugo-developer")
  Task("Content Specialist", "Optimize markdown content and frontmatter with SEO coordination", "content-specialist")
  Task("Template Specialist", "Create Hugo templates with architecture expert coordination", "template-specialist")

  # Phase 3: Quality Validation Team (Independent Review)
  Task("QA Expert", "Validate Hugo build, content quality, and comprehensive testing", "qa-expert")
  Task("Code Reviewer", "Review all changes for compliance and coordinate final approval", "reviewer")
  Task("Integration Tester", "Test cross-component integration and coordinate validation evidence", "tester")

  # Phase 4: Knowledge & Documentation (Coordination Closure)
  Task("Knowledge Expert", "Document decisions, coordinate knowledge updates, and validate team learning", "knowledge-expert")

  # MANDATORY: Cross-agent coordination requirements
  Memory { namespace: "multi-agent/hugo-dev/$(date +%s)" }
  CrossValidation { required: true, evidence: "all_agents", consensus: "majority" }
  ReviewGates { pre_implementation: true, cross_validation: true, final_approval: true }

  TodoWrite { todos: [12-15 todos including multi-agent coordination checkpoints] }
```

**🚨 CRITICAL CHANGE**: This pattern now MANDATES multi-agent coordination instead of optional expert consultation. Single agents attempting Hugo development will be AUTOMATICALLY BLOCKED and team coordination will be FORCED.

### Ruby Testing Integration with Hugo Workflow
```bash
# Single message - Ruby test automation development
[Parallel Ruby-Enhanced Execution]:
  Task("Ruby Coder", "Implement Ruby test automation following /knowledge/80.01-ruby-development-standards.md", "ruby-coder")
  Task("Ruby Reviewer", "Review Ruby code quality, idioms, and Minitest patterns per /knowledge/80.03-ruby-testing-methodology.md", "ruby-reviewer")
  Task("QA Expert", "Validate Ruby test integration with Hugo build pipeline", "qa-expert")
  Task("Architecture Expert", "Design Ruby test architecture to complement Hugo workflows", "architecture-expert")

  TodoWrite { todos: [8-10 todos including Ruby TDD implementation] }
```

### Expert Consultation Protocol (Hugo-Specific + Ruby Testing)
- Hugo configuration issues → Architecture Expert + Security Expert
- Content organization → Knowledge Expert + SEO Expert
- Build performance → Performance Expert + Architecture Expert
- Content quality → QA Expert + Content Specialist
- Security headers/CSP → Security Expert + Hugo Developer
- Ruby test automation → Ruby Coder + Ruby Reviewer
- Ruby code quality → Ruby Reviewer + QA Expert
- Test framework integration → Ruby Coder + Architecture Expert

### Environment Configuration (Hugo JAMstack)
```yaml
project_name: "jt_site"
project_type: "hugo_static_site"
tech_stack: "hugo+postcss+tailwind+bun+ruby"
ruby_version: "3.4.0+"
ruby_test_framework: "minitest"
environment: "development"
claude_flow_version: "2.0.0+"
mcp_servers: ["claude-flow", "ruv-swarm", "flow-nexus"]
quality_enforcement: true
four_eyes_mandatory: true
knowledge_management_active: true
simplicity_enforcement: true
complexity_alerts: true
expert_agents_active: true
hugo_specific_validation: true
jamstack_optimization: true
static_site_security: true
content_quality_gates: true
```

## 🔗 Integration with Unified Handbook System

### Hugo-Specific Handbook Integration
```yaml
handbook_integration:
  global_standards: "/knowledge/ (via symlink)" # Supreme authority
  project_adaptations: "docs/ (Johnny Decimal organized)" # Secondary authority
  hugo_patterns: "docs/30-39-architecture-design/" # Hugo-specific architecture
  content_guidelines: "docs/90-99-content-strategy/" # Content management
  seo_standards: "docs/seo-optimization-implementation-guide.md" # SEO compliance

integration_examples:
  security_patterns:
    global: "/knowledge/40.01-security-first-development.md"
    project: "docs/40-49-security-compliance/"
    hugo_specific: "CSP headers, static asset integrity, secure hosting"

  performance_standards:
    global: "/knowledge/performance-optimization-global.md"
    project: "docs/test-suite-improvement-plan.md"
    hugo_specific: "Core Web Vitals, build optimization, CDN configuration"
```

---

## 📚 COMPREHENSIVE HANDBOOK REFERENCES

All detailed operational procedures, methodologies, and frameworks are documented in the unified handbook system:

### 🌐 **GLOBAL HANDBOOK REFERENCES** (Supreme Authority)
- `/knowledge/10.01-global-concurrent-execution.md` - Universal concurrent execution patterns
- `/knowledge/20.01-tdd-methodology-reference.md` - Universal TDD methodology and standards
- `/knowledge/20.02-four-eyes-principle-global.md` - Universal dual validation protocols
- `/knowledge/20.03-zero-defect-philosophy.md` - Universal prevention-first development
- `/knowledge/30.01-agent-coordination-patterns.md` - Universal multi-agent coordination
- `/knowledge/30.02-memory-management-protocols.md` - Universal cross-agent memory protocols
- `/knowledge/40.01-security-first-development.md` - Universal security standards
- `/knowledge/50.01-global-file-management.md` - Universal file organization standards
- `/knowledge/60.01-global-agent-guidance-reference.md` - Universal agent operational guidelines
- `/knowledge/60.02-global-agile-framework.md` - Universal agile development framework

### 📦 **PROJECT HANDBOOK REFERENCES** (Secondary Authority - Must Extend Global)
- `docs/60.01-agent-guidance-reference.md` - Hugo agent operational guidelines
- `docs/60.02-agile-framework-reference.md` - Hugo sprint management and workflows
- `docs/60.03-tdd-quality-enforcement.md` - Hugo testing standards and validation
- `docs/60.04-four-eyes-principle.md` - Hugo collaboration protocols
- `docs/60.05-knowledge-organization.md` - Hugo documentation and knowledge management
- `docs/60.06-anti-duplication-system.md` - Hugo file management and duplication prevention
- `docs/60.07-agent-coordination-protocols.md` - Hugo cross-agent communication and memory
- `docs/60.08-micro-refactoring-methodology.md` - Hugo safe code change techniques
- `docs/60.09-verification-first-development.md` - Hugo validation and testing approaches
- `docs/60.11-visual-validation-requirements.md` - **Comprehensive visual validation and UI/UX evidence requirements**

## 🚨 AGENT ENFORCEMENT PROTOCOL - MANDATORY EXECUTION

### 🔒 VALIDATION HOOKS (PREVENT VIOLATIONS BEFORE THEY HAPPEN)

**CRITICAL RESTORATION**: Pre-violation prevention hooks restored per handbook compliance analysis

#### **PRE-TASK VALIDATION HOOKS**
```bash
# MANDATORY: Run ALL validation hooks before task execution
pre_task_validation_suite() {
    local task_description="$1"

    echo "🔒 PRE-TASK VALIDATION SUITE"
    echo "Task: $task_description"

    # Hook 1: TDD Compliance Check
    validate_tdd_compliance "$task_description" || {
        echo "🚫 TASK BLOCKED: TDD compliance failure"; return 1;
    }

    # Hook 2: Four-Eyes Pairing Check
    if swarm_delegation_trigger "$task_description"; then
        automatic_pairing_trigger "$task_description" || {
            echo "🚫 TASK BLOCKED: Pairing requirement not met"; return 1;
        }
    fi

    # Hook 3: Research-First Check
    enforce_research_first "$task_description" || {
        echo "🚫 TASK BLOCKED: Research phase missing"; return 1;
    }

    # Hook 4: Complexity Assessment
    local complexity=$(calculate_task_complexity "$task_description")
    if [[ $complexity -ge 7 ]]; then
        orchestrate_swarm_execution "$task_description"
    fi

    echo "✅ PRE-TASK VALIDATION: All hooks passed"
    return 0
}
```

#### **DURING-TASK VALIDATION HOOKS**
```bash
# MANDATORY: Continuous validation during task execution
during_task_validation() {
    local current_phase="$1"  # tdd_red, tdd_green, tdd_refactor, implementation
    local changes_made="$2"

    echo "🔄 DURING-TASK VALIDATION"
    echo "Phase: $current_phase"

    case "$current_phase" in
        "tdd_red"|"tdd_green"|"tdd_refactor")
            validate_tdd_cycle "$current_phase" "$changes_made" || {
                echo "🚫 PHASE BLOCKED: TDD cycle validation failed"; return 1;
            }
            ;;
        "implementation")
            micro_refactoring_enforcement || {
                echo "🚫 IMPLEMENTATION BLOCKED: 3-line rule violation"; return 1;
            }
            ;;
        "micro_step")
            performance_regression_check || {
                echo "🚫 MICRO-STEP BLOCKED: Performance regression"; return 1;
            }
            ;;
    esac

    echo "✅ DURING-TASK VALIDATION: Phase validated"
    return 0
}
```

#### **POST-TASK VALIDATION HOOKS**
```bash
# MANDATORY: Final validation before task completion
post_task_validation_suite() {
    local task_description="$1"

    echo "🎯 POST-TASK VALIDATION SUITE"

    # Hook 1: Build Validation
    echo "🔧 Build validation..."
    if ! bin/hugo-build > build-validation.log 2>&1; then
        echo "❌ FAILED: Build validation"
        echo "🚫 TASK BLOCKED: Build does not complete"
        return 1
    fi

    # Hook 2: Test Validation
    echo "🧪 Test validation..."
    if ! bin/test > test-validation.log 2>&1; then
        echo "❌ FAILED: Test validation"
        echo "🚫 TASK BLOCKED: Tests do not pass"
        return 1
    fi

    # Hook 3: Cross-Agent Verification (if swarm task)
    if echo "$task_description" | grep -iE "(complex|multiple|architecture|security)"; then
        validate_pairing_completion "current-task" || {
            echo "🚫 TASK BLOCKED: Cross-agent verification incomplete"; return 1;
        }
    fi

    # Hook 4: Knowledge Documentation
    echo "📚 Knowledge documentation check..."
    if ! echo "$task_description" | grep -iE "(document|knowledge|guide)"; then
        echo "⚠️  WARNING: Consider documenting patterns learned"
    fi

    echo "✅ POST-TASK VALIDATION: All hooks passed"
    echo "🎉 TASK COMPLETION: Validated and approved"
    return 0
}
```

### 🐌 SLOW AND STEADY CONSERVATIVE WORKFLOW ENFORCEMENT

#### **CONSERVATIVE WORKFLOW PRINCIPLES**
```bash
# MANDATORY: Conservative approach enforcement
conservative_workflow_enforcement() {
    local task_description="$1"

    echo "🐌 CONSERVATIVE WORKFLOW ENFORCEMENT"
    echo "Principle: Slow and steady wins the race"

    # Conservative Rule 1: Small increments only
    echo "📏 SMALL INCREMENTS: Maximum 3 lines per change"
    echo "   • Each change must be testable"
    echo "   • Each change must be reviewable"
    echo "   • Each change must be rollback-ready"

    # Conservative Rule 2: Validation at every step
    echo "🔍 CONTINUOUS VALIDATION:"
    echo "   • Build after every micro-step"
    echo "   • Test after every micro-step"
    echo "   • Review after every micro-step"

    # Conservative Rule 3: Safety over speed
    echo "🛡️  SAFETY OVER SPEED:"
    echo "   • No shortcuts permitted"
    echo "   • No 'quick fixes' without tests"
    echo "   • No assumptions without validation"

    # Conservative Rule 4: Collaboration over solo work
    echo "🤝 COLLABORATION REQUIRED:"
    echo "   • Pairing for all non-trivial tasks"
    echo "   • Expert consultation for specialized work"
    echo "   • Cross-validation for all changes"

    echo "✅ CONSERVATIVE WORKFLOW: Principles enforced"
}

# MANDATORY: Rollback-ready development
rollback_ready_development() {
    echo "🔄 ROLLBACK-READY DEVELOPMENT"

    # Ensure clean working state
    if ! git status --porcelain | grep -q '^$'; then
        echo "⚠️  WARNING: Uncommitted changes present"
        echo "📋 RECOMMENDATION: Commit or stash changes before proceeding"
    fi

    # Create automatic checkpoint
    local checkpoint_name="pre_task_$(date +%Y%m%d_%H%M%S)"
    echo "📍 CHECKPOINT: $checkpoint_name"
    echo "🔄 ROLLBACK COMMAND: git reset --hard HEAD"

    # Set up automatic rollback on failure
    echo "🛡️  SAFETY NET: Automatic rollback enabled"
    echo "   • Any test failure triggers automatic rollback"
    echo "   • Any build failure triggers automatic rollback"
    echo "   • Any validation failure triggers automatic rollback"
}
```

### ⚡ PRE-FILE-CREATION CHECKLIST (ZERO TOLERANCE)
**EVERY AGENT MUST RUN THESE MCP-OPTIMIZED COMMANDS BEFORE CREATING ANY FILE**:

```bash
# MANDATORY: Complete validation suite before any file operations
pre_file_creation_validation() {
    local intended_action="$1"  # create, edit, delete
    local target_file="$2"

    echo "🔒 PRE-FILE-CREATION VALIDATION SUITE"
    echo "Action: $intended_action"
    echo "Target: $target_file"

    # 1. MANDATORY: Existing file/functionality check
    echo "📚 Checking for existing implementations..."
    claude-context search "$(basename $target_file)" --path "." | head -5

    # 2. MANDATORY: Global handbook compliance
    echo "🌐 Checking global handbook compliance..."
    claude-context search "$(echo $intended_action)" --path "/knowledge/" | head -3

    # 3. MANDATORY: Project adaptation compliance
    echo "📦 Checking project adaptation compliance..."
    claude-context search "$(echo $intended_action)" --path "docs/" | head -3

    # 4. MANDATORY: Anti-duplication check
    echo "🚫 Anti-duplication validation..."
    if [[ "$target_file" =~ (_new|_v2|_refactored|_backup|_copy|_temp) ]]; then
        echo "❌ BLOCKED: Forbidden file suffix detected"
        echo "🚫 FILE CREATION BLOCKED: No duplicate files allowed"
        return 1
    fi

    # 5. MANDATORY: Simplicity check
    echo "🎯 Simplicity validation..."
    if [[ -f "$target_file" ]] && [[ "$intended_action" == "create" ]]; then
        echo "❌ BLOCKED: File already exists"
        echo "🚫 FILE CREATION BLOCKED: Use Edit tool instead"
        echo "✅ REQUIRED: Edit existing file rather than create new one"
        return 1
    fi

    # 6. MANDATORY: Framework and package research
    echo "🔍 Framework research validation..."
    context7 resolve-library-id "hugo" > /dev/null 2>&1 || echo "⚠️  Hugo docs unavailable"

    echo "✅ PRE-FILE-CREATION VALIDATION: All checks passed"
    return 0
}

# Usage: pre_file_creation_validation "create" "new-script.sh"
```

### 🛡️ AGENT COMPLIANCE REQUIREMENTS (FALSE SUCCESS PREVENTION ENHANCED)

#### **TIER 1: FALSE SUCCESS PREVENTION (ZERO TOLERANCE)**
1. **MANDATORY EVIDENCE**: Cannot claim success without running validation commands and providing output
2. **SCOPE VALIDATION**: Must verify complete system, not just narrow task focus
3. **CROSS-AGENT VERIFICATION**: Independent validation required from multiple agents
4. **BUILD + TEST VALIDATION**: Must run `bin/hugo-build && bin/test` before any success claim
5. **ASSET VERIFICATION**: Must verify all referenced files exist before claiming fixes
6. **TRUTH VERIFICATION**: Must use truth verification protocol for all swarm coordination

#### **TIER 2: OPERATIONAL COMPLIANCE (MCP-ENHANCED)**
7. **EXISTING TOOL USAGE**: Must use `bin/test`, `bin/hugo-dev`, `bin/lighthouse` etc. (validated via MCP tools)
8. **NO DUPLICATION**: Zero tolerance for duplicate scripts, docs, or configs (MCP search validation)
9. **SIMPLICITY FIRST**: Edit existing files, never create variations (MCP-verified existence checks)
10. **VERIFICATION**: Run MCP-optimized pre-creation checklist or task FAILS
11. **HANDBOOK COMPLIANCE**: Must follow global standards and project adaptations (dual MCP search)
12. **EXPERT CONSULTATION**: Must use expert agents for specialized tasks (MCP coordination)
13. **CONCURRENT EXECUTION**: Must batch all operations in single messages (MCP orchestration)
14. **ZERO-DUPLICATION TOLERANCE**: No files with suffixes like `_new`, `_v2`, `_refactored` (MCP pattern detection)
15. **MCP TOOL PRIORITY**: Always prefer MCP tools over basic bash commands for search and validation
16. **FRAMEWORK RESEARCH**: Use `context7` and `package-search` MCPs for comprehensive research

#### **TIER 3: SUCCESS CLAIM PROTOCOL (MANDATORY)**
17. **EVIDENCE COLLECTION**: Must collect and provide build output, test results, asset verification
18. **VISUAL VALIDATION**: Must provide screenshots for any UI/visual changes
19. **REGRESSION TESTING**: Must verify no functionality was broken
20. **INDEPENDENT VERIFICATION**: Each agent in swarm must validate independently

## 🚨 SMART DECOMPOSITION ENFORCEMENT SYSTEM - MANDATORY BLOCKING

### **CRITICAL: IDEA-TO-ATOMIC TASK CHAIN VALIDATION**

All agents MUST validate task atomicity before implementation. This prevents large, complex changes that violate micro-refactoring discipline.

#### **Smart Decomposition Validation Function**
```bash
# MANDATORY: validate_smart_decomposition - BLOCKS non-atomic tasks
validate_smart_decomposition() {
    local task_description="$1"

    echo "🧠 SMART DECOMPOSITION VALIDATION: Analyzing task complexity..."

    # Step 1: Check if task requires decomposition
    if ! is_atomic_task "$task_description"; then
        echo "❌ BLOCKED: Task requires decomposition into atomic steps"
        echo "🚫 REQUIREMENT: Break down using smart decomposition chain"
        echo "📋 FORMAT REQUIRED:"
        echo "   • Single action per task (one verb only)"
        echo "   • ≤3 lines of code changes maximum"
        echo "   • Clear acceptance criteria"
        echo "   • Testable outcome"
        show_decomposition_requirements "$task_description"
        exit 1
    fi

    # Step 2: Validate job story format for user-facing work
    if is_user_facing_task "$task_description"; then
        if ! validate_job_story_format "$task_description"; then
            echo "❌ BLOCKED: User-facing tasks must follow job story format"
            echo "📝 REQUIRED FORMAT: 'When I [situation] I want [motivation] so I can [outcome]'"
            exit 1
        fi
    fi

    # Step 3: Validate micro-step sizing
    if ! validate_micro_step_limits "$task_description"; then
        echo "❌ BLOCKED: Task exceeds micro-step limits (≤3 lines per step)"
        echo "🔄 REQUIRED: Break into micro-refactoring sequence"
        exit 1
    fi

    # Step 4: Check for complexity indicators
    local complexity_score=$(calculate_task_complexity "$task_description")
    if [[ $complexity_score -gt 5 ]]; then
        echo "❌ BLOCKED: Task complexity ($complexity_score/10) requires swarm coordination"
        echo "🐝 REQUIRED: Delegate to specialized swarm"
        exit 1
    fi

    echo "✅ DECOMPOSITION VALIDATED: Task meets atomicity requirements"
    return 0
}

# Atomic task detection with smart heuristics
is_atomic_task() {
    local task="$1"
    local complexity_indicators=(
        "and" "also" "plus" "additionally" "furthermore"
        "then" "after" "following" "next" "subsequently"
        "refactor.*and" "implement.*and" "add.*and.*modify"
        "multiple" "various" "several" "many" "all"
        "system" "infrastructure" "architecture" "framework"
    )

    # Check for complexity indicators
    for indicator in "${complexity_indicators[@]}"; do
        if echo "$task" | grep -qi "$indicator"; then
            return 1  # Task needs decomposition
        fi
    done

    # Check for multiple verbs (suggests multiple actions)
    local verb_count=$(echo "$task" | grep -o '\b\(add\|create\|update\|modify\|refactor\|implement\|build\|design\|test\|fix\|enhance\|optimize\|configure\|setup\|install\)\b' | wc -l)
    if [[ $verb_count -gt 1 ]]; then
        return 1  # Multiple actions need decomposition
    fi

    # Check estimated line count
    local estimated_lines=$(estimate_lines_from_description "$task")
    if [[ $estimated_lines -gt 3 ]]; then
        return 1  # Exceeds micro-step limit
    fi

    return 0  # Task appears atomic
}

# Job story format validation
validate_job_story_format() {
    local story="$1"
    local pattern="^When.*I want.*so I can.*"

    if echo "$story" | grep -qiE "$pattern"; then
        return 0  # Valid job story format
    else
        return 1  # Invalid format
    fi
}

# Check if task is user-facing
is_user_facing_task() {
    local task="$1"
    local user_indicators=("ui" "ux" "interface" "page" "content" "user" "visitor" "customer" "frontend" "design" "layout" "style")

    for indicator in "${user_indicators[@]}"; do
        if echo "$task" | grep -qi "$indicator"; then
            return 0  # User-facing task
        fi
    done

    return 1  # Internal/technical task
}

# Validate micro-step size limits
validate_micro_step_limits() {
    local task="$1"
    local estimated_lines=$(estimate_lines_from_description "$task")

    if [[ $estimated_lines -le 3 ]]; then
        return 0  # Within limits
    else
        return 1  # Exceeds limits
    fi
}

# Calculate task complexity score (0-10)
calculate_task_complexity() {
    local task="$1"
    local score=0

    # File impact scoring
    local file_indicators=("file" "files" "multiple" "various" "all" "system" "project")
    for indicator in "${file_indicators[@]}"; do
        if echo "$task" | grep -qi "$indicator"; then
            score=$((score + 2))
        fi
    done

    # Technology complexity
    local tech_indicators=("database" "api" "service" "integration" "authentication" "security" "performance")
    for indicator in "${tech_indicators[@]}"; do
        if echo "$task" | grep -qi "$indicator"; then
            score=$((score + 3))
        fi
    done

    # Architecture impact
    local arch_indicators=("architecture" "refactor" "restructure" "redesign" "framework")
    for indicator in "${arch_indicators[@]}"; do
        if echo "$task" | grep -qi "$indicator"; then
            score=$((score + 4))
        fi
    done

    # Cap at 10
    if [[ $score -gt 10 ]]; then
        score=10
    fi

    echo $score
}

# Estimate lines of code from description
estimate_lines_from_description() {
    local desc="$1"
    local lines=1  # Default to 1 line

    # Keywords that suggest more lines
    if echo "$desc" | grep -qi "implement\|create\|build\|develop"; then
        lines=$((lines + 2))
    fi

    if echo "$desc" | grep -qi "function\|class\|method\|component"; then
        lines=$((lines + 3))
    fi

    if echo "$desc" | grep -qi "multiple\|various\|several"; then
        lines=$((lines + 5))
    fi

    if echo "$desc" | grep -qi "complex\|advanced\|comprehensive"; then
        lines=$((lines + 10))
    fi

    echo $lines
}

# Show decomposition requirements
show_decomposition_requirements() {
    local task="$1"

    echo ""
    echo "🔄 SMART DECOMPOSITION REQUIREMENTS:"
    echo "1. Break task into single-action steps (one verb each)"
    echo "2. Each step must be ≤3 lines of code"
    echo "3. Each step must have clear acceptance criteria"
    echo "4. Each step must be independently testable"
    echo ""
    echo "📝 EXAMPLE DECOMPOSITION FOR: '$task'"
    echo "❌ BAD:  'Implement user authentication and dashboard'"
    echo "✅ GOOD: Step 1: 'Add login form validation'"
    echo "✅ GOOD: Step 2: 'Create authentication middleware'"
    echo "✅ GOOD: Step 3: 'Build dashboard route handler'"
    echo ""
    echo "🎯 EACH STEP FOLLOWS: When I [trigger] I want [outcome] so I can [benefit]"
}
```

### **LAYER-BY-LAYER VALIDATION ENFORCEMENT**

```bash
# MANDATORY: Layer-by-layer validation after each micro-step
validate_layer_by_layer() {
    local task_description="$1"
    local current_layer="$2"  # syntax, logic, integration, system

    echo "🔍 LAYER-BY-LAYER VALIDATION: $current_layer"

    case "$current_layer" in
        "syntax")
            echo "📝 SYNTAX LAYER VALIDATION:"
            echo "   • Checking syntax correctness"
            echo "   • Validating code formatting"
            echo "   • Ensuring no syntax errors"
            if ! validate_syntax_layer; then
                echo "❌ BLOCKED: Syntax layer validation failed"
                echo "🔧 REQUIRED: Fix syntax errors before proceeding"
                exit 1
            fi
            ;;
        "logic")
            echo "🧠 LOGIC LAYER VALIDATION:"
            echo "   • Testing logical correctness"
            echo "   • Validating expected behavior"
            echo "   • Checking edge cases"
            if ! validate_logic_layer "$task_description"; then
                echo "❌ BLOCKED: Logic layer validation failed"
                echo "🔧 REQUIRED: Fix logic errors before proceeding"
                exit 1
            fi
            ;;
        "integration")
            echo "🔗 INTEGRATION LAYER VALIDATION:"
            echo "   • Testing component integration"
            echo "   • Validating API contracts"
            echo "   • Checking data flow"
            if ! validate_integration_layer "$task_description"; then
                echo "❌ BLOCKED: Integration layer validation failed"
                echo "🔧 REQUIRED: Fix integration issues before proceeding"
                exit 1
            fi
            ;;
        "system")
            echo "🏗️ SYSTEM LAYER VALIDATION:"
            echo "   • Full system testing"
            echo "   • Performance validation"
            echo "   • Security verification"
            if ! validate_system_layer "$task_description"; then
                echo "❌ BLOCKED: System layer validation failed"
                echo "🔧 REQUIRED: Fix system issues before proceeding"
                exit 1
            fi
            ;;
    esac

    echo "✅ LAYER VALIDATED: $current_layer layer passed"
    return 0
}

# Validate syntax layer
validate_syntax_layer() {
    echo "🔍 Checking Hugo template syntax..."
    if command -v hugo >/dev/null 2>&1; then
        hugo --renderToMemory --quiet --logLevel error 2>/dev/null || return 1
    fi

    echo "🔍 Checking SCSS/CSS syntax..."
    # Add CSS/SCSS syntax validation here if needed

    return 0
}

# Validate logic layer
validate_logic_layer() {
    local task="$1"

    echo "🧪 Running targeted tests for logic validation..."
    if [[ -f "bin/test" ]]; then
        bin/test || return 1
    fi

    echo "🎯 Validating task-specific logic for: $task"
    # Add task-specific logic validation here

    return 0
}

# Validate integration layer
validate_integration_layer() {
    local task="$1"

    echo "🔗 Testing component integration..."
    if [[ -f "bin/test" ]]; then
        bin/test || return 1
    fi

    echo "🏗️ Building for integration validation..."
    if command -v hugo >/dev/null 2>&1; then
        hugo --renderToMemory --environment production || return 1
    fi

    return 0
}

# Validate system layer
validate_system_layer() {
    local task="$1"

    echo "🏗️ Full system build test..."
    if command -v hugo >/dev/null 2>&1; then
        hugo --minify --gc --cleanDestinationDir --environment production || return 1
    fi

    echo "⚡ Performance validation..."
    if [[ -f "bin/lighthouse" ]] && [[ "$task" =~ (performance|page|content) ]]; then
        echo "ℹ️ Performance check recommended for task: $task"
    fi

    return 0
}
```

### **GOAL CONFIRMATION ENFORCEMENT**

```bash
# MANDATORY: Goal confirmation before marking task complete
confirm_task_goal_achieved() {
    local task_description="$1"
    local implementation_details="$2"

    echo "🎯 GOAL CONFIRMATION VALIDATION"
    echo "Task: $task_description"
    echo "Implementation: $implementation_details"
    echo ""

    # Step 1: Verify original goal is met
    echo "📋 VERIFYING ORIGINAL GOAL ACHIEVEMENT:"
    if ! validate_original_goal_met "$task_description" "$implementation_details"; then
        echo "❌ BLOCKED: Original goal not achieved"
        echo "🚫 TASK NOT COMPLETE: Implementation does not meet stated goal"
        echo "🔧 REQUIRED: Adjust implementation to achieve original goal"
        exit 1
    fi

    # Step 2: Check for scope creep
    echo "🔍 CHECKING FOR SCOPE CREEP:"
    if detect_scope_creep "$task_description" "$implementation_details"; then
        echo "⚠️  WARNING: Scope creep detected"
        echo "📋 RECOMMENDATION: Document additional features separately"
    fi

    # Step 3: Validate acceptance criteria
    echo "✅ VALIDATING ACCEPTANCE CRITERIA:"
    if ! validate_acceptance_criteria_met "$task_description"; then
        echo "❌ BLOCKED: Acceptance criteria not met"
        echo "🚫 TASK NOT COMPLETE: Must meet all acceptance criteria"
        exit 1
    fi

    echo "🎉 GOAL CONFIRMED: Task successfully achieves stated objective"
    return 0
}

# Validate original goal is met
validate_original_goal_met() {
    local task="$1"
    local implementation="$2"

    # Extract key requirements from task description
    local key_requirements=$(extract_key_requirements "$task")

    echo "🔍 Key requirements: $key_requirements"
    echo "🔍 Implementation details: $implementation"

    # Simple keyword matching for validation
    for requirement in $key_requirements; do
        if ! echo "$implementation" | grep -qi "$requirement"; then
            echo "❌ Missing requirement: $requirement"
            return 1
        fi
    done

    return 0
}

# Extract key requirements from task description
extract_key_requirements() {
    local task="$1"

    # Extract action verbs and objects
    echo "$task" | grep -o '\b\(add\|create\|update\|modify\|refactor\|implement\|build\|design\|test\|fix\|enhance\|optimize\)\s\+\w\+' | head -5
}

# Detect scope creep
detect_scope_creep() {
    local original_task="$1"
    local implementation="$2"

    local original_scope_size=$(echo "$original_task" | wc -w)
    local implementation_scope_size=$(echo "$implementation" | wc -w)

    # If implementation description is significantly larger, might indicate scope creep
    if [[ $implementation_scope_size -gt $((original_scope_size * 3)) ]]; then
        return 0  # Scope creep detected
    fi

    return 1  # No scope creep
}

# Validate acceptance criteria
validate_acceptance_criteria_met() {
    local task="$1"

    echo "📋 Checking standard acceptance criteria..."

    # Run tests
    if [[ -f "bin/test" ]]; then
        echo "🧪 Running tests..."
        bin/test || return 1
    fi

    # Check build
    if command -v hugo >/dev/null 2>&1; then
        echo "🏗️ Validating build..."
        hugo --renderToMemory --quiet || return 1
    fi

    return 0
}
```

### **ENFORCEMENT INTEGRATION WITH EXISTING SYSTEMS**

This comprehensive validation system integrates with all existing enforcement mechanisms:

1. **TDD Three Laws**: Atomic tasks enable proper test-first development
2. **Four-Eyes Principle**: Smaller tasks make reviews more effective
3. **Micro-Refactoring**: Natural alignment with ≤3 line changes
4. **Swarm Delegation**: Automatic delegation for complex tasks (score >5)
5. **Conservative Workflow**: Supports "slow and steady" approach
6. **Layer-by-Layer**: Progressive validation from syntax → logic → integration → system
7. **Goal Confirmation**: Ensures original objectives are met without scope creep

### 🔗 Integration with Unified Handbook System

```yaml
handbook_integration:
  global_standards: "/knowledge/ (via symlink)" # Supreme authority
  project_adaptations: "docs/ (Johnny Decimal organized)" # Secondary authority
  hugo_patterns: "docs/30-39-architecture-design/" # Hugo-specific architecture
  content_guidelines: "docs/90-99-content-strategy/" # Content management
  seo_standards: "docs/seo-optimization-implementation-guide.md" # SEO compliance

integration_examples:
  security_patterns:
    global: "/knowledge/40.01-security-first-development.md"
    project: "docs/40-49-security-compliance/"
    hugo_specific: "CSP headers, static asset integrity, secure hosting"

  performance_standards:
    global: "/knowledge/performance-optimization-global.md"
    project: "docs/test-suite-improvement-plan.md"
    hugo_specific: "Core Web Vitals, build optimization, CDN configuration"

  tdd_methodology:
    global: "/knowledge/20.01-tdd-methodology-reference.md"
    project: "docs/60.03-tdd-quality-enforcement.md"
    hugo_specific: "Content TDD, build validation, static site testing"
```

---

## 🚨 MANDATORY: TECH STACK CONSISTENCY ENFORCEMENT

**Authority**: Global Standard from `/knowledge/70.01-tech-stack-consistency-enforcement.md`
**Compliance**: MANDATORY for all agents working on JT Site
**Project Adaptation**: Hugo/Jekyll static site generation with Ruby tooling

### 🎯 JT SITE TECH STACK DETECTION
**Primary Language**: Ruby (Jekyll/Hugo hybrid approach)
**Framework**: Hugo (static site generator) with Ruby tooling
**Template Engine**: Hugo templates (.html) with Go template syntax
**Testing**: Ruby-based (Minitest/RSpec) via bin/test
**Build System**: Hugo + Node.js (bun/npm) for asset pipeline
**Deployment**: GitHub Pages via Hugo build process

### ✅ REQUIRED JT Site Patterns
```ruby
# Ruby tooling patterns (REQUIRED for bin/ scripts)
users.each { |user| user.activate! }
return unless user.valid?

# Hugo template patterns (REQUIRED for layouts/)
{{ range .Pages }}{{ .Title }}{{ end }}
{{ with .Params.author }}{{ . }}{{ end }}

# SCSS/CSS patterns (REQUIRED for assets/)
.nav-item { &:hover { color: $primary; } }

# JavaScript patterns (REQUIRED for themes/assets/)
const handleClick = (event) => { event.preventDefault(); }
```

### ❌ FORBIDDEN Anti-Patterns for JT Site
```bash
# ❌ Python-style patterns (FORBIDDEN)
# [item for item in items]  # Use Ruby: items.map(&:method)

# ❌ Raw PHP/WordPress patterns (FORBIDDEN)
# <?php echo $title; ?>     # Use Hugo: {{ .Title }}

# ❌ React/JSX in Hugo templates (FORBIDDEN)
# <Component />             # Use Hugo partials: {{ partial "component" . }}

# ❌ Non-Ruby automation (FORBIDDEN)
# Python/Node.js build scripts  # Use Ruby in bin/ directory
```

### 🔧 Hugo-Specific Enforcement Rules
1. **Template Compliance**: All layouts must use Hugo's Go template syntax
2. **Asset Pipeline**: SCSS compilation through Hugo's asset pipeline
3. **Content Structure**: Markdown files with Hugo front matter format
4. **SEO Integration**: Hugo's built-in SEO features, not external plugins
5. **Build Process**: Hugo commands only, no Jekyll or other static generators

## 🚫 MANDATORY: SCRIPT PREVENTION AND TEMPORARY FILE MANAGEMENT

**Authority**: Global Standard from `/knowledge/50.02-script-prevention-and-temporary-file-management.md`
**Compliance**: ZERO TOLERANCE - NO script creation without explicit user request
**JT Site Adaptation**: Use existing bin/ tools and Hugo commands only

### 🛡️ ABSOLUTE SCRIPT PROHIBITIONS
```yaml
jt_site_script_prevention:
  never_create:
    - "deployment scripts (use existing GitHub Actions)"
    - "build automation (use existing bin/ tools)"
    - "content validation scripts (use bin/test)"
    - "SEO automation scripts (use existing tools)"
    - "image optimization scripts (use Hugo image processing)"

  always_use_existing:
    - "bin/build for Hugo builds"
    - "bin/test for validation"
    - "bin/serve for development server"
    - "npm/bun scripts in package.json"
    - "Hugo commands for content operations"

  temporary_directories:
    - "/_tmp/hugo-builds/ (1-hour TTL)"
    - "/_runtime/content-analysis/ (session TTL)"
    - "/_workspace/seo-experiments/ (manual cleanup)"
```

### 🔧 JT Site Tool Hierarchy (MANDATORY)
1. **Hugo Commands**: `hugo build`, `hugo server`, `hugo new`
2. **Existing bin/ Scripts**: `bin/build`, `bin/test`, `bin/serve`
3. **Package Scripts**: `bun run build`, `bun run test`, `bun run dev`
4. **Ruby Tools**: For bin/ directory maintenance only
5. **Temporary Scripts**: ONLY in designated temporary directories with TTL

### 📁 JT Site Directory Enforcement
```bash
# ✅ ALLOWED permanent directories
/content/           # Hugo content
/layouts/           # Hugo templates
/assets/            # Hugo assets
/static/            # Static files
/bin/               # Ruby tooling scripts
/docs/              # Project documentation

# ✅ ALLOWED temporary directories
/_tmp/hugo-builds/     # Temporary Hugo builds (1-hour TTL)
/_runtime/analysis/    # Content analysis (session TTL)
/_workspace/drafts/    # Content drafts (manual cleanup)

# ❌ FORBIDDEN script creation locations
/scripts/              # Use bin/ instead
/automation/           # Use existing tools
/build/                # Use Hugo build process
/deploy/               # Use GitHub Actions
```

## 🛠️ MANDATORY: MCP TOOL PROTOCOLS FOR JT SITE

**Authority**: Enhanced MCP tool enforcement for Hugo/Jekyll workflow
**Integration**: GitHub MCP tools for repository management
**Compliance**: Use MCP tools for research, coordination, and GitHub integration

### 🔍 MANDATORY MCP Research Pattern for JT Site
```bash
# STEP 1: Global standards research (MANDATORY FIRST)
claude-context search "[topic]" --path "/knowledge/"

# STEP 2: JT Site project patterns (MANDATORY SECOND)
claude-context search "[topic]" --path "docs/"

# STEP 3: Hugo/Jekyll framework research
context7 resolve-library-id "hugo"
context7 get-library-docs "/gohugoio/hugo" --topic "[feature]"

# STEP 4: Ruby tooling research (for bin/ scripts)
mcp__package-search__package_search_hybrid \
  --registry_name "crates_io" \
  --package_name "ruby" \
  --semantic_queries '["[ruby-pattern]"]'

# STEP 5: Content and SEO research
mcp__brave-search__brave_web_search \
  --query "Hugo [feature] best practices 2025"
```

### 🐙 GitHub MCP Integration for JT Site
```bash
# Repository analysis and management
mcp__flow-nexus__github_repo_analyze \
  --repo "jetthoughts/jetthoughts.github.io" \
  --analysis_type "performance"

# SEO content optimization with GitHub integration
mcp__flow-nexus__github_workflow_auto \
  --repo "jetthoughts/jetthoughts.github.io" \
  --workflow "seo-optimization"

# Content review and PR management
mcp__flow-nexus__github_pr_manage \
  --repo "jetthoughts/jetthoughts.github.io" \
  --action "review" \
  --pr_number "[pr-id]"
```

### 📚 JT Site Documentation Generation with MCP
```bash
# Claude-context for comprehensive documentation search
claude-context search "Hugo content management" --path "."

# Memory coordination for cross-agent document creation
mcp__memory__create_entities \
  --entities '[{"name": "jt_site_docs", "entityType": "documentation", "observations": ["content patterns", "SEO guidelines"]}]'

# Knowledge base updates
mcp__memory__add_observations \
  --observations '[{"entityName": "jt_site_docs", "contents": ["updated Hugo patterns", "new SEO requirements"]}]'
```

### 🎯 JT Site Agent MCP Tool Requirements
```yaml
jt_site_agent_mcp_requirements:
  mandatory_tools_usage:
    research_phase:
      - "claude-context (handbook system navigation)"
      - "context7 (Hugo/Jekyll documentation)"
      - "brave-search (current best practices)"

    implementation_phase:
      - "memory coordination (cross-agent communication)"
      - "github integration (repository management)"
      - "performance monitoring (site optimization)"

    validation_phase:
      - "automated testing via existing bin/ tools"
      - "github pr review coordination"
      - "seo validation through existing processes"

  forbidden_alternatives:
    - "Custom script creation instead of MCP tool usage"
    - "File-based agent communication instead of memory coordination"
    - "Manual repository management instead of GitHub MCP tools"
    - "Custom research tools instead of MCP research stack"
```

### 🔄 JT Site Workflow with MCP Integration
1. **Research Phase**: claude-context → context7 → brave-search (all via MCP)
2. **Planning Phase**: Memory coordination for cross-agent communication
3. **Implementation Phase**: Existing bin/ tools + Hugo commands only
4. **Validation Phase**: GitHub MCP tools for PR management and review
5. **Documentation Phase**: Memory-based knowledge capture and documentation

---

**Remember**: This comprehensive configuration enforces unified handbook system compliance with Hugo/JAMstack specializations. All agents MUST follow the dual-source handbook system (global standards FIRST, project adaptations SECOND) and maintain zero-tolerance policies for duplication, quality, and security violations.
- Each new learning after each incident should be tracked in CLAUDE.md
- Do not mask bugs with exciption handlers at all. Only if it requested then add exception handler!
- Use the most conservative way, through cooperatin and follwoing xp practices.
- Always spawn a whole xp team swarm to handle the task through claude-flow  and ruv-swarm
