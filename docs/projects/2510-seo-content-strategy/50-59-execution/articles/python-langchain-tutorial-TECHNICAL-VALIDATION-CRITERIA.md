# Python LangChain Tutorial - Technical Validation Criteria

**Document Type**: Pre-Publication Technical Validation Framework
**Target Article**: LangChain Python Tutorial: Complete Guide 2025 (Week 2)
**Created**: 2025-01-27
**Status**: VALIDATION CRITERIA READY - Awaiting Article Creation

---

## 🎯 PURPOSE

This document defines **production-ready technical validation criteria** for the Python LangChain tutorial. All code examples MUST meet these standards before publication.

**Success Criteria**: Score 9.5+/10 for APPROVED status

---

## 📋 CODE VALIDATION CHECKLIST

### 1. Syntax & Compatibility (MANDATORY)

**Python Version**:
- [ ] All code compatible with Python 3.9+ (current LTS)
- [ ] No deprecated syntax from Python 2.x
- [ ] Type hints used for function signatures (Python 3.9+ syntax)
- [ ] F-strings for string formatting (not .format() or %)

**Import Statements**:
- [ ] All imports complete and accurate
- [ ] No missing dependencies
- [ ] Clear dependency versions specified in examples
- [ ] Imports organized: stdlib → third-party → local

**Code Example**:
```python
# ✅ CORRECT: Complete imports with version context
from typing import List, Dict, Optional
from langchain.chat_models import ChatOpenAI  # langchain>=0.1.0
from langchain.schema import HumanMessage, SystemMessage
import os
from pathlib import Path

# ❌ WRONG: Missing imports, unclear versions
from langchain import something  # What version? What module?
```

**Validation Method**:
```bash
# Test Python 3.9+ compatibility
python3.9 -m py_compile example.py

# Check syntax with ruff
ruff check example.py
```

---

### 2. Security Best Practices (ZERO TOLERANCE)

**API Key Management** (CRITICAL):
- [ ] **ZERO hardcoded API keys** (immediate rejection)
- [ ] Environment variable usage with `python-dotenv`
- [ ] `.env.example` template provided
- [ ] Security warnings in documentation

**Code Example**:
```python
# ✅ CORRECT: Environment variable with fallback validation
import os
from dotenv import load_dotenv

load_dotenv()

OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
if not OPENAI_API_KEY:
    raise ValueError(
        "OPENAI_API_KEY not found. "
        "Set it in .env file or environment variables."
    )

llm = ChatOpenAI(api_key=OPENAI_API_KEY, model="gpt-4")

# ❌ WRONG: Hardcoded API key (SECURITY VIOLATION)
llm = ChatOpenAI(api_key="sk-proj-abc123...")  # NEVER DO THIS
```

**Input Sanitization**:
- [ ] User prompts sanitized before LLM calls
- [ ] SQL injection prevention (if using DB)
- [ ] XSS prevention in web outputs
- [ ] Path traversal prevention in file operations

**Code Example**:
```python
# ✅ CORRECT: Input validation
from bleach import clean

def sanitize_user_input(user_prompt: str) -> str:
    """Sanitize user input to prevent injection attacks."""
    # Remove potential HTML/script tags
    sanitized = clean(user_prompt, tags=[], strip=True)
    # Limit length to prevent token exhaustion attacks
    return sanitized[:2000]

user_input = sanitize_user_input(request.data.get("prompt", ""))
```

**Rate Limiting**:
- [ ] Rate limiting patterns included for production
- [ ] Cost protection mechanisms demonstrated
- [ ] Timeout configurations specified

**Code Example**:
```python
# ✅ CORRECT: Rate limiting with retry logic
from ratelimit import limits, sleep_and_retry
from openai import RateLimitError

CALLS_PER_MINUTE = 60

@sleep_and_retry
@limits(calls=CALLS_PER_MINUTE, period=60)
def call_llm_with_rate_limit(prompt: str) -> str:
    """LLM call with automatic rate limiting."""
    try:
        response = llm.invoke(prompt)
        return response.content
    except RateLimitError:
        # Exponential backoff handled by @sleep_and_retry
        raise
```

---

### 3. Production Readiness (REQUIRED)

**Error Handling**:
- [ ] Try-except blocks for API calls
- [ ] Proper logging (not just print statements)
- [ ] Graceful degradation on failures
- [ ] Meaningful error messages

**Code Example**:
```python
# ✅ CORRECT: Production-ready error handling
import logging
from openai import OpenAIError, RateLimitError

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def get_llm_response(prompt: str, max_retries: int = 3) -> Optional[str]:
    """Get LLM response with retry logic and proper error handling."""
    for attempt in range(max_retries):
        try:
            response = llm.invoke(prompt)
            logger.info(f"LLM call successful on attempt {attempt + 1}")
            return response.content

        except RateLimitError as e:
            logger.warning(f"Rate limit hit, attempt {attempt + 1}/{max_retries}")
            if attempt < max_retries - 1:
                time.sleep(2 ** attempt)  # Exponential backoff
            else:
                logger.error("Max retries reached for rate limit")
                raise

        except OpenAIError as e:
            logger.error(f"OpenAI API error: {e}")
            return None

    return None

# ❌ WRONG: No error handling
response = llm.invoke(prompt)  # What if API is down?
print(response.content)  # No logging, just print
```

**Caching Strategies**:
- [ ] Redis/in-memory caching examples
- [ ] LangChain cache integration
- [ ] TTL specifications for cached data

**Code Example**:
```python
# ✅ CORRECT: LangChain caching for cost optimization
from langchain.cache import RedisCache
from langchain.globals import set_llm_cache
import redis

# Configure Redis cache
redis_client = redis.Redis(
    host=os.getenv("REDIS_HOST", "localhost"),
    port=int(os.getenv("REDIS_PORT", 6379)),
    db=0
)
set_llm_cache(RedisCache(redis_client))

# Now LLM calls are cached automatically
llm = ChatOpenAI(model="gpt-4")
response = llm.invoke("What is LangChain?")  # Cached for subsequent calls
```

**Cost Optimization**:
- [ ] Token counting examples
- [ ] Model selection guidance (gpt-4 vs gpt-3.5-turbo)
- [ ] Streaming responses for long outputs
- [ ] Batch processing patterns

**Code Example**:
```python
# ✅ CORRECT: Token counting for cost awareness
from langchain.callbacks import get_openai_callback

with get_openai_callback() as cb:
    response = llm.invoke("Explain quantum computing")
    print(f"Total Tokens: {cb.total_tokens}")
    print(f"Prompt Tokens: {cb.prompt_tokens}")
    print(f"Completion Tokens: {cb.completion_tokens}")
    print(f"Total Cost (USD): ${cb.total_cost:.4f}")
```

**Monitoring & Observability**:
- [ ] Logging integration (structlog or Python logging)
- [ ] Metrics collection examples (Prometheus/StatsD)
- [ ] Tracing for debugging (LangSmith/OpenTelemetry)

**Code Example**:
```python
# ✅ CORRECT: Structured logging for production
import structlog

logger = structlog.get_logger()

def process_user_query(user_id: str, query: str) -> str:
    """Process user query with structured logging."""
    logger.info(
        "processing_query",
        user_id=user_id,
        query_length=len(query),
        model="gpt-4"
    )

    try:
        response = llm.invoke(query)
        logger.info(
            "query_successful",
            user_id=user_id,
            response_length=len(response.content),
            tokens_used=response.response_metadata.get("token_usage", {})
        )
        return response.content

    except Exception as e:
        logger.error(
            "query_failed",
            user_id=user_id,
            error=str(e),
            error_type=type(e).__name__
        )
        raise
```

---

### 4. Framework Integration Compliance

#### Django Integration (Django 4.2+)

**Requirements**:
- [ ] Async view support (`async def` views)
- [ ] Celery integration for background tasks
- [ ] Django settings.py configuration
- [ ] Model integration patterns
- [ ] Admin interface examples

**Code Example**:
```python
# ✅ CORRECT: Django async view with LangChain
# views.py
from django.http import JsonResponse
from django.views.decorators.http import require_http_methods
from asgiref.sync import sync_to_async
from langchain.chat_models import ChatOpenAI
import logging

logger = logging.getLogger(__name__)
llm = ChatOpenAI(model="gpt-4", temperature=0.7)

@require_http_methods(["POST"])
async def chat_endpoint(request):
    """Async Django view for LangChain chat."""
    try:
        user_message = request.POST.get("message", "")
        if not user_message:
            return JsonResponse({"error": "Message required"}, status=400)

        # Run LangChain in async context
        response = await sync_to_async(llm.invoke)(user_message)

        return JsonResponse({
            "response": response.content,
            "model": "gpt-4",
            "timestamp": timezone.now().isoformat()
        })

    except Exception as e:
        logger.error(f"Chat error: {e}")
        return JsonResponse(
            {"error": "Internal server error"},
            status=500
        )
```

**Celery Integration**:
```python
# ✅ CORRECT: Celery task for background LLM processing
# tasks.py
from celery import shared_task
from langchain.chat_models import ChatOpenAI
from .models import ChatHistory

@shared_task(
    bind=True,
    max_retries=3,
    default_retry_delay=60
)
def process_chat_async(self, user_id: int, message: str):
    """Process chat message asynchronously with Celery."""
    try:
        llm = ChatOpenAI(model="gpt-4")
        response = llm.invoke(message)

        # Save to database
        ChatHistory.objects.create(
            user_id=user_id,
            message=message,
            response=response.content,
            tokens_used=response.response_metadata.get("token_usage", {})
        )

        return response.content

    except Exception as e:
        # Retry with exponential backoff
        raise self.retry(exc=e)
```

**Django Settings**:
```python
# ✅ CORRECT: Django settings.py configuration
# settings.py
import os
from pathlib import Path

# LangChain settings
LANGCHAIN_API_KEY = os.getenv("LANGCHAIN_API_KEY")
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

# Celery configuration
CELERY_BROKER_URL = os.getenv("REDIS_URL", "redis://localhost:6379/0")
CELERY_RESULT_BACKEND = os.getenv("REDIS_URL", "redis://localhost:6379/0")

# Cache configuration for LangChain
CACHES = {
    "default": {
        "BACKEND": "django.core.cache.backends.redis.RedisCache",
        "LOCATION": os.getenv("REDIS_URL", "redis://127.0.0.1:6379/1"),
    }
}
```

#### FastAPI Integration (FastAPI 0.100+)

**Requirements**:
- [ ] Modern async/await patterns
- [ ] Pydantic v2 models
- [ ] WebSocket streaming support
- [ ] Dependency injection patterns
- [ ] OpenAPI schema integration

**Code Example**:
```python
# ✅ CORRECT: FastAPI async endpoint with streaming
from fastapi import FastAPI, HTTPException, Depends
from fastapi.responses import StreamingResponse
from pydantic import BaseModel, Field
from langchain.chat_models import ChatOpenAI
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler
import asyncio

app = FastAPI(title="LangChain API", version="1.0.0")

class ChatRequest(BaseModel):
    """Chat request schema with validation."""
    message: str = Field(..., min_length=1, max_length=2000)
    model: str = Field(default="gpt-4", pattern="^gpt-(3.5|4).*")
    temperature: float = Field(default=0.7, ge=0.0, le=2.0)

class ChatResponse(BaseModel):
    """Chat response schema."""
    response: str
    model: str
    tokens_used: int

async def get_llm(model: str = "gpt-4") -> ChatOpenAI:
    """Dependency injection for LLM instance."""
    return ChatOpenAI(
        model=model,
        streaming=True,
        callbacks=[StreamingStdOutCallbackHandler()]
    )

@app.post("/chat", response_model=ChatResponse)
async def chat_endpoint(
    request: ChatRequest,
    llm: ChatOpenAI = Depends(get_llm)
):
    """Async chat endpoint with LangChain."""
    try:
        response = await llm.ainvoke(request.message)
        return ChatResponse(
            response=response.content,
            model=request.model,
            tokens_used=response.response_metadata.get("token_usage", {}).get("total_tokens", 0)
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/chat/stream")
async def chat_stream_endpoint(request: ChatRequest):
    """Streaming chat endpoint using Server-Sent Events."""
    async def event_generator():
        llm = ChatOpenAI(model=request.model, streaming=True)
        async for chunk in llm.astream(request.message):
            yield f"data: {chunk.content}\n\n"

    return StreamingResponse(
        event_generator(),
        media_type="text/event-stream"
    )
```

---

### 5. Type Hints & Documentation

**Requirements**:
- [ ] Type hints for all function signatures
- [ ] Docstrings for complex functions (Google style)
- [ ] Return type annotations
- [ ] Optional types where appropriate

**Code Example**:
```python
# ✅ CORRECT: Complete type hints and docstrings
from typing import List, Dict, Optional, Union
from langchain.schema import BaseMessage, HumanMessage, AIMessage

def create_chat_history(
    messages: List[Dict[str, str]],
    system_prompt: Optional[str] = None
) -> List[BaseMessage]:
    """
    Convert message dictionaries to LangChain message objects.

    Args:
        messages: List of message dicts with 'role' and 'content' keys
        system_prompt: Optional system prompt to prepend

    Returns:
        List of LangChain message objects (HumanMessage or AIMessage)

    Raises:
        ValueError: If message format is invalid

    Example:
        >>> messages = [
        ...     {"role": "user", "content": "Hello"},
        ...     {"role": "assistant", "content": "Hi there!"}
        ... ]
        >>> chat_history = create_chat_history(messages)
    """
    chat_messages: List[BaseMessage] = []

    if system_prompt:
        chat_messages.append(SystemMessage(content=system_prompt))

    for msg in messages:
        if msg["role"] == "user":
            chat_messages.append(HumanMessage(content=msg["content"]))
        elif msg["role"] == "assistant":
            chat_messages.append(AIMessage(content=msg["content"]))
        else:
            raise ValueError(f"Invalid role: {msg['role']}")

    return chat_messages
```

---

### 6. Testing Examples (MANDATORY)

**Requirements**:
- [ ] pytest examples for unit tests
- [ ] Mock examples for LLM calls
- [ ] Integration test patterns
- [ ] Async test examples (pytest-asyncio)

**Code Example**:
```python
# ✅ CORRECT: pytest examples with mocking
# test_langchain_integration.py
import pytest
from unittest.mock import patch, MagicMock
from langchain.schema import AIMessage
from myapp.chat import get_llm_response

@pytest.fixture
def mock_llm():
    """Mock LLM for testing."""
    with patch('myapp.chat.llm') as mock:
        mock.invoke.return_value = AIMessage(
            content="Mocked response",
            response_metadata={"token_usage": {"total_tokens": 50}}
        )
        yield mock

def test_get_llm_response_success(mock_llm):
    """Test successful LLM response."""
    response = get_llm_response("Test prompt")
    assert response == "Mocked response"
    mock_llm.invoke.assert_called_once_with("Test prompt")

def test_get_llm_response_handles_errors(mock_llm):
    """Test error handling in LLM calls."""
    mock_llm.invoke.side_effect = Exception("API Error")

    response = get_llm_response("Test prompt")
    assert response is None  # Should return None on error

@pytest.mark.asyncio
async def test_async_chat_endpoint():
    """Test async FastAPI endpoint."""
    from httpx import AsyncClient
    from myapp.main import app

    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.post(
            "/chat",
            json={"message": "Hello", "model": "gpt-4"}
        )
        assert response.status_code == 200
        assert "response" in response.json()
```

---

## 🔍 OWASP AI SECURITY CHECKLIST

**LLM-Specific Security Considerations**:

- [ ] **LLM01: Prompt Injection Prevention**
  - Input validation and sanitization
  - System prompt protection
  - Output filtering

- [ ] **LLM02: Insecure Output Handling**
  - XSS prevention in web outputs
  - SQL injection prevention
  - Code execution prevention

- [ ] **LLM03: Training Data Poisoning** (N/A for API usage)

- [ ] **LLM04: Model Denial of Service**
  - Request rate limiting
  - Token budget limits
  - Timeout configurations

- [ ] **LLM05: Supply Chain Vulnerabilities**
  - Dependency version pinning
  - Security audit of dependencies
  - Regular updates

- [ ] **LLM06: Sensitive Information Disclosure**
  - No API keys in responses
  - PII filtering from outputs
  - Data retention policies

**Code Example**:
```python
# ✅ CORRECT: OWASP AI Security - Prompt Injection Prevention
import re
from typing import Optional

BLOCKED_PATTERNS = [
    r"ignore previous instructions",
    r"disregard all prior",
    r"system prompt:",
    r"<\s*script",  # XSS prevention
]

def validate_user_prompt(prompt: str) -> Optional[str]:
    """
    Validate user prompt against injection attacks.

    Returns:
        Sanitized prompt or None if malicious content detected
    """
    # Check for blocked patterns
    for pattern in BLOCKED_PATTERNS:
        if re.search(pattern, prompt, re.IGNORECASE):
            logger.warning(
                "Blocked malicious prompt",
                pattern=pattern,
                prompt_preview=prompt[:100]
            )
            return None

    # Length validation (prevent DoS)
    if len(prompt) > 5000:
        return prompt[:5000]  # Truncate

    return prompt
```

---

## 📊 VALIDATION SCORING RUBRIC

### Scoring Breakdown (Total: 100 points)

#### Code Quality (40 points)
- **Syntax & Compatibility** (10 points)
  - Python 3.9+ compatible
  - Type hints present
  - Imports complete

- **Error Handling** (15 points)
  - Try-except blocks
  - Logging integration
  - Retry logic with backoff

- **Code Style** (15 points)
  - Follows PEP 8
  - Meaningful variable names
  - Docstrings for complex functions

#### Security (30 points)
- **API Key Management** (15 points)
  - NO hardcoded keys (automatic fail if violated)
  - Environment variables used
  - Validation errors on missing keys

- **Input Sanitization** (10 points)
  - User input validated
  - Prompt injection prevention
  - XSS/SQL injection guards

- **Rate Limiting** (5 points)
  - Rate limiting demonstrated
  - Cost protection patterns

#### Production Readiness (20 points)
- **Caching** (5 points)
  - Cache integration shown
  - TTL specified

- **Monitoring** (5 points)
  - Logging examples
  - Metrics collection

- **Cost Optimization** (5 points)
  - Token counting
  - Model selection guidance

- **Testing** (5 points)
  - pytest examples
  - Mock patterns

#### Framework Compliance (10 points)
- **Django** (5 points if applicable)
  - Async views
  - Celery integration
  - Settings configuration

- **FastAPI** (5 points if applicable)
  - Async/await patterns
  - Pydantic v2
  - Streaming examples

---

## 🎯 APPROVAL CRITERIA

### Automatic REJECTION Triggers
- **Hardcoded API keys** (sk-proj-..., OPENAI_API_KEY = "...")
- **Missing error handling** on API calls
- **No type hints** on function signatures
- **Python 2.x syntax** or deprecated patterns
- **Security vulnerabilities** (XSS, SQL injection)

### Scoring Thresholds
- **10/10 (Perfect)**: Production-ready, comprehensive, zero issues
- **9.5/10 (APPROVED)**: Minor improvements possible, ready to publish
- **9.0/10 (APPROVED)**: Good quality, 1-2 minor fixes needed
- **8.0/10 (CONDITIONAL)**: Moderate issues, requires revisions before approval
- **7.0/10 (NEEDS WORK)**: Significant issues, major revisions required
- **<7.0/10 (REJECTED)**: Major rewrite required

### Minimum Score for Publication
**Target**: 9.5+/10 (APPROVED status)

---

## 📝 VALIDATION REPORT TEMPLATE

When the Python tutorial is created, use this template:

```markdown
# Python LangChain Tutorial - Technical Validation Report

**Article**: LangChain Python Tutorial: Complete Guide 2025
**Validation Date**: [Date]
**Validator**: [Agent Name]
**Overall Score**: [X.X/10]
**Status**: [APPROVED | CONDITIONAL | REJECTED]

---

## Executive Summary

[Brief overview of validation results]

---

## Detailed Scoring

### Code Quality (40 points)
- Syntax & Compatibility: [X/10]
- Error Handling: [X/15]
- Code Style: [X/15]

**Total**: [X/40]

### Security (30 points)
- API Key Management: [X/15]
- Input Sanitization: [X/10]
- Rate Limiting: [X/5]

**Total**: [X/30]

### Production Readiness (20 points)
- Caching: [X/5]
- Monitoring: [X/5]
- Cost Optimization: [X/5]
- Testing: [X/5]

**Total**: [X/20]

### Framework Compliance (10 points)
- Django Integration: [X/5]
- FastAPI Integration: [X/5]

**Total**: [X/10]

---

## Issues Found

### Critical Issues (BLOCKING)
- [ ] Issue 1: [Description]

### Major Issues
- [ ] Issue 1: [Description]

### Minor Issues
- [ ] Issue 1: [Description]

---

## Code Examples Review

### Example 1: [Title]
- **Status**: [✅ PASS | ⚠️ NEEDS FIX | ❌ FAIL]
- **Issues**: [List]

### Example 2: [Title]
- **Status**: [✅ PASS | ⚠️ NEEDS FIX | ❌ FAIL]
- **Issues**: [List]

---

## Security Audit

### OWASP AI Security Checklist
- [x] LLM01: Prompt Injection Prevention
- [x] LLM02: Insecure Output Handling
- [x] LLM04: Model Denial of Service
- [x] LLM05: Supply Chain Vulnerabilities
- [x] LLM06: Sensitive Information Disclosure

### Vulnerabilities Found
- None | [List vulnerabilities]

---

## Framework Integration Review

### Django (if applicable)
- [x] Async views properly implemented
- [x] Celery integration correct
- [x] Settings configuration secure

### FastAPI (if applicable)
- [x] Async/await patterns correct
- [x] Pydantic v2 models used
- [x] Streaming endpoints functional

---

## Recommendations

### Required Changes (Before Publication)
1. [Change 1]
2. [Change 2]

### Optional Improvements
1. [Improvement 1]
2. [Improvement 2]

---

## Final Decision

**Status**: [APPROVED FOR PUBLICATION | REVISIONS REQUIRED | REJECTED]

**Justification**: [Explain decision based on scoring]

---

**Validator Signature**: [Agent Name]
**Date**: [YYYY-MM-DD]
```

---

## 🚀 NEXT STEPS

1. **Content Creator**: Creates Python LangChain tutorial draft
2. **Technical Validator**: Runs validation using this criteria document
3. **Validator**: Creates validation report using template above
4. **Content Creator**: Implements required fixes
5. **Validator**: Re-validates until 9.5+/10 score achieved
6. **Publication**: Article approved for publication

---

## 📚 REFERENCE MATERIALS

### Official Documentation
- [LangChain Python Docs](https://python.langchain.com/)
- [Django 4.2 Documentation](https://docs.djangoproject.com/en/4.2/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [OWASP AI Security](https://owasp.org/www-project-top-10-for-large-language-model-applications/)

### Code Quality Tools
- `ruff` - Fast Python linter
- `mypy` - Static type checker
- `pytest` - Testing framework
- `black` - Code formatter

### Security Scanning
- `bandit` - Security issue scanner
- `safety` - Dependency vulnerability scanner
- `semgrep` - Static analysis for security patterns

---

**Last Updated**: 2025-01-27
**Next Review**: After Python tutorial creation
**Status**: READY FOR USE
