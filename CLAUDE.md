# Claude Code Configuration - JT Site (Hugo-based Static Site)

## 📖 **UNIFIED HANDBOOK NAVIGATION**

### 🎯 **START HERE FOR ALL GUIDANCE**
**📚 Primary Navigation Hub**: **`docs/60.01-agent-guidance-reference.md`** - Complete agent operational guidelines
- Cross-references between global (`/knowledge/` via symlink) and project (`/docs/`) handbooks
- Authority hierarchy explained (global standards supersede project adaptations)
- Complete navigation structure for both handbook sources

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

#### **Framework & Package Research**: Hugo + Static Site Tools
```bash
# Hugo documentation and patterns
context7 resolve-library-id "hugo"
context7 get-library-docs "/gohugoio/hugo" --topic "[topic]"

# Package source analysis for Node.js tools
mcp__package-search__package_search_hybrid \
  --registry_name "npm" \
  --package_name "[package]" \
  --semantic_queries '["hugo integration", "static site generation"]'

# Web search for Hugo/JAMstack patterns
mcp__searxng__search "[hugo OR jamstack OR static site] [topic]"
```

## 🚨 CRITICAL: Agent Handbook System

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

## 🛡️ EXPERT AGENT CONFIGURATIONS (Hugo/Static Site Specialized)

### Security Expert (Zero-Trust Architecture for Static Sites)
**MANDATORY**: Zero vulnerabilities tolerance with JAMstack security compliance
- Content Security Policy: 100% strict CSP for static assets
- Secret management: Zero hardcoded secrets in Hugo configs/content
- Dependency scanning: Hugo modules and Node.js packages
- Static asset integrity: Subresource integrity for all external resources
- HTTPS enforcement: All deployments via secure protocols

### QA Expert (Zero-Defect Static Site Methodology)
**MANDATORY**: 100% functional correctness for Hugo builds and content
- Build validation: Hugo build must complete without errors/warnings
- Content quality: Markdown linting, link validation, image optimization
- Performance gates: Lighthouse scores >90 across all metrics
- Cross-browser testing: Static site compatibility validation
- SEO compliance: Meta tags, structured data, accessibility standards

### Architecture Expert (JAMstack & Hugo Patterns)
**MANDATORY**: Clean Hugo architecture with performance optimization
- Hugo structure: Proper theme/layout separation, modular shortcodes
- Content organization: Logical content taxonomies and URL structures
- Asset optimization: Image processing, CSS/JS bundling, CDN integration
- Build optimization: Efficient Hugo build times and caching strategies
- Deployment architecture: Static site hosting patterns (Netlify/Vercel/S3)

### Performance Expert (Static Site Optimization)
**MANDATORY**: <200ms first load, optimal Core Web Vitals
- Page load speed: <200ms first contentful paint
- Build performance: Hugo build times <30 seconds for full site
- Asset optimization: WebP images, minified CSS/JS, tree-shaking
- CDN strategies: Global content distribution optimization
- Caching policies: Optimal cache headers for static assets

### Knowledge Expert (Hugo Content Management)
**MANDATORY**: Zero-duplication content with intelligent Hugo organization
- Content structure: Logical Hugo content organization with taxonomies
- Markdown standards: Consistent frontmatter and content formatting
- Hugo modules: Dependency management and theme organization
- Documentation: Hugo shortcodes, templates, and configuration docs
- SEO optimization: Content discoverability and search optimization

## 🧪 QUALITY STANDARDS & SIMPLICITY

**TDD Enforcement**: ACTIVE across all agents
**Coverage Targets**: >80% statements, >75% branches
**Micro-Refactoring**: ≤3 lines per change, ≤50 lines per task
**Zero Tolerance**: Breaking changes, incomplete functionality

**SIMPLICITY REQUIREMENTS**:
- Scripts under 50 lines when possible
- Functions under 20 lines
- Clear, self-documenting code
- Remove unused code immediately
- Consolidate duplicate functionality

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

## 🛡️ SIMPLICITY & ANTI-DUPLICATION ENFORCEMENT

**CRITICAL MANDATE**: Always choose the SIMPLEST solution that works
**Zero Tolerance**:
- File suffixes (_refactored, _new, _v2, etc.) BLOCKED
- Overengineered custom solutions when standard tools exist
- Complex abstractions when simple code works
- Multiple similar scripts or files

**Tool Usage**: Edit/MultiEdit for existing files, Write only for new files
**Validation**: Pre/during/post-task duplication and complexity scanning

**SIMPLICITY PRINCIPLES**:
- Use existing tools/libraries before building custom solutions
- Delete complex code in favor of simple alternatives
- One file per purpose, no redundant variations
- Readable code over clever code
- Standard patterns over custom frameworks

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

### Expert Agents (5) - Hugo Specialized
`security-expert`, `qa-expert`, `architecture-expert`, `performance-expert`, `knowledge-expert`

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

### Quick Commands (Hugo JAMstack)
```bash
# Hugo Development
bin/hugo-dev                 # Start development server (http://localhost:1313)
bin/hugo-build               # Build optimized site for production
bin/hugo-clean               # Clean build artifacts and caches
bun run serve                # Development server with live reload
bun run build:production     # Full production build with minification

# Testing & Validation (Hugo specific)
bun run test                 # Run complete test suite (build + links)
bun run test:build           # Validate Hugo can render all content
bun run test:links           # Check for broken internal/external links
bin/dtest                    # Docker-based integration tests
bun run test:performance     # Lighthouse performance audit

# Content & SEO
bun run lint:hugo            # Hugo template and content validation
bun run analyze              # Hugo template metrics and optimization hints
markdownlint content/        # Markdown content quality check

# Performance Optimization
bun run clean:cache          # Clear Hugo resource generation cache
bun run build:preview        # Build with drafts and future content

# Expert Agent Consultation Examples
Task("Security Expert", "Audit Hugo config and static assets for security", "security-expert")
Task("Performance Expert", "Optimize Core Web Vitals and build performance", "performance-expert")
Task("SEO Expert", "Audit content for SEO compliance and structured data", "seo-expert")
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

### Hugo Development with Expert Consultation
```bash
# Single message - Complete Hugo feature development
[Parallel Expert-Enhanced Execution]:
  Task("Security Expert", "Audit Hugo config, CSP headers, and static asset security", "security-expert")
  Task("Performance Expert", "Optimize Core Web Vitals, build performance, and asset delivery", "performance-expert")
  Task("Architecture Expert", "Design Hugo module structure and template organization", "architecture-expert")
  Task("QA Expert", "Validate Hugo build, content quality, and SEO compliance", "qa-expert")
  Task("Knowledge Expert", "Organize content taxonomy and documentation structure", "knowledge-expert")
  Task("Hugo Developer", "Implement feature following expert guidance", "hugo-developer")
  Task("Content Specialist", "Optimize markdown content and frontmatter", "content-specialist")

  TodoWrite { todos: [8-10 todos including expert consultations] }
```

### Expert Consultation Protocol (Hugo-Specific)
- Hugo configuration issues → Architecture Expert + Security Expert
- Content organization → Knowledge Expert + SEO Expert
- Build performance → Performance Expert + Architecture Expert
- Content quality → QA Expert + Content Specialist
- Security headers/CSP → Security Expert + Hugo Developer

### Environment Configuration (Hugo JAMstack)
```yaml
project_name: "jt_site"
project_type: "hugo_static_site"
tech_stack: "hugo+postcss+tailwind+bun"
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
