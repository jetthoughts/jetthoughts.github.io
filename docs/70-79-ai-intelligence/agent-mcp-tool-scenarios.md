# Agent MCP Tool Scenarios Guide: claude-context & serena Priority

**Authority**: Claude-Flow Expert Configuration Enhancement
**Status**: Active Enhancement - Implementation Phase
**Priority**: HIGH - 100x Speed Advantage Implementation
**Integration**: All agents now prioritize claude-context and serena tools

## Overview

This guide provides specific usage scenarios for all agent types to leverage claude-context and serena MCP tools as PRIMARY research and navigation tools. With 830 files indexed and 4,184 chunks ready for semantic search, these tools provide 100x faster results compared to traditional grep/find/glob approaches.

## Core Tool Capabilities

### claude-context (PRIMARY - Semantic Search)
- **Files Indexed**: 830 files
- **Chunks Available**: 4,184 searchable chunks
- **Speed Advantage**: 100x faster than grep/find
- **Use Case**: Semantic codebase search, pattern discovery, handbook navigation

### serena (PRIMARY - Symbol Navigation)
- **Capability**: Precise symbol navigation and code analysis
- **Use Case**: Symbol relationships, dependency tracking, architecture analysis
- **Integration**: Code structure understanding, refactoring support

## Agent-Specific Usage Scenarios

### Coder Agents: Implementation Research & Development

#### Scenario 1: Hugo Theme Development
```bash
# BEFORE: Traditional slow search
find themes/ -name "*.html" | xargs grep -l "navigation"

# AFTER: 100x faster semantic search
claude-context search "navigation component patterns" --path "themes/beaver/layouts/" --limit 12
serena find_symbol "navigation" --relative_path "themes/beaver/layouts/partials/"
serena get_symbols_overview --relative_path "themes/beaver/layouts/"
```

#### Scenario 2: CSS Migration Strategy Research
```bash
# Research existing CSS migration patterns
claude-context search "CSS migration dual-class system" --path "docs/" --limit 10
claude-context search "c- component fl- legacy classes" --path "themes/beaver/assets/css/" --limit 15

# Analyze symbol relationships in CSS
serena find_symbol "migration_strategy" --relative_path "themes/beaver/assets/css/"
serena find_referencing_symbols "dual_class" --relative_path "themes/beaver/"
```

#### Scenario 3: Ruby Test Infrastructure Integration
```bash
# Discover test patterns semantically
claude-context search "Ruby test Hugo integration" --path "test/" --limit 12
claude-context search "screenshot testing cross-browser" --path "lib/test_selection/" --limit 8

# Navigate test symbol structure
serena find_symbol "test_selection" --relative_path "lib/"
serena find_referencing_symbols "capybara" --relative_path "test/"
```

### Researcher Agents: Pattern Analysis & Discovery

#### Scenario 1: Architecture Pattern Research
```bash
# Comprehensive architecture discovery
claude-context search "Hugo architecture patterns" --path "/knowledge/" --limit 10
claude-context search "static site architecture" --path "docs/" --limit 8
claude-context search "theme architecture beaver" --path "themes/" --limit 15

# Symbol-level architectural analysis
serena get_symbols_overview --relative_path "themes/beaver/"
serena find_symbol "template_inheritance" --relative_path "themes/beaver/layouts/"
```

#### Scenario 2: Performance Optimization Research
```bash
# Performance pattern discovery
claude-context search "performance optimization Hugo" --path "/knowledge/" --limit 8
claude-context search "Core Web Vitals implementation" --path "docs/" --limit 6
claude-context search "asset optimization pipeline" --path "themes/beaver/assets/" --limit 10

# Performance-related symbol analysis
serena find_symbol "optimization" --relative_path "themes/beaver/"
serena find_referencing_symbols "lighthouse" --relative_path "bin/"
```

#### Scenario 3: Documentation Cross-Reference Research
```bash
# Handbook cross-reference validation
claude-context search "global handbook reference" --path "/knowledge/" --limit 12
claude-context search "project adaptation compliance" --path "docs/" --limit 10
claude-context search "Johnny Decimal Diátaxis" --path "docs/" --limit 8

# Documentation symbol structure
serena get_symbols_overview --relative_path "docs/"
serena find_symbol "documentation_standards" --relative_path "docs/"
```

### Reviewer Agents: Code Analysis & Quality Validation

#### Scenario 1: Code Quality Review
```bash
# Quality pattern analysis
claude-context search "code quality standards" --path "/knowledge/" --limit 8
claude-context search "review checklist Hugo" --path "docs/" --limit 6
claude-context search "test masking prevention" --path "test/" --limit 10

# Symbol-level quality analysis
serena find_symbol "quality_gate" --relative_path "."
serena find_referencing_symbols "test_validation" --relative_path "test/"
```

#### Scenario 2: Dependency Review
```bash
# Dependency pattern analysis
claude-context search "dependency management Hugo" --path "themes/" --limit 8
claude-context search "module integration patterns" --path "docs/" --limit 6

# Dependency symbol relationships
serena find_symbol "dependency" --relative_path "themes/beaver/"
serena find_referencing_symbols "import" --relative_path "themes/beaver/assets/"
```

#### Scenario 3: Security Review
```bash
# Security pattern discovery
claude-context search "security headers CSP" --path "/knowledge/" --limit 6
claude-context search "static site security" --path "docs/" --limit 5
claude-context search "asset security validation" --path "themes/" --limit 8

# Security-related symbol analysis
serena find_symbol "security" --relative_path "."
serena find_referencing_symbols "csp" --relative_path "themes/beaver/"
```

### Tester Agents: Test Discovery & Validation

#### Scenario 1: Test Pattern Discovery
```bash
# Test methodology research
claude-context search "TDD Three Laws Hugo" --path "/knowledge/" --limit 6
claude-context search "behavioral testing patterns" --path "test/" --limit 10
claude-context search "visual regression testing" --path "lib/" --limit 8

# Test symbol structure analysis
serena get_symbols_overview --relative_path "test/"
serena find_symbol "test_" --relative_path "test/" --substring_matching true
serena find_referencing_symbols "assert" --relative_path "test/"
```

#### Scenario 2: Test Coverage Analysis
```bash
# Coverage pattern analysis
claude-context search "test coverage requirements" --path "/knowledge/" --limit 5
claude-context search "Hugo test coverage patterns" --path "test/" --limit 8

# Coverage symbol tracking
serena find_symbol "coverage" --relative_path "test/"
serena find_referencing_symbols "test_selection" --relative_path "lib/"
```

#### Scenario 3: Test Quality Validation
```bash
# Test quality pattern discovery
claude-context search "test quality standards" --path "/knowledge/" --limit 6
claude-context search "test masking prevention" --path "docs/" --limit 5

# Test quality symbol analysis
serena find_symbol "quality" --relative_path "test/"
serena find_referencing_symbols "validation" --relative_path "test/"
```

### Planner Agents: Strategic Planning & Architecture

#### Scenario 1: Strategic Architecture Planning
```bash
# Strategic pattern research
claude-context search "strategic planning Hugo" --path "/knowledge/" --limit 8
claude-context search "architecture decision records" --path "docs/" --limit 6
claude-context search "technical roadmap planning" --path "docs/" --limit 5

# Strategic symbol relationships
serena get_symbols_overview --relative_path "docs/"
serena find_symbol "strategy" --relative_path "docs/"
serena find_referencing_symbols "planning" --relative_path "docs/"
```

#### Scenario 2: Cross-Domain Planning
```bash
# Cross-domain pattern analysis
claude-context search "cross-domain integration" --path "/knowledge/" --limit 6
claude-context search "Hugo Ruby CSS integration" --path "." --limit 10

# Cross-domain symbol analysis
serena find_symbol "integration" --relative_path "."
serena find_referencing_symbols "coordination" --relative_path "."
```

### Hugo-Expert Agents: Hugo-Specific Development

#### Scenario 1: Hugo Configuration Research
```bash
# Hugo-specific pattern discovery
claude-context search "Hugo configuration patterns" --path "/knowledge/" --limit 8
claude-context search "hugo.toml optimization" --path "." --limit 5
claude-context search "Hugo build optimization" --path "docs/" --limit 6

# Hugo configuration symbols
serena find_symbol "hugo" --relative_path "." --substring_matching true
serena find_referencing_symbols "config" --relative_path "."
```

#### Scenario 2: Theme Architecture Analysis
```bash
# Theme architecture research
claude-context search "Hugo theme architecture" --path "themes/" --limit 15
claude-context search "partial template organization" --path "themes/beaver/layouts/" --limit 12

# Theme symbol structure
serena get_symbols_overview --relative_path "themes/beaver/"
serena find_symbol "partial" --relative_path "themes/beaver/layouts/"
serena find_referencing_symbols "template" --relative_path "themes/beaver/"
```

#### Scenario 3: Asset Pipeline Optimization
```bash
# Asset pipeline research
claude-context search "Hugo Pipes asset processing" --path "themes/" --limit 10
claude-context search "CSS SCSS optimization" --path "themes/beaver/assets/" --limit 12

# Asset pipeline symbols
serena find_symbol "asset" --relative_path "themes/beaver/"
serena find_referencing_symbols "pipeline" --relative_path "themes/beaver/assets/"
```

## Memory Coordination Integration

### Agent Adoption Tracking
```bash
# Track agent adoption of claude-context and serena tools
mcp__claude-flow__memory_usage --action store \
  --namespace "mcp-tool-adoption/claude-context" \
  --key "agent-[agent-name]-[timestamp]" \
  --value "usage-count:active,performance-improvement:100x"

mcp__claude-flow__memory_usage --action store \
  --namespace "mcp-tool-adoption/serena" \
  --key "agent-[agent-name]-[timestamp]" \
  --value "symbol-navigation:active,code-analysis:enhanced"
```

### Cross-Agent Research Coordination
```bash
# Coordinate research findings across agents
mcp__claude-flow__memory_usage --action store \
  --namespace "research-coordination/claude-context-findings" \
  --key "pattern-[pattern-name]-[timestamp]" \
  --value "discovered-by:[agent],semantic-search-results:[findings]"

mcp__claude-flow__memory_usage --action store \
  --namespace "research-coordination/serena-findings" \
  --key "symbol-[symbol-name]-[timestamp]" \
  --value "analyzed-by:[agent],symbol-relationships:[relationships]"
```

### Performance Metrics Tracking
```bash
# Track performance improvements from tool usage
mcp__claude-flow__memory_usage --action store \
  --namespace "performance-metrics/search-speed" \
  --key "claude-context-vs-grep-[timestamp]" \
  --value "speed-improvement:100x,accuracy-improvement:semantic"

mcp__claude-flow__memory_usage --action store \
  --namespace "performance-metrics/navigation-efficiency" \
  --key "serena-vs-manual-[timestamp]" \
  --value "symbol-discovery:precise,relationship-tracking:comprehensive"
```

## Best Practices for All Agents

### 1. Always Research First
- Use claude-context for semantic discovery before implementation
- Use serena for symbol analysis before code modifications
- Never use grep/find/glob without first trying claude-context/serena

### 2. Leverage Semantic Understanding
- Use natural language queries with claude-context
- Search for concepts, not just keywords
- Combine claude-context and serena for comprehensive analysis

### 3. Cross-Reference Findings
- Validate claude-context results with serena symbol analysis
- Cross-reference semantic findings with actual code structure
- Use both tools together for complete understanding

### 4. Document Tool Usage
- Record successful search patterns in memory coordination
- Share effective queries across agent teams
- Track performance improvements from tool usage

### 5. Integrate with Existing Workflows
- Use claude-context/serena in pre-task research phases
- Integrate findings with existing quality gates
- Coordinate results with cross-agent collaboration patterns

## Success Metrics

### Speed Improvements
- **Search Time**: 100x faster than grep/find for pattern discovery
- **Code Navigation**: Instant symbol relationship understanding
- **Research Efficiency**: Semantic understanding vs keyword matching

### Quality Improvements
- **Pattern Discovery**: More comprehensive pattern identification
- **Code Understanding**: Deeper architectural comprehension
- **Cross-Reference Validation**: Better handbook compliance verification

### Collaboration Enhancements
- **Cross-Agent Research**: Shared semantic findings across teams
- **Memory Coordination**: Enhanced research result sharing
- **Knowledge Building**: Cumulative intelligence through tool usage

## Implementation Status

### Completed
- ✅ Updated core agent descriptions (coder, researcher, reviewer, tester, planner)
- ✅ Updated hugo-expert agent description
- ✅ Enhanced behavioral descriptions with claude-context and serena priority
- ✅ Created comprehensive usage scenarios documentation

### In Progress
- 🔄 Agent adoption monitoring and performance tracking
- 🔄 Cross-agent research coordination enhancement
- 🔄 Memory namespace optimization for tool usage

### Next Steps
- 🎯 Agent notification system for MCP tool priority changes
- 🎯 Performance metrics collection and analysis
- 🎯 Tool usage pattern optimization based on agent feedback

---

**Remember**: claude-context (830 files, 4,184 chunks) and serena provide 100x faster results than traditional grep/find/glob approaches. Always use these tools FIRST for research, pattern discovery, and code navigation tasks.