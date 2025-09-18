# Agent General Handbook

## 🎯 Purpose
This handbook provides common behavioral protocols and standards that apply to all agents working on the jt_site project. It complements the core CLAUDE.md configuration with project-specific guidance.

## 🧠 Core Behavioral Framework

### Research-First Methodology
Every agent MUST follow this research sequence before implementation:

1. **Knowledge Base Consultation**
   ```bash
   claude-context search "[task-topic]" --path "/knowledge/" --limit 10
   ```

2. **Existing Pattern Analysis**
   ```bash
   claude-context search "[implementation-pattern]" --path "/projects/jt_site/" --limit 15
   ```

3. **Framework Validation**
   ```bash
   context7 get-library-docs "[relevant-framework]" --topic "[specific-area]"
   ```

4. **Cross-Reference Validation**
   - Check Johnny Decimal areas (20-29 for testing, 30-39 for standards)
   - Validate Diátaxis content types (tutorial, how-to, explanation, reference)
   - Ensure no content duplication exists

### Memory Coordination Patterns
All agents use structured memory keys for cross-agent coordination:

```bash
# Project-specific memory patterns
project/jt_site/task/[agent-type]/[timestamp]
project/jt_site/progress/[feature]/[status]  
project/jt_site/quality/[validation-type]/[results]
project/jt_site/research/[topic]/[findings]
```

## 🛡️ Quality Assurance Framework

### Zero-Defect Implementation Standards
1. **Functional Correctness**: 100% feature completion before task finalization
2. **Technical Debt**: Zero tolerance for TODO, FIXME, HACK patterns
3. **Consistency**: Adherence to project coding standards and patterns
4. **Security**: Input validation and secure coding practices applied

### Four-Eyes Validation Protocol
Every significant change requires paired agent validation:
- Implementation agent performs the work
- Validation agent reviews for quality, correctness, and compliance
- Both agents must sign-off before task completion

### Anti-Duplication Enforcement
- NEVER create files with suffixes like `_new`, `_refactored`, `_updated`
- ALWAYS use Edit/MultiEdit tools for existing file modifications
- ALWAYS search existing codebase before creating new files

## 📐 Project-Specific Standards

### File Organization for JT_Site
```
/projects/jt_site/
├── src/                    # Source code
├── tests/                  # Test files
├── docs/                   # Project documentation
├── .claude/
│   ├── agents/            # Project-specific agent configs
│   └── handbooks/         # This handbook system
└── knowledge/             # Project knowledge base
```

### Code Quality Requirements
- **Test Coverage**: >80% statement coverage, >75% branch coverage
- **File Size**: Maximum 500 lines per file
- **Complexity**: Single responsibility principle enforced
- **Documentation**: Self-documenting code with minimal essential comments

### Technology Stack Awareness
Agents working on jt_site should be familiar with:
- Frontend: React, TypeScript, CSS-in-JS
- Backend: Node.js, Express, PostgreSQL  
- Testing: Jest, React Testing Library
- Build: Webpack, Babel, ESLint
- Deployment: Docker, CI/CD pipelines

## 🔧 Tool Usage Patterns

### Preferred Tool Hierarchy
1. **Claude Code Tools**: Primary execution (Task, Read, Write, Edit, Bash)
2. **Claude-Context**: Codebase search and pattern discovery
3. **Context7**: Framework documentation and specifications
4. **MCP Tools**: Coordination and memory management only

### Memory Usage Best Practices
- Store research findings for cross-agent access
- Persist task progress for session continuity
- Share quality validation results across agents
- Maintain cross-reference integrity in knowledge base

## 🚀 Performance Optimization

### Concurrent Execution Requirements
All agents MUST batch operations in single messages:
- Multiple file operations together
- Coordinated agent spawning
- Bulk todo list updates
- Combined bash command sequences

### Efficiency Guidelines
- Minimize redundant searches and validations
- Reuse established patterns from knowledge base
- Cache research findings in memory for reuse
- Optimize tool usage for reduced overhead

## 🧪 Project-Specific TDD Guidelines

### Test Structure for JT_Site
- Unit tests: Focus on individual functions/components
- Integration tests: API endpoints and component interactions
- E2E tests: Critical user workflows only
- Performance tests: Key performance metrics validation

### Testing Framework Usage
- Jest for unit and integration testing
- React Testing Library for component testing
- Cypress for E2E testing (when required)
- Performance testing tools as needed

## 📚 Knowledge Management Integration

### Johnny Decimal Navigation for JT_Site
- 10-19: Project foundation and setup
- 20-29: Testing and quality assurance
- 30-39: Development standards and practices
- 40-49: Knowledge management and documentation
- 50-59: Operations and deployment

### Diátaxis Content Creation
- **Tutorial**: Step-by-step learning content
- **How-to**: Problem-solving guides
- **Explanation**: Conceptual background
- **Reference**: Lookup information

## 🎯 Success Metrics

### Quality Indicators
- ✅ Zero technical debt accumulation
- ✅ 100% functional correctness achieved
- ✅ Four-Eyes validation completed for all changes
- ✅ Knowledge base integration maintained
- ✅ Cross-agent coordination successful

### Performance Indicators  
- ✅ Task completion within estimated timeframes
- ✅ Minimal revision cycles through quality gates
- ✅ Effective reuse of established patterns
- ✅ Optimal tool usage and resource efficiency

## 🔄 Continuous Improvement

### Learning Integration
Agents should continuously improve by:
- Analyzing successful implementation patterns
- Learning from quality validation feedback
- Updating personal knowledge from project experiences
- Sharing insights through memory coordination system

### Pattern Evolution
Contribute to project pattern library by:
- Documenting successful solution approaches
- Identifying reusable code and configuration patterns
- Updating knowledge base with new insights
- Maintaining cross-reference integrity

---

**This handbook should be referenced alongside the core CLAUDE.md and specialized agent handbooks for comprehensive behavioral guidance.**