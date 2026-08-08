> ⚠️ **ARCHIVED 2026-08-08** — superseded by 60-69/60.03-tdd-quality-enforcement.md + 60.14 + 60.18 doctrine.

# Test Quality Enforcement Summary

## 🎯 **QUICK REFERENCE FOR AGENTS**

This document summarizes the test quality enforcement system using **EXISTING PROJECT INFRASTRUCTURE ONLY**.

### **Primary Validation Tool: bin/test**

```bash
# Individual test validation
bin/test test/unit/specific_test.rb

# Full test suite validation
bin/test

# Hugo build validation
bun run test:build
```

## 🚨 **CRITICAL: PROHIBITED TEST PATTERNS**

These patterns will result in **IMMEDIATE REJECTION**:

```ruby
# ❌ BLOCKED: Output statements without assertions
def test_something
  puts "Processing data..."  # VIOLATION
  print "Result: #{result}" # VIOLATION
  p data                   # VIOLATION
end

# ❌ BLOCKED: No assertions
def test_behavior
  user = create_user      # NO VALIDATION
  process_data(user)      # NO ASSERTIONS
  # Test does nothing meaningful
end
```

## ✅ **REQUIRED: PROPER TEST PATTERNS**

Every test must follow these patterns:

```ruby
# ✅ CORRECT: Assertion-based validation
def test_user_creation
  user = User.new(name: "John")

  assert_equal "John", user.name    # REQUIRED
  assert_kind_of User, user         # REQUIRED
end

# ✅ CORRECT: Error condition testing
def test_invalid_data
  user = User.new(name: "")

  refute user.valid?                # REQUIRED
  assert_includes user.errors[:name], "can't be blank"
end

# ✅ CORRECT: Explicit failure for TDD
def test_upcoming_feature
  flunk "Feature not implemented yet"  # ACCEPTABLE
end
```

## 📋 **REQUIRED ASSERTION METHODS**

Use these Minitest assertion methods in every test:

- `assert_equal(expected, actual)` - Values must match
- `assert_kind_of(Class, object)` - Type validation
- `assert_includes(collection, item)` - Collection membership
- `refute(condition)` - Negative assertions
- `refute_nil(object)` - Object existence validation
- `flunk("message")` - Explicit test failure

## 🔄 **TDD WORKFLOW WITH EXISTING TOOLS**

### Step 1: Write Failing Test
```bash
# Create test file with failing test
touch test/unit/new_feature_test.rb
bin/test test/unit/new_feature_test.rb  # Should fail
```

### Step 2: Make Test Pass
```bash
# Write minimal code to pass test
bin/test test/unit/new_feature_test.rb  # Should pass
```

### Step 3: Refactor Safely
```bash
# Ensure all tests continue passing
bin/test  # Full suite validation
```

## 🏗️ **EXISTING PROJECT STRUCTURE**

Leverage the existing test organization:

```
test/
├── unit/           # Unit tests with assertions
├── system/         # Browser-based system tests
└── support/        # Test helpers and utilities

Tools:
├── bin/test        # Primary test runner
├── Rakefile        # Test task configuration
└── package.json    # Hugo build validation scripts
```

## 🚀 **HUGO-SPECIFIC VALIDATION**

Use existing Hugo validation tools:

```bash
bun run build      # Standard Hugo build
bun run test:build  # Production rendering with diagnostics
bin/test           # Ruby test suite including Hugo tests
```

## 📊 **QUALITY METRICS**

Every test must meet these standards:
- **100% assertion coverage**: Every test has at least one assertion
- **Zero output statements**: No puts, print, or p without assertions
- **Behavior validation**: Tests verify what code does, not how
- **Clear naming**: Test method names describe expected behavior

## 🛡️ **ENFORCEMENT MECHANISM**

The existing `bin/test` script automatically enforces these standards:
1. Runs `bundle exec rake test`
2. Executes all `test/**/*_test.rb` files
3. Minitest framework validates assertion presence
4. Output-only tests get flagged as meaningless
5. Missing assertions result in zero-assertion test reports

**Remember**: Use existing project infrastructure (`bin/test`, `bun run test:build`) rather than creating new validation tools.