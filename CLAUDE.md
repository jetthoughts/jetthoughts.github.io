# Claude Code Configuration - SPARC Development Environment

## 📚 KNOWLEDGE-DRIVEN DEVELOPMENT

**This project follows comprehensive knowledge management practices. All agents MUST consult the structured knowledge base before proposing solutions.**

**Knowledge Base Location**: `/knowledge/` - Complete practices, processes, solutions, and templates
**Documentation Base Location**: `/docs/` - Project documentation and architectural decisions
**Knowledge Index**: `/knowledge/KNOWLEDGE_INDEX.md` - Navigation guide for all knowledge

### 🎯 Core Knowledge Principles
1. **Research-First Development**: Use `claude-context`, `context7`, `docs MCP` to validate all approaches
2. **Pattern Consistency**: Follow established patterns from knowledge base solutions
3. **Quality Assurance**: Apply comprehensive validation checklists for all implementations
4. **Security-First**: Implement security practices from knowledge base frameworks
5. **TDD Methodology**: Follow test-driven development from knowledge base practices

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

### Agent Memory Coordination
```bash
# Each agent uses unique coordination key
tests/generated/{agent-name}/*

# Check existing tests before creating new ones
npx claude-flow@alpha hooks memory-search \
  --pattern "tests/generated/*" \
  --key "*{test-topic}*"
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

## 🧬 MICRO NON-BREAKING CHANGES PROTOCOL

### Critical Implementation Requirements

**MANDATORY FOR ALL AGENTS**: All code changes MUST follow the strict micro-refactoring protocols to ensure system stability and rapid iteration cycles.

#### The 3-Line Rule (ENFORCED)
```yaml
micro_refactoring_compliance:
  max_lines_per_change: 3
  max_total_lines_per_task: 50
  test_after_each_change: required
  rollback_on_failure: automatic
  continuous_validation: true
```

#### Implementation Protocol

**Phase 1: Task Decomposition**
- Break ALL tasks into 3-line micro-changes
- Plan maximum 50 lines total per complete task
- Identify rollback points for each micro-step
- Ensure each micro-change is independently testable

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

**ALL AGENTS MUST:**
1. **Plan in micro-steps**: Decompose tasks to 3-line changes
2. **Execute incrementally**: Apply changes one micro-step at a time  
3. **Test continuously**: Validate after each micro-change
4. **Rollback immediately**: Revert on any failure
5. **Document patterns**: Record successful micro-change patterns

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

**Mandatory Verification After Each Micro-Change:**

1. **Immediate Test Validation**
   ```bash
   # Run after EVERY 3-line change
   hugo build --verbose --dry-run  # Hugo build validation
   npm test                        # Unit/integration tests
   npm run lint                    # Code quality checks
   ```

2. **System Stability Verification**
   ```bash
   # Verify system remains in working state
   hugo server --bind 0.0.0.0 --port 1313 &
   sleep 5
   curl -f http://localhost:1313/ || rollback_change
   pkill hugo
   ```

3. **Performance Impact Validation**
   ```bash
   # Ensure no performance regression
   build_time=$(time hugo build 2>&1 | grep real)
   if [[ $build_time > baseline_time ]]; then
       echo "❌ Performance regression detected"
       rollback_change
   fi
   ```

**Reverification Protocol:**
- ALL agents MUST use paired validation (coder + reviewer)
- Complex changes (>1 micro-step) REQUIRE reviewer agent verification
- Critical changes (security, architecture) MANDATE paired validation
- Simple changes (≤3 lines) MAY use single agent with post-completion validation

## 🚨 CRITICAL: CONCURRENT EXECUTION & FILE MANAGEMENT

**ABSOLUTE RULES**:
1. ALL operations MUST be concurrent/parallel in a single message
2. **NEVER save working files, text/mds and tests to the root folder**
3. ALWAYS organize files in appropriate subdirectories
4. **USE CLAUDE CODE'S TASK TOOL** for spawning agents concurrently, not just MCP

### ⚡ GOLDEN RULE: "1 MESSAGE = ALL RELATED OPERATIONS"

**MANDATORY PATTERNS:**
- **TodoWrite**: ALWAYS batch ALL todos in ONE call (5-10+ todos minimum)
- **Task tool (Claude Code)**: ALWAYS spawn ALL agents in ONE message with full instructions
- **File operations**: ALWAYS batch ALL reads/writes/edits in ONE message
- **Bash commands**: ALWAYS batch ALL terminal operations in ONE message
- **Memory operations**: ALWAYS batch ALL memory store/retrieve in ONE message

### 🎯 CRITICAL: Claude Code Task Tool for Agent Execution

**Claude Code's Task tool is the PRIMARY way to spawn agents:**
```javascript
// ✅ CORRECT: Use Claude Code's Task tool for parallel agent execution
[Single Message]:
  Task("Research agent", "Analyze requirements and patterns...", "researcher")
  Task("Coder agent", "Implement core features...", "coder")
  Task("Tester agent", "Create comprehensive tests...", "tester")
  Task("Reviewer agent", "Review code quality...", "reviewer")
  Task("Architect agent", "Design system architecture...", "system-architect")
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

## 🚀 Available Agents (54 Total)

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

```javascript
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

## 📋 Agent Coordination Protocol

### Every Agent Spawned via Task Tool MUST:

**1️⃣ BEFORE Work:**
```bash
npx claude-flow@alpha hooks pre-task --description "[task]"
npx claude-flow@alpha hooks session-restore --session-id "swarm-[id]"
```

**2️⃣ DURING Work:**
```bash
npx claude-flow@alpha hooks post-edit --file "[file]" --memory-key "swarm/[agent]/[step]"
npx claude-flow@alpha hooks notify --message "[what was done]"
```

**3️⃣ AFTER Work:**
```bash
npx claude-flow@alpha hooks post-task --task-id "[task]"
npx claude-flow@alpha hooks session-end --export-metrics true
```

## 🎯 Concurrent Execution Examples

### ✅ CORRECT WORKFLOW: MCP Coordinates, Claude Code Executes

```javascript
// Step 1: MCP tools set up coordination (optional, for complex tasks)
[Single Message - Coordination Setup]:
  mcp__claude-flow__swarm_init { topology: "mesh", maxAgents: 6 }
  mcp__claude-flow__agent_spawn { type: "researcher" }
  mcp__claude-flow__agent_spawn { type: "coder" }
  mcp__claude-flow__agent_spawn { type: "tester" }

// Step 2: Claude Code Task tool spawns ACTUAL agents that do the work
[Single Message - Parallel Agent Execution]:
  // Claude Code's Task tool spawns real agents concurrently
  Task("Research agent", "Analyze API requirements and best practices. Check memory for prior decisions.", "researcher")
  Task("Coder agent", "Implement REST endpoints with authentication. Coordinate via hooks.", "coder")
  Task("Database agent", "Design and implement database schema. Store decisions in memory.", "code-analyzer")
  Task("Tester agent", "Create comprehensive test suite with 90% coverage.", "tester")
  Task("Reviewer agent", "Review code quality and security. Document findings.", "reviewer")

  // Batch ALL todos in ONE call
  TodoWrite { todos: [
    {id: "1", content: "Research API patterns", status: "in_progress", priority: "high"},
    {id: "2", content: "Design database schema", status: "in_progress", priority: "high"},
    {id: "3", content: "Implement authentication", status: "pending", priority: "high"},
    {id: "4", content: "Build REST endpoints", status: "pending", priority: "high"},
    {id: "5", content: "Write unit tests", status: "pending", priority: "medium"},
    {id: "6", content: "Integration tests", status: "pending", priority: "medium"},
    {id: "7", content: "API documentation", status: "pending", priority: "low"},
    {id: "8", content: "Performance optimization", status: "pending", priority: "low"}
  ]}

  // Parallel file operations
  Bash "mkdir -p app/{src,tests,docs,config}"
  Write "app/package.json"
  Write "app/src/server.js"
  Write "app/tests/server.test.js"
  Write "app/docs/API.md"
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

Remember: **Claude Flow coordinates, Claude Code creates!**

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.
Never save working files, text/mds and tests to the root folder.
- always spawn swarm to handle requests
- After each task spawn appropriate agent to run the whole test suite with `bin/dtest` to confirm there is no breaking changes have been introduced, by making all tests pass. If there are broken test request review and handling them!
- if there are broken tests related to screenshots then need to manaully review appropriate diffs and evaluate them. if they are ok then commit them; if not request a fix!
- prioritize to use claude-context for search through codebase over average search
- verify tests after each change and request to rework on found issues
- prevent deletion of valid tests to make them pass. IMPORTANT: pre-validate changes with reviewer to avoid breaking changes
- spawn swarm: prevent deletion of valid tests to make them pass. IMPORTANT: pre-validate changes with reviewer to avoid breaking changes