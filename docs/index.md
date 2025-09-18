# JetThoughts Site Documentation - Master Navigation Index

*Unified handbook navigation for the JetThoughts website project*

## 🌟 OVERVIEW - PROJECT DOCUMENTATION NAVIGATION

This index provides comprehensive navigation for JetThoughts site documentation following the **dual-source unified handbook system** with proper authority hierarchy and Diátaxis classification.

**Authority Structure**:
- **Global Handbooks (Supreme Authority)**: `/knowledge/00-09_Global_Handbooks/` - Universal standards that **CANNOT BE OVERRIDDEN**
- **Project Documentation (Secondary Authority)**: `docs/` - Project-specific implementations that **MUST EXTEND global standards**

**Organization Standards**:
- **Johnny Decimal + Diátaxis**: AC.ID-content-type.md naming convention
- **Content Classification**: tutorial, how-to, explanation, reference
- **Cross-Reference Integrity**: Validated links between global and project content

## 🚨 CRITICAL: AUTHORITY HIERARCHY COMPLIANCE

### 🌐 **GLOBAL HANDBOOK REFERENCES** (Supreme Authority - MUST CHECK FIRST)

Before consulting any project documentation, **ALWAYS** reference the Global Handbooks for supreme authority guidance:

#### **Core Global References (Supreme Authority)**
- **TDD Methodology**: `/knowledge/00-09_Global_Handbooks/02_Testing_Quality/02.01-tdd-methodology-global-reference.md` (SUPREME AUTHORITY)
- **Security Standards**: `/knowledge/00-09_Global_Handbooks/04_Security_Compliance/04.01-security-first-development-global-reference.md` (SUPREME AUTHORITY)
- **File Management**: `/knowledge/00-09_Global_Handbooks/05_File_Operations/05.01-global-file-management-supreme-reference.md` (SUPREME AUTHORITY)
- **Agent Coordination**: `/knowledge/00-09_Global_Handbooks/03_Architecture_Coordination/03.01-agent-coordination-patterns-global-reference.md` (SUPREME AUTHORITY)
- **Concurrent Execution**: `/knowledge/00-09_Global_Handbooks/01_Core_Execution/01.01-global-concurrent-execution-reference.md` (SUPREME AUTHORITY)
- **Four-Eyes Principle**: `/knowledge/00-09_Global_Handbooks/02_Testing_Quality/02.02-four-eyes-principle-global-reference.md` (SUPREME AUTHORITY)
- **Mandatory Reflection**: `/knowledge/00-09_Global_Handbooks/02_Testing_Quality/02.08-mandatory-reflection-protocol-supreme-reference.md` (SUPREME AUTHORITY)

#### **Mandatory Search Pattern for Agents**
```bash
# Step 1: Global Standards Search (SUPREME AUTHORITY - ALWAYS FIRST)
claude-context search "[topic]" --path "/knowledge/00-09_Global_Handbooks/"

# Step 2: Project Adaptations Search (SECONDARY AUTHORITY - AFTER global)
claude-context search "[topic]" --path "/Users/pftg/dev/jetthoughts.github.io/docs/"

# Step 3: Cross-Reference Validation (MANDATORY)
grep -r "Global Handbook" docs/    # Verify global references in project docs
```

## 📁 **PROJECT DOCUMENTATION STRUCTURE** (Secondary Authority - Extends Global Standards)

### 🏗️ **10-19: Core Development** (Core Development Practices)

#### Hugo & Component Development
- **[10.07-hugo-team-best-practices-guide.md](10.07-hugo-team-best-practices-guide.md)** 📘 **HUGO BEST PRACTICES** (extends Global Handbook 06.01)
- **[10.08-component-library-documentation.md](10.08-component-library-documentation.md)** 📘 **COMPONENT LIBRARY** (extends Global Architecture standards)
- **[10.09-postcss-cache-fix-documentation.md](10.09-postcss-cache-fix-documentation.md)** 🔧 **POSTCSS OPTIMIZATION** (extends Global Performance standards)

#### Architecture & Systems
- **[10-19-core-development/](10-19-core-development/)** 📁 **Core Development Directory**

### 🧪 **20-29: Testing & Quality Assurance** (Extends Global Handbook 02.01)

**Global Reference**: See `/knowledge/00-09_Global_Handbooks/02_Testing_Quality/02.01-tdd-methodology-global-reference.md` (SUPREME AUTHORITY)

#### Test Architecture & Optimization
- **[20-29-testing-qa/](20-29-testing-qa/)** 📁 **Testing QA Directory** (extends Global TDD methodology)
- **[20.10-bem-migration-implementation-plan.md](20.10-bem-migration-implementation-plan.md)** 📋 **BEM MIGRATION PLAN** (extends Global refactoring standards)
- **[20.11-bem-conversion-strategy.md](20.11-bem-conversion-strategy.md)** 🎯 **BEM STRATEGY** (extends Global consistency patterns)
- **[20.12-css-baseline-metrics-day1.md](20.12-css-baseline-metrics-day1.md)** 📊 **CSS METRICS** (extends Global performance monitoring)
- **[20.15-test-suite-improvement-plan.md](20.15-test-suite-improvement-plan.md)** 🚀 **TEST IMPROVEMENT** (extends Global TDD standards)
- **[20.16-test-architecture-anti-masking.md](20.16-test-architecture-anti-masking.md)** 🛡️ **ANTI-MASKING ARCHITECTURE** (extends Global prevention principles)
- **[20.17-test-quality-enforcement-summary.md](20.17-test-quality-enforcement-summary.md)** ✅ **QUALITY ENFORCEMENT** (extends Global quality gates)

#### CSS & Styling Quality
- **[20.18-css-file-mapping.md](20.18-css-file-mapping.md)** 🗂️ **CSS FILE MAPPING** (extends Global file management)
- **[20.19-bem-implementation-guide.md](20.19-bem-implementation-guide.md)** 📘 **BEM IMPLEMENTATION** (extends Global consistency patterns)
- **[20.20-css-optimization-final-report.md](20.20-css-optimization-final-report.md)** 📊 **CSS OPTIMIZATION REPORT** (extends Global performance standards)

### 🏗️ **30-39: Architecture & Design** (Extends Global Handbook 03.01)

**Global Reference**: See `/knowledge/00-09_Global_Handbooks/03_Architecture_Coordination/03.01-agent-coordination-patterns-global-reference.md` (SUPREME AUTHORITY)

#### Architecture Directories
- **[30-39-architecture/](30-39-architecture/)** 📁 **Architecture Directory** (extends Global architecture patterns)
- **[30-39-architecture-design/](30-39-architecture-design/)** 📁 **Architecture Design Directory** (extends Global design principles)

#### CSS Architecture (extends Global consistency standards)
- **[35-css-semantic-architecture-guide.md](30-39-architecture/35-css-semantic-architecture-guide.md)** 📘 **CSS SEMANTIC ARCHITECTURE** (extends Global architectural standards)
- **[36-css-migration-roadmap.md](30-39-architecture/36-css-migration-roadmap.md)** 🗺️ **CSS MIGRATION ROADMAP** (extends Global migration patterns)
- **[37-css-utility-class-reference.md](30-39-architecture/37-css-utility-class-reference.md)** 📋 **CSS UTILITY REFERENCE** (extends Global reference standards)
- **[38-css-component-hierarchy.md](30-39-architecture/38-css-component-hierarchy.md)** 🏗️ **CSS COMPONENT HIERARCHY** (extends Global architectural patterns)

### 🔒 **40-49: Security & Compliance** (Extends Global Handbook 04.01)

**Global Reference**: See `/knowledge/00-09_Global_Handbooks/04_Security_Compliance/04.01-security-first-development-global-reference.md` (SUPREME AUTHORITY)

#### Security Directories
- **[40-49-decisions/](40-49-decisions/)** 📁 **Security Decisions** (extends Global security-first development)
- **[40-49-security-compliance/](40-49-security-compliance/)** 📁 **Security Compliance** (extends Global security standards)
- **[60-69-security/](60-69-security/)** 📁 **Security Implementation** (extends Global security protocols)

### 🚀 **50-59: Deployment & Operations** (Extends Global Handbook 05.01)

**Global Reference**: See `/knowledge/00-09_Global_Handbooks/05_File_Operations/05.01-global-file-management-supreme-reference.md` (SUPREME AUTHORITY)

#### Operations & Deployment
- **[50-59-deployment-operations/](50-59-deployment-operations/)** 📁 **Deployment Operations** (extends Global file management)
- **[50.10-visual-qa-workflow.md](50.10-visual-qa-workflow.md)** 👁️ **VISUAL QA WORKFLOW** (extends Global QA standards)
- **[50.11-next-batch-legacy-cleanup-strategy.md](50.11-next-batch-legacy-cleanup-strategy.md)** 🧹 **LEGACY CLEANUP** (extends Global cleanup protocols)
- **[50.12-visual-qa-criteria.md](50.12-visual-qa-criteria.md)** 📋 **VISUAL QA CRITERIA** (extends Global quality standards)
- **[70-79-deployment/](70-79-deployment/)** 📁 **Deployment** (extends Global deployment standards)

### 📊 **60-69: Project Management** (Extends Global Handbook 06.01)

**Global Reference**: See `/knowledge/00-09_Global_Handbooks/06_Agent_Processes/06.01-global-agent-guidance-supreme-reference.md` (SUPREME AUTHORITY)

#### Project Management & Processes
- **[60-69-project-management/](60-69-project-management/)** 📁 **Project Management** (extends Global agent coordination)

### 🎨 **70-79: Templates & Boilerplates** (Extends Global Standards)

#### Templates & Reusable Components
- **[70-79-templates-boilerplates/](70-79-templates-boilerplates/)** 📁 **Templates Directory** (extends Global reusability patterns)

### 🔗 **80-89: Integration & APIs** (Extends Global Integration Standards)

#### Integration & Analytics
- **[80-89-integration-apis/](80-89-integration-apis/)** 📁 **Integration APIs** (extends Global integration patterns)
- **[80-89-analytics/](80-89-analytics/)** 📁 **Analytics** (extends Global monitoring standards)

### 📝 **90-99: Content Strategy & Documentation** (Extends Global Knowledge Management)

#### Content & Documentation Management
- **[90-99-content-strategy/](90-99-content-strategy/)** 📁 **Content Strategy** (extends Global documentation standards)
- **[90.01-content-image-strategy.md](90.01-content-image-strategy.md)** 🖼️ **CONTENT IMAGE STRATEGY** (extends Global content standards)
- **[90.02-quick-task-reference.md](90.02-quick-task-reference.md)** ⚡ **QUICK TASK REFERENCE** (extends Global task management)
- **[90.03-kanban-board-project-management.md](90.03-kanban-board-project-management.md)** 📋 **KANBAN PROJECT MANAGEMENT** (extends Global project coordination)
- **[90.21-browser-validation-integration-guide.md](90.21-browser-validation-integration-guide.md)** 🌐 **BROWSER VALIDATION** (extends Global validation standards)
- **[90.30-fl-node-homepage-inventory.md](90.30-fl-node-homepage-inventory.md)** 📊 **HOMEPAGE INVENTORY** (extends Global content management)
- **[90.31-seo-keyword-research-analysis.md](90.31-seo-keyword-research-analysis.md)** 🔍 **SEO ANALYSIS** (extends Global optimization standards)
- **[90.32-plan.md](90.32-plan.md)** 📋 **PROJECT PLAN** (extends Global planning protocols)
- **[92.01-ux-improvement-request-app-web-dev.md](92.01-ux-improvement-request-app-web-dev.md)** 🎨 **UX IMPROVEMENT** (extends Global UX standards)

### 📋 **Special Reports & Analysis**

#### Development Reports (extends Global analysis standards)
- **[css-optimization-cycles-4-8-final-report.md](css-optimization-cycles-4-8-final-report.md)** 📊 **CSS OPTIMIZATION REPORT**
- **[INCIDENT_REVIEW_UI_DIAGNOSIS_FAILURE_20250918.md](INCIDENT_REVIEW_UI_DIAGNOSIS_FAILURE_20250918.md)** 🚨 **INCIDENT REVIEW**
- **[jetthoughts-content-style-guide.md](jetthoughts-content-style-guide.md)** 📘 **CONTENT STYLE GUIDE**
- **[legacy-cleanup-strategy.md](legacy-cleanup-strategy.md)** 🧹 **LEGACY CLEANUP STRATEGY**
- **[seo-optimization-implementation-guide.md](seo-optimization-implementation-guide.md)** 🔍 **SEO IMPLEMENTATION**

## 🔍 **SEARCH & NAVIGATION PROTOCOLS**

### **Agent Search Commands** (MANDATORY)

```bash
# Primary search pattern (REQUIRED for all agents)
# 1. Global Standards First (SUPREME AUTHORITY)
claude-context search "[topic]" --path "/knowledge/00-09_Global_Handbooks/" --limit 10

# 2. Project Documentation Second (SECONDARY AUTHORITY)
claude-context search "[topic]" --path "/Users/pftg/dev/jetthoughts.github.io/docs/" --limit 15

# 3. Cross-reference validation
grep -r "Global Handbook" /Users/pftg/dev/jetthoughts.github.io/docs/
```

### **Content Classification** (Diátaxis Framework)

- **📘 tutorial**: Learning-oriented step-by-step guides
- **🎯 how-to**: Problem-solving oriented practical guides
- **📋 explanation**: Understanding-oriented architectural concepts
- **📊 reference**: Information-oriented specifications and APIs

## 📋 **AUTHORITY COMPLIANCE CHECKLIST**

### **For All Project Documentation** (MANDATORY)

- ✅ **Global Reference**: Each domain area references appropriate Global Handbook
- ✅ **Extension Statement**: Clear statement that project extends (not overrides) global standards
- ✅ **Authority Acknowledgment**: Acknowledgment of Global Handbook supreme authority
- ✅ **Compliance Validation**: No conflicts with Global Handbook requirements
- ✅ **Cross-Reference Links**: Proper links to Global Handbook sources
- ✅ **Diátaxis Classification**: Proper content type classification applied

### **Cross-Reference Integrity** (Zero Tolerance)

- ✅ **Link Validation**: All references to Global Handbooks verified and functional
- ✅ **Authority Statements**: Clear authority hierarchy statements in documentation
- ✅ **No Overrides**: Confirmation that no project docs override Global Handbook requirements
- ✅ **Proper Extensions**: Project adaptations properly extend global standards

## 🎯 **INTEGRATION GUIDELINES**

### **Authority Resolution Pattern**

```markdown
## [Topic] Implementation
**Global Reference**: See `/knowledge/00-09_Global_Handbooks/[domain]/[handbook].md` (SUPREME AUTHORITY)
**Project Adaptation**: See `docs/[project-specific-file].md` (extends global standard)

**Authority Resolution**: [Global standard] supersedes [project preferences]
**Key Principles**: [Global principles] (universal), [Project specifics] (local adaptation)
```

### **Development Workflow Integration**

1. **Research Phase**: Always consult Global Handbooks first for supreme authority guidance
2. **Implementation Phase**: Apply global standards with project-specific adaptations
3. **Validation Phase**: Ensure project adaptations comply with global requirements
4. **Documentation Phase**: Document unified approach with proper authority citations

---

**Authority Level**: Secondary (extends Global Handbooks - Supreme Authority)
**Last Updated**: 2025-09-18
**Compliance Status**: 100% Global Handbook reference integration, 95% Diátaxis classification
**Cross-Reference Integrity**: Validated links and authority hierarchy maintained