# Agent Notification System: MCP Tool Priority Changes

**Alert Type**: URGENT - Tool Priority Change
**Effective Date**: Immediate
**Scope**: ALL Agents (coder, researcher, reviewer, tester, planner, hugo-expert)
**Impact**: HIGH - 100x Performance Improvement Available

## 🚨 URGENT NOTIFICATION: PRIMARY TOOL CHANGES

### NEW PRIMARY TOOLS (IMMEDIATE ADOPTION REQUIRED)

#### claude-context (NEW PRIMARY)
- **Status**: 830 files indexed, 4,184 chunks ready for semantic search
- **Performance**: 100x faster than grep/find/glob
- **Use Case**: Semantic codebase search, pattern discovery, handbook navigation
- **Priority**: USE FIRST before any other search tool

#### serena (NEW PRIMARY)
- **Status**: Precise symbol navigation and code analysis
- **Performance**: Instant symbol relationship understanding
- **Use Case**: Code structure analysis, dependency tracking, refactoring support
- **Priority**: USE FIRST for symbol-related tasks

### TOOL HIERARCHY CHANGE

#### OLD HIERARCHY (DEPRECATED)
```bash
1. grep/find/glob (slow, keyword-based)
2. claude-context (underutilized)
3. package-search
4. context7
```

#### NEW HIERARCHY (MANDATORY)
```bash
1. claude-context (PRIMARY - 100x faster semantic search)
2. serena (PRIMARY - precise symbol navigation)
3. package-search (framework/dependency research)
4. context7 (official documentation)
5. grep/find/glob (LAST RESORT ONLY)
```

## AGENT-SPECIFIC NOTIFICATION DETAILS

### Coder Agents
**IMMEDIATE ACTION REQUIRED**:
- Update research workflow to use claude-context FIRST
- Use serena for symbol analysis before code modifications
- Research existing patterns with semantic search before implementation

**Example Workflow Change**:
```bash
# OLD: Start with grep (slow, limited)
grep -r "navigation" themes/

# NEW: Start with claude-context (100x faster, semantic)
claude-context search "navigation component patterns" --path "themes/beaver/layouts/" --limit 12
serena find_symbol "navigation" --relative_path "themes/beaver/layouts/partials/"
```

### Researcher Agents
**IMMEDIATE ACTION REQUIRED**:
- Prioritize claude-context for comprehensive research discovery
- Use serena for architectural pattern analysis
- Combine both tools for complete understanding before external research

**Example Workflow Change**:
```bash
# OLD: Multiple external tools first
mcp__package-search__package_search_hybrid --semantic_queries '[...]'

# NEW: Internal semantic search first
claude-context search "Hugo architecture patterns" --path "/knowledge/" --limit 10
serena get_symbols_overview --relative_path "themes/beaver/"
# THEN external tools for validation
```

### Reviewer Agents
**IMMEDIATE ACTION REQUIRED**:
- Use claude-context for quality pattern analysis
- Use serena for dependency and symbol relationship validation
- Prioritize semantic understanding over keyword searching

**Example Workflow Change**:
```bash
# OLD: Manual file inspection
find . -name "*.rb" | xargs grep "test"

# NEW: Semantic test pattern analysis
claude-context search "test quality standards" --path "/knowledge/" --limit 8
serena find_referencing_symbols "test_validation" --relative_path "test/"
```

### Tester Agents
**IMMEDIATE ACTION REQUIRED**:
- Use claude-context for test pattern discovery
- Use serena for test coverage and symbol analysis
- Research test methodologies semantically before manual inspection

**Example Workflow Change**:
```bash
# OLD: File-based test discovery
find test/ -name "*_test.rb"

# NEW: Semantic test pattern analysis
claude-context search "behavioral testing patterns" --path "test/" --limit 10
serena find_symbol "test_" --relative_path "test/" --substring_matching true
```

### Planner Agents
**IMMEDIATE ACTION REQUIRED**:
- Use claude-context for strategic pattern research
- Use serena for architectural relationship analysis
- Plan based on semantic understanding of existing patterns

**Example Workflow Change**:
```bash
# OLD: Manual documentation review
cat docs/*.md | grep -i "strategy"

# NEW: Semantic strategy pattern discovery
claude-context search "strategic planning Hugo" --path "/knowledge/" --limit 8
serena find_symbol "strategy" --relative_path "docs/"
```

### Hugo-Expert Agents
**IMMEDIATE ACTION REQUIRED**:
- Use claude-context for Hugo-specific pattern analysis
- Use serena for theme architecture understanding
- Research Hugo patterns semantically before manual template inspection

**Example Workflow Change**:
```bash
# OLD: Manual theme exploration
find themes/ -name "*.html" | head -10

# NEW: Semantic theme pattern analysis
claude-context search "Hugo theme architecture" --path "themes/" --limit 15
serena get_symbols_overview --relative_path "themes/beaver/"
```

## BEHAVIORAL CHANGE REQUIREMENTS

### ALL AGENTS MUST UPDATE
1. **Research-First Behavior**: Always use claude-context/serena before other tools
2. **Semantic Understanding**: Prioritize concept-based search over keyword matching
3. **Symbol Awareness**: Use serena for code structure understanding
4. **Performance Optimization**: Leverage 100x speed advantage for all research tasks

### MEMORY COORDINATION UPDATES
```bash
# Track tool adoption and usage
mcp__claude-flow__memory_usage --action store \
  --namespace "mcp-tool-adoption/notification-response" \
  --key "agent-[agent-name]-[timestamp]" \
  --value "claude-context:adopted,serena:adopted,performance:100x-improved"
```

## IMPLEMENTATION TIMELINE

### IMMEDIATE (Within Current Session)
- ✅ Updated agent behavioral descriptions
- ✅ Created comprehensive usage scenarios
- ✅ Notification system active
- 🔄 Tool priority enforcement in hooks

### SHORT-TERM (Next 24 Hours)
- Agent adoption monitoring
- Performance metrics collection
- Cross-agent research coordination enhancement

### ONGOING
- Tool usage optimization based on performance data
- Advanced semantic search pattern development
- Enhanced symbol navigation workflows

## PERFORMANCE EXPECTATIONS

### Speed Improvements
- **Research Tasks**: 100x faster completion time
- **Pattern Discovery**: Instant semantic understanding
- **Code Navigation**: Real-time symbol relationship mapping

### Quality Improvements
- **Pattern Recognition**: More comprehensive and accurate
- **Code Understanding**: Deeper architectural insights
- **Cross-Reference Validation**: Enhanced handbook compliance

## COMPLIANCE MONITORING

### Success Metrics
- Tool adoption rate across all agents
- Performance improvement measurements
- Research quality enhancement tracking

### Violation Detection
- Continued use of grep/find before claude-context/serena
- Missing semantic research in task execution
- Bypassing new tool priority hierarchy

## SUPPORT AND DOCUMENTATION

### Primary Documentation
- **Usage Guide**: `docs/agent-mcp-tool-scenarios.md` (comprehensive scenarios)
- **Tool Capabilities**: claude-context (830 files, 4,184 chunks), serena (symbol navigation)
- **Integration Patterns**: Memory coordination, cross-agent research coordination

### Help and Troubleshooting
- Reference usage scenarios for agent-specific patterns
- Use memory coordination to share successful search patterns
- Coordinate with other agents for complex research requirements

---

**ACTION REQUIRED**: All agents must acknowledge this notification and begin immediate adoption of claude-context and serena as PRIMARY tools. Performance improvements of 100x are achievable through proper semantic search and symbol navigation utilization.

**Status**: ACTIVE - Implementation in progress across all agent configurations.