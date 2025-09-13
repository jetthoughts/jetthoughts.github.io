# Claude Code Configuration - JT Site

## 📚 CRITICAL: Agent Handbook System

**ALL AGENTS MUST CONSULT HANDBOOKS**: Before any project work, reference the comprehensive guidance system:

- **Primary Reference**: `docs/60.01-agent-guidance-reference.md` - Complete agent operational guidelines
- **Quick Access**: `docs/60.02-agile-framework-reference.md` - Sprint and iteration management
- **Quality Standards**: `docs/60.03-tdd-quality-enforcement.md` - Testing and validation requirements
- **Collaboration**: `docs/60.04-four-eyes-principle.md` - Mandatory pairing protocols
- **Knowledge Management**: `docs/60.05-knowledge-organization.md` - Johnny Decimal + Diátaxis standards

## 🏃 AGILE FRAMEWORK (JT Site)

**Sprint**: #1 "Foundation Sprint" | Jan 6-20, 2025 | Velocity: 40
**Current**: Iteration 1 (Jan 6-12) | Capacity: 200h (5 devs × 40h)

**WIP Limits**: 1 goal, 1 sprint, 1 iteration, 3 stories, 5 tasks max

**Full Details**: See `docs/60.02-agile-framework-reference.md`

## 🧪 QUALITY STANDARDS

**TDD Enforcement**: ACTIVE across all agents
**Coverage Targets**: >80% statements, >75% branches
**Micro-Refactoring**: ≤3 lines per change, ≤50 lines per task
**Zero Tolerance**: Breaking changes, incomplete functionality

**Complete Framework**: See `docs/60.03-tdd-quality-enforcement.md`

## 👥 FOUR-EYES PRINCIPLE (MANDATORY)

**Required Pairing**:
- Code changes: Coder + Reviewer
- Bug fixes: Coder + Tester
- Security: Developer + Security Specialist
- Critical changes: Implementer + Architect

**Checkpoint Validation**: Pre, Mid, Post-implementation with dual sign-off

**Full Protocol**: See `docs/60.04-four-eyes-principle.md`

## 📋 KNOWLEDGE MANAGEMENT

**Structure**: Johnny Decimal (AC.ID-type.md) + Diátaxis classification
**Areas**: 10-99 range with defined purposes
**Validation**: Pre-creation research, cross-references, index updates

**Complete Guidelines**: See `docs/60.05-knowledge-organization.md`

## 🛡️ ANTI-DUPLICATION ENFORCEMENT

**Zero Tolerance**: File suffixes (_refactored, _new, _v2, etc.) BLOCKED
**Tool Usage**: Edit/MultiEdit for existing files, Write only for new files
**Validation**: Pre/during/post-task duplication scanning

**Full System**: See `docs/60.06-anti-duplication-system.md`

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

### Technology Stack
- **Frontend**: React 18, TypeScript, Tailwind CSS
- **Backend**: Node.js, Express, PostgreSQL
- **Testing**: Jest, React Testing Library, Cypress
- **Build**: Vite, ESBuild
- **Deploy**: Docker, AWS/Vercel

### Development Workflow
1. **Sprint Planning**: Define 2-week sprint with 2 iterations
2. **Story Breakdown**: Job stories → tasks → micro-refactoring steps
3. **Agent Coordination**: Four-Eyes pairing for all development
4. **Quality Gates**: TDD enforcement with continuous validation
5. **Knowledge Management**: Document patterns in structured system

### Quick Commands
```bash
# Development
npm start                    # Start development server
npm test                     # Run test suite
npm run build               # Production build

# SPARC Workflow
npx claude-flow@alpha sparc tdd "feature"
npx claude-flow@alpha sparc run architect "design"
npx claude-flow@alpha sparc batch spec-pseudocode "task"

# Agent Coordination
npx claude-flow@alpha swarm init --topology mesh
npx claude-flow@alpha agent spawn --type coder --capabilities react,typescript
npx claude-flow@alpha task orchestrate "implement feature X"
```

### Memory Management
```bash
# Coordination patterns
coordination/jt-site/*              # Cross-agent communication
quality/validation/*                # Quality gate tracking
knowledge/patterns/*                # Pattern libraries
four-eyes/pairing/*                # Paired agent coordination
```

### Environment Configuration
```yaml
project_name: "jt_site"
environment: "development"
claude_flow_version: "2.0.0+"
mcp_servers: ["claude-flow", "ruv-swarm", "flow-nexus"]
quality_enforcement: true
four_eyes_mandatory: true
knowledge_management_active: true
```

---

## 📚 COMPREHENSIVE REFERENCES

All detailed operational procedures, methodologies, and frameworks are documented in the handbook system:

- `docs/60.01-agent-guidance-reference.md` - Complete agent operational guidelines
- `docs/60.02-agile-framework-reference.md` - Sprint management and workflows
- `docs/60.03-tdd-quality-enforcement.md` - Testing standards and validation
- `docs/60.04-four-eyes-principle.md` - Mandatory collaboration protocols
- `docs/60.05-knowledge-organization.md` - Documentation and knowledge management
- `docs/60.06-anti-duplication-system.md` - File management and duplication prevention
- `docs/60.07-agent-coordination-protocols.md` - Cross-agent communication and memory
- `docs/60.08-micro-refactoring-methodology.md` - Safe code change techniques
- `docs/60.09-verification-first-development.md` - Validation and testing approaches

**Remember**: This streamlined configuration provides JT Site-specific settings and quick references. Consult the handbook system for complete operational procedures.