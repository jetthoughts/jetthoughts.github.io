---
title: "Building RAG Applications in Rails 7.1+ with pgvector: Complete Guide"
description: "Learn how to add semantic search and RAG capabilities to your Rails app using pgvector. Step-by-step tutorial with code examples for Ruby developers."
date: 2025-10-16
tags: ["rails", "ai", "machine-learning", "postgresql", "semantic-search", "rag"]
author: "JetThoughts Team"
slug: "building-rag-applications-rails-pgvector"
---

Traditional keyword search struggles to understand user intent. When someone searches "best pizza spots" versus "top-rated pizzerias," your app should know these mean the same thing. That's where Retrieval Augmented Generation (RAG) comes in.

RAG combines semantic search with AI-generated responses, letting your Rails app understand meaning, not just match keywords. This guide shows you how to build a production-ready RAG system using pgvector—a PostgreSQL extension that brings vector similarity search directly into your database.

By the end of this tutorial, you'll have a working document Q&A system that understands natural language queries and generates accurate, context-aware answers using your own data.

## Prerequisites

Before starting, ensure you have:

- Rails 7.1+ application with PostgreSQL 15+ database
- Ruby 3.2+ installed
- OpenAI API key ([get one here](https://platform.openai.com/api-keys))
- Basic understanding of embeddings (text converted to numerical vectors)
- Familiarity with ActiveRecord and Rails services

This tutorial assumes intermediate Rails knowledge. If you're new to AI concepts, check out [What is RAG?](https://aws.amazon.com/what-is/retrieval-augmented-generation/) first.

## What You'll Build

We're building a document Q&A system where users can ask questions in natural language and receive AI-generated answers based on your documentation. Think of it as ChatGPT trained specifically on your company's knowledge base.

The complete code examples are available on [GitHub](https://github.com/jetthoughts/rails-rag-pgvector-example).

## Part 1: Setup & Fundamentals 🟢

### Installing the pgvector Extension

pgvector is a PostgreSQL extension that adds vector similarity search capabilities. Unlike external vector databases (Pinecone, Weaviate), pgvector runs inside your existing PostgreSQL database—no additional infrastructure needed.

First, install the pgvector extension on your PostgreSQL server. On macOS with Homebrew:

```bash
brew install pgvector
```

On Linux (Ubuntu/Debian):

```bash
sudo apt-get install postgresql-15-pgvector
```

Now create a migration to enable pgvector in your Rails database:

```ruby
# db/migrate/20251016000001_enable_pgvector.rb
class EnablePgvector < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'vector'
  end
end
```

Next, add a vector column to store document embeddings. OpenAI's `text-embedding-3-small` model generates 1536-dimensional vectors:

```ruby
# db/migrate/20251016000002_add_embedding_to_documents.rb
class AddEmbeddingToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_column :documents, :embedding, :vector, limit: 1536
  end
end
```

Run the migrations:

```bash
rails db:migrate
```

Your database now supports vector storage and similarity search operations.

### Generating Embeddings with OpenAI

Embeddings are numerical representations of text that capture semantic meaning. Similar concepts have similar vectors, even if they use different words.

Install the OpenAI Ruby client:

```bash
bundle add ruby-openai
```

Create a service to generate embeddings:

```ruby
# app/services/embedding_service.rb
class EmbeddingService
  def initialize
    @client = OpenAI::Client.new(
      access_token: ENV['OPENAI_API_KEY']
    )
  end

  def generate(text)
    response = @client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: text
      }
    )
    response.dig('data', 0, 'embedding')
  end
end
```

The `text-embedding-3-small` model is cost-effective and performs well for most use cases. For production apps, consider batch processing multiple texts in a single API call to reduce latency.

### Storing Document Vectors

Create a Document model that automatically generates and stores embeddings:

```ruby
# app/models/document.rb
class Document < ApplicationRecord
  validates :title, :content, presence: true

  after_save :generate_embedding, if: :content_changed?

  private

  def generate_embedding
    embedding = EmbeddingService.new.generate(content)
    update_column(:embedding, embedding)
  end
end
```

When you save a document, Rails automatically generates its embedding:

```ruby
Document.create!(
  title: 'Rails Performance Guide',
  content: 'Use database indexes to speed up queries...'
)
# Embedding automatically generated and stored
```

The `after_save` callback ensures embeddings stay synchronized with content changes. For large documents, consider moving this to a background job (covered in Part 3).

### Vector Similarity Search

pgvector provides several distance operators for measuring similarity. We'll use cosine distance (`<=>`), which works well for normalized embeddings:

```ruby
# app/models/document.rb
class Document < ApplicationRecord
  # Previous code...

  def self.search_similar(query, limit: 5)
    query_embedding = EmbeddingService.new.generate(query)

    # Find documents with closest vector distance
    where.not(embedding: nil)
      .order(Arel.sql("embedding <=> '#{query_embedding}'"))
      .limit(limit)
  end
end
```

Now you can search documents semantically:

```ruby
Document.search_similar('How do I make my Rails app faster?')
# Returns documents about performance, optimization, caching, etc.
# Even if they don't contain the exact words "faster" or "performance"
```

Cosine distance returns values between 0 (identical) and 2 (opposite). Smaller distances indicate higher similarity.

## Part 2: Building the RAG Pipeline 🟡

### Document Chunking Strategy

Large documents create problems for RAG systems. When you retrieve a 10,000-word document, most of it won't be relevant to the user's question. Chunking splits documents into smaller, focused segments that improve retrieval precision.

Optimal chunk sizes depend on your content, but 200-500 tokens (roughly 150-375 words) works well for most cases. Smaller chunks provide more precise retrieval, but you might miss context. Larger chunks preserve context but reduce precision.

```ruby
# app/services/chunk_service.rb
class ChunkService
  CHUNK_SIZE = 300 # tokens
  CHUNK_OVERLAP = 50 # tokens for context continuity

  def initialize(tokenizer: Tokenizers.from_pretrained('gpt2'))
    @tokenizer = tokenizer
  end

  def chunk_text(text)
    tokens = @tokenizer.encode(text).ids
    chunks = []

    (0...tokens.length).step(CHUNK_SIZE - CHUNK_OVERLAP) do |i|
      chunk_tokens = tokens[i, CHUNK_SIZE]
      chunk_text = @tokenizer.decode(chunk_tokens)
      chunks << chunk_text
    end

    chunks
  end
end
```

This creates overlapping chunks to preserve context across boundaries. If a sentence is split, the overlap ensures both chunks contain the full sentence.

Update your Document model to store chunks:

```ruby
# db/migrate/20251016000003_create_document_chunks.rb
class CreateDocumentChunks < ActiveRecord::Migration[7.1]
  def change
    create_table :document_chunks do |t|
      t.references :document, foreign_key: true
      t.text :content
      t.vector :embedding, limit: 1536
      t.integer :position
      t.timestamps
    end
  end
end
```

### Semantic Search Implementation

Build a service that searches across document chunks and returns the most relevant content:

```ruby
# app/services/vector_search_service.rb
class VectorSearchService
  SIMILARITY_THRESHOLD = 0.7

  def search(query, limit: 5)
    query_embedding = EmbeddingService.new.generate(query)

    # Calculate cosine similarity (1 - cosine distance)
    # Higher scores = more similar
    DocumentChunk
      .select(
        'document_chunks.*',
        "1 - (embedding <=> '#{query_embedding}') AS similarity_score"
      )
      .where('1 - (embedding <=> ?) > ?', query_embedding, SIMILARITY_THRESHOLD)
      .order('similarity_score DESC')
      .limit(limit)
      .includes(:document)
  end
end
```

The similarity threshold (0.7) filters out low-quality matches. Tune this value based on your data—too high and you might miss relevant results, too low and you'll include irrelevant content.

Test your semantic search:

```ruby
results = VectorSearchService.new.search('database optimization techniques')
results.each do |chunk|
  puts "Score: #{chunk.similarity_score}"
  puts "Content: #{chunk.content[0..100]}..."
  puts "---"
end
```

### RAG Query Pipeline

The RAG pipeline combines vector search with AI generation. First, retrieve relevant context, then use it to generate an accurate answer:

```ruby
# app/services/rag_service.rb
class RagService
  def initialize
    @vector_search = VectorSearchService.new
    @openai = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
  end

  def query(question)
    # Step 1: Retrieve relevant chunks
    chunks = @vector_search.search(question, limit: 3)

    return no_context_response if chunks.empty?

    # Step 2: Build context from chunks
    context = chunks.map { |c| c.content }.join("\n\n")

    # Step 3: Generate answer using OpenAI
    response = @openai.chat(
      parameters: {
        model: 'gpt-4-turbo-preview',
        messages: build_messages(context, question),
        temperature: 0.3 # Lower = more factual
      }
    )

    response.dig('choices', 0, 'message', 'content')
  end

  private

  def build_messages(context, question)
    [
      {
        role: 'system',
        content: "You are a helpful assistant. Answer questions based ONLY on the provided context. If the context doesn't contain relevant information, say so."
      },
      {
        role: 'user',
        content: "Context:\n#{context}\n\nQuestion: #{question}"
      }
    ]
  end

  def no_context_response
    "I couldn't find relevant information to answer your question."
  end
end
```

The low temperature (0.3) makes responses more deterministic and factual. Higher values increase creativity but might introduce hallucinations.

### Rails Controller Integration

Expose the RAG system through a REST API:

```ruby
# app/controllers/api/rag_controller.rb
module Api
  class RagController < ApplicationController
    def query
      question = params.require(:question)

      result = RagService.new.query(question)

      render json: {
        answer: result,
        timestamp: Time.current
      }
    rescue ActionController::ParameterMissing => e
      render json: { error: e.message }, status: :bad_request
    rescue StandardError => e
      Rails.logger.error("RAG query failed: #{e.message}")
      render json: { error: 'Query processing failed' }, status: :internal_server_error
    end
  end
end
```

Add the route:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    post 'rag/query', to: 'rag#query'
  end
end
```

Test your endpoint:

```bash
curl -X POST http://localhost:3000/api/rag/query \
  -H "Content-Type: application/json" \
  -d '{"question": "How do I optimize database queries in Rails?"}'
```

## Part 3: Production Optimization 🔴

### Caching Embeddings

Generating embeddings costs money and time (50-200ms per request). For frequently queried content, implement caching:

```ruby
# app/services/cached_embedding_service.rb
class CachedEmbeddingService
  CACHE_TTL = 24.hours

  def initialize
    @openai = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
    @redis = Redis.new
  end

  def generate(text)
    cache_key = cache_key_for(text)

    # Try cache first
    cached = @redis.get(cache_key)
    return JSON.parse(cached) if cached

    # Generate fresh embedding
    response = @openai.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: text
      }
    )

    embedding = response.dig('data', 0, 'embedding')

    # Cache the result
    @redis.setex(
      cache_key,
      CACHE_TTL.to_i,
      embedding.to_json
    )

    embedding
  end

  def invalidate(text)
    @redis.del(cache_key_for(text))
  end

  private

  def cache_key_for(text)
    # Use SHA256 to handle long texts
    digest = Digest::SHA256.hexdigest(text)
    "embedding:#{digest}"
  end
end
```

Update your services to use the cached version:

```ruby
# app/services/rag_service.rb
class RagService
  def initialize
    @vector_search = VectorSearchService.new
    @embedding_service = CachedEmbeddingService.new
    @openai = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
  end

  # rest of the code...
end
```

Cache invalidation happens automatically after 24 hours, or manually when content changes:

```ruby
class Document < ApplicationRecord
  after_update :invalidate_cache, if: :content_changed?

  private

  def invalidate_cache
    CachedEmbeddingService.new.invalidate(content)
  end
end
```

### Batch Processing & Background Jobs

Generating embeddings synchronously blocks your request-response cycle. For bulk document imports or large documents, use background jobs with Sidekiq:

```ruby
# app/jobs/embedding_job.rb
class EmbeddingJob < ApplicationJob
  queue_as :default

  # Track progress for UI feedback
  def perform(document_id)
    document = Document.find(document_id)
    chunks = ChunkService.new.chunk_text(document.content)

    # Process chunks in batches to reduce API calls
    chunks.each_slice(20).with_index do |chunk_batch, batch_index|
      embeddings = generate_embeddings_batch(chunk_batch)

      chunk_batch.each_with_index do |content, index|
        DocumentChunk.create!(
          document: document,
          content: content,
          embedding: embeddings[index],
          position: (batch_index * 20) + index
        )
      end

      # Update progress
      progress = ((batch_index + 1) * 20 / chunks.size.to_f * 100).round
      update_progress(document, progress)

      # Rate limiting: OpenAI allows 3,000 RPM
      sleep(0.02) if batch_index < chunks.size / 20 - 1
    end

    document.update!(indexed_at: Time.current)
  end

  private

  def generate_embeddings_batch(texts)
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])

    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: texts
      }
    )

    response['data'].map { |d| d['embedding'] }
  end

  def update_progress(document, progress)
    # Store in Redis for real-time UI updates
    Redis.new.setex(
      "document:#{document.id}:progress",
      1.hour.to_i,
      progress
    )
  end
end
```

Queue the job when creating documents:

```ruby
class Document < ApplicationRecord
  after_create :enqueue_embedding_job

  private

  def enqueue_embedding_job
    EmbeddingJob.perform_later(id)
  end
end
```

Monitor job progress via API:

```ruby
# app/controllers/api/documents_controller.rb
def indexing_status
  document = Document.find(params[:id])
  progress = Redis.new.get("document:#{document.id}:progress") || 0

  render json: {
    indexed: document.indexed_at.present?,
    progress: progress.to_i
  }
end
```

### Performance Tuning

Add indexes to speed up vector similarity queries:

```ruby
# db/migrate/20251016000004_add_vector_indexes.rb
class AddVectorIndexes < ActiveRecord::Migration[7.1]
  def change
    # IVFFlat index for approximate nearest neighbor search
    # Lists: sqrt(total_rows) is a good starting point
    execute <<-SQL
      CREATE INDEX idx_document_chunks_embedding ON document_chunks
      USING ivfflat (embedding vector_cosine_ops)
      WITH (lists = 100);
    SQL

    # Analyze the table to populate index statistics
    execute 'ANALYZE document_chunks;'
  end
end
```

IVFFlat indexes trade accuracy for speed. They partition vectors into clusters (lists), then search only relevant clusters. More lists = better accuracy but slower search.

Monitor query performance:

```ruby
# app/services/vector_search_service.rb
class VectorSearchService
  def search(query, limit: 5)
    start_time = Time.current

    results = perform_search(query, limit)

    duration = Time.current - start_time
    Rails.logger.info("Vector search completed in #{duration}ms")

    results
  end

  private

  def perform_search(query, limit)
    # Previous search implementation
  end
end
```

Optimize chunk retrieval counts based on your use case:
- **High precision needed**: Retrieve fewer chunks (3-5), use higher similarity threshold (0.8+)
- **High recall needed**: Retrieve more chunks (10-15), use lower similarity threshold (0.6+)
- **Balanced approach**: 5-7 chunks, threshold 0.7

## Real-World Example: Document Q&A System

Let's walk through a complete example using JetThoughts' development documentation:

```ruby
# Seed development documentation
Document.create!(
  title: 'Rails Performance Best Practices',
  content: 'Use database indexes for frequently queried columns. Implement caching with Redis. Optimize N+1 queries with includes()...'
)

Document.create!(
  title: 'Testing Strategy',
  content: 'Write integration tests first. Use RSpec for behavior-driven development. Mock external APIs in tests...'
)

# Wait for background jobs to process
sleep(5)

# Query the system
rag = RagService.new
answer = rag.query('How should I improve my Rails application performance?')

puts answer
# Output: "To improve Rails application performance, consider these approaches:
# 1. Add database indexes to frequently queried columns
# 2. Implement caching using Redis for expensive operations
# 3. Optimize N+1 queries using includes() or preload()
# These techniques are mentioned in the Rails Performance Best Practices documentation."
```

Performance metrics for this system:
- **Embedding generation**: ~100ms per chunk
- **Vector search**: 10-50ms (with IVFFlat index)
- **LLM generation**: 1-3 seconds
- **Total query time**: 1.5-4 seconds
- **Cost per query**: ~$0.002 (OpenAI API pricing)

## Troubleshooting Common Issues

### Embeddings returning null vectors
**Cause**: Empty or whitespace-only text
**Solution**: Validate content before generating embeddings:

```ruby
def generate_embedding
  return if content.blank?
  embedding = EmbeddingService.new.generate(content)
  update_column(:embedding, embedding)
end
```

### Vector search returns no results
**Cause**: Similarity threshold too high or no indexed documents
**Solution**: Lower threshold or check document indexing status:

```ruby
# Check indexing
Document.where(indexed_at: nil).count

# Test with lower threshold
VectorSearchService::SIMILARITY_THRESHOLD = 0.5
```

### Slow query performance
**Cause**: Missing indexes or too many chunks
**Solution**: Add IVFFlat index and adjust chunk size:

```ruby
# Check if index exists
ActiveRecord::Base.connection.execute(
  "SELECT * FROM pg_indexes WHERE tablename = 'document_chunks'"
)

# Reduce chunk count
ChunkService::CHUNK_SIZE = 500 # Larger chunks = fewer total chunks
```

### OpenAI API rate limits
**Cause**: Too many concurrent requests
**Solution**: Implement rate limiting in background jobs:

```ruby
class EmbeddingJob < ApplicationJob
  # Process 10 jobs per minute
  sidekiq_options retry: 3, rate: { limit: 10, period: 1.minute }
end
```

## Conclusion

You've built a production-ready RAG system that combines PostgreSQL's vector capabilities with OpenAI's language models. Your Rails app can now understand semantic queries, retrieve relevant context, and generate accurate answers based on your documentation.

Key takeaways:
- pgvector eliminates the need for external vector databases
- Chunking documents improves retrieval precision
- Caching and background jobs optimize performance
- Proper indexing makes vector search fast enough for production

### Next Steps

**Enhance retrieval quality**:
- Implement [hybrid search](https://www.jetthoughts.com/blog/combining-keyword-semantic-search-rails/) (combine keyword + vector search)
- Add [cross-encoder reranking](https://www.sbert.net/examples/applications/cross-encoder/README.html) for better relevance
- Experiment with metadata filtering (date ranges, categories)

**Improve answer generation**:
- Stream responses with [ActionCable](https://www.jetthoughts.com/blog/actioncable-real-time-features/) for better UX
- Add citation tracking (which chunks informed the answer)
- Implement conversation history for multi-turn dialogues

**Scale for production**:
- Monitor vector index performance with [pganalyze](https://pganalyze.com/)
- Implement query analytics with [Ahoy](https://www.jetthoughts.com/blog/analytics-tracking-rails-ahoy/)
- Add [Sidekiq Pro](https://www.jetthoughts.com/blog/sidekiq-optimization/) for better job management

### Related Posts

- [Optimizing PostgreSQL for Rails Applications](https://www.jetthoughts.com/blog/postgresql-optimization/)
- [Background Jobs Best Practices with Sidekiq](https://www.jetthoughts.com/blog/sidekiq-best-practices/)
- [Building Real-Time Features with ActionCable](https://www.jetthoughts.com/blog/actioncable-real-time-features/)

Have questions about implementing RAG in your Rails app? [Contact JetThoughts](https://www.jetthoughts.com/contact-us/) for consulting and development services.

---

**Source code**: Complete working examples available at [github.com/jetthoughts/rails-rag-pgvector-example](https://github.com/jetthoughts/rails-rag-pgvector-example)
