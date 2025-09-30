# JT_Site Documentation Hub

## 🎯 Authority Hierarchy

1. **SUPREME AUTHORITY**: `/knowledge/` - Global standards (inherited via symbolic link)
   - Company-wide practices and universal patterns
   - Cannot be overridden by project documentation
   - Automatically propagated to all linked projects

2. **SECONDARY AUTHORITY**: `docs/` - JT_Site project adaptations
   - Project-specific implementations and decisions
   - Must extend (not override) global standards
   - Hugo, CSS, JavaScript, visual testing specifics

## 📚 Navigation Guide

### **Global Standards** (Supreme Authority - Check FIRST)
- **Universal Patterns**: Browse `/knowledge/` for company-wide standards
- **TDD Methodology**: `/knowledge/20.01-tdd-methodology-reference.md`
- **Security Standards**: `/knowledge/40.01-security-first-development.md`
- **Agent Coordination**: `/knowledge/30.01-agent-coordination-patterns.md`
- **Knowledge Management**: `/knowledge/60.01-johnny-decimal-reference.md`

### **JT_Site Specifics** (Secondary Authority - Check SECOND)
- **Project Adaptations**: Browse `docs/` for jt_site implementations
- **Visual Testing**: Project-specific visual regression patterns
- **Hugo Patterns**: Static site generation and CSS patterns
- **Agent Configurations**: See `.claude/agents/` for jt_site agent configs
- **Active Projects**: See `docs/projects/` for current work

### **Cross-Project Learning** (Tertiary Reference)
- **AI Search Patterns**: `/projects/elital_search/docs/` for search implementations
- **Sync Patterns**: `/projects/elital_sync/docs/` for synchronization
- **Testing Tools**: `/projects/snap_diff-capybara/docs/` for visual testing

## 🔍 Research Protocol (MANDATORY for ALL Agents)

### **Step-by-Step Search Sequence**
```bash
# Step 1: Global standards search (SUPREME AUTHORITY - check FIRST)
claude-context search "[topic]" --path "/knowledge/"

# Step 2: JT_Site adaptations search (SECONDARY AUTHORITY - check SECOND)
claude-context search "[topic]" --path "/projects/jt_site/docs/"

# Step 3: Cross-project pattern discovery (TERTIARY REFERENCE)
claude-context search "[topic]" --path "/projects/"

# Step 4: Cross-reference validation (MANDATORY)
grep -r "knowledge/" /projects/jt_site/docs/  # Verify global references
```

### **Research Tools Hierarchy**
1. **claude-context**: Codebase and handbook semantic search
2. **context7**: Online framework documentation
3. **package-search**: Dependencies and source code analysis
4. **searxng/brave-search**: Current best practices validation

## 📝 Before Creating New Documentation

### **Pre-Creation Checklist**
1. ✅ **Search Global Standards**: Check if pattern exists in `/knowledge/`
2. ✅ **Search JT_Site Docs**: Check if pattern exists in `docs/`
3. ✅ **Validate Need**: Confirm new doc is necessary (no duplication)
4. ✅ **Plan Extension**: Determine how to extend (not override) global standards
5. ✅ **Choose Classification**: Select appropriate Johnny Decimal area and Diátaxis type

### **Naming Convention**
```
Format: XX.YY-descriptive-name-diataxis-type.md

Examples:
- 70.01-hugo-static-site-generation-reference.md
- 71.05-css-visual-regression-testing-how-to.md
- 72.08-capybara-test-patterns-tutorial.md
```

### **Required Cross-References**
All docs MUST reference relevant global standards:
```markdown
**Global Reference**: `/knowledge/XX.YY-file-name.md` (Global [standard-type])
**Project Adaptation**: This document extends global standards for JT_Site specifics
```

## 🛡️ Quality Awareness (Guidelines, NOT Enforcement)

### **Anti-Duplication Awareness**
Before adding files, consider:
- 🔍 **Search First**: Use claude-context, Glob, Grep to find existing files
- 📊 **Assess Reuse**: Can existing files accommodate your changes?
- 🔧 **Restructure First**: Consider consolidating before creating new files
- ❌ **Avoid Patterns**: `*_new.*`, `*_refactored.*`, `*_v2.*`, `*_copy.*`

**Note**: These are guidelines for team awareness, NOT automated blocking. Use judgment.

### **Test Quality (Behavioral Focus)**
- 🎯 **Behavior Over Implementation**: Focus tests on business behavior, not internals
- 🚫 **Avoid Test Smells**: Reference `/knowledge/25.04-test-smell-prevention-enforcement-protocols.md`
- 📝 **Descriptive Assertions**: Use clear, descriptive failure messages
- 🧪 **Test-First Development**: Write tests before implementation when appropriate

**Note**: Guidelines are recommendations for better test quality, not rigid enforcement rules.

## 🛠️ JT_Site Tech Stack

### **Core Technologies**
- **Static Site Generator**: Hugo
- **Styling**: CSS, SCSS, Sass
- **JavaScript**: Vanilla JS (minimal, progressive enhancement)
- **Ruby**: Testing infrastructure and tooling

### **Testing Stack**
- **Integration Testing**: Capybara (browser automation)
- **Test Framework**: Minitest
- **Browser Driver**: Selenium WebDriver
- **Visual Testing**: snap_diff-capybara (screenshot comparison)

### **Development Workflow**
- **Version Control**: Git
- **CI/CD**: GitHub Actions
- **Deployment**: Static hosting (GitHub Pages, Netlify, etc.)

## 🚀 Quick Start for Agents

### **New Agent Onboarding**
1. **Read Global Knowledge**: Start with `/knowledge/KNOWLEDGE_INDEX.md`
2. **Review JT_Site Docs**: Browse `docs/` for project-specific patterns
3. **Understand Tech Stack**: Familiarize with Hugo, CSS, Capybara
4. **Check Agent Configs**: Review `.claude/agents/` for existing agent patterns

### **Before Any Implementation**
1. **Research Global Standards**: Check global knowledge for established patterns
2. **Research JT_Site Patterns**: Check project docs for adaptations
3. **Validate Approach**: Ensure compliance with both global and project standards
4. **Coordinate with Experts**: Spawn appropriate expert agents for guidance

## 📋 Documentation Organization

### **Johnny Decimal Areas (JT_Site)**
```
70-79: Static Site Generation & Hugo
80-89: Visual Testing & Browser Automation
90-99: Project-Specific Tooling & Scripts
```

### **Diátaxis Content Types**
- **Tutorial**: Learning-oriented step-by-step guides
- **How-To**: Problem-oriented solutions for specific tasks
- **Explanation**: Understanding-oriented conceptual documentation
- **Reference**: Information-oriented technical specifications

## 🔗 Related Resources

### **Global Handbooks**
- **Master Index**: `/knowledge/KNOWLEDGE_INDEX.md` (99+ documents)
- **TDD Standards**: `/knowledge/20.01-tdd-methodology-reference.md`
- **Four-Eyes Principle**: `/knowledge/20.02-four-eyes-principle-global.md`
- **Security-First**: `/knowledge/40.01-security-first-development.md`

### **Cross-Project Resources**
- **Autonomus AI Swarm**: Main project with comprehensive agent ecosystem
- **Elital Search**: AI search patterns and CrewAI integration
- **Snap Diff Capybara**: Visual regression testing tool (used by jt_site)

---

**Last Updated**: 2025-09-30
**Authority Level**: Navigation Hub (references both Supreme and Secondary authorities)
**Maintenance**: Update when significant documentation structure changes occur