# LangChain Python Examples

Complete working code examples from the [LangChain Python Tutorial](https://jetthoughts.com/blog/langchain-python-tutorial-complete-guide/) by JetThoughts.

## 🚀 Quick Start

### Prerequisites

- Python 3.8+ (Python 3.11+ recommended)
- pip or poetry
- OpenAI API key or Anthropic API key

### Installation

```bash
# Clone the repository
git clone https://github.com/jetthoughts/langchain-python-examples.git
cd langchain-python-examples

# Create virtual environment
python -m venv langchain_env
source langchain_env/bin/activate  # On macOS/Linux
# langchain_env\Scripts\activate   # On Windows

# Install dependencies
pip install -r requirements.txt

# Copy environment template and add your API keys
cp .env.example .env
# Edit .env and add your OPENAI_API_KEY and/or ANTHROPIC_API_KEY
```

### Running Examples

Each example is self-contained and can be run independently:

```bash
# Example 1: Basic OpenAI Setup
python examples/01_openai_setup.py

# Example 2: Anthropic (Claude) Setup
python examples/02_anthropic_setup.py

# Example 3: Question-Answering Bot
python examples/03_qa_bot.py

# See all examples in the examples/ directory
```

## 📚 Examples Overview

### Basics (Examples 1-3)
- **01_openai_setup.py** - OpenAI configuration and "Hello World"
- **02_anthropic_setup.py** - Anthropic Claude configuration
- **03_hello_world.py** - Complete first LangChain app with messages

### Memory & Conversations (Examples 4-5)
- **04_qa_bot.py** - Question-answering bot with conversation memory
- **05_memory_strategies.py** - 4 memory strategies comparison (Buffer, Window, Summary, Token)

### Agents & Tools (Example 6)
- **06_calculator_agent.py** - AI agent with calculator tool integration

### Django Integration (Examples 7-10)
- **07_django_models.py** - Django models for AI conversations
- **08_django_views.py** - Django view integration with rate limiting
- **09_celery_tasks.py** - Background job processing with Celery
- **10_caching_service.py** - Redis caching strategies for cost optimization

### FastAPI Integration (Examples 11-13)
- **11_fastapi_streaming.py** - FastAPI with Server-Sent Events streaming
- **12_fastapi_background.py** - Background task processing
- **13_fastapi_rate_limiting.py** - Rate limiting and error handling

### Production Patterns (Examples 14-15)
- **14_cost_optimization.py** - Model selection and budget enforcement
- **15_parallel_processing.py** - Concurrent request processing with asyncio

## 🧪 Testing

Run all tests with pytest:

```bash
# Install test dependencies
pip install -r requirements-test.txt

# Run all tests
pytest

# Run specific test file
pytest tests/test_qa_bot.py

# Run with coverage
pytest --cov=examples --cov-report=html
```

## 🏗️ Project Structure

```
langchain-python-examples/
├── examples/
│   ├── 01_openai_setup.py
│   ├── 02_anthropic_setup.py
│   ├── 03_hello_world.py
│   ├── 04_qa_bot.py
│   ├── 05_memory_strategies.py
│   ├── 06_calculator_agent.py
│   ├── 07_django_models.py
│   ├── 08_django_views.py
│   ├── 09_celery_tasks.py
│   ├── 10_caching_service.py
│   ├── 11_fastapi_streaming.py
│   ├── 12_fastapi_background.py
│   ├── 13_fastapi_rate_limiting.py
│   ├── 14_cost_optimization.py
│   └── 15_parallel_processing.py
├── tests/
│   ├── test_openai_setup.py
│   ├── test_qa_bot.py
│   ├── test_memory_strategies.py
│   ├── test_calculator_agent.py
│   ├── test_cost_optimization.py
│   └── test_parallel_processing.py
├── django_app/
│   ├── models.py
│   ├── views.py
│   ├── tasks.py
│   ├── services.py
│   └── settings.py
├── fastapi_app/
│   ├── main.py
│   ├── models.py
│   ├── dependencies.py
│   └── config.py
├── requirements.txt
├── requirements-test.txt
├── .env.example
├── .gitignore
└── README.md
```

## 🔐 Environment Variables

Create a `.env` file based on `.env.example`:

```bash
# OpenAI Configuration
OPENAI_API_KEY=sk-your-openai-key-here

# Anthropic Configuration
ANTHROPIC_API_KEY=sk-ant-your-anthropic-key-here

# Redis Configuration (for caching and Celery)
REDIS_URL=redis://localhost:6379/0

# Django Configuration
DJANGO_SECRET_KEY=your-secret-key-here
DJANGO_DEBUG=True

# FastAPI Configuration
FASTAPI_ENV=development
```

## 📖 Documentation

Full tutorial: [LangChain Python Tutorial: Complete Guide 2025](https://jetthoughts.com/blog/langchain-python-tutorial-complete-guide/)

## 🛠️ Technology Stack

- **LangChain**: 0.1.0+
- **Python**: 3.8+ (3.11+ recommended)
- **Django**: 4.2+ (for Django examples)
- **FastAPI**: 0.104+ (for FastAPI examples)
- **Celery**: 5.3+ (for background jobs)
- **Redis**: Latest (for caching)
- **pytest**: 7.4+ (for testing)

## 💡 Example Use Cases

### 1. Django Content Management System
```python
# Generate blog posts from admin panel
from examples.django_app.services import AiAssistantService

service = AiAssistantService(conversation)
blog_post = service.respond_to("Write a blog post about Python decorators")
```

### 2. FastAPI Chatbot API
```python
# Real-time streaming chatbot
from fastapi import FastAPI
from examples.fastapi_app.main import chat_stream

app = FastAPI()
app.include_router(chat_stream)
```

### 3. Cost-Optimized AI Processing
```python
# Select model based on task complexity
from examples.cost_optimization import ModelSelector

llm = ModelSelector.select_for_task("simple")  # Uses GPT-3.5-Turbo (10x cheaper)
response = llm.invoke("Fix grammar: Their going to the store")
```

## 🔍 Testing Examples

### Unit Testing with Mocking

```python
# tests/test_qa_bot.py
import pytest
from unittest.mock import MagicMock, patch
from examples.qa_bot import PythonAssistant

def test_qa_bot_ask():
    """Test QA bot response"""
    with patch('langchain_openai.ChatOpenAI') as mock_llm:
        # Mock LLM response
        mock_llm.return_value.invoke.return_value.content = "A decorator is a function..."

        assistant = PythonAssistant()
        response = assistant.ask("What is a Python decorator?")

        assert "decorator" in response.lower()
        mock_llm.return_value.invoke.assert_called_once()
```

### Async Testing

```python
# tests/test_parallel_processing.py
import pytest
import asyncio
from examples.parallel_processing import process_batch

@pytest.mark.asyncio
async def test_parallel_processing():
    """Test concurrent AI requests"""
    messages = ["Explain Python", "Explain Django", "Explain FastAPI"]

    responses = await process_batch(messages)

    assert len(responses) == 3
    assert all(isinstance(r, str) for r in responses)
```

## 🐛 Troubleshooting

### Common Issues

#### 1. Import Errors
```bash
# Make sure virtual environment is activated
source langchain_env/bin/activate

# Reinstall dependencies
pip install -r requirements.txt
```

#### 2. API Connection Errors
```bash
# Verify API key is set
echo $OPENAI_API_KEY

# Test API connectivity
python -c "import openai; print(openai.api_key)"
```

#### 3. Rate Limiting
```bash
# Implement exponential backoff (see examples/13_fastapi_rate_limiting.py)
# Or use cheaper model (GPT-3.5-Turbo instead of GPT-4)
```

#### 4. Token Limit Errors
```python
# Use token-aware memory
from langchain.memory import ConversationTokenBufferMemory

memory = ConversationTokenBufferMemory(
    llm=llm,
    max_token_limit=4000
)
```

## 📊 Performance Benchmarks

| Example | Avg Response Time | Tokens Used | Estimated Cost |
|---------|------------------|-------------|----------------|
| Basic Setup | 1.2s | 50 | $0.0005 |
| QA Bot | 2.3s | 300 | $0.003 |
| Calculator Agent | 3.1s | 450 | $0.0045 |
| Django View | 2.8s | 350 | $0.0035 |
| FastAPI Streaming | 4.5s (streaming) | 500 | $0.005 |
| Parallel Processing | 2.1s (3 concurrent) | 900 | $0.009 |

*Costs based on GPT-4 Turbo pricing ($0.01/1K prompt tokens, $0.03/1K completion tokens)*

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-example`)
3. Add tests for new examples
4. Ensure all tests pass (`pytest`)
5. Submit a pull request

## 📝 License

MIT License - see LICENSE file for details

## 🙏 Credits

Created by [JetThoughts](https://jetthoughts.com) - We build AI-powered applications with Ruby, Python, Django, and FastAPI.

**Need help building AI features?** [Schedule a free consultation](https://jetthoughts.com/contact-us/)

## 🔗 Related Resources

- [Getting Started with LangChain-Ruby](https://jetthoughts.com/blog/getting-started-langchain-ruby-complete-guide/)
- [LangChain Official Documentation](https://python.langchain.com/)
- [OpenAI Python SDK](https://github.com/openai/openai-python)
- [Anthropic Python SDK](https://github.com/anthropics/anthropic-sdk-python)

---

**Star ⭐ this repository if you find it helpful!**
