---
dev_to_id: 2169852
title: "Getting Started with LangChain-Ruby: A Complete Guide"
description: "Learn how to build AI-powered applications with LangChain-Ruby. Complete guide with working code examples, Rails integration, and production best practices for junior Ruby developers."
created_at: "2025-01-27T18:30:00Z"
edited_at: "2025-01-27T18:30:00Z"
draft: false
tags: ["ruby", "rails", "ai", "langchain", "tutorial"]
canonical_url: "https://jetthoughts.com/blog/getting-started-langchain-ruby-complete-guide/"
cover_image: ""
slug: "getting-started-langchain-ruby-complete-guide"
metatags:
  image: og-getting-started-langchain-ruby.png
---

Building AI-powered features in your Ruby applications has never been more accessible. With the official LangChain-Ruby SDK (released in 2025), you can integrate OpenAI, Anthropic, and other LLM providers directly into your Rails apps without wrestling with complex API integrations.

This guide walks you through everything you need to build your first AI agent in Ruby—from installation to production deployment. By the end, you'll have working code examples and understand how to integrate LangChain-Ruby into real Rails applications.

## Table of Contents

1. [What is LangChain-Ruby?](#what-is-langchain-ruby)
2. [Installation & Setup](#installation-setup)
3. [Building Your First AI Agent](#building-first-agent)
4. [Integrating with Rails Applications](#rails-integration)
5. [Production Considerations](#production-considerations)
6. [Troubleshooting Common Issues](#troubleshooting)
7. [Next Steps](#next-steps)

## What is LangChain-Ruby? {#what-is-langchain-ruby}

LangChain-Ruby (also known as `langchainrb`) is the official Ruby implementation of the popular LangChain framework. It provides a unified interface for working with Large Language Models (LLMs), making it easy to build AI-powered features without worrying about vendor-specific API differences.

### Why LangChain-Ruby Matters NOW

The Ruby AI landscape changed dramatically in 2025 when the `langchainrb` gem reached production stability (v0.19.5+). Here's why this matters:

**Before LangChain-Ruby**: Ruby developers had to write custom API clients for each LLM provider, handle rate limiting manually, and build their own conversation management systems.

**After LangChain-Ruby**: You get a batteries-included framework with:
- Unified LLM interface (OpenAI, Anthropic, Google, Cohere)
- Built-in conversation memory management
- Tool integration for extending AI capabilities
- Vector database support for semantic search
- Production-ready error handling and retry logic

### LangChain-Ruby vs. Python LangChain

If you're coming from Python LangChain, here's what you need to know:

| Feature | Python LangChain | Ruby LangChain |
|---------|-----------------|----------------|
| **LLM Providers** | 100+ providers | 15+ core providers (growing) |
| **Community Size** | Large (~70k GitHub stars) | Growing (~2k GitHub stars) |
| **Rails Integration** | Manual setup | `langchainrb_rails` gem |
| **Syntax Style** | Python-idiomatic | Ruby-idiomatic |
| **Performance** | Fast (Python) | Comparable (Ruby 3.2+) |
| **Production Ready** | Yes (2023+) | Yes (2025+) |

**Migration Tip**: Core concepts (Chains, Agents, Tools, Memory) work the same way. Ruby syntax is more elegant and feels natural if you're already working in Rails.

### Use Cases Perfect for Ruby Developers

LangChain-Ruby shines in these scenarios:

1. **Rails Application Enhancement**: Add AI features to existing Rails apps without switching languages
2. **Customer Support Automation**: Build intelligent chatbots using your Ruby backend
3. **Content Generation**: Generate blog posts, emails, or documentation from Rails admin panels
4. **Data Analysis**: Process and summarize user data using natural language queries
5. **Semantic Search**: Upgrade traditional search with vector-based similarity matching

## Installation & Setup {#installation-setup}

Let's get LangChain-Ruby running in under 5 minutes.

### Prerequisites

Before starting, ensure you have:
- **Ruby 3.2+** (LangChain-Ruby requires modern Ruby features)
- **Rails 7.1+** (for Rails integration examples)
- **An LLM API key** (OpenAI or Anthropic recommended)

Check your Ruby version:

```bash
ruby -v
# Should show: ruby 3.2.0 or higher
```

### Installing the LangChain-Ruby Gem

Add the gem to your Gemfile:

```ruby
# Gemfile
gem 'langchainrb', '~> 0.19'

# Optional: Add specific LLM provider gems
gem 'ruby-openai', '~> 6.3' # For OpenAI integration
gem 'anthropic', '~> 0.1'   # For Claude integration
```

Install dependencies:

```bash
bundle install
```

**Version Note**: Use version `0.19.5+` for production stability. Earlier versions had experimental APIs that have since changed.

### Setting Up API Keys (Best Practices)

Never hardcode API keys! Use environment variables with the `dotenv` gem:

1. **Add dotenv to your Gemfile**:

```ruby
# Gemfile
gem 'dotenv-rails', groups: [:development, :test]
```

2. **Create a `.env` file** (add to `.gitignore`!):

```bash
# .env
OPENAI_API_KEY=sk-your-openai-key-here
ANTHROPIC_API_KEY=sk-ant-your-anthropic-key-here
```

3. **Add `.env` to `.gitignore`**:

```bash
# .gitignore
.env
.env.local
```

### Configuring LLM Providers

LangChain-Ruby supports multiple providers. Here's how to configure each:

#### OpenAI Configuration

```ruby
# config/initializers/langchain.rb (Rails)
# OR at the top of your script (standalone Ruby)

require 'langchain'

# Initialize OpenAI LLM
openai_llm = Langchain::LLM::OpenAI.new(
  api_key: ENV['OPENAI_API_KEY'],
  default_options: {
    model: 'gpt-4-turbo',
    temperature: 0.7,
    max_tokens: 1000
  }
)
```

#### Anthropic (Claude) Configuration

```ruby
# Claude is often better for production use (lower hallucination rates)
anthropic_llm = Langchain::LLM::Anthropic.new(
  api_key: ENV['ANTHROPIC_API_KEY'],
  default_options: {
    model: 'claude-3-sonnet-20240229',
    max_tokens: 1024,
    temperature: 0.5
  }
)
```

### Testing Your Setup: "Hello World" Example

Let's verify everything works with a simple LLM call:

```ruby
# test_langchain.rb
require 'bundler/setup'
require 'langchain'
require 'dotenv/load'

# Initialize LLM
llm = Langchain::LLM::OpenAI.new(
  api_key: ENV['OPENAI_API_KEY']
)

# Make your first AI call
response = llm.complete(
  prompt: "Explain Ruby in exactly 3 sentences. Be encouraging!"
)

puts response.completion
```

Run it:

```bash
ruby test_langchain.rb
```

**Expected Output** (from GPT-4):
> Ruby is a dynamic, object-oriented programming language known for its elegant syntax and developer happiness focus. It powers millions of web applications through the Rails framework and emphasizes readability and productivity. You'll love how Ruby makes complex code feel simple and expressive!

If you see output like this, congratulations! LangChain-Ruby is working.

## Building Your First AI Agent {#building-first-agent}

Now let's build something more sophisticated: an AI agent that can answer questions and use tools.

### Understanding Agents vs. Chains

Before diving into code, understand the key concepts:

| Concept | What It Does | When to Use |
|---------|--------------|-------------|
| **LLM** | Basic text completion | Simple prompts, single responses |
| **Chain** | Sequence of LLM calls | Multi-step workflows, data transformations |
| **Agent** | LLM + tools + decision-making | Dynamic problem-solving, external API calls |
| **Memory** | Conversation history | Chatbots, multi-turn interactions |

**Rule of Thumb**: Start with LLMs, use Chains for workflows, use Agents when you need decision-making.

### Creating a Simple Question-Answering Agent

Here's a complete AI agent that can answer questions about Ruby:

```ruby
# ruby_assistant.rb
require 'langchain'
require 'dotenv/load'

class RubyAssistant
  def initialize
    # Set up LLM
    @llm = Langchain::LLM::OpenAI.new(
      api_key: ENV['OPENAI_API_KEY'],
      default_options: { model: 'gpt-4-turbo' }
    )

    # Set up memory to remember conversation context
    @memory = Langchain::Memory::ConversationBufferMemory.new(
      llm: @llm,
      max_messages: 10 # Keep last 10 messages
    )

    # Create agent with system instructions
    @agent = Langchain::Agent.new(
      llm: @llm,
      memory: @memory,
      instructions: "You are a helpful Ruby programming expert.
                     Provide clear, practical advice with code examples.
                     Be encouraging and reference Ruby best practices."
    )
  end

  def ask(question)
    response = @agent.run(message: question)
    response.content
  rescue StandardError => e
    "Error: #{e.message}"
  end

  def conversation_history
    @memory.messages
  end
end

# Usage example
assistant = RubyAssistant.new

# Ask multiple questions - agent remembers context!
puts "Q: What's a Ruby block?"
puts assistant.ask("What's a Ruby block? Give a simple example.")
puts "\n---\n"

puts "Q: How do I make it return a value?"
# Agent remembers we're talking about blocks!
puts assistant.ask("How do I make it return a value?")
puts "\n---\n"

# Show conversation history
puts "Conversation so far:"
assistant.conversation_history.each_with_index do |msg, i|
  puts "#{i + 1}. #{msg.role}: #{msg.content[0..80]}..."
end
```

**Key Features in This Example**:
- ✅ Memory management (agent remembers context)
- ✅ Error handling (production-ready)
- ✅ Conversation history tracking
- ✅ System instructions for consistent behavior

### Adding Memory to Agents

LangChain-Ruby provides multiple memory strategies:

#### 1. Buffer Memory (Simple, Fixed Window)

```ruby
# Keep last N messages
memory = Langchain::Memory::ConversationBufferMemory.new(
  llm: @llm,
  max_messages: 10
)
```

**Best For**: Simple chatbots, short conversations

#### 2. Summary Memory (Compressed Context)

```ruby
# Automatically summarize older messages
memory = Langchain::Memory::ConversationSummaryMemory.new(
  llm: @llm,
  max_messages: 50, # Summarize after 50 messages
  summary_message_count: 10 # Keep last 10 messages verbatim
)
```

**Best For**: Long conversations, cost optimization

#### 3. Token Buffer Memory (Stay Under Token Limits)

```ruby
# Ensure we never exceed token limits
memory = Langchain::Memory::ConversationTokenBufferMemory.new(
  llm: @llm,
  max_token_limit: 4000 # For GPT-4 Turbo
)
```

**Best For**: Production apps with strict token budgets

### Implementing Tool Use

Tools let your AI agent interact with external systems. Here's how to add a calculator tool:

```ruby
# calculator_agent.rb
require 'langchain'
require 'dotenv/load'

class CalculatorAgent
  def initialize
    @llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])

    # Define a calculator tool
    calculator_tool = Langchain::Tool::RubyCodeInterpreter.new

    # Create agent with tools
    @agent = Langchain::Agent.new(
      llm: @llm,
      tools: [calculator_tool],
      instructions: "You can perform calculations using the calculator tool.
                     Always show your work."
    )
  end

  def calculate(problem)
    response = @agent.run(message: problem)
    response.content
  end
end

# Usage
calc_agent = CalculatorAgent.new

puts calc_agent.calculate("What's 1,234 * 567 + 89?")
# Agent will:
# 1. Recognize it needs to calculate
# 2. Use the calculator tool: (1234 * 567) + 89
# 3. Return: "The answer is 699,667"
```

**Available Built-In Tools**:
- `Langchain::Tool::RubyCodeInterpreter` - Execute Ruby code safely
- `Langchain::Tool::GoogleSearch` - Web search (requires SerpApi)
- `Langchain::Tool::WikipediaSearch` - Wikipedia lookups
- `Langchain::Tool::NewsRetriever` - Fetch news articles
- `Langchain::Tool::Weather` - Get weather data

## Integrating with Rails Applications {#rails-integration}

Let's integrate LangChain-Ruby into a real Rails application with proper architecture patterns.

### Rails Architecture Patterns for AI

Follow these patterns to keep your Rails app clean:

```
app/
├── services/          # Business logic with AI
│   └── ai_assistant_service.rb
├── jobs/              # Background AI processing
│   └── generate_summary_job.rb
├── controllers/       # Handle AI requests
│   └── ai_chat_controller.rb
└── models/            # Store AI data
    ├── conversation.rb
    └── ai_message.rb
```

### Controller Integration

Here's a production-ready Rails controller for an AI chatbot:

```ruby
# app/controllers/ai_chat_controller.rb
class AiChatController < ApplicationController
  before_action :authenticate_user!

  def create
    # Get user's message from params
    user_message = params[:message]

    # Rate limiting (prevent abuse)
    if current_user.ai_messages_today >= 50
      return render json: {
        error: "Daily AI message limit reached"
      }, status: :too_many_requests
    end

    # Process with AI (async recommended for production)
    GenerateAiResponseJob.perform_later(
      user_id: current_user.id,
      conversation_id: params[:conversation_id],
      message: user_message
    )

    render json: {
      status: "processing",
      message: "AI is thinking..."
    }, status: :accepted
  end

  def show
    # Get conversation history
    conversation = current_user.conversations.find(params[:id])

    render json: {
      messages: conversation.ai_messages.order(created_at: :asc),
      status: conversation.status
    }
  end
end
```

### Background Job Processing with Sidekiq

Process AI requests asynchronously to keep your app responsive:

```ruby
# app/jobs/generate_ai_response_job.rb
class GenerateAiResponseJob < ApplicationJob
  queue_as :ai_processing

  retry_on Langchain::LLM::ApiError, wait: :exponentially_longer

  def perform(user_id:, conversation_id:, message:)
    user = User.find(user_id)
    conversation = Conversation.find(conversation_id)

    # Store user's message
    conversation.ai_messages.create!(
      role: 'user',
      content: message,
      user: user
    )

    # Generate AI response
    ai_response = AiAssistantService.new(conversation).respond_to(message)

    # Store AI response
    conversation.ai_messages.create!(
      role: 'assistant',
      content: ai_response,
      user: nil
    )

    # Update conversation status
    conversation.update!(status: 'completed', completed_at: Time.current)

    # Notify user via Action Cable (real-time updates)
    ConversationChannel.broadcast_to(
      conversation,
      { message: ai_response, status: 'completed' }
    )
  end
end
```

### Caching Strategies for LLM Responses

LLM calls are expensive. Cache intelligently:

```ruby
# app/services/ai_assistant_service.rb
class AiAssistantService
  def initialize(conversation)
    @conversation = conversation
    @llm = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])
  end

  def respond_to(message)
    # Cache identical questions (exact match)
    cache_key = "ai_response:#{Digest::SHA256.hexdigest(message)}"

    Rails.cache.fetch(cache_key, expires_in: 24.hours) do
      # Generate response only if not cached
      generate_response(message)
    end
  end

  private

  def generate_response(message)
    # Load conversation history for context
    memory = build_memory_from_conversation

    agent = Langchain::Agent.new(
      llm: @llm,
      memory: memory,
      instructions: system_instructions
    )

    response = agent.run(message: message)

    # Log token usage for cost tracking
    log_token_usage(response.usage)

    response.content
  rescue Langchain::LLM::ApiError => e
    # Handle rate limits, API errors gracefully
    Rails.logger.error("AI API Error: #{e.message}")
    "I'm having trouble connecting right now. Please try again shortly."
  end

  def build_memory_from_conversation
    memory = Langchain::Memory::ConversationBufferMemory.new(
      llm: @llm,
      max_messages: 20
    )

    # Load last 20 messages from database
    @conversation.ai_messages.last(20).each do |msg|
      memory.add_message(role: msg.role, content: msg.content)
    end

    memory
  end

  def system_instructions
    "You are a helpful AI assistant for #{Rails.application.class.module_parent_name}.
     Be concise, friendly, and accurate.
     If you don't know something, say so clearly."
  end

  def log_token_usage(usage)
    # Track costs in database for billing/monitoring
    TokenUsage.create!(
      conversation: @conversation,
      prompt_tokens: usage[:prompt_tokens],
      completion_tokens: usage[:completion_tokens],
      total_tokens: usage[:total_tokens],
      estimated_cost_usd: calculate_cost(usage)
    )
  end

  def calculate_cost(usage)
    # GPT-4 Turbo pricing (as of 2025)
    prompt_cost = usage[:prompt_tokens] * 0.00001    # $0.01 per 1K tokens
    completion_cost = usage[:completion_tokens] * 0.00003 # $0.03 per 1K tokens
    prompt_cost + completion_cost
  end
end
```

### Error Handling and Rate Limiting

Production apps need robust error handling:

```ruby
# config/initializers/langchain.rb
Langchain.configure do |config|
  # Automatic retries with exponential backoff
  config.retry_on_rate_limit = true
  config.max_retries = 3
  config.initial_retry_delay = 1 # second

  # Timeout settings (prevent hanging requests)
  config.request_timeout = 30 # seconds

  # Logging
  config.logger = Rails.logger
  config.log_level = Rails.env.production? ? :info : :debug
end
```

## Production Considerations {#production-considerations}

Running LangChain-Ruby in production requires careful planning around costs, performance, and reliability.

### Cost Optimization Strategies

LLM calls are your biggest expense. Optimize aggressively:

#### 1. Use Cheaper Models When Possible

```ruby
# Don't use GPT-4 for simple tasks!
class ModelSelector
  def self.select_for_task(task_complexity)
    case task_complexity
    when :simple
      # Grammar fixing, simple classification
      { model: 'gpt-3.5-turbo', max_tokens: 500 }
    when :moderate
      # Summaries, basic reasoning
      { model: 'gpt-4-turbo', max_tokens: 1000 }
    when :complex
      # Advanced reasoning, code generation
      { model: 'gpt-4', max_tokens: 2000 }
    end
  end
end
```

**Savings**: GPT-3.5-Turbo costs 10x less than GPT-4!

#### 2. Implement Aggressive Caching

```ruby
# Cache similar queries (semantic similarity)
class SemanticCache
  def fetch_or_generate(query, &block)
    # Find semantically similar queries
    similar_query = find_similar_cached_query(query, threshold: 0.95)

    if similar_query
      Rails.cache.read("ai_response:#{similar_query}")
    else
      response = block.call
      Rails.cache.write("ai_response:#{query}", response, expires_in: 7.days)
      response
    end
  end

  private

  def find_similar_cached_query(query, threshold:)
    # Use vector similarity (pgvector) to find similar queries
    # Implementation depends on your vector database setup
    # This is a simplified example
    CachedQuery.semantic_search(query, threshold: threshold).first&.query_text
  end
end
```

#### 3. Set Strict Token Limits

```ruby
# app/models/ai_message.rb
class AiMessage < ApplicationRecord
  validates :content, length: { maximum: 500 } # Limit user input

  def self.max_tokens_for_response
    # Never exceed this, regardless of user request
    1500
  end
end
```

### Response Time Optimization

Users expect fast responses. Optimize for speed:

#### 1. Streaming Responses (Real-Time)

```ruby
# app/controllers/ai_chat_controller.rb
def stream
  response_stream = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])
    .complete_stream(prompt: params[:message])

  # Stream to client via Server-Sent Events
  response.headers['Content-Type'] = 'text/event-stream'
  response.headers['Cache-Control'] = 'no-cache'

  response_stream.each do |chunk|
    response.stream.write("data: #{chunk.to_json}\n\n")
  end
ensure
  response.stream.close
end
```

#### 2. Parallel Processing for Multiple Requests

```ruby
# Process multiple AI requests concurrently
def generate_batch_responses(messages)
  threads = messages.map do |message|
    Thread.new do
      llm.complete(prompt: message)
    end
  end

  threads.map(&:value) # Wait for all to complete
end
```

### Error Handling and Fallbacks

Never let AI failures break your app:

```ruby
class RobustAiService
  def respond_with_fallback(message)
    # Try primary AI provider
    primary_response(message)
  rescue Langchain::LLM::ApiError => e
    Rails.logger.warn("Primary AI failed: #{e.message}")

    # Fallback to secondary provider
    fallback_response(message)
  rescue StandardError => e
    Rails.logger.error("All AI providers failed: #{e.message}")

    # Ultimate fallback: return helpful error message
    "I'm temporarily unavailable. Our team has been notified.
     Please try again in a few minutes."
  end

  private

  def primary_response(message)
    openai_llm.complete(prompt: message).completion
  end

  def fallback_response(message)
    # Use cheaper/different provider as backup
    anthropic_llm.complete(prompt: message).completion
  end
end
```

### Monitoring and Logging

Track AI performance religiously:

```ruby
# config/initializers/ai_monitoring.rb
ActiveSupport::Notifications.subscribe('langchain.completion') do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  # Log to monitoring service (e.g., Datadog, New Relic)
  StatsD.increment('ai.completion.count')
  StatsD.timing('ai.completion.duration', event.duration)
  StatsD.gauge('ai.completion.tokens', event.payload[:total_tokens])
  StatsD.gauge('ai.completion.cost_usd', event.payload[:cost])

  # Alert if costs spike
  if event.payload[:cost] > 0.50 # $0.50 per request
    Rails.logger.warn("High-cost AI request: $#{event.payload[:cost]}")
  end
end
```

### Security Best Practices

Protect your AI integration:

```ruby
# 1. API Key Management - NEVER commit keys
# Use Rails credentials or environment variables
openai_key = Rails.application.credentials.dig(:openai, :api_key) ||
             ENV['OPENAI_API_KEY']

# 2. Input Sanitization - Prevent prompt injection
def sanitize_user_input(input)
  # Remove potential prompt injection attempts
  input.gsub(/ignore previous instructions/i, '')
       .gsub(/you are now/i, '')
       .truncate(500) # Limit length
end

# 3. Output Filtering - Prevent inappropriate responses
def filter_ai_response(response)
  # Check for inappropriate content
  if contains_inappropriate_content?(response)
    Rails.logger.warn("AI generated inappropriate content")
    return "I can't provide that information."
  end

  response
end

# 4. Rate Limiting - Prevent abuse
class User < ApplicationRecord
  def ai_messages_today
    ai_messages.where('created_at >= ?', 24.hours.ago).count
  end

  def can_use_ai?
    ai_messages_today < daily_ai_limit
  end

  def daily_ai_limit
    premium? ? 500 : 50
  end
end
```

## Troubleshooting Common Issues {#troubleshooting}

### Connection Errors

**Problem**: `Langchain::LLM::ApiError: Connection refused`

**Solutions**:
```ruby
# 1. Check API key is set correctly
puts ENV['OPENAI_API_KEY'] # Should not be nil or empty

# 2. Verify network connectivity
require 'net/http'
Net::HTTP.get(URI('https://api.openai.com/v1/models')) rescue $!.class
# Should connect successfully

# 3. Check for proxy settings
ENV['HTTP_PROXY'] = 'http://your-proxy:8080' if behind_corporate_firewall?
```

### Rate Limiting

**Problem**: `Langchain::LLM::RateLimitError: Rate limit exceeded`

**Solutions**:
```ruby
# 1. Implement exponential backoff
def complete_with_retry(prompt, max_attempts: 3)
  attempts = 0

  begin
    attempts += 1
    llm.complete(prompt: prompt)
  rescue Langchain::LLM::RateLimitError => e
    if attempts < max_attempts
      sleep_time = 2 ** attempts # Exponential backoff
      Rails.logger.info("Rate limited, retrying in #{sleep_time}s...")
      sleep(sleep_time)
      retry
    else
      raise e
    end
  end
end

# 2. Use queue systems (Sidekiq) to throttle requests
class AiProcessingJob < ApplicationJob
  queue_as :ai_low_priority # Separate queue with rate limit

  # Process max 10 jobs per minute
  throttle threshold: 10, period: 1.minute
end
```

### Token Limit Errors

**Problem**: `Langchain::LLM::TokenLimitError: Maximum context length exceeded`

**Solutions**:
```ruby
# 1. Use token-aware memory
memory = Langchain::Memory::ConversationTokenBufferMemory.new(
  llm: @llm,
  max_token_limit: 4000 # For GPT-4 Turbo (8K context)
)

# 2. Truncate long inputs
def truncate_to_tokens(text, max_tokens: 3000)
  # Rough estimate: 1 token ≈ 4 characters
  max_chars = max_tokens * 4
  text.truncate(max_chars, separator: ' ')
end

# 3. Use summarization for long context
def summarize_conversation_history(messages)
  long_context = messages.map(&:content).join("\n")

  llm.complete(
    prompt: "Summarize this conversation in 3 bullet points:\n#{long_context}"
  ).completion
end
```

### Gem Compatibility Issues

**Problem**: `LoadError: cannot load such file -- langchain`

**Solutions**:
```bash
# 1. Verify gem installation
bundle show langchainrb
# Should show installed path

# 2. Check Ruby version compatibility
ruby -v
# Needs Ruby 3.2.0 or higher

# 3. Update bundler and reinstall
gem update bundler
bundle install --clean --force

# 4. Check for version conflicts
bundle exec gem dependency langchainrb -R
```

## Next Steps {#next-steps}

You've built your first AI agent with LangChain-Ruby! Here's where to go next:

### Advanced Tutorials

**Explore deeper topics**:
1. **Vector Databases with pgvector**: Build semantic search in Rails
2. **Custom Tool Creation**: Extend AI agents with your own APIs
3. **Multi-Agent Systems**: Coordinate multiple AI agents
4. **Fine-Tuning Models**: Customize LLMs for your domain

### Community Resources

**Get involved**:
- **GitHub**: [patterns-ai-core/langchainrb](https://github.com/patterns-ai-core/langchainrb) - Official repository
- **Discord**: Join the LangChain Ruby community
- **RubyGems**: [langchainrb gem page](https://rubygems.org/gems/langchainrb) - Latest releases
- **Stack Overflow**: Tag questions with `langchain-ruby`

### Official Documentation

**Reference materials**:
- [LangChain-Ruby Official Docs](https://rubydoc.info/gems/langchainrb) - Complete API reference
- [OpenAI Ruby SDK](https://github.com/alexrudall/ruby-openai) - OpenAI integration
- [Anthropic Ruby SDK](https://github.com/anthropics/anthropic-sdk-ruby) - Claude integration
- [Rails AI Integration Patterns](https://world.hey.com/timrock/langchain-rb-rails-integration-619e3627) - Production patterns

### Need Expert Help?

Building production AI features is complex. JetThoughts specializes in Ruby/Rails AI integration with:
- ✅ LangChain-Ruby expertise
- ✅ Production-ready architectures
- ✅ Cost optimization strategies
- ✅ Security best practices

**Ready to add AI to your Rails app?** [Schedule a free consultation](/contact-us/) and let's discuss your project.

---

**What to Read Next**:
- Building Semantic Search with pgvector and Rails (Coming Soon)
- Production AI Cost Optimization Strategies (Coming Soon)
- Custom AI Agents for Ruby Applications (Coming Soon)

Have questions about LangChain-Ruby? Drop a comment below or reach out on [Twitter](https://twitter.com/jetthoughts)!
