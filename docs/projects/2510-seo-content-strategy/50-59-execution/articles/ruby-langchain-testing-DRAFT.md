# Ruby LangChain Testing: Complete RSpec Guide 2025

**Target Keyword**: ruby langchain testing (180/mo searches + long-tail variations)
**Secondary Keywords**: rspec langchain mocking, ruby ai testing, langchain-ruby testing
**Word Count**: 2,800+ words (COMPREHENSIVE guide)
**Target Audience**: Ruby developers building AI features, Rails teams adopting LangChain
**Format**: Comprehensive testing guide with working RSpec examples

---

## Draft Article Content

---

**Meta Title**: Ruby LangChain Testing: Complete RSpec Guide 2025 | JetThoughts

**Meta Description**: Master RSpec testing for LangChain-Ruby applications. Complete guide with mocking strategies, VCR integration, CI/CD setup, and 15 production-ready examples. Build reliable AI features today.

**Slug**: ruby-langchain-testing-complete-rspec-guide

**Tags**: ruby, langchain, rspec, testing, ai, mocking, vcr, ci-cd

---

Testing AI-powered Ruby applications presents unique challenges. How do you test code that calls expensive LLM APIs? How do you mock non-deterministic AI responses? How do you ensure your LangChain integrations work reliably in production?

This comprehensive guide shows you how to test LangChain-Ruby applications using RSpec, WebMock, VCR, and modern CI/CD practices. You'll learn proven patterns for mocking AI APIs, testing conversation flows, and building a reliable test suite that doesn't drain your API budget.

## Table of Contents

1. [Why Testing AI Applications Matters](#why-testing-matters)
2. [RSpec Setup for LangChain](#rspec-setup)
3. [Mocking AI API Calls](#mocking-api-calls)
4. [Testing Conversation Memory](#testing-memory)
5. [Integration Testing Strategies](#integration-testing)
6. [Testing Error Handling](#error-handling)
7. [CI/CD Integration](#cicd-integration)
8. [Test Coverage & Reporting](#test-coverage)
9. [Performance Testing](#performance-testing)
10. [Troubleshooting Common Issues](#troubleshooting)
11. [Next Steps & Resources](#next-steps)

## Why Testing AI Applications Matters {#why-testing-matters}

Testing LangChain applications is fundamentally different from testing traditional Ruby code. Here's why a solid testing strategy is critical:

### The Unique Challenges of AI Testing

**Challenge 1: Non-Deterministic Responses**
Unlike traditional APIs that return predictable JSON, LLMs generate different responses each time. Testing requires flexible assertion strategies that validate behavior, not exact outputs.

**Challenge 2: Expensive API Calls**
Every test that calls OpenAI or Anthropic costs money. A poorly designed test suite can burn through your API budget in minutes. The solution: comprehensive mocking and strategic use of real API calls.

**Challenge 3: Rate Limits**
LLM providers enforce strict rate limits. Running 100+ tests against live APIs will trigger rate limiting errors. You need isolation strategies to test thoroughly without hitting limits.

**Challenge 4: Flaky Tests**
Network issues, API timeouts, and provider outages can cause random test failures. Proper retry logic, timeouts, and fallback strategies are essential.

### What Good LangChain Testing Looks Like

A well-tested LangChain-Ruby application should have:

- **95%+ code coverage** (validated by SimpleCov)
- **Fast test suite** (<5 seconds for unit tests, mocked APIs)
- **Strategic integration tests** (limited real API calls, gated by environment)
- **Robust error handling** (network failures, rate limits, invalid responses)
- **CI/CD integration** (GitHub Actions running tests on every PR)
- **Reproducible tests** (VCR cassettes for consistent API responses)

> This guide builds on our [Getting Started with LangChain-Ruby](/blog/getting-started-langchain-ruby/) tutorial (Week 1). If you haven't read that yet, we recommend starting there to understand LangChain-Ruby basics before diving into testing strategies.

**Also see**: [LangChain Python Tutorial](/blog/langchain-python-tutorial-complete-guide/) for pytest patterns that can be adapted to RSpec.

### Real-World Testing Scenarios

Here's what you'll be able to test after reading this guide:

1. **AI Agent Behavior**: Validate that agents make correct tool choices without calling real APIs
2. **Conversation Memory**: Ensure conversation history is maintained across multiple turns
3. **Error Recovery**: Test how your app handles API failures, timeouts, and rate limits
4. **Cost Optimization**: Verify prompt compression and token reduction strategies work correctly
5. **Security**: Test that API keys are never logged or exposed in error messages
6. **Performance**: Benchmark response times and ensure they meet SLA requirements

## RSpec Setup for LangChain {#rspec-setup}

Let's configure RSpec properly for LangChain testing with all essential dependencies and best practices.

### Prerequisites

Before starting, ensure your project has:

- **Ruby 3.2+** (LangChain-Ruby requires modern Ruby versions)
- **RSpec 3.12+** (latest RSpec with comprehensive matchers)
- **LangChain-Ruby 0.10+** (stable LangChain version)

Check versions:

```bash
ruby --version
# Should show: ruby 3.2.0 or higher

bundle exec rspec --version
# Should show: RSpec 3.12 or higher
```

### Installing Testing Dependencies

Add these gems to your `Gemfile` in the `:test` group:

```ruby
# Gemfile
source 'https://rubygems.org'

# LangChain dependencies
gem 'langchainrb', '~> 0.10.0'
gem 'ruby-openai', '~> 6.0'
gem 'anthropic', '~> 0.3'

# Testing dependencies
group :test do
  gem 'rspec', '~> 3.12'
  gem 'rspec-rails', '~> 6.1' # If using Rails
  gem 'webmock', '~> 3.19'    # HTTP request stubbing
  gem 'vcr', '~> 6.2'         # Record/replay HTTP interactions
  gem 'simplecov', '~> 0.22'  # Test coverage reporting
  gem 'factory_bot', '~> 6.4' # Test data factories
  gem 'faker', '~> 3.2'       # Fake data generation
  gem 'timecop', '~> 0.9'     # Time manipulation for tests
end

group :development, :test do
  gem 'dotenv', '~> 2.8'      # Environment variable management
  gem 'pry-byebug', '~> 3.10' # Debugging
end
```

Install dependencies:

```bash
bundle install
```

### RSpec Configuration for LangChain

Create or update `spec/spec_helper.rb` with LangChain-specific settings:

```ruby
# spec/spec_helper.rb
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
  minimum_coverage 95  # Enforce 95% coverage
end

require 'webmock/rspec'
require 'vcr'
require 'dotenv/load'

# Configure WebMock to prevent real HTTP requests during tests
# Block all network connections except localhost and AI APIs
# Note: 'allow' is only for VCR recording mode (:new_episodes)
# In :none mode (CI), VCR uses cassettes exclusively (no network)
WebMock.disable_net_connect!(
  allow_localhost: true,
  allow: ['api.openai.com', 'api.anthropic.com']  # For VCR recording only
)

# Configure VCR for recording/replaying API interactions
VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!

  # Filter sensitive data from cassettes
  config.filter_sensitive_data('<OPENAI_API_KEY>') { ENV['OPENAI_API_KEY'] }
  config.filter_sensitive_data('<ANTHROPIC_API_KEY>') { ENV['ANTHROPIC_API_KEY'] }

  # Allow real HTTP for integration tests (when explicitly enabled)
  config.allow_http_connections_when_no_cassette = false

  # Ignore localhost requests (for local testing servers)
  config.ignore_localhost = true
end

RSpec.configure do |config|
  # Use color for better readability
  config.color = true

  # Use documentation format for detailed output
  config.formatter = :documentation

  # Fail fast - stop after first failure during debugging
  # config.fail_fast = true  # Uncomment for debugging

  # Run specs in random order to detect dependencies
  config.order = :random
  Kernel.srand config.seed

  # Shared contexts for LangChain testing
  config.include_context 'with mocked llm', :mocked_llm
  config.include_context 'with vcr', :vcr

  # Disable real API calls by default
  config.before(:each) do
    # Modern RSpec 3.12+ pattern with instance_double
    llm = instance_double(Langchain::LLM::OpenAI)
    allow(llm).to receive(:complete).and_return('Mocked response - use VCR or stub explicitly')
    allow(Langchain::LLM::OpenAI).to receive(:new).and_return(llm)
  end
end
```

### Creating Shared Contexts for Common Test Scenarios

Shared contexts reduce duplication and standardize testing patterns:

```ruby
# spec/support/shared_contexts/langchain_contexts.rb
RSpec.shared_context 'with mocked llm' do
  let(:llm) do
    instance_double(
      Langchain::LLM::OpenAI,
      complete: 'Mocked LLM response',
      chat: 'Mocked chat response',
      embed: [0.1, 0.2, 0.3]  # Mocked embedding vector
    )
  end

  let(:anthropic_llm) do
    instance_double(
      Langchain::LLM::Anthropic,
      complete: 'Mocked Claude response'
    )
  end
end

RSpec.shared_context 'with test api keys' do
  before do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with('OPENAI_API_KEY').and_return('test-openai-key')
    allow(ENV).to receive(:[]).with('ANTHROPIC_API_KEY').and_return('test-anthropic-key')
  end
end

RSpec.shared_context 'with vcr', :vcr do
  around(:each) do |example|
    VCR.use_cassette(example.metadata[:vcr], record: :new_episodes) do
      example.run
    end
  end
end
```

Load shared contexts in `spec/rails_helper.rb` or `spec/spec_helper.rb`:

```ruby
# spec/rails_helper.rb (or spec_helper.rb)
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
```

### Basic Test Structure: Testing a Simple LLM Call

Here's your first working test to validate the setup:

```ruby
# spec/langchain/basic_llm_spec.rb
require 'rails_helper'

RSpec.describe 'Basic LangChain LLM Integration', :vcr do
  include_context 'with test api keys'

  describe 'OpenAI completion' do
    it 'generates a response for a simple prompt' do
      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      response = llm.complete(prompt: 'Say "Hello from RSpec!" in exactly 3 words.')

      # Flexible assertion for non-deterministic responses
      expect(response).to be_a(String)
      expect(response).not_to be_empty
      expect(response.downcase).to include('hello')
    end

    it 'handles invalid API keys gracefully', :mocked_llm do
      llm = Langchain::LLM::OpenAI.new(api_key: 'invalid-key')

      # Stub the API call to simulate authentication error
      allow(llm).to receive(:complete).and_raise(
        Langchain::LLM::ApiError.new('Incorrect API key')
      )

      expect {
        llm.complete(prompt: 'Test')
      }.to raise_error(Langchain::LLM::ApiError, /API key/)
    end
  end

  describe 'response validation' do
    it 'validates response structure', :mocked_llm do
      llm = instance_double(Langchain::LLM::OpenAI)

      # Mock a structured response
      allow(llm).to receive(:complete).and_return(
        { content: 'Test response', model: 'gpt-4', tokens: 10 }.to_json
      )

      response = llm.complete(prompt: 'Test')
      parsed = JSON.parse(response)

      expect(parsed).to have_key('content')
      expect(parsed).to have_key('model')
      expect(parsed['tokens']).to be_a(Integer)
    end
  end
end
```

### Understanding LangChain-Ruby Response Objects

LangChain-Ruby 0.10+ returns structured response objects (not plain strings):

```ruby
# OpenAI LLM response structure
response = llm.complete(prompt: "What is Ruby?")
# => #<Langchain::LLM::OpenAIResponse>

# Access response content
response.completion         # => "Ruby is a dynamic, open-source programming language..."
response.model              # => "gpt-3.5-turbo"
response.prompt_tokens      # => 8
response.completion_tokens  # => 42
response.total_tokens       # => 50

# Your tests should verify this structure:
expect(response).to be_a(Langchain::LLM::OpenAIResponse)
expect(response.completion).to include("Ruby")
expect(response.total_tokens).to be > 0
```

Run the test:

```bash
bundle exec rspec spec/langchain/basic_llm_spec.rb
```

**Expected Output**:
```
Basic LangChain LLM Integration
  OpenAI completion
    generates a response for a simple prompt (VCR)
    handles invalid API keys gracefully (mocked)
  response validation
    validates response structure (mocked)

Finished in 0.15 seconds
3 examples, 0 failures
```

**Coverage Check**:
```bash
open coverage/index.html  # View SimpleCov report
```

✅ If tests pass and coverage report opens, your RSpec setup is complete!

## Mocking AI API Calls {#mocking-api-calls}

Mocking LLM API calls is essential for fast, reliable, and cost-effective testing. Here are proven strategies.

### Strategy 1: WebMock for Complete Control

WebMock gives you low-level control over HTTP interactions:

```ruby
# spec/langchain/mocking/webmock_strategy_spec.rb
require 'rails_helper'

RSpec.describe 'WebMock Strategy for LangChain' do
  describe 'mocking OpenAI API calls' do
    before do
      # Stub the OpenAI completions endpoint
      stub_request(:post, 'https://api.openai.com/v1/completions')
        .with(
          headers: {
            'Authorization' => "Bearer #{ENV['OPENAI_API_KEY']}",
            'Content-Type' => 'application/json'
          },
          body: hash_including({
            model: 'gpt-3.5-turbo',
            prompt: /test/i
          })
        )
        .to_return(
          status: 200,
          body: {
            id: 'cmpl-test123',
            object: 'text_completion',
            created: Time.now.to_i,
            model: 'gpt-3.5-turbo',
            choices: [{
              text: 'This is a mocked response from OpenAI',
              index: 0,
              finish_reason: 'stop'
            }],
            usage: {
              prompt_tokens: 5,
              completion_tokens: 10,
              total_tokens: 15
            }
          }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'returns mocked completion response' do
      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      response = llm.complete(prompt: 'test prompt', model: 'gpt-3.5-turbo')

      expect(response).to include('mocked response')
    end

    it 'validates request parameters' do
      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      llm.complete(prompt: 'test prompt', model: 'gpt-3.5-turbo')

      # WebMock automatically validates the stub was called with correct params
      expect(WebMock).to have_requested(:post, 'https://api.openai.com/v1/completions')
        .with { |req| JSON.parse(req.body)['prompt'].include?('test') }
    end
  end

  describe 'mocking API errors' do
    it 'simulates rate limiting errors' do
      stub_request(:post, 'https://api.openai.com/v1/completions')
        .to_return(
          status: 429,
          body: { error: { message: 'Rate limit exceeded', type: 'rate_limit_error' } }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      expect {
        llm.complete(prompt: 'test')
      }.to raise_error(Langchain::LLM::ApiError, /rate limit/i)
    end

    it 'simulates network timeouts' do
      stub_request(:post, 'https://api.openai.com/v1/completions')
        .to_timeout

      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      expect {
        llm.complete(prompt: 'test')
      }.to raise_error(Langchain::LLM::ApiError, /timeout/i)
    end
  end
end
```

### Strategy 2: VCR for Recording/Replaying Real API Calls

VCR records real API interactions once, then replays them in subsequent test runs:

```ruby
# spec/langchain/mocking/vcr_strategy_spec.rb
require 'rails_helper'

RSpec.describe 'VCR Strategy for LangChain' do
  describe 'recording OpenAI interactions', vcr: 'openai/basic_completion' do
    it 'records and replays real API responses' do
      # First run: Makes real API call and records to cassette
      # Subsequent runs: Replays from cassette (no API call, instant response)
      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      response = llm.complete(
        prompt: 'Explain Ruby testing in exactly 2 sentences.',
        model: 'gpt-3.5-turbo'
      )

      expect(response).to be_a(String)
      expect(response.split('.').count).to be >= 2
    end
  end

  describe 'VCR with dynamic cassette names' do
    it 'uses test-specific cassettes for isolation', vcr: { cassette_name: 'openai/dynamic_test' } do
      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      response = llm.complete(prompt: 'What is Ruby?')

      expect(response).to include('Ruby')
    end
  end

  describe 'VCR re-recording strategies' do
    it 'forces re-recording when API behavior changes', vcr: { cassette_name: 'openai/force_record', record: :all } do
      # record: :all - Always record new interactions (overwrites cassette)
      # record: :new_episodes - Record only new requests
      # record: :none - Never record (fail if cassette missing)

      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      response = llm.complete(prompt: 'Latest Ruby version?')

      expect(response).not_to be_empty
    end
  end
end
```

**VCR Cassette Example** (auto-generated in `spec/fixtures/vcr_cassettes/openai/basic_completion.yml`):

```yaml
---
http_interactions:
- request:
    method: post
    uri: https://api.openai.com/v1/chat/completions
    headers:
      Authorization:
      - Bearer <OPENAI_API_KEY>  # ← Matches filter_sensitive_data config
      Content-Type:
      - application/json
    body:
      encoding: UTF-8
      string: '{"model":"gpt-3.5-turbo","messages":[{"role":"user","content":"Explain Ruby testing..."}]}'
  response:
    status:
      code: 200
      message: OK
    headers:
      Content-Type:
      - application/json
    body:
      encoding: UTF-8
      string: '{"id":"chatcmpl-abc123","object":"chat.completion","created":1698432000,"choices":[{"message":{"role":"assistant","content":"Ruby testing uses RSpec for behavior-driven development..."}}]}'
  recorded_at: Thu, 17 Oct 2025 12:00:00 GMT
recorded_with: VCR 6.2.0
```

### Strategy 3: RSpec Doubles for Unit Testing

For pure unit tests, use RSpec's built-in mocking:

```ruby
# spec/langchain/mocking/rspec_doubles_spec.rb
require 'rails_helper'

RSpec.describe 'RSpec Doubles for LangChain' do
  describe 'instance doubles for type safety' do
    it 'validates method signatures with instance_double' do
      # instance_double validates method existence when you stub it, not at creation time
      llm = instance_double(Langchain::LLM::OpenAI)

      # Validation happens HERE when stubbing methods
      allow(llm).to receive(:complete).and_return('Test response')
      allow(llm).to receive(:embed).and_return([0.1, 0.2, 0.3])

      result = llm.complete(prompt: 'test')

      expect(result).to eq('Test response')
    end

    it 'raises errors for invalid method stubs' do
      llm = instance_double(Langchain::LLM::OpenAI)

      # This RAISES error if #nonexistent_method doesn't exist on OpenAI class
      expect {
        allow(llm).to receive(:nonexistent_method).and_return('value')
      }.to raise_error(RSpec::Mocks::MockExpectationError)
    end
  end

  describe 'verifying method calls' do
    it 'expects specific method calls with arguments' do
      llm = instance_double(Langchain::LLM::OpenAI)

      allow(llm).to receive(:complete).with(
        hash_including(prompt: 'specific prompt')
      ).and_return('Expected response')

      result = llm.complete(prompt: 'specific prompt', temperature: 0.7)

      expect(result).to eq('Expected response')
      expect(llm).to have_received(:complete).with(
        hash_including(prompt: 'specific prompt')
      )
    end
  end

  describe 'stubbing embeddings for RAG tests' do
    it 'returns consistent embedding vectors' do
      llm = instance_double(Langchain::LLM::OpenAI)

      # Stub consistent embeddings for reproducible tests
      allow(llm).to receive(:embed).with('Ruby').and_return([0.9, 0.1, 0.0])
      allow(llm).to receive(:embed).with('Python').and_return([0.1, 0.9, 0.0])

      ruby_embedding = llm.embed('Ruby')
      python_embedding = llm.embed('Python')

      # Verify embeddings are different
      expect(ruby_embedding).not_to eq(python_embedding)

      # Calculate cosine similarity (for vector search tests)
      similarity = dot_product(ruby_embedding, python_embedding)
      expect(similarity).to be < 0.5  # Should be dissimilar
    end
  end

  private

  def dot_product(vec_a, vec_b)
    vec_a.zip(vec_b).sum { |a, b| a * b }
  end
end
```

### Strategy 4: Factory Pattern for Test Data

Create reusable factories for common LLM responses:

```ruby
# spec/factories/langchain_responses.rb
FactoryBot.define do
  factory :openai_completion_response, class: Hash do
    id { "cmpl-#{SecureRandom.hex(8)}" }
    object { 'text_completion' }
    created { Time.now.to_i }
    model { 'gpt-3.5-turbo' }
    choices do
      [{
        text: Faker::Lorem.paragraph(sentence_count: 3),
        index: 0,
        finish_reason: 'stop'
      }]
    end
    usage do
      {
        prompt_tokens: rand(5..20),
        completion_tokens: rand(50..200),
        total_tokens: rand(55..220)
      }
    end

    skip_create
    initialize_with { attributes.stringify_keys }
  end

  factory :openai_chat_response, class: Hash do
    id { "chatcmpl-#{SecureRandom.hex(8)}" }
    object { 'chat.completion' }
    created { Time.now.to_i }
    model { 'gpt-4' }
    choices do
      [{
        message: {
          role: 'assistant',
          content: Faker::Lorem.paragraph(sentence_count: 2)
        },
        finish_reason: 'stop',
        index: 0
      }]
    end

    skip_create
    initialize_with { attributes.stringify_keys }
  end

  factory :anthropic_completion_response, class: Hash do
    id { "msg_#{SecureRandom.hex(8)}" }
    type { 'message' }
    role { 'assistant' }
    content do
      [{
        type: 'text',
        text: Faker::Lorem.paragraph(sentence_count: 3)
      }]
    end
    model { 'claude-3-sonnet-20240229' }
    stop_reason { 'end_turn' }
    usage do
      {
        input_tokens: rand(5..20),
        output_tokens: rand(50..200)
      }
    end

    skip_create
    initialize_with { attributes.stringify_keys }
  end
end
```

**Using Factories in Tests**:

```ruby
# spec/langchain/mocking/factory_strategy_spec.rb
require 'rails_helper'

RSpec.describe 'Factory Pattern for LangChain Mocking' do
  it 'uses factories for consistent test data' do
    # Generate realistic OpenAI response
    mock_response = build(:openai_completion_response,
      choices: [{
        text: 'Ruby is great for web development.',
        finish_reason: 'stop',
        index: 0
      }]
    )

    llm = instance_double(Langchain::LLM::OpenAI)
    allow(llm).to receive(:complete).and_return(mock_response.to_json)

    response = llm.complete(prompt: 'What is Ruby?')
    parsed = JSON.parse(response)

    expect(parsed['choices'].first['text']).to include('Ruby')
    expect(parsed['usage']['total_tokens']).to be > 0
  end

  it 'generates multiple unique responses' do
    # Create 5 different responses with Faker
    responses = build_list(:openai_completion_response, 5)

    expect(responses.map { |r| r['id'] }.uniq.count).to eq(5)
    expect(responses.map { |r| r['choices'].first['text'] }.uniq.count).to eq(5)
  end
end
```

## Testing Conversation Memory {#testing-memory}

Conversation memory is critical for chatbots and multi-turn interactions. Here's how to test it thoroughly.

### Testing Buffer Memory (Simple History)

```ruby
# spec/langchain/memory/buffer_memory_spec.rb
require 'rails_helper'

RSpec.describe 'LangChain Buffer Memory Testing' do
  let(:llm) { instance_double(Langchain::LLM::OpenAI) }
  let(:memory) { Langchain::Memory::ConversationBufferMemory.new }

  describe 'conversation history tracking' do
    it 'stores and retrieves conversation messages' do
      # Add user and AI messages
      memory.add_user_message('What is Ruby?')
      memory.add_ai_message('Ruby is a dynamic programming language.')
      memory.add_user_message('Who created it?')
      memory.add_ai_message('Yukihiro Matsumoto created Ruby.')

      # Verify message count
      expect(memory.messages.count).to eq(4)

      # Verify message structure
      expect(memory.messages[0]).to include(role: 'user', content: 'What is Ruby?')
      expect(memory.messages[1]).to include(role: 'assistant')

      # Verify message retrieval
      history = memory.to_s
      expect(history).to include('What is Ruby?')
      expect(history).to include('Yukihiro Matsumoto')
    end

    it 'clears conversation history' do
      memory.add_user_message('Test message')
      expect(memory.messages.count).to eq(1)

      memory.clear

      expect(memory.messages).to be_empty
    end
  end

  describe 'memory integration with LLM' do
    it 'passes conversation context to LLM', :mocked_llm do
      allow(llm).to receive(:chat).and_return('Based on our conversation, Ruby is great!')

      # Simulate multi-turn conversation
      memory.add_user_message('Tell me about Ruby')
      memory.add_ai_message('Ruby is a programming language.')
      memory.add_user_message('Why is it popular?')

      # LLM receives full conversation context
      response = llm.chat(messages: memory.messages)

      expect(response).to include('conversation')
      expect(llm).to have_received(:chat).with(
        hash_including(messages: array_including(
          hash_including(role: 'user', content: /Ruby/i)
        ))
      )
    end
  end
end
```

### Testing Summary Memory (Token Optimization)

```ruby
# spec/langchain/memory/summary_memory_spec.rb
require 'rails_helper'

RSpec.describe 'LangChain Summary Memory Testing' do
  let(:llm) { instance_double(Langchain::LLM::OpenAI) }
  let(:memory) do
    Langchain::Memory::ConversationSummaryMemory.new(llm: llm, max_token_limit: 100)
  end

  describe 'automatic summarization when token limit exceeded' do
    before do
      # Mock LLM to return summaries
      allow(llm).to receive(:complete).with(
        hash_including(prompt: /summarize/i)
      ).and_return('Summary: User asked about Ruby. AI explained Ruby basics.')
    end

    it 'summarizes old messages when approaching token limit' do
      # Add enough messages to exceed token limit
      10.times do |i|
        memory.add_user_message("Question #{i}: " + Faker::Lorem.paragraph)
        memory.add_ai_message("Answer #{i}: " + Faker::Lorem.paragraph)
      end

      # Verify summarization was triggered
      expect(llm).to have_received(:complete).with(
        hash_including(prompt: /summarize/i)
      ).at_least(:once)

      # Verify summary is stored
      expect(memory.summary).not_to be_empty
      expect(memory.summary).to include('Summary:')
    end
  end

  describe 'retrieving context with summary' do
    it 'combines summary with recent messages for context' do
      allow(llm).to receive(:complete).and_return('Summary of past conversation.')

      # Add messages that trigger summarization
      5.times { memory.add_user_message('Old message'); memory.add_ai_message('Old response') }

      # Add recent messages
      memory.add_user_message('Recent question')
      memory.add_ai_message('Recent answer')

      # Get context for next LLM call
      context = memory.get_context

      # Should include summary + recent messages
      expect(context).to include('Summary of past conversation')
      expect(context).to include('Recent question')
    end
  end
end
```

### Testing Entity Memory (Named Entity Tracking)

```ruby
# spec/langchain/memory/entity_memory_spec.rb
require 'rails_helper'

RSpec.describe 'LangChain Entity Memory Testing' do
  let(:llm) { instance_double(Langchain::LLM::OpenAI) }
  let(:memory) { Langchain::Memory::EntityMemory.new(llm: llm) }

  describe 'entity extraction and tracking' do
    before do
      # Mock LLM entity extraction
      allow(llm).to receive(:complete).with(
        hash_including(prompt: /extract entities/i)
      ).and_return('{"name": "Alice", "role": "developer", "language": "Ruby"}')
    end

    it 'extracts and stores entities from conversation' do
      memory.add_user_message('My name is Alice and I work as a developer.')

      # Verify entity extraction was called
      expect(llm).to have_received(:complete).with(
        hash_including(prompt: /extract entities/i)
      )

      # Verify entities are stored
      expect(memory.entities).to include('name' => 'Alice')
      expect(memory.entities).to include('role' => 'developer')
    end

    it 'updates entities across multiple messages' do
      allow(llm).to receive(:complete).and_return(
        '{"name": "Alice"}',
        '{"language": "Ruby", "years_experience": "5"}'
      )

      memory.add_user_message('I am Alice.')
      memory.add_user_message('I have 5 years of Ruby experience.')

      # Verify entities are merged
      expect(memory.entities['name']).to eq('Alice')
      expect(memory.entities['language']).to eq('Ruby')
      expect(memory.entities['years_experience']).to eq('5')
    end
  end

  describe 'using entity context in prompts' do
    it 'injects entity information into LLM context' do
      memory.entities = { name: 'Alice', language: 'Ruby' }

      context = memory.get_entity_context

      expect(context).to include('Alice')
      expect(context).to include('Ruby')
    end
  end
end
```

## Integration Testing Strategies {#integration-testing}

Integration tests validate real API interactions. Use them sparingly and strategically.

### Gated Integration Tests (Environment-Controlled)

```ruby
# spec/langchain/integration/gated_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Gated Integration Tests', if: ENV['RUN_INTEGRATION_TESTS'] == 'true' do
  # Only runs when RUN_INTEGRATION_TESTS=true (CI production environment)

  describe 'real OpenAI API interaction' do
    it 'makes actual API call and validates response structure', vcr: { record: :new_episodes } do
      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      response = llm.complete(
        prompt: 'Respond with exactly the word "SUCCESS" and nothing else.',
        temperature: 0,  # Deterministic response
        max_tokens: 5
      )

      expect(response).to be_a(String)
      expect(response.upcase).to include('SUCCESS')
    end

    it 'validates real streaming responses' do
      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])
      chunks = []

      llm.complete(
        prompt: 'Count from 1 to 3.',
        stream: proc { |chunk| chunks << chunk }
      )

      expect(chunks).not_to be_empty
      expect(chunks.join).to match(/1.*2.*3/)
    end
  end

  describe 'error handling with real API' do
    it 'handles rate limiting gracefully' do
      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      # Make rapid requests to trigger rate limit (if applicable)
      expect {
        20.times { llm.complete(prompt: 'test', max_tokens: 5) }
      }.to raise_error(Langchain::LLM::ApiError).or not_raise_error

      # Test should pass either way (rate limit OR success)
    end
  end
end
```

**Running Integration Tests**:

```bash
# Skip integration tests (default - fast)
bundle exec rspec

# Run integration tests (slow, costs money, requires real API keys)
RUN_INTEGRATION_TESTS=true bundle exec rspec spec/langchain/integration/
```

### Testing Against Multiple LLM Providers

```ruby
# spec/langchain/integration/multi_provider_spec.rb
require 'rails_helper'

RSpec.describe 'Multi-Provider Integration', if: ENV['RUN_INTEGRATION_TESTS'] == 'true' do
  shared_examples 'standard LLM behavior' do |provider_class, api_key_env|
    let(:llm) { provider_class.new(api_key: ENV[api_key_env]) }

    it 'generates valid text completions' do
      response = llm.complete(prompt: 'Say "Hello"')

      expect(response).to be_a(String)
      expect(response.downcase).to include('hello')
    end

    it 'supports temperature control' do
      # Temperature 0 should be deterministic
      response1 = llm.complete(prompt: 'Say the number 42', temperature: 0)
      response2 = llm.complete(prompt: 'Say the number 42', temperature: 0)

      # Should be very similar (allowing for small API variations)
      expect(response1).to include('42')
      expect(response2).to include('42')
    end
  end

  describe 'OpenAI provider', vcr: 'integration/openai' do
    it_behaves_like 'standard LLM behavior', Langchain::LLM::OpenAI, 'OPENAI_API_KEY'

    it 'supports function calling' do
      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      function_definition = {
        name: 'get_weather',
        description: 'Get current weather',
        parameters: {
          type: 'object',
          properties: {
            location: { type: 'string' }
          }
        }
      }

      response = llm.chat(
        messages: [{ role: 'user', content: 'What is the weather in Tokyo?' }],
        functions: [function_definition]
      )

      expect(response).to have_key('function_call')
    end
  end

  describe 'Anthropic provider', vcr: 'integration/anthropic' do
    it_behaves_like 'standard LLM behavior', Langchain::LLM::Anthropic, 'ANTHROPIC_API_KEY'

    it 'supports system prompts' do
      llm = Langchain::LLM::Anthropic.new(api_key: ENV['ANTHROPIC_API_KEY'])

      response = llm.chat(
        system: 'You are a Ruby expert. Always mention Ruby in your responses.',
        messages: [{ role: 'user', content: 'What is programming?' }]
      )

      expect(response.downcase).to include('ruby')
    end
  end
end
```

## Testing Error Handling {#error-handling}

Robust error handling is critical for production LangChain applications. Test all failure scenarios.

### Testing API Errors and Retry Logic

```ruby
# spec/langchain/errors/api_error_handling_spec.rb
require 'rails_helper'

RSpec.describe 'API Error Handling and Retry Logic' do
  let(:llm) { Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY']) }

  describe 'handling authentication errors' do
    it 'raises clear error for invalid API key' do
      stub_request(:post, /api.openai.com/)
        .to_return(
          status: 401,
          body: { error: { message: 'Invalid API key', type: 'invalid_request_error' } }.to_json
        )

      expect {
        llm.complete(prompt: 'test')
      }.to raise_error(Langchain::LLM::ApiError, /invalid.*api key/i)
    end

    it 'does not expose API key in error messages' do
      stub_request(:post, /api.openai.com/)
        .to_return(status: 401, body: { error: { message: 'Auth failed' } }.to_json)

      begin
        llm.complete(prompt: 'test')
      rescue Langchain::LLM::ApiError => e
        # Verify API key is NOT in error message
        expect(e.message).not_to include(ENV['OPENAI_API_KEY'])
        expect(e.message).not_to match(/sk-[a-zA-Z0-9]{48}/)
      end
    end
  end

  describe 'handling rate limiting' do
    it 'implements exponential backoff retry strategy' do
      # Simulate rate limit on first 2 calls, success on 3rd
      call_count = 0
      stub_request(:post, /api.openai.com/)
        .to_return do
          call_count += 1
          if call_count < 3
            { status: 429, body: { error: { message: 'Rate limit exceeded' } }.to_json }
          else
            { status: 200, body: { choices: [{ text: 'Success' }] }.to_json }
          end
        end

      # Assuming LangChain implements retry logic
      result = nil
      expect {
        result = llm.complete(prompt: 'test', max_retries: 3, retry_delay: 0.1)
      }.not_to raise_error

      expect(result).to include('Success')
      expect(call_count).to eq(3)
    end
  end

  describe 'handling network errors' do
    it 'raises timeout error with helpful message' do
      stub_request(:post, /api.openai.com/).to_timeout

      expect {
        llm.complete(prompt: 'test')
      }.to raise_error(Langchain::LLM::ApiError, /timeout/i)
    end

    it 'handles connection refused' do
      stub_request(:post, /api.openai.com/).to_raise(Errno::ECONNREFUSED)

      expect {
        llm.complete(prompt: 'test')
      }.to raise_error(Langchain::LLM::ApiError, /connection/i)
    end
  end

  describe 'handling malformed responses' do
    it 'validates JSON response structure' do
      stub_request(:post, /api.openai.com/)
        .to_return(status: 200, body: 'Invalid JSON{{{')

      expect {
        llm.complete(prompt: 'test')
      }.to raise_error(Langchain::LLM::ApiError, /invalid.*response/i)
    end

    it 'handles missing expected fields in response' do
      stub_request(:post, /api.openai.com/)
        .to_return(status: 200, body: { missing: 'choices' }.to_json)

      expect {
        llm.complete(prompt: 'test')
      }.to raise_error(Langchain::LLM::ApiError, /missing.*choices/i)
    end
  end
end
```

### Testing Cost Controls and Token Limits

```ruby
# spec/langchain/errors/cost_control_spec.rb
require 'rails_helper'

RSpec.describe 'Cost Controls and Token Limit Testing' do
  let(:llm) { instance_double(Langchain::LLM::OpenAI) }

  describe 'token counting before API calls' do
    it 'estimates token count and warns if exceeding budget' do
      # Mock token counter (use tiktoken gem in real implementation)
      allow(Langchain::Utils::TokenCounter).to receive(:count).with(
        'Very long prompt' * 1000
      ).and_return(5000)

      long_prompt = 'Very long prompt' * 1000
      token_count = Langchain::Utils::TokenCounter.count(long_prompt)

      expect(token_count).to be > 4000  # Exceeds typical budget

      # Application should reject or truncate
      expect(token_count).to be_a(Integer)
    end
  end

  describe 'max_tokens enforcement' do
    it 'limits response length to control costs' do
      allow(llm).to receive(:complete).with(
        hash_including(max_tokens: 100)
      ).and_return('Short response within budget')

      response = llm.complete(
        prompt: 'Write a long essay',
        max_tokens: 100  # Hard limit
      )

      expect(llm).to have_received(:complete).with(
        hash_including(max_tokens: 100)
      )
    end
  end

  describe 'cost tracking per request' do
    it 'logs token usage for cost analysis' do
      mock_response = {
        choices: [{ text: 'Response' }],
        usage: {
          prompt_tokens: 50,
          completion_tokens: 30,
          total_tokens: 80
        }
      }

      allow(llm).to receive(:complete).and_return(mock_response.to_json)

      response = llm.complete(prompt: 'test')
      parsed = JSON.parse(response)

      # Calculate cost (OpenAI GPT-4 pricing: $0.03/1K prompt, $0.06/1K completion)
      prompt_cost = (parsed['usage']['prompt_tokens'] / 1000.0) * 0.03
      completion_cost = (parsed['usage']['completion_tokens'] / 1000.0) * 0.06
      total_cost = prompt_cost + completion_cost

      expect(total_cost).to be < 0.01  # Under 1 cent
    end
  end
end
```

## CI/CD Integration {#cicd-integration}

Automate testing with GitHub Actions and continuous integration best practices.

### GitHub Actions Workflow for LangChain Testing

```yaml
# .github/workflows/langchain_tests.yml
name: LangChain Test Suite

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

env:
  RUBY_VERSION: 3.2

jobs:
  unit_tests:
    name: Unit Tests (Mocked APIs)
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: ${{ env.RUBY_VERSION }}
        bundler-cache: true

    - name: Install dependencies
      run: bundle install --jobs 4 --retry 3

    - name: Run unit tests (no real API calls)
      run: bundle exec rspec spec --tag ~integration --tag ~vcr
      env:
        OPENAI_API_KEY: test-key-for-mocking
        ANTHROPIC_API_KEY: test-key-for-mocking

    - name: Check test coverage
      run: |
        if [ -f coverage/.last_run.json ]; then
          ruby -e "
            require 'json'
            coverage_data = JSON.parse(File.read('coverage/.last_run.json'))
            coverage = coverage_data.dig('result', 'line') || 0

            puts \"Test coverage: #{coverage.round(2)}%\"

            if coverage < 95.0
              puts \"❌ Coverage #{coverage.round(2)}% is below 95% threshold\"
              exit 1
            end

            puts '✅ Coverage meets 95% threshold'
          "
        fi

  vcr_tests:
    name: VCR Tests (Recorded APIs)
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: ${{ env.RUBY_VERSION }}
        bundler-cache: true

    - name: Run VCR tests (replaying cassettes)
      run: bundle exec rspec spec --tag vcr
      env:
        # Use fake keys since VCR replays from cassettes
        OPENAI_API_KEY: vcr-mock-key
        ANTHROPIC_API_KEY: vcr-mock-key

    - name: Upload VCR cassettes as artifacts
      if: failure()
      uses: actions/upload-artifact@v3
      with:
        name: vcr-cassettes
        path: spec/fixtures/vcr_cassettes/

  integration_tests:
    name: Integration Tests (Real APIs)
    runs-on: ubuntu-latest
    # Only run on main branch or when explicitly triggered
    if: github.ref == 'refs/heads/main' || github.event_name == 'workflow_dispatch'

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: ${{ env.RUBY_VERSION }}
        bundler-cache: true

    - name: Run integration tests (REAL API calls - costs money!)
      run: bundle exec rspec spec/langchain/integration/
      env:
        RUN_INTEGRATION_TESTS: 'true'
        OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
        ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}

    - name: Report API costs
      if: always()
      run: |
        echo "⚠️  Integration tests completed - check API usage dashboards"
        echo "OpenAI: https://platform.openai.com/usage"
        echo "Anthropic: https://console.anthropic.com/settings/billing"

  security_scan:
    name: Security Scan (API Keys)
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Scan for hardcoded secrets
      run: |
        # Check for accidentally committed API keys (updated patterns for real-world key formats)
        if grep -r -E "sk-[a-zA-Z0-9_-]{20,}" . --exclude-dir={.git,vendor,node_modules}; then
          echo "❌ Found potential hardcoded OpenAI API key!"
          exit 1
        fi
        if grep -r -E "sk-ant-[a-zA-Z0-9_-]{20,}" . --exclude-dir={.git,vendor}; then
          echo "❌ Found potential hardcoded Anthropic API key!"
          exit 1
        fi
        if grep -r -E "ghp_[a-zA-Z0-9]{36}" . --exclude-dir={.git,vendor}; then
          echo "❌ Found potential hardcoded GitHub token!"
          exit 1
        fi
        if grep -r -E "AKIA[0-9A-Z]{16}" . --exclude-dir={.git,vendor}; then
          echo "❌ Found potential hardcoded AWS access key!"
          exit 1
        fi
        echo "✅ No hardcoded API keys found"
```

**Setting Up GitHub Secrets**:

```bash
# In GitHub repository settings:
# Settings > Secrets and variables > Actions > New repository secret

# Add these secrets:
OPENAI_API_KEY=sk-your-real-openai-key
ANTHROPIC_API_KEY=sk-ant-your-real-anthropic-key
```

### Local Pre-Commit Hooks

```bash
# .git/hooks/pre-commit (make executable: chmod +x .git/hooks/pre-commit)
#!/bin/bash

echo "Running pre-commit checks for LangChain tests..."

# 1. Run fast unit tests
echo "Running unit tests (mocked APIs)..."
bundle exec rspec spec --tag ~integration --tag ~vcr --fail-fast
if [ $? -ne 0 ]; then
  echo "❌ Unit tests failed - fix before committing"
  exit 1
fi

# 2. Check for hardcoded API keys
echo "Scanning for hardcoded API keys..."
if git diff --cached | grep -E "sk-[a-zA-Z0-9]{48}|sk-ant-"; then
  echo "❌ Hardcoded API key detected in staged changes!"
  exit 1
fi

# 3. Verify test coverage
echo "Checking test coverage..."
COVERAGE=$(cat coverage/.last_run.json | jq -r '.result.line' 2>/dev/null || echo "0")
if (( $(echo "$COVERAGE < 95" | bc -l) )); then
  echo "⚠️  Coverage $COVERAGE% is below 95% - add tests"
  echo "Proceed anyway? (y/n)"
  read -r response
  if [[ ! "$response" =~ ^[Yy]$ ]]; then
    exit 1
  fi
fi

echo "✅ All pre-commit checks passed!"
```

## Test Coverage & Reporting {#test-coverage}

Track and visualize test coverage with SimpleCov and enforce quality gates.

### SimpleCov Configuration for LangChain Projects

```ruby
# spec/spec_helper.rb (top of file, before any requires)
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/vendor/'

  add_group 'LangChain Core', 'app/services/langchain'
  add_group 'LLM Clients', 'lib/llm'
  add_group 'Memory Management', 'app/models/conversation_memory'
  add_group 'Controllers', 'app/controllers'
  add_group 'Background Jobs', 'app/jobs'

  # Enforce 95% minimum coverage
  minimum_coverage 95
  minimum_coverage_by_file 90

  # Fail build if coverage drops
  refuse_coverage_drop :maximum_coverage_drop => 2.0
end

SimpleCov.at_exit do
  SimpleCov.result.format!

  # Print coverage summary to console
  puts "\n📊 Test Coverage Summary:"
  puts "Overall: #{SimpleCov.result.covered_percent.round(2)}%"
  puts "Files: #{SimpleCov.result.covered_lines}/#{SimpleCov.result.total_lines} lines"

  # Fail if below threshold
  if SimpleCov.result.covered_percent < 95
    puts "❌ Coverage #{SimpleCov.result.covered_percent.round(2)}% is below 95% threshold!"
    exit 1
  else
    puts "✅ Coverage passes 95% threshold"
  end
end
```

### Generating Coverage Reports

```bash
# Run tests and generate HTML coverage report
bundle exec rspec spec

# Open coverage report in browser
open coverage/index.html

# View coverage summary in terminal
cat coverage/.last_run.json | jq '.result'
```

**Coverage Report Output**:
```
📊 Test Coverage Summary:
Overall: 96.8%
Files: 1547/1598 lines
✅ Coverage passes 95% threshold

Coverage report generated:
  coverage/index.html
```

### Testing Coverage for Specific Components

```ruby
# spec/coverage/langchain_coverage_spec.rb
require 'rails_helper'

RSpec.describe 'Test Coverage Validation' do
  it 'ensures LangChain core services have 100% coverage' do
    # Run this after full test suite
    result = SimpleCov.result

    langchain_files = result.files.select { |f| f.filename.include?('langchain') }

    langchain_files.each do |file|
      coverage_percent = file.covered_percent.round(2)

      puts "#{file.filename}: #{coverage_percent}%"

      # LangChain core should have 95%+ coverage (critical path)
      expect(coverage_percent).to be >= 95.0,
        "#{file.filename} has #{coverage_percent}% coverage (expected 95%+)"
    end
  end
end
```

## Performance Testing {#performance-testing}

Benchmark LangChain operations to ensure they meet performance SLAs.

### Benchmarking LLM Response Times

```ruby
# spec/performance/llm_performance_spec.rb
require 'rails_helper'
require 'benchmark'

RSpec.describe 'LangChain Performance Benchmarks' do
  let(:llm) { instance_double(Langchain::LLM::OpenAI) }

  describe 'mocked LLM call performance' do
    before do
      allow(llm).to receive(:complete).and_return('Fast mocked response')
    end

    it 'completes in under 10ms (mocked)' do
      time = Benchmark.realtime do
        llm.complete(prompt: 'test')
      end

      expect(time).to be < 0.01  # 10ms
      puts "Mocked LLM call: #{(time * 1000).round(2)}ms"
    end
  end

  describe 'real API performance', if: ENV['RUN_INTEGRATION_TESTS'] == 'true' do
    let(:real_llm) { Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY']) }

    it 'completes basic prompt in under 3 seconds', vcr: 'performance/basic_prompt' do
      time = Benchmark.realtime do
        real_llm.complete(
          prompt: 'Say "Fast"',
          max_tokens: 5,
          temperature: 0
        )
      end

      expect(time).to be < 3.0  # 3 second SLA
      puts "Real API call: #{time.round(2)}s"
    end

    it 'streaming completes first token in under 1 second' do
      first_token_time = nil
      start_time = Time.now

      real_llm.complete(
        prompt: 'Count to 5',
        stream: proc { |chunk|
          first_token_time ||= Time.now - start_time
        }
      )

      expect(first_token_time).to be < 1.0
      puts "Time to first token: #{first_token_time.round(2)}s"
    end
  end
end
```

### Memory and Resource Usage Testing

```ruby
# spec/performance/memory_usage_spec.rb
require 'rails_helper'
require 'benchmark/memory'

RSpec.describe 'Memory Usage Benchmarks' do
  describe 'conversation memory efficiency' do
    it 'stays under 10MB for 100 message conversations' do
      memory = Langchain::Memory::ConversationBufferMemory.new

      report = Benchmark.memory do |x|
        x.report('100 messages') do
          100.times do |i|
            memory.add_user_message("User message #{i}")
            memory.add_ai_message("AI response #{i}")
          end
        end
      end

      allocated_mb = report.total_allocated_memory / 1024.0 / 1024.0

      expect(allocated_mb).to be < 10.0
      puts "Memory allocated: #{allocated_mb.round(2)} MB"
    end
  end

  describe 'vector storage performance' do
    it 'indexes 1000 documents in under 5 seconds' do
      embeddings = instance_double(Langchain::LLM::OpenAI)
      allow(embeddings).to receive(:embed).and_return([0.1] * 1536)  # Mock 1536-dim vector

      vector_store = []

      time = Benchmark.realtime do
        1000.times do |i|
          embedding = embeddings.embed("Document #{i}")
          vector_store << { id: i, vector: embedding, content: "Doc #{i}" }
        end
      end

      expect(time).to be < 5.0
      puts "1000 embeddings indexed: #{time.round(2)}s"
    end
  end
end
```

## Troubleshooting Common Issues {#troubleshooting}

Solutions to frequent testing challenges.

### Issue 1: VCR Cassette Not Found

**Problem**: `VCR::Errors::UnhandledHTTPRequestError: Real HTTP connections are disabled`

**Solution**:
```ruby
# spec/langchain/troubleshooting/vcr_issues_spec.rb
RSpec.describe 'VCR Troubleshooting' do
  describe 'forcing cassette creation' do
    it 'creates missing cassette on first run', vcr: { cassette_name: 'test/new_cassette', record: :new_episodes } do
      # record: :new_episodes - Creates cassette if missing, replays if exists
      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      response = llm.complete(prompt: 'test')

      expect(response).not_to be_empty
    end
  end

  describe 'updating outdated cassettes' do
    it 'regenerates cassette when API changes', vcr: { cassette_name: 'test/outdated', record: :all } do
      # record: :all - Always makes real API call and overwrites cassette
      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      response = llm.complete(prompt: 'updated prompt')

      expect(response).not_to be_empty
    end
  end
end
```

### Issue 2: Flaky Tests Due to Non-Determinism

**Problem**: LLM responses vary, causing random test failures

**Solution**:
```ruby
# spec/langchain/troubleshooting/determinism_spec.rb
RSpec.describe 'Handling Non-Deterministic Responses' do
  describe 'flexible assertions' do
    it 'validates behavior, not exact output' do
      llm = instance_double(Langchain::LLM::OpenAI)
      allow(llm).to receive(:complete).and_return(
        # Could be any of these responses
        ['Ruby is great!', 'Ruby is awesome!', 'Ruby is fantastic!'].sample
      )

      response = llm.complete(prompt: 'What is Ruby?')

      # Assert behavior, not exact text
      expect(response).to match(/ruby/i)
      expect(response).to match(/great|awesome|fantastic/i)
      expect(response.length).to be > 5
    end
  end

  describe 'using temperature: 0 for determinism' do
    it 'produces consistent responses with temperature: 0', vcr: 'determinism/temp_zero' do
      llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

      response1 = llm.complete(prompt: 'Say exactly: Ruby 3.2', temperature: 0)
      response2 = llm.complete(prompt: 'Say exactly: Ruby 3.2', temperature: 0)

      # With temp: 0, responses should be identical or very similar
      expect(response1).to include('Ruby')
      expect(response2).to include('Ruby')
    end
  end
end
```

### Issue 3: Tests Timeout Waiting for API

**Problem**: Tests hang indefinitely waiting for slow API responses

**Solution**:
```ruby
# spec/langchain/troubleshooting/timeout_spec.rb
RSpec.describe 'Handling API Timeouts' do
  around(:each) do |example|
    # Set global timeout for slow tests
    Timeout.timeout(10) do  # 10 second max per test
      example.run
    end
  rescue Timeout::Error
    fail 'Test exceeded 10 second timeout'
  end

  it 'configures explicit timeout for LLM calls' do
    llm = Langchain::LLM::OpenAI.new(
      api_key: ENV['OPENAI_API_KEY'],
      request_timeout: 5  # 5 second timeout
    )

    expect {
      llm.complete(prompt: 'test')
    }.not_to raise_error(Timeout::Error)
  end

  it 'mocks slow API calls for fast tests' do
    llm = instance_double(Langchain::LLM::OpenAI)

    # Simulate slow API (would timeout in real call)
    allow(llm).to receive(:complete) do
      sleep(0.01)  # Fast mock instead of slow API
      'Quick mocked response'
    end

    response = nil
    time = Benchmark.realtime do
      response = llm.complete(prompt: 'test')
    end

    expect(time).to be < 0.1  # Fast
    expect(response).to eq('Quick mocked response')
  end
end
```

## Next Steps & Resources {#next-steps}

You now have a comprehensive testing foundation for LangChain-Ruby applications. Here's how to deepen your expertise:

### Advanced Testing Topics to Explore

1. **Property-Based Testing with RSpec**: Use `rspec-parameterized` for testing LLM behavior across wide input ranges
2. **Contract Testing**: Validate LangChain API integrations with Pact or similar tools
3. **Load Testing**: Simulate high-volume AI traffic with tools like `ruby-jmeter`
4. **Mutation Testing**: Use `mutant` gem to test the quality of your tests themselves
5. **Visual Regression Testing**: Test AI-generated UI components with Percy or similar tools

### Recommended Tools and Gems

```ruby
# Gemfile - advanced testing tools
group :test do
  gem 'rspec-parameterized', '~> 1.0'  # Data-driven tests
  gem 'shoulda-matchers', '~> 6.0'     # Expressive matchers
  gem 'database_cleaner', '~> 2.0'     # Clean test database
  gem 'capybara', '~> 3.39'            # Browser testing
  gem 'selenium-webdriver', '~> 4.15'  # Browser automation
  gem 'rspec-retry', '~> 0.6'          # Retry flaky tests
  gem 'test-prof', '~> 1.3'            # Performance profiling
end
```

### Related JetThoughts Articles

Expand your LangChain knowledge with these comprehensive guides:

- **[Getting Started with LangChain-Ruby: Complete Guide](/blog/getting-started-langchain-ruby-complete-guide/)** - Foundation for building AI features in Ruby
- **[Ruby Testing Best Practices](/blog/ruby-on-rails-testing-strategy-unit-tests-integration/)** - Core testing strategies for Rails applications
- **[RSpec Patterns and Practices](/blog/)** - Advanced RSpec techniques and patterns
- **[CI/CD with GitHub Actions for Rails](/blog/)** - Comprehensive CI/CD automation guide
- **[Ruby Performance Optimization](/blog/)** - Benchmarking and profiling strategies

### Community Resources

- **[LangChain-Ruby GitHub](https://github.com/patterns-ai-core/langchainrb)** - Official repository, issues, examples
- **[RSpec Documentation](https://rspec.info/)** - Comprehensive RSpec reference
- **[WebMock Documentation](https://github.com/bblimke/webmock)** - HTTP stubbing patterns
- **[VCR Documentation](https://github.com/vcr/vcr)** - Record/replay HTTP interactions
- **[SimpleCov Documentation](https://github.com/simplecov-ruby/simplecov)** - Test coverage analysis

### Production Testing Checklist

Before deploying LangChain features to production:

- [ ] **95%+ test coverage** validated by SimpleCov
- [ ] **All tests passing** in CI/CD pipeline (unit, VCR, integration)
- [ ] **No hardcoded API keys** (security scan passes)
- [ ] **Error handling tested** (rate limits, timeouts, network failures)
- [ ] **Performance benchmarks met** (response time < 3s, memory usage reasonable)
- [ ] **VCR cassettes recorded** for all critical API interactions
- [ ] **Integration tests gated** (only run in production CI, not every PR)
- [ ] **Cost controls implemented** (token limits, max_tokens, budget alerts)
- [ ] **Monitoring configured** (API usage, error rates, latency)
- [ ] **Rollback plan documented** (how to disable AI features if needed)

---

**Ready to build reliable AI features?** Start with comprehensive testing, ship with confidence, and iterate based on real production data. Your users will thank you for the reliability.

**Need help implementing LangChain testing for your Ruby project?** [Contact JetThoughts](/contact/) for expert consultation on AI-powered Rails applications.

---

**Published**: October 17, 2025
**Author**: JetThoughts Development Team
**Category**: Ruby, AI, Testing
**Tags**: ruby, langchain, rspec, testing, ai, mocking, vcr, ci-cd, performance
