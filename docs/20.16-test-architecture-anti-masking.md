# Test Architecture: Preventing Test Masking

## Overview

This document defines the architectural patterns and enforcement mechanisms to prevent test masking - the dangerous practice where tests appear to pass but actually hide failures.

## Problem Statement

Tests that output messages instead of failing violate fundamental testing principles:
- **Silent Failures**: Tests continue running after problems
- **Custom Logging**: Using puts/print instead of assertions
- **No Fail-Fast**: Tests don't stop on first failure
- **Exception Swallowing**: Rescue blocks that hide errors

## Architectural Solution

### 1. Strict Test Base Classes

All tests MUST inherit from strict base classes that enforce assertions:

```ruby
# For general tests
class MyTest < StrictTestBase
  def test_something
    # MUST use assertions, not puts
    assert condition, "Clear failure message"
  end
end

# For schema tests
class MySchemaTest < StrictSchemaTestBase
  def test_schema
    # Automatic JSON validation with fail-fast
    schema = assert_valid_json(json_string)
  end
end
```

### 2. Mandatory Assertion Helpers

```ruby
# JSON parsing that ALWAYS fails on invalid input
parsed = assert_valid_json(json_string, "Context")

# HTML parsing with validation
doc = assert_valid_html(html_content, "Context")

# File reading with existence check
content = assert_file_exists_and_read(path)

# Element finding with mandatory assertion
elements = assert_element_exists(doc, selector)

# Schema validation with structure checks
assert_schema_structure(data, required_fields)
```

### 3. Fail-Fast Execution

Tests stop immediately on first failure:

```bash
# Run with fail-fast mode
FAIL_FAST=1 rake test

# Or use strict test runner
rake test:architecture:strict
```

### 4. Banned Anti-Patterns

The following patterns are PROHIBITED in tests:

```ruby
# ❌ BANNED: Output instead of assertions
puts "Schema should have context"  # WRONG!

# ✅ CORRECT: Use assertions
assert schema["@context"], "Schema must have context"

# ❌ BANNED: Swallowing exceptions
begin
  JSON.parse(content)
rescue JSON::ParserError
  # Silent failure!
end

# ✅ CORRECT: Let it fail or use helper
parsed = assert_valid_json(content)

# ❌ BANNED: Tests without assertions
def test_something
  doc = parse_file("test.html")
  # No assertions!
end

# ✅ CORRECT: Always assert
def test_something
  doc = parse_file("test.html")
  assert doc.css("title").any?, "Document must have title"
end
```

## Enforcement Mechanisms

### 1. Architectural Enforcement Plugin

Automatically detects and prevents anti-patterns:

```ruby
# test_helper_strict.rb enables:
- Minimum assertion requirement per test
- Banned output methods (puts/print/p)
- Fail-fast on first failure
- Quality monitoring
```

### 2. Rake Tasks for Validation

```bash
# Validate architecture
rake test:architecture:validate

# Analyze test quality
rake test:architecture:quality

# Run with strict enforcement
rake test:architecture:strict

# Auto-fix common issues
rake test:architecture:fix

# Generate compliance report
rake test:architecture:report
```

### 3. CI/CD Integration

Add to CI pipeline:

```yaml
# .github/workflows/test.yml
- name: Validate Test Architecture
  run: rake test:architecture:validate

- name: Run Tests with Strict Mode
  env:
    STRICT_TEST_MODE: "1"
    FAIL_FAST: "1"
  run: rake test:architecture:strict
```

## Migration Guide

### Step 1: Update Base Classes

```ruby
# Before
class MyTest < Minitest::Test

# After
class MyTest < StrictTestBase
```

### Step 2: Replace Output with Assertions

```ruby
# Before
puts "Value should be present"

# After
assert value.present?, "Value must be present"
```

### Step 3: Remove Exception Swallowing

```ruby
# Before
begin
  JSON.parse(content)
rescue => e
  nil
end

# After
assert_valid_json(content, "Context")
```

### Step 4: Add Assertions to All Tests

```ruby
# Before
def test_page_loads
  visit "/page"
  # No assertion!
end

# After
def test_page_loads
  visit "/page"
  assert page.has_content?("Expected"), "Page must load with content"
end
```

## Quality Metrics

Tests are scored on:
- **Assertions Present**: -20 points if missing
- **No Rescue Blocks**: -30 points for swallowing errors
- **No Output Statements**: -25 points for puts/print
- **Fail-Fast Compliance**: -25 points if continues after failure

Target: Minimum quality score of 80/100

## Benefits

1. **Immediate Failure Detection**: Problems surface instantly
2. **Clear Error Messages**: Assertions provide context
3. **Faster Debugging**: Fail-fast stops at the problem
4. **Reliable CI/CD**: No false positives
5. **Maintainable Tests**: Clear expectations

## Enforcement Rules

1. **MUST** inherit from StrictTestBase or StrictSchemaTestBase
2. **MUST** have at least one assertion per test
3. **MUST NOT** use puts/print/p for validation
4. **MUST NOT** rescue exceptions without failing
5. **MUST** use assertion helpers for parsing
6. **MUST** provide clear failure messages
7. **SHOULD** use fail-fast mode in CI/CD
8. **SHOULD** maintain quality score above 80

## Tools and Commands

```bash
# Validate architecture before commit
rake test:architecture:validate

# Run tests with all enforcements
STRICT_TEST_MODE=1 FAIL_FAST=1 rake test

# Check quality score
rake test:architecture:quality

# Generate compliance report
rake test:architecture:report
```

## Conclusion

This architecture ensures tests actually test, rather than pretending to test. By enforcing assertions, preventing output, and failing fast, we eliminate test masking and ensure genuine quality validation.