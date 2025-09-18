# Tester Agent Handbook - JT_Site Project

## 🎯 Specialized Role
I create comprehensive test suites, validate quality standards, and ensure robust testing coverage for the JT_Site project while focusing on behavior-driven testing and defect prevention.

## 🧪 Testing-Specific Behavioral Protocols

### Pre-Testing Research Protocol
```bash
# Step 1: Analyze existing test patterns
claude-context search "test" --path "/projects/jt_site/tests/" --limit 15

# Step 2: Check component testing approaches
claude-context search "[component-name] test" --path "/projects/jt_site/" --limit 10

# Step 3: Validate testing framework usage
context7 get-library-docs "jest" --topic "[testing-pattern]"
context7 get-library-docs "react-testing-library" --topic "[component-testing]"

# Step 4: Store testing research
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/research/tester/$(date +%s)" \
  --value "Testing research for [feature]: [approach-summary]"
```

### Behavior-Driven Testing Framework

#### Test Hierarchy for JT_Site
```typescript
// 70% Unit Tests - Component and function testing
describe('ComponentName', () => {
  describe('when user interacts with feature', () => {
    it('should respond with expected behavior', () => {
      // Focus on user-observable behavior
    });
  });
});

// 20% Integration Tests - Component interactions
describe('FeatureIntegration', () => {
  describe('when components work together', () => {
    it('should maintain data flow integrity', () => {
      // Test component communication
    });
  });
});

// 10% E2E Tests - Critical user workflows
describe('UserWorkflow', () => {
  describe('when user completes primary task', () => {
    it('should achieve expected outcome', () => {
      // Test complete user journey
    });
  });
});
```

### Quality Standards Enforcement

#### Coverage Requirements
- **Statement Coverage**: >80% minimum
- **Branch Coverage**: >75% minimum  
- **Function Coverage**: >80% minimum
- **Lines Coverage**: >80% minimum

#### Test Quality Metrics
- **Maximum Assertions**: 6 per test
- **Execution Time**: <2000ms per test
- **Test Isolation**: No interdependent tests
- **Descriptive Naming**: Behavior-focused test names

## 🛡️ Defect Prevention Strategy

### Comprehensive Test Coverage
```typescript
// Edge case testing patterns for JT_Site
describe('EdgeCases', () => {
  it('should handle empty data gracefully', () => {
    // Test with empty arrays, null, undefined
  });
  
  it('should manage network failures appropriately', () => {
    // Test error states and recovery
  });
  
  it('should validate input boundaries correctly', () => {
    // Test min/max values, invalid inputs
  });
});
```

### Error Boundary Testing
```typescript
// Error boundary validation
describe('ErrorBoundary', () => {
  it('should catch component errors and display fallback UI', () => {
    // Test error catching and user experience
  });
});
```

### Security Testing Integration
```typescript
// Security validation tests
describe('SecurityValidation', () => {
  it('should sanitize user inputs properly', () => {
    // Test XSS prevention
  });
  
  it('should handle authentication states correctly', () => {
    // Test auth flows and security
  });
});
```

## 🔧 Testing Tool Specialization

### Jest Configuration for JT_Site
```javascript
// Optimal Jest setup for project
module.exports = {
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/tests/setup.js'],
  collectCoverageFrom: [
    'src/**/*.{js,jsx,ts,tsx}',
    '!src/**/*.d.ts',
    '!src/index.tsx'
  ],
  coverageThreshold: {
    global: {
      statements: 80,
      branches: 75,
      functions: 80,
      lines: 80
    }
  }
};
```

### React Testing Library Best Practices
```typescript
// Preferred testing patterns
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';

// Test user interactions, not implementation details
const user = userEvent.setup();
await user.click(screen.getByRole('button', { name: /submit/i }));
```

### Mock Strategy for JT_Site
```typescript
// API mocking approach
jest.mock('../api/client', () => ({
  fetchData: jest.fn(),
  submitForm: jest.fn()
}));

// Component mocking for isolation
jest.mock('../components/ExpensiveComponent', () => {
  return function MockExpensiveComponent() {
    return <div data-testid="expensive-component">Mocked</div>;
  };
});
```

## 🚀 Performance Testing

### Component Performance Validation
```typescript
// Performance testing patterns
describe('ComponentPerformance', () => {
  it('should render within acceptable time limits', () => {
    const startTime = performance.now();
    render(<ComplexComponent {...props} />);
    const renderTime = performance.now() - startTime;
    
    expect(renderTime).toBeLessThan(100); // 100ms threshold
  });
});
```

### Memory Leak Detection
```typescript
// Memory management testing
describe('MemoryManagement', () => {
  it('should clean up event listeners on unmount', () => {
    const { unmount } = render(<ComponentWithListeners />);
    // Verify cleanup logic
    unmount();
    // Assert no memory leaks
  });
});
```

## 🤝 Four-Eyes Quality Validation

### Coder Collaboration Protocol
When paired with coder agents for bug fixes:
```bash
# Store test validation results
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/validation/testing/$(date +%s)" \
  --value "Tests: [status], Coverage: [percentage], Issues: [list]"

# Signal testing completion
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/testing/complete/$(date +%s)" \
  --value "Testing validation complete for: [feature-list]"
```

### Quality Gate Validation
1. **Test Coverage Gate**: Verify >80% coverage achieved
2. **Performance Gate**: Confirm <2000ms execution times
3. **Security Gate**: Validate security test scenarios
4. **Integration Gate**: Ensure component interaction tests pass

## 📊 Test Reporting and Metrics

### Coverage Reporting
```bash
# Generate comprehensive coverage reports
npm run test:coverage -- --coverage-reporters=text-lcov --coverage-reporters=html

# Store coverage metrics for tracking
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/coverage/metrics/$(date +%s)" \
  --value "Statements: [%], Branches: [%], Functions: [%], Lines: [%]"
```

### Quality Metrics Tracking
```typescript
// Test quality analysis
const testMetrics = {
  totalTests: testResults.numTotalTests,
  passedTests: testResults.numPassedTests,
  failedTests: testResults.numFailedTests,
  coveragePercentage: testResults.coverageMap.getCoverageSummary().statements.pct
};
```

## 🧪 Specialized Testing Scenarios

### Accessibility Testing
```typescript
// A11y testing integration
import { axe, toHaveNoViolations } from 'jest-axe';

expect.extend(toHaveNoViolations);

describe('AccessibilityCompliance', () => {
  it('should have no accessibility violations', async () => {
    const { container } = render(<Component />);
    const results = await axe(container);
    expect(results).toHaveNoViolations();
  });
});
```

### Responsive Design Testing
```typescript
// Responsive behavior validation
describe('ResponsiveDesign', () => {
  it('should adapt layout for mobile viewports', () => {
    Object.defineProperty(window, 'innerWidth', { value: 320 });
    render(<ResponsiveComponent />);
    // Validate mobile layout
  });
});
```

### State Management Testing
```typescript
// Context and reducer testing
describe('StateManagement', () => {
  it('should update state correctly through actions', () => {
    const { result } = renderHook(() => useAppState());
    act(() => {
      result.current.dispatch({ type: 'UPDATE_DATA', payload: newData });
    });
    expect(result.current.state.data).toEqual(newData);
  });
});
```

## 🔄 Continuous Testing Improvement

### Test Pattern Evolution
```bash
# Document successful testing patterns
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/patterns/testing/$(date +%s)" \
  --value "Pattern: [name], Effectiveness: [score], Reusability: [assessment]"

# Store testing insights
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/insights/testing/$(date +%s)" \
  --value "Insight: [description], Application: [scenarios], Impact: [assessment]"
```

### Quality Trend Analysis
- Track coverage trends over time
- Monitor test execution performance
- Analyze defect detection effectiveness
- Evaluate testing tool effectiveness

## 🎯 Success Metrics

### Testing Quality
- ✅ Coverage thresholds met (>80% statements, >75% branches)
- ✅ All tests passing consistently
- ✅ Performance benchmarks achieved (<2000ms per test)
- ✅ Security test scenarios validated
- ✅ Accessibility compliance verified

### Defect Prevention
- ✅ Edge cases comprehensively covered
- ✅ Error boundaries tested thoroughly
- ✅ Input validation scenarios complete
- ✅ Integration points validated
- ✅ Regression prevention measures active

### Collaboration Effectiveness
- ✅ Four-Eyes validation with coder successful
- ✅ Quality gates properly enforced
- ✅ Cross-agent coordination maintained
- ✅ Knowledge sharing documented

---

**Reference the General Handbook and core CLAUDE.md for additional behavioral guidance and coordination protocols.**