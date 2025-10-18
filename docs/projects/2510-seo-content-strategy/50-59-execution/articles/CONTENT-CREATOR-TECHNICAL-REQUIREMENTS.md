# Content Creator Technical Requirements: Ruby/Rails LangChain Article

**Purpose**: Guide for content-creator to ensure code examples pass technical validation
**Target Article**: Ruby on Rails LangChain Getting Started Guide (2025)
**Technical Reviewer**: Available for validation after draft completion

---

## Technical Validation Checklist (Content Creator Self-Check)

### Before Requesting Technical Validation

**✅ Complete this checklist BEFORE submitting draft for technical review:**

```yaml
code_quality_checklist:
  syntax_validation:
    - [ ] All code uses valid Ruby 3.2+ syntax
    - [ ] No deprecated Ruby methods used
    - [ ] All require statements are correct
    - [ ] Code follows Ruby style guide (2-space indentation, descriptive names)

  completeness_validation:
    - [ ] ALL necessary require statements included at top of examples
    - [ ] Gemfile snippet provided with versions
    - [ ] Environment setup instructions included (.env file example)
    - [ ] Setup steps clearly documented

  security_validation:
    - [ ] NO hardcoded API keys anywhere in code
    - [ ] ALL API keys use ENV['VARIABLE_NAME'] pattern
    - [ ] Input validation examples included where appropriate
    - [ ] Security best practices mentioned

  production_readiness:
    - [ ] Error handling patterns demonstrated (begin/rescue/end)
    - [ ] Logging examples included
    - [ ] Performance considerations mentioned
    - [ ] Rate limiting guidance provided

  testing_validation:
    - [ ] I tested EVERY code example personally
    - [ ] Code runs without errors on Ruby 3.2+
    - [ ] Code produces expected output
    - [ ] All dependencies are available via bundler
```

---

## Code Example Template (Copy-Paste Ready)

### Template 1: Basic LLM Call (Installation & Setup)

```ruby
# Gemfile
source 'https://rubygems.org'

gem 'langchain-ruby', '~> 0.10.0'
gem 'ruby-openai', '~> 6.0'
gem 'dotenv', '~> 2.8'

# Run: bundle install

# .env file (DO NOT commit to version control)
# OPENAI_API_KEY=your_actual_openai_api_key_here
# ANTHROPIC_API_KEY=your_actual_anthropic_api_key_here

# basic_llm_call.rb
require 'langchain'
require 'dotenv/load'

# Load API key from environment (SECURE PATTERN)
api_key = ENV['OPENAI_API_KEY']

begin
  # Initialize LangChain LLM
  llm = Langchain::LLM::OpenAI.new(api_key: api_key)

  # Make a simple completion request
  response = llm.complete(prompt: "Explain Ruby on Rails in one sentence")

  puts "Response: #{response}"

rescue Langchain::LLM::ApiError => e
  # Handle API-specific errors
  puts "API Error: #{e.message}"
  puts "Please check your API key and network connection"

rescue StandardError => e
  # Handle unexpected errors
  puts "Unexpected error: #{e.message}"
end
```

**✅ This example demonstrates:**
- Complete imports (langchain, dotenv)
- Gemfile with versions
- Environment variable usage (secure)
- Error handling (API-specific + fallback)
- Clear comments explaining each step
- Production-ready pattern

---

### Template 2: RAG Implementation (Vector Search)

```ruby
# Gemfile additions
gem 'pg', '~> 1.5'
gem 'pgvector', '~> 0.3'
gem 'ruby-openai', '~> 6.0'

# rag_example.rb
require 'langchain'
require 'dotenv/load'
require 'pg'

# Database configuration (use ENV in production)
db_config = {
  host: ENV.fetch('DATABASE_HOST', 'localhost'),
  port: ENV.fetch('DATABASE_PORT', 5432),
  dbname: ENV.fetch('DATABASE_NAME', 'rails_ai_dev'),
  user: ENV.fetch('DATABASE_USER', 'postgres'),
  password: ENV.fetch('DATABASE_PASSWORD', 'password')
}

begin
  # Connect to PostgreSQL with pgvector
  conn = PG.connect(db_config)

  # Initialize OpenAI embeddings
  embeddings = Langchain::LLM::OpenAI.new(
    api_key: ENV['OPENAI_API_KEY'],
    default_options: { model: 'text-embedding-3-small' }
  )

  # Example: Embed a query
  query = "How do I install LangChain in Ruby?"
  query_embedding = embeddings.embed(text: query)

  # Perform vector similarity search (pgvector syntax)
  results = conn.exec_params(
    "SELECT content, embedding <-> $1 AS distance
     FROM documents
     ORDER BY embedding <-> $1
     LIMIT 5",
    [query_embedding.to_s]
  )

  # Display results
  results.each do |row|
    puts "Content: #{row['content']}"
    puts "Distance: #{row['distance']}"
    puts "---"
  end

rescue PG::Error => e
  # Handle database errors
  puts "Database Error: #{e.message}"
  puts "Check database connection and pgvector extension installation"

rescue Langchain::LLM::ApiError => e
  # Handle LangChain API errors
  puts "LangChain API Error: #{e.message}"

ensure
  # Always close database connection
  conn&.close
end
```

**✅ This example demonstrates:**
- Database configuration using ENV variables
- pgvector integration
- Embeddings generation
- Vector similarity search
- Multiple error handling scenarios
- Resource cleanup (ensure block)
- Production-ready database patterns

---

### Template 3: Streaming Responses

```ruby
# streaming_example.rb
require 'langchain'
require 'dotenv/load'

api_key = ENV['OPENAI_API_KEY']

begin
  llm = Langchain::LLM::OpenAI.new(api_key: api_key)

  puts "Streaming response:"

  # Stream tokens as they arrive
  llm.complete(
    prompt: "Write a short Ruby on Rails tutorial",
    stream: proc { |chunk|
      # Print each token as it arrives
      print chunk
      $stdout.flush  # Ensure immediate output
    }
  )

  puts "\n\nStreaming complete!"

rescue Langchain::LLM::ApiError => e
  puts "API Error during streaming: #{e.message}"
  puts "Streaming may fail on network interruptions - implement retry logic"

rescue StandardError => e
  puts "Error: #{e.message}"
end
```

**✅ This example demonstrates:**
- Streaming API usage
- Real-time output handling
- stdout flushing for immediate display
- Error handling for network interruptions
- Production consideration comments

---

## Common Technical Validation Failures (AVOID THESE)

### ❌ FAILURE 1: Hardcoded API Keys
```ruby
# ❌ WRONG - SECURITY VIOLATION
api_key = "sk-abc123xyz456"  # Technical reviewer will REJECT

# ✅ CORRECT
api_key = ENV['OPENAI_API_KEY']
```

### ❌ FAILURE 2: Missing Imports
```ruby
# ❌ WRONG - Code won't run
llm = Langchain::LLM::OpenAI.new(api_key: api_key)  # NameError: uninitialized constant Langchain

# ✅ CORRECT
require 'langchain'
require 'dotenv/load'

llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])
```

### ❌ FAILURE 3: No Error Handling
```ruby
# ❌ WRONG - Will crash in production
response = llm.complete(prompt: "Hello")  # Network error = crash

# ✅ CORRECT
begin
  response = llm.complete(prompt: "Hello")
rescue Langchain::LLM::ApiError => e
  puts "API Error: #{e.message}"
end
```

### ❌ FAILURE 4: Incomplete Setup Instructions
```ruby
# ❌ WRONG - Missing Gemfile
require 'langchain'  # Readers don't know what gem to install

# ✅ CORRECT
# Gemfile
gem 'langchain-ruby', '~> 0.10.0'

# Then in code:
require 'langchain'
```

---

## Technical Validation Process

### What Technical Reviewer Will Do

```yaml
validation_steps:
  step_1_extract_code:
    action: "Extract all code examples from draft article"
    tool: "grep -A 10 '```ruby' article.md"

  step_2_syntax_check:
    action: "Validate Ruby syntax for each example"
    tool: "ruby -c example.rb"
    pass_criteria: "Syntax OK"

  step_3_execution_test:
    action: "Run each code example in test environment"
    tool: "ruby example.rb"
    pass_criteria: "No errors, expected output"

  step_4_security_scan:
    action: "Scan for hardcoded secrets"
    tool: "grep -n 'api_key.*=' example.rb | grep -v ENV"
    pass_criteria: "No hardcoded keys found"

  step_5_best_practices:
    action: "Validate Ruby idioms and patterns"
    criteria:
      - "Follows Ruby style guide"
      - "Error handling present"
      - "Production-ready patterns"

  step_6_generate_report:
    action: "Create technical validation report"
    output: "articles/ruby-langchain-getting-started-TECHNICAL-VALIDATION.md"
    includes:
      - "Code accuracy score (0-10)"
      - "Security audit findings"
      - "Production readiness assessment"
      - "Recommendations for improvement"
```

### Validation Scoring Rubric

```yaml
technical_accuracy_scoring:
  syntax_accuracy:
    weight: 20%
    criteria:
      - "Valid Ruby 3.2+ syntax"
      - "No deprecated methods"
      - "Correct require statements"

  completeness:
    weight: 20%
    criteria:
      - "All imports present"
      - "Setup instructions included"
      - "Gemfile provided"

  security:
    weight: 25%
    criteria:
      - "No hardcoded secrets"
      - "ENV variable usage"
      - "Input validation shown"

  best_practices:
    weight: 20%
    criteria:
      - "Ruby idioms followed"
      - "Error handling present"
      - "Clear code comments"

  production_readiness:
    weight: 15%
    criteria:
      - "Logging demonstrated"
      - "Performance considerations"
      - "Scalability guidance"

overall_score:
  10: "Perfect - Ready to publish immediately"
  9: "Excellent - Minor improvements suggested"
  8: "Good - Some improvements needed"
  7: "Acceptable - Several improvements required"
  6: "Below standard - Significant revision needed"
  0-5: "Major issues - Complete rewrite required"
```

---

## Pre-Validation Self-Test

### Run These Commands Yourself (Before Submitting)

```bash
# 1. Create test environment
mkdir -p /tmp/article-self-test
cd /tmp/article-self-test

# 2. Copy Gemfile from your article
cat > Gemfile <<EOF
source 'https://rubygems.org'
gem 'langchain-ruby', '~> 0.10.0'
gem 'ruby-openai', '~> 6.0'
gem 'dotenv', '~> 2.8'
EOF

# 3. Install dependencies
bundle install

# 4. Create .env with test keys
cat > .env <<EOF
OPENAI_API_KEY=your_test_key_here
EOF

# 5. Extract first code example from your article
# (manually copy-paste your first code example to example1.rb)

# 6. Test syntax
ruby -c example1.rb
# Expected: Syntax OK

# 7. Test execution (if you have real API keys)
ruby example1.rb
# Expected: No errors, produces output

# 8. Security scan (MUST show only ENV usage)
grep -n "api_key.*=" example1.rb
# Expected: Only lines with ENV['...'] pattern

# 9. If ALL tests pass → Ready for technical validation
# 10. If ANY test fails → Fix issues before submitting
```

---

## How to Request Technical Validation

### Workflow Steps

```yaml
content_creator_workflow:
  step_1_complete_draft:
    action: "Write complete article with code examples"
    location: "docs/projects/2510-seo-content-strategy/50-59-execution/articles/ruby-langchain-getting-started-DRAFT.md"
    requirements:
      - "3,000+ words comprehensive content"
      - "Working code examples (tested by you)"
      - "SEO-optimized structure"
      - "All code follows templates above"

  step_2_self_validation:
    action: "Run pre-validation self-test"
    checklist:
      - "✅ All code syntax validated (ruby -c)"
      - "✅ All code execution tested (ruby file.rb)"
      - "✅ Security scan passed (no hardcoded keys)"
      - "✅ Technical checklist complete"

  step_3_store_in_memory:
    action: "Signal draft ready for technical validation"
    memory_key: "seo-content-strategy/technical/ruby-article-1-ready-for-validation"
    observation: "Ruby/Rails LangChain draft complete with tested code examples"

  step_4_request_validation:
    message: "Technical reviewer: validate code examples in Ruby/Rails LangChain draft article"
    includes:
      - "Draft location: docs/projects/2510-.../ruby-langchain-getting-started-DRAFT.md"
      - "Code examples: [count] examples covering [topics]"
      - "Self-test results: All syntax/execution/security tests passed"

  step_5_receive_validation_report:
    location: "docs/projects/2510-.../ruby-langchain-getting-started-TECHNICAL-VALIDATION.md"
    action: "Review technical findings"
    next_steps:
      - "If score ≥9/10: Proceed to content reviewer"
      - "If score 7-8/10: Fix recommended improvements"
      - "If score <7/10: Address critical issues, request re-validation"
```

---

## Expected Technical Validation Report Format

### Sample Report Structure

```markdown
# Technical Validation Report: Ruby/Rails LangChain Getting Started Guide

## Executive Summary
- Total code examples: 12
- Examples validated: 12
- Issues found: 2 minor
- **Overall technical accuracy: 9/10** ✅ APPROVED

## Code Example Validation

### Example 1: Basic LLM Call
**Location**: Section "Installation & Setup"
**Status**: ✅ Validated

#### Syntax Check ✅
- Ruby syntax: ✅ Valid Ruby 3.2+
- Deprecations: ✅ None found

#### Completeness Check ✅
- All imports present: ✅ Yes
- Setup code included: ✅ Yes (Gemfile + .env)

#### Security Review ✅
- API key handling: ✅ Secure (ENV variables)
- Input validation: ✅ Present

#### Production Readiness ✅
- Error handling: ✅ Comprehensive
- Logging: ✅ Demonstrated

**Score: 10/10** - Perfect example

### Example 2: RAG Implementation
**Status**: ✅ Validated with minor recommendations

[... detailed validation for each example ...]

## Approval Status
- Technical accuracy: ✅ Approved
- Code quality: ✅ Approved
- Production readiness: ✅ Approved
- **Overall recommendation**: ✅ **PUBLISH** (after minor improvements)

## Recommendations

### Priority 2 (Should Fix - Optional)
1. Add rate limiting example in streaming section
2. Include caching strategy for production deployments

## Testing Artifacts
- Test environment: /tmp/langchain-ruby-validation
- All 12 examples executed successfully ✅
- Security scan: No hardcoded secrets found ✅
```

---

## Quick Reference: Code Quality Standards

### ✅ GOOD Code Example Characteristics

```ruby
# GOOD: Complete, secure, production-ready example
require 'langchain'  # ✅ Clear imports
require 'dotenv/load'  # ✅ Environment setup

api_key = ENV['OPENAI_API_KEY']  # ✅ Secure key handling

begin
  llm = Langchain::LLM::OpenAI.new(api_key: api_key)
  response = llm.complete(prompt: "Hello")  # ✅ Clear purpose
  puts "Response: #{response}"  # ✅ Clear output

rescue Langchain::LLM::ApiError => e  # ✅ Specific error handling
  puts "API Error: #{e.message}"

rescue StandardError => e  # ✅ Fallback error handling
  puts "Error: #{e.message}"
end

# ✅ Comments explain WHY, not WHAT
# ✅ Production-ready error handling
# ✅ Follows Ruby idioms
# ✅ Clear variable names
```

### ❌ BAD Code Example Characteristics

```ruby
# BAD: Incomplete, insecure, not production-ready
l=Langchain::LLM::OpenAI.new(api_key:"sk-abc123")  # ❌ Hardcoded key, no imports, bad naming
puts l.complete(prompt:"Hi")  # ❌ No error handling, crashes on API failure
# ❌ Missing: require statements
# ❌ Missing: error handling
# ❌ Security: hardcoded API key
# ❌ Style: poor variable naming
# ❌ Production: will crash on network errors
```

---

## Appendix: Ruby/Rails Best Practices Checklist

### Code Style
- [ ] 2-space indentation (Ruby standard)
- [ ] Descriptive variable names (not `x`, `y`, `data`)
- [ ] Comments explain WHY, not WHAT
- [ ] Methods under 10 lines when possible
- [ ] Single responsibility principle

### Error Handling
- [ ] Begin/rescue/end blocks for external API calls
- [ ] Specific rescue clauses (Langchain::LLM::ApiError)
- [ ] Fallback rescue StandardError
- [ ] Meaningful error messages
- [ ] Don't swallow exceptions silently

### Security
- [ ] ALL API keys from ENV variables
- [ ] No credentials in code
- [ ] Input validation for user data
- [ ] SQL parameterization (if using database)
- [ ] XSS prevention in views

### Production Readiness
- [ ] Logging for debugging (Rails.logger.info)
- [ ] Timeouts for API calls
- [ ] Rate limiting awareness
- [ ] Caching strategies mentioned
- [ ] Performance implications documented

---

## Contact & Support

### Technical Reviewer Agent
- **Status**: ✅ Ready for validation workflow
- **Response Time**: 2-3 hours for comprehensive validation
- **Deliverable**: Detailed technical validation report with scoring

### Validation Request Format
```
Message: "Technical reviewer: validate code examples in Ruby/Rails LangChain draft"

Context:
- Draft location: [file path]
- Code examples count: [number]
- Self-test status: [passed/partial/not run]
- Special considerations: [any concerns or questions]
```

---

**Last Updated**: 2025-10-17
**Version**: 1.0
**Next Review**: After first article validation (feedback integration)
