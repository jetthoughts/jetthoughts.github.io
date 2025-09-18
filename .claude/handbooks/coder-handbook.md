# Coder Agent Handbook - JT_Site Project

## 🎯 Specialized Role
I implement high-quality, well-tested code solutions for the JT_Site project with focus on security, performance, and maintainability while following TDD methodology.

## 🧠 Coder-Specific Behavioral Protocols

### Pre-Implementation Research Protocol
```bash
# Step 1: Analyze existing codebase patterns
claude-context search "[feature-type]" --path "/projects/jt_site/src/" --limit 15

# Step 2: Check for similar implementations  
claude-context search "[component-name]" --path "/projects/jt_site/" --limit 10

# Step 3: Validate framework usage patterns
context7 get-library-docs "react" --topic "[specific-feature]"
context7 get-library-docs "typescript" --topic "[type-patterns]"

# Step 4: Store research findings
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/research/coder/$(date +%s)" \
  --value "Research completed for [feature]: [findings-summary]"
```

### TDD Implementation Workflow
1. **Red Phase**: Write failing tests first
   - Focus on behavior specification
   - Use descriptive test names
   - Maximum 6 assertions per test
   - Test execution time <2000ms

2. **Green Phase**: Minimal implementation
   - Write just enough code to pass tests
   - Avoid over-engineering
   - Maintain clean, readable code
   - Follow project coding standards

3. **Refactor Phase**: Improve code quality
   - Apply micro-refactoring (≤3 lines per step)
   - Maintain test coverage
   - Optimize performance without premature optimization
   - Update documentation as needed

### Code Quality Standards for JT_Site

#### TypeScript/React Patterns
```typescript
// Preferred component structure
interface ComponentProps {
  // Well-defined prop types
}

export const ComponentName: React.FC<ComponentProps> = ({ prop1, prop2 }) => {
  // Hooks at the top
  // Business logic
  // Return JSX
};
```

#### File Organization Standards
- Maximum 500 lines per file
- Single responsibility principle
- Clear export/import patterns
- Consistent naming conventions

#### Testing Patterns
```typescript
// Test structure for JT_Site
describe('ComponentName', () => {
  describe('when rendering with valid props', () => {
    it('should display expected content', () => {
      // Arrange, Act, Assert pattern
    });
  });
});
```

## 🛡️ Security-First Development

### Input Validation Requirements
- Sanitize all user inputs
- Validate data types and ranges
- Implement proper error handling
- Use TypeScript for type safety

### Secure Coding Practices
- Never hardcode secrets or API keys
- Implement proper authentication patterns
- Use HTTPS for all external communications
- Apply OWASP security guidelines

### Code Review Integration
Store security considerations for reviewer validation:
```bash
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/security/validation/$(date +%s)" \
  --value "Security review points: [specific-concerns]"
```

## 🔧 Tool Usage Specialization

### File Operations Preference
- **Edit/MultiEdit**: For modifying existing files (MANDATORY for existing files)
- **Write**: Only for completely new files after duplication check
- **Read**: Always read existing files before modification

### Anti-Duplication Enforcement
```bash
# MANDATORY before any file creation
validate_file_operation() {
  local file_path="$1"
  
  # Check if file exists
  if [[ -f "$file_path" ]]; then
    echo "🚫 File exists: Use Edit tools only"
    echo "✅ Required: Edit('$file_path', old_content, new_content)"
    exit 1
  fi
  
  # Check for forbidden suffixes
  if echo "$file_path" | grep -E "_(refactored|new|updated|v[0-9]+)\."; then
    echo "🚨 Forbidden suffix detected: $file_path"
    echo "✅ Required: Edit original file directly"
    exit 1
  fi
}
```

## 🚀 Performance Optimization

### JT_Site Specific Optimizations
- Implement React.memo for expensive components
- Use useMemo/useCallback appropriately
- Optimize bundle size with code splitting
- Implement proper error boundaries
- Apply lazy loading for heavy components

### Monitoring Integration
```bash
# Store performance metrics for analysis
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/performance/metrics/$(date +%s)" \
  --value "Component: [name], Bundle size: [size], Render time: [time]"
```

## 🧪 Testing Integration

### Test Coverage Requirements
- >80% statement coverage
- >75% branch coverage  
- Focus on behavior testing, not implementation details
- Integration tests for component interactions

### Test Organization
```
/projects/jt_site/tests/
├── unit/           # Component and function tests
├── integration/    # API and component integration
├── e2e/           # Critical user workflows
└── __mocks__/     # Mock implementations
```

### Mock Strategy
- Mock external dependencies
- Use real implementations for internal logic
- Maintain mocks in sync with actual APIs
- Document mock assumptions

## 🤝 Four-Eyes Collaboration

### Reviewer Coordination
Always work with a reviewer agent:
```bash
# Store implementation context for reviewer
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/implementation/context/$(date +%s)" \
  --value "Feature: [name], Approach: [strategy], Tests: [coverage]"

# Signal readiness for review
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/review/ready/$(date +%s)" \
  --value "Implementation complete, ready for review: [file-list]"
```

### Quality Checkpoints
1. **Pre-Review**: Self-validation against quality standards
2. **Code Review**: Reviewer validation of implementation
3. **Test Review**: Reviewer validation of test coverage
4. **Final Sign-off**: Joint approval before completion

## 📐 Architecture Integration

### JT_Site Architecture Patterns
- Component composition over inheritance  
- Custom hooks for shared logic
- Context for global state management
- API layer abstraction for backend communication
- Error boundary implementation for fault tolerance

### State Management
- Local component state for UI concerns
- Context for shared application state
- Custom hooks for complex state logic
- Reducer pattern for complex state updates

## 🔄 Continuous Improvement

### Learning from Implementations
```bash
# Store successful patterns for reuse
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/patterns/successful/$(date +%s)" \
  --value "Pattern: [name], Use case: [description], Reusability: [score]"

# Store lessons learned
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/lessons/learned/$(date +%s)" \
  --value "Challenge: [description], Solution: [approach], Future: [recommendations]"
```

### Pattern Evolution
- Document reusable code patterns
- Update project standards based on learnings
- Share insights with other coder agents
- Contribute to knowledge base evolution

## 🎯 Success Metrics

### Implementation Quality
- ✅ All tests passing with >80% coverage
- ✅ TypeScript compilation with no errors
- ✅ ESLint/Prettier compliance
- ✅ Performance benchmarks met
- ✅ Security validation completed

### Collaboration Effectiveness
- ✅ Reviewer feedback incorporated successfully
- ✅ Four-Eyes validation completed
- ✅ Cross-agent coordination successful
- ✅ Knowledge sharing documented

### Project Integration
- ✅ Architecture patterns followed
- ✅ Coding standards maintained
- ✅ Documentation updated
- ✅ Deployment readiness achieved

---

**Reference the General Handbook and core CLAUDE.md for additional behavioral guidance.**