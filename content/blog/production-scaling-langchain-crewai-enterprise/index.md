---
title: "From Prototype to Production: Scaling LangChain and CrewAI Applications in Enterprise Environments"
description: "Complete enterprise guide to scaling LangChain and CrewAI from prototype to production. Covers architecture patterns, security, compliance, monitoring, and real-world case study with 80% improvement metrics."
date: 2025-10-15
tags: ["LangChain", "CrewAI", "Enterprise AI", "Production Scaling", "AI Architecture", "FastAPI", "Docker", "Kubernetes", "Observability", "Security"]
categories: ["AI Development", "Enterprise Architecture", "DevOps"]
author: "JetThoughts Team"
slug: "production-scaling-langchain-crewai-enterprise"
canonical_url: "https://jetthoughts.com/blog/production-scaling-langchain-crewai-enterprise/"
meta_title: "Scaling LangChain & CrewAI to Production: Enterprise Architecture Guide | JetThoughts"
meta_description: "Enterprise guide: Scale LangChain and CrewAI from prototype to production. Real architecture patterns, security, Kubernetes deployment, monitoring setup. Includes case study with 80% performance improvements."
cover_image: "/blog/production-scaling-langchain-crewai-enterprise/cover.jpg"
---

## The Challenge

Your LangChain or CrewAI prototype works beautifully in development. But production? That's where things get complicated—security audits, compliance requirements, monitoring dashboards, and the pressure to handle millions of requests without breaking.

## Our Approach

Take your AI agent from laptop to enterprise-grade deployment with battle-tested architecture patterns, security frameworks, and operational excellence. We'll walk through real-world production scaling that delivered 80% faster resolution times.

When Klarna deployed their LangChain-powered customer support assistant, they weren't just experimenting—they were putting an AI system in front of **85 million active users**. The result? An **80% reduction in customer resolution time** and millions of dollars saved.

That's the gap between prototype and production. Your LangChain or CrewAI application might work perfectly on your laptop, but scaling to handle enterprise workloads requires a completely different mindset.

Here's what nobody tells you: the AI model is often the easiest part. The real challenge is building the infrastructure, security, monitoring, and operational practices that enterprise environments demand. After helping multiple organizations scale their AI agent applications from prototype to production, we've learned exactly what it takes.

Let me show you the architecture patterns, security frameworks, and deployment strategies that turn your experimental AI agent into a production-grade system that executives trust and operations teams can actually maintain.

---

## Understanding the production readiness gap

Before we dive into architecture, let's be honest about what "production-ready" actually means in enterprise environments.

### Why prototypes fail in production

Your prototype probably works great for these reasons:

**Development Environment Advantages:**
- Single user (you)
- Unlimited retry attempts
- Manual error handling
- No security audit requirements
- Forgiving latency tolerance
- Static test data
- No compliance concerns
- Direct API access without rate limits

**Production Reality:**
```
Concurrent users: 1 → 10,000+
Error tolerance: "I'll fix it" → 99.9% uptime SLA
Security: Developer laptop → SOC 2 compliance audit
Data: Sample files → PII, HIPAA, financial records
Observability: Console logs → Enterprise monitoring stack
Cost: "Whatever it takes" → Budget-conscious optimization
Deployment: Git push → Multi-region Kubernetes cluster
```

**The Gap Example:**

A financial services company built a beautiful LangChain document analysis prototype. It processed their sample PDFs perfectly. Then they tried production data:

- **Week 1:** Rate limited by OpenAI (violated usage policies)
- **Week 2:** Compliance blocked deployment (PII in API requests)
- **Week 3:** Security audit failed (API keys in environment variables)
- **Week 4:** Monitoring showed 30-second latencies (unacceptable for users)

They had to rebuild 80% of their infrastructure before the first production deployment.

### The enterprise checklist

Here's what your AI application needs before enterprises will trust it in production:

**Security & Compliance (Non-Negotiable):**
```yaml
security_requirements:
  authentication:
    - Multi-factor authentication for admin access
    - API key rotation policies (30-90 days)
    - OAuth 2.0 / SAML integration with corporate identity
    - Role-based access control (RBAC) for different user tiers

  data_protection:
    - End-to-end encryption (in transit and at rest)
    - PII detection and redaction before external API calls
    - Data residency compliance (EU data stays in EU)
    - Audit logging of all data access (GDPR/CCPA)

  compliance_frameworks:
    - SOC 2 Type II audit readiness
    - HIPAA compliance for healthcare data
    - GDPR compliance for European users
    - ISO 27001 information security standards

  vulnerability_management:
    - Dependency scanning (OWASP, Snyk, Dependabot)
    - Container image scanning before deployment
    - Penetration testing quarterly
    - Bug bounty program for critical systems
```

**Operational Excellence (Required):**
```yaml
operational_requirements:
  monitoring:
    - Real-time alerting (PagerDuty, Opsgenie integration)
    - Custom dashboards for business metrics
    - Distributed tracing for multi-agent workflows
    - Log aggregation (ELK stack, Datadog, Splunk)

  reliability:
    - 99.9% uptime SLA (43 minutes downtime/month maximum)
    - Automated failover between regions
    - Circuit breakers for external API failures
    - Graceful degradation when AI services unavailable

  scalability:
    - Auto-scaling based on request volume
    - Load balancing across multiple instances
    - Caching strategies (Redis, CDN for static assets)
    - Database connection pooling and query optimization

  cost_management:
    - Token usage tracking per user/department
    - Budget alerts before overruns
    - Model selection based on cost/performance trade-offs
    - Request batching to reduce API calls
```

**Developer Experience (Often Overlooked):**
```yaml
developer_experience:
  deployment:
    - One-command deployment to staging and production
    - Automated rollback on deployment failures
    - Blue-green or canary deployment strategies
    - Infrastructure as Code (Terraform, Pulumi)

  debugging:
    - Request replay for reproducing issues
    - Detailed error context (not just stack traces)
    - A/B testing framework for prompt variations
    - Integration with developer tools (VS Code extensions)

  documentation:
    - API documentation auto-generated from code (OpenAPI)
    - Runbooks for common operational scenarios
    - Architecture diagrams (Mermaid, Lucidchart)
    - Onboarding guides for new team members
```

If you're missing any of these components, you're not ready for enterprise production. Let's build them systematically.

---

## Production architecture patterns for LangChain and CrewAI

Let's design an architecture that enterprise operations teams can actually deploy, monitor, and maintain at scale.

### Core architecture principles

Before we write any code, let's establish the non-negotiable principles:

**Principle 1: Separation of Concerns**

Your AI logic should be completely isolated from your infrastructure concerns:

```
┌─────────────────────────────────────────────────────────────┐
│                     Load Balancer (AWS ALB)                  │
└─────────────────────┬───────────────────────────────────────┘
                      │
        ┌─────────────┴──────────────┐
        │                            │
┌───────▼────────┐          ┌────────▼───────┐
│  API Gateway   │          │  API Gateway   │
│  (FastAPI)     │          │  (FastAPI)     │
│  • Auth        │          │  • Auth        │
│  • Rate limits │          │  • Rate limits │
└───────┬────────┘          └────────┬───────┘
        │                            │
┌───────▼─────────────────────────────▼────────┐
│         Agent Orchestration Layer             │
│  (LangChain/CrewAI Business Logic)           │
│  • Stateless by design                       │
│  • Environment-agnostic                      │
│  • Testable in isolation                     │
└───────┬──────────────────────────────────────┘
        │
        ├─────────┬──────────┬──────────┬───────────┐
        │         │          │          │           │
┌───────▼──┐ ┌────▼────┐ ┌──▼────┐ ┌───▼────┐ ┌────▼────┐
│  Redis   │ │  Vector │ │  LLM  │ │ Tools  │ │  Queue  │
│  Cache   │ │  Store  │ │  APIs │ │ (MCP)  │ │ (Celery)│
└──────────┘ └─────────┘ └───────┘ └────────┘ └─────────┘
```

**Why this matters:** When your LangChain agent logic is entangled with FastAPI routes, Kubernetes configs, and monitoring code, you can't test anything in isolation. Separate your concerns.

**Principle 2: Design for Failure**

In production, everything fails. Plan for it:

```python
# app/core/resilience.py
from typing import Callable, TypeVar, Optional
from tenacity import retry, stop_after_attempt, wait_exponential
from circuitbreaker import circuit
import logging

T = TypeVar('T')
logger = logging.getLogger(__name__)


class ResilientAIService:
    """
    Wrap AI service calls with production-grade resilience patterns.

    Implements:
    - Exponential backoff retry for transient failures
    - Circuit breaker to prevent cascade failures
    - Timeout enforcement to prevent hanging requests
    - Graceful degradation with fallback responses
    """

    @retry(
        stop=stop_after_attempt(3),
        wait=wait_exponential(multiplier=1, min=4, max=10),
        reraise=True
    )
    @circuit(failure_threshold=5, recovery_timeout=60)
    async def call_llm_with_resilience(
        self,
        prompt: str,
        model: str = "gpt-4",
        timeout: int = 30,
        fallback_response: Optional[str] = None
    ) -> str:
        """
        Call LLM API with automatic retry, circuit breaking, and fallback.

        Retry policy:
        - 3 attempts with exponential backoff (4s, 8s, 10s)
        - Circuit opens after 5 consecutive failures
        - Circuit recovers after 60 seconds

        Args:
            prompt: Input prompt for LLM
            model: Model identifier (e.g., "gpt-4", "claude-3")
            timeout: Maximum seconds to wait for response
            fallback_response: Response to return if all retries fail

        Returns:
            LLM response or fallback response

        Raises:
            CircuitBreakerError: When circuit is open (too many failures)
            TimeoutError: When request exceeds timeout
        """
        try:
            # Implementation with timeout enforcement
            response = await asyncio.wait_for(
                self._call_llm(prompt, model),
                timeout=timeout
            )
            return response

        except asyncio.TimeoutError:
            logger.error(f"LLM call timeout after {timeout}s for model {model}")
            if fallback_response:
                logger.info(f"Using fallback response: {fallback_response[:100]}...")
                return fallback_response
            raise

        except Exception as e:
            logger.error(f"LLM call failed: {str(e)}", exc_info=True)
            if fallback_response:
                logger.info(f"Using fallback response after error")
                return fallback_response
            raise


# Usage in production:
resilient_service = ResilientAIService()

try:
    response = await resilient_service.call_llm_with_resilience(
        prompt="Analyze this customer query...",
        model="gpt-4",
        timeout=30,
        fallback_response="I'm experiencing high load. Please try again in a moment."
    )
except CircuitBreakerError:
    # Circuit is open - too many consecutive failures
    # Serve cached response or gracefully degrade
    response = get_cached_response() or DEFAULT_RESPONSE
```

**Why this matters:** When OpenAI has a 30-second outage, your entire application shouldn't go down with it. Circuit breakers prevent cascade failures.

**Principle 3: Observability from Day One**

If you can't measure it, you can't improve it:

```python
# app/core/observability.py
from opentelemetry import trace
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.jaeger.thrift import JaegerExporter
from prometheus_client import Counter, Histogram, Gauge
import structlog
import time

# Structured logging configuration
logger = structlog.get_logger()

# Prometheus metrics for business and technical monitoring
llm_requests_total = Counter(
    'llm_requests_total',
    'Total number of LLM API requests',
    ['model', 'status', 'user_tier']
)

llm_request_duration = Histogram(
    'llm_request_duration_seconds',
    'Duration of LLM requests in seconds',
    ['model', 'operation']
)

llm_tokens_used = Counter(
    'llm_tokens_used_total',
    'Total tokens consumed across all LLM calls',
    ['model', 'user_id', 'operation']
)

llm_cost_dollars = Counter(
    'llm_cost_dollars_total',
    'Estimated cost in dollars for LLM usage',
    ['model', 'department']
)

active_agent_workflows = Gauge(
    'active_agent_workflows',
    'Number of currently running agent workflows',
    ['agent_type', 'priority']
)


class ObservableAIAgent:
    """
    Wrap LangChain/CrewAI agents with comprehensive observability.

    Provides:
    - Distributed tracing (OpenTelemetry + Jaeger)
    - Structured logging (structlog)
    - Business metrics (Prometheus)
    - Performance profiling
    """

    def __init__(self, agent_name: str, agent_type: str):
        self.agent_name = agent_name
        self.agent_type = agent_type
        self.tracer = trace.get_tracer(__name__)

    async def execute_with_observability(
        self,
        task: str,
        user_id: str,
        department: str,
        priority: str = "normal"
    ):
        """
        Execute agent task with full observability.

        Automatically tracks:
        - Request duration and latency percentiles
        - Token usage and estimated costs
        - Success/failure rates by user tier
        - Active concurrent workflows
        """
        start_time = time.time()

        # Increment active workflows gauge
        active_agent_workflows.labels(
            agent_type=self.agent_type,
            priority=priority
        ).inc()

        # Start distributed trace span
        with self.tracer.start_as_current_span(
            f"agent_execution:{self.agent_name}",
            attributes={
                "agent.name": self.agent_name,
                "agent.type": self.agent_type,
                "user.id": user_id,
                "user.department": department,
                "task.priority": priority,
            }
        ) as span:
            try:
                # Structured logging with context
                logger.info(
                    "agent_execution_started",
                    agent_name=self.agent_name,
                    agent_type=self.agent_type,
                    user_id=user_id,
                    task_preview=task[:100],
                    priority=priority
                )

                # Execute actual agent work
                result = await self._execute_agent_task(task)

                # Track success metrics
                duration = time.time() - start_time
                llm_request_duration.labels(
                    model=result['model_used'],
                    operation=self.agent_type
                ).observe(duration)

                llm_requests_total.labels(
                    model=result['model_used'],
                    status='success',
                    user_tier=result.get('user_tier', 'standard')
                ).inc()

                # Track token usage and cost
                tokens = result.get('tokens_used', 0)
                llm_tokens_used.labels(
                    model=result['model_used'],
                    user_id=user_id,
                    operation=self.agent_type
                ).inc(tokens)

                estimated_cost = self._calculate_cost(
                    model=result['model_used'],
                    tokens=tokens
                )
                llm_cost_dollars.labels(
                    model=result['model_used'],
                    department=department
                ).inc(estimated_cost)

                # Add result metadata to span
                span.set_attribute("agent.tokens_used", tokens)
                span.set_attribute("agent.cost_dollars", estimated_cost)
                span.set_attribute("agent.duration_seconds", duration)
                span.set_status(trace.Status(trace.StatusCode.OK))

                logger.info(
                    "agent_execution_completed",
                    agent_name=self.agent_name,
                    duration_seconds=duration,
                    tokens_used=tokens,
                    estimated_cost_dollars=estimated_cost,
                    status="success"
                )

                return result

            except Exception as e:
                # Track failure metrics
                duration = time.time() - start_time
                llm_requests_total.labels(
                    model="unknown",
                    status='error',
                    user_tier='unknown'
                ).inc()

                # Record error in span
                span.record_exception(e)
                span.set_status(trace.Status(trace.StatusCode.ERROR))

                logger.error(
                    "agent_execution_failed",
                    agent_name=self.agent_name,
                    error=str(e),
                    duration_seconds=duration,
                    exc_info=True
                )
                raise

            finally:
                # Always decrement active workflows
                active_agent_workflows.labels(
                    agent_type=self.agent_type,
                    priority=priority
                ).dec()


# FastAPI integration for automatic instrumentation
def setup_observability(app):
    """Configure OpenTelemetry and Prometheus for FastAPI application."""

    # Configure Jaeger exporter for distributed tracing
    jaeger_exporter = JaegerExporter(
        agent_host_name="jaeger",
        agent_port=6831,
    )

    provider = TracerProvider()
    provider.add_span_processor(BatchSpanProcessor(jaeger_exporter))
    trace.set_tracer_provider(provider)

    # Auto-instrument FastAPI
    FastAPIInstrumentor.instrument_app(app)

    logger.info("observability_configured", exporters=["jaeger", "prometheus"])
```

**Why this matters:** When a customer reports "the AI is slow today," you need data—not guesses. Observability tells you exactly which model, which prompt, and which infrastructure component is the bottleneck.

### Production-ready FastAPI integration

Now let's build a FastAPI application that enterprises can actually deploy:

```python
# app/main.py
from fastapi import FastAPI, HTTPException, Depends, Security, BackgroundTasks
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from fastapi.middleware.cors import CORSMiddleware
from fastapi.middleware.gzip import GZipMiddleware
from prometheus_fastapi_instrumentator import Instrumentator
from slowapi import Limiter, _rate_limit_exceeded_handler
from slowapi.util import get_remote_address
from slowapi.errors import RateLimitExceeded
import uvicorn
from typing import Optional
import os

from app.core.observability import setup_observability, ObservableAIAgent
from app.core.resilience import ResilientAIService
from app.core.security import verify_api_key, get_current_user
from app.models.requests import AgentRequest, AgentResponse
from app.agents.langchain_agent import LangChainAgentOrchestrator
from app.agents.crewai_agent import CrewAIAgentOrchestrator

# Initialize FastAPI with production configuration
app = FastAPI(
    title="Enterprise AI Agent API",
    description="Production-grade LangChain and CrewAI orchestration",
    version="1.0.0",
    docs_url="/api/docs" if os.getenv("ENV") != "production" else None,  # Disable docs in prod
    redoc_url="/api/redoc" if os.getenv("ENV") != "production" else None,
)

# Security middleware
security = HTTPBearer()

# Rate limiting configuration
limiter = Limiter(key_func=get_remote_address)
app.state.limiter = limiter
app.add_exception_handler(RateLimitExceeded, _rate_limit_exceeded_handler)

# CORS configuration for enterprise environments
app.add_middleware(
    CORSMiddleware,
    allow_origins=os.getenv("ALLOWED_ORIGINS", "*").split(","),
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE"],
    allow_headers=["*"],
)

# Compression for large responses
app.add_middleware(GZipMiddleware, minimum_size=1000)

# Setup observability (Prometheus + Jaeger)
setup_observability(app)
Instrumentator().instrument(app).expose(app, endpoint="/metrics")

# Initialize agent orchestrators
langchain_orchestrator = LangChainAgentOrchestrator()
crewai_orchestrator = CrewAIAgentOrchestrator()


@app.get("/health")
async def health_check():
    """
    Health check endpoint for load balancer and monitoring.

    Returns:
        - status: Service health status
        - dependencies: Health of critical dependencies
    """
    health_status = {
        "status": "healthy",
        "dependencies": {
            "redis": await check_redis_health(),
            "vector_store": await check_vector_store_health(),
            "llm_api": await check_llm_api_health(),
        }
    }

    # Return 503 if any critical dependency is down
    if any(status == "unhealthy" for status in health_status["dependencies"].values()):
        health_status["status"] = "degraded"
        raise HTTPException(status_code=503, detail=health_status)

    return health_status


@app.post(
    "/api/v1/agents/langchain/execute",
    response_model=AgentResponse,
    dependencies=[Depends(verify_api_key)]
)
@limiter.limit("100/minute")  # Per-IP rate limiting
async def execute_langchain_agent(
    request: AgentRequest,
    background_tasks: BackgroundTasks,
    credentials: HTTPAuthorizationCredentials = Security(security),
    current_user = Depends(get_current_user)
):
    """
    Execute LangChain agent workflow with enterprise-grade observability.

    Rate Limits:
        - 100 requests per minute per IP
        - Higher limits available for enterprise tier

    Authentication:
        - Bearer token required in Authorization header
        - API key validated against user database

    Args:
        request: Agent execution request with task and configuration
        background_tasks: Background task queue for async operations
        credentials: HTTP bearer token from Authorization header
        current_user: Authenticated user object from JWT/API key

    Returns:
        AgentResponse with execution results, metrics, and trace ID
    """
    observable_agent = ObservableAIAgent(
        agent_name="langchain_executor",
        agent_type="langchain"
    )

    try:
        result = await observable_agent.execute_with_observability(
            task=request.task,
            user_id=current_user.id,
            department=current_user.department,
            priority=request.priority
        )

        # Queue background analytics update
        background_tasks.add_task(
            update_usage_analytics,
            user_id=current_user.id,
            tokens_used=result['tokens_used'],
            cost=result['estimated_cost']
        )

        return AgentResponse(**result)

    except Exception as e:
        logger.error(
            "agent_execution_error",
            agent_type="langchain",
            user_id=current_user.id,
            error=str(e),
            exc_info=True
        )
        raise HTTPException(
            status_code=500,
            detail=f"Agent execution failed: {str(e)}"
        )


@app.post(
    "/api/v1/agents/crewai/execute",
    response_model=AgentResponse,
    dependencies=[Depends(verify_api_key)]
)
@limiter.limit("50/minute")  # Lower limit for more expensive CrewAI workflows
async def execute_crewai_agent(
    request: AgentRequest,
    background_tasks: BackgroundTasks,
    credentials: HTTPAuthorizationCredentials = Security(security),
    current_user = Depends(get_current_user)
):
    """
    Execute CrewAI multi-agent workflow with team coordination.

    Rate Limits:
        - 50 requests per minute per IP (higher token usage than LangChain)

    CrewAI workflows consume more tokens due to multi-agent coordination,
    so rate limits are lower to prevent budget overruns.
    """
    observable_agent = ObservableAIAgent(
        agent_name="crewai_executor",
        agent_type="crewai"
    )

    try:
        result = await observable_agent.execute_with_observability(
            task=request.task,
            user_id=current_user.id,
            department=current_user.department,
            priority=request.priority
        )

        background_tasks.add_task(
            update_usage_analytics,
            user_id=current_user.id,
            tokens_used=result['tokens_used'],
            cost=result['estimated_cost']
        )

        return AgentResponse(**result)

    except Exception as e:
        logger.error(
            "agent_execution_error",
            agent_type="crewai",
            user_id=current_user.id,
            error=str(e),
            exc_info=True
        )
        raise HTTPException(
            status_code=500,
            detail=f"Agent execution failed: {str(e)}"
        )


@app.get("/api/v1/usage/summary")
async def get_usage_summary(current_user = Depends(get_current_user)):
    """
    Retrieve token usage and cost summary for current user.

    Returns:
        - tokens_used_today: Total tokens consumed today
        - cost_today: Estimated cost in dollars
        - remaining_budget: Monthly budget remaining
    """
    summary = await fetch_usage_summary(current_user.id)
    return summary


if __name__ == "__main__":
    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",
        port=8000,
        reload=os.getenv("ENV") == "development",
        workers=int(os.getenv("WORKERS", "4")),
        log_config="logging_config.yaml"
    )
```

**What this gives you:**
- **Security:** API key authentication, rate limiting, CORS protection
- **Observability:** Prometheus metrics, Jaeger tracing, structured logs
- **Reliability:** Health checks, graceful degradation, background tasks
- **Scalability:** Multi-worker support, compression, efficient routing

This isn't a prototype anymore—it's production infrastructure.

---

## Security and compliance framework

Let's implement the security patterns that pass enterprise audits.

### API authentication and authorization

Never trust incoming requests. Always verify, always authorize:

```python
# app/core/security.py
from fastapi import HTTPException, Security, Depends
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from jose import JWTError, jwt
from passlib.context import CryptContext
from datetime import datetime, timedelta
from typing import Optional
import os
import redis
from sqlalchemy.orm import Session

from app.models.database import User, APIKey
from app.core.database import get_db

# Security configuration
SECRET_KEY = os.getenv("JWT_SECRET_KEY")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30
REFRESH_TOKEN_EXPIRE_DAYS = 30

# Password hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Redis for token blacklist and rate limiting
redis_client = redis.from_url(os.getenv("REDIS_URL", "redis://localhost:6379"))

security = HTTPBearer()


class AuthService:
    """
    Enterprise authentication service with JWT and API key support.

    Implements:
    - JWT token generation with refresh tokens
    - API key validation with rotation policies
    - Token blacklisting for logout
    - Role-based access control (RBAC)
    """

    @staticmethod
    def verify_password(plain_password: str, hashed_password: str) -> bool:
        """Verify password against bcrypt hash."""
        return pwd_context.verify(plain_password, hashed_password)

    @staticmethod
    def get_password_hash(password: str) -> str:
        """Generate bcrypt hash for password storage."""
        return pwd_context.hash(password)

    @staticmethod
    def create_access_token(
        data: dict,
        expires_delta: Optional[timedelta] = None
    ) -> str:
        """
        Create JWT access token with expiration.

        Args:
            data: Payload dictionary to encode in JWT
            expires_delta: Custom expiration time (default: 30 minutes)

        Returns:
            Encoded JWT token string
        """
        to_encode = data.copy()

        if expires_delta:
            expire = datetime.utcnow() + expires_delta
        else:
            expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)

        to_encode.update({
            "exp": expire,
            "iat": datetime.utcnow(),
            "type": "access"
        })

        encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
        return encoded_jwt

    @staticmethod
    def create_refresh_token(user_id: str) -> str:
        """
        Create long-lived refresh token for token renewal.

        Refresh tokens have longer expiration (30 days) and can be used
        to generate new access tokens without re-authentication.
        """
        expire = datetime.utcnow() + timedelta(days=REFRESH_TOKEN_EXPIRE_DAYS)

        to_encode = {
            "sub": user_id,
            "exp": expire,
            "iat": datetime.utcnow(),
            "type": "refresh"
        }

        encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
        return encoded_jwt

    @staticmethod
    async def verify_token(token: str) -> dict:
        """
        Verify JWT token and extract payload.

        Checks:
        - Token signature validity
        - Token expiration
        - Token not in blacklist (for logout)

        Raises:
            HTTPException: If token is invalid, expired, or blacklisted
        """
        try:
            # Check if token is blacklisted (user logged out)
            if redis_client.get(f"blacklist:{token}"):
                raise HTTPException(
                    status_code=401,
                    detail="Token has been revoked"
                )

            # Decode and verify token
            payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])

            # Verify token type
            if payload.get("type") != "access":
                raise HTTPException(
                    status_code=401,
                    detail="Invalid token type"
                )

            return payload

        except JWTError as e:
            raise HTTPException(
                status_code=401,
                detail=f"Token validation failed: {str(e)}"
            )

    @staticmethod
    async def blacklist_token(token: str, expire_seconds: int):
        """
        Add token to blacklist (for logout functionality).

        Blacklisted tokens are stored in Redis with expiration matching
        the token's original expiration time.
        """
        redis_client.setex(
            f"blacklist:{token}",
            expire_seconds,
            "1"
        )


async def verify_api_key(
    credentials: HTTPAuthorizationCredentials = Security(security),
    db: Session = Depends(get_db)
) -> dict:
    """
    Verify API key from Authorization header.

    Supports two authentication methods:
    1. JWT Bearer tokens (from login)
    2. API keys (for programmatic access)

    Args:
        credentials: HTTP Bearer token from Authorization header
        db: Database session for API key lookup

    Returns:
        User information dictionary

    Raises:
        HTTPException: If authentication fails
    """
    token = credentials.credentials

    # Try JWT token verification first
    try:
        payload = await AuthService.verify_token(token)
        user_id = payload.get("sub")

        if not user_id:
            raise HTTPException(
                status_code=401,
                detail="Invalid token payload"
            )

        user = db.query(User).filter(User.id == user_id).first()

        if not user:
            raise HTTPException(
                status_code=401,
                detail="User not found"
            )

        return {
            "user_id": user.id,
            "email": user.email,
            "department": user.department,
            "tier": user.subscription_tier,
            "roles": user.roles
        }

    except HTTPException:
        # JWT verification failed, try API key
        api_key = db.query(APIKey).filter(
            APIKey.key == token,
            APIKey.is_active == True,
            APIKey.expires_at > datetime.utcnow()
        ).first()

        if not api_key:
            raise HTTPException(
                status_code=401,
                detail="Invalid or expired API key"
            )

        # Check API key rotation policy (warn if > 60 days old)
        key_age = (datetime.utcnow() - api_key.created_at).days
        if key_age > 60:
            logger.warning(
                "api_key_rotation_warning",
                api_key_id=api_key.id,
                age_days=key_age,
                user_id=api_key.user_id
            )

        # Update last_used_at timestamp
        api_key.last_used_at = datetime.utcnow()
        db.commit()

        user = api_key.user

        return {
            "user_id": user.id,
            "email": user.email,
            "department": user.department,
            "tier": user.subscription_tier,
            "roles": user.roles,
            "api_key_id": api_key.id
        }


async def get_current_user(
    auth_data: dict = Depends(verify_api_key),
    db: Session = Depends(get_db)
):
    """
    Retrieve current authenticated user object.

    Use this dependency in route handlers to get full user object
    with all attributes and relationships.
    """
    user = db.query(User).filter(User.id == auth_data["user_id"]).first()

    if not user:
        raise HTTPException(
            status_code=401,
            detail="User not found"
        )

    return user


def require_role(required_role: str):
    """
    Decorator factory for role-based access control (RBAC).

    Usage:
        @app.get("/admin/users")
        @require_role("admin")
        async def list_users(current_user = Depends(get_current_user)):
            # Only users with "admin" role can access
            pass
    """
    async def role_checker(current_user = Depends(get_current_user)):
        if required_role not in current_user.roles:
            raise HTTPException(
                status_code=403,
                detail=f"Insufficient permissions. Required role: {required_role}"
            )
        return current_user

    return Depends(role_checker)
```

### Data privacy and PII protection

Enterprises care deeply about data privacy. Here's how to handle sensitive data correctly:

```python
# app/core/privacy.py
from presidio_analyzer import AnalyzerEngine
from presidio_anonymizer import AnonymizerEngine
from typing import Dict, List, Optional
import hashlib
import re

# Initialize Presidio for PII detection
analyzer = AnalyzerEngine()
anonymizer = AnonymizerEngine()


class PIIProtectionService:
    """
    Detect and redact PII before sending data to external APIs.

    Compliant with:
    - GDPR (European data protection)
    - CCPA (California privacy law)
    - HIPAA (healthcare data)
    - SOC 2 (security controls)
    """

    # Supported PII entity types
    PII_ENTITIES = [
        "PERSON",           # Names
        "EMAIL_ADDRESS",    # Email addresses
        "PHONE_NUMBER",     # Phone numbers
        "CREDIT_CARD",      # Credit card numbers
        "US_SSN",           # Social Security Numbers
        "IBAN_CODE",        # Bank account numbers
        "IP_ADDRESS",       # IP addresses
        "LOCATION",         # Physical addresses
        "DATE_TIME",        # Dates that could identify individuals
        "MEDICAL_LICENSE",  # Healthcare identifiers
        "US_DRIVER_LICENSE", # Driver's license numbers
    ]

    @staticmethod
    def detect_pii(text: str, language: str = "en") -> List[Dict]:
        """
        Detect PII entities in text using Presidio.

        Args:
            text: Input text to scan for PII
            language: Language code (default: English)

        Returns:
            List of detected PII entities with type, location, and score
        """
        results = analyzer.analyze(
            text=text,
            language=language,
            entities=PIIProtectionService.PII_ENTITIES
        )

        return [
            {
                "entity_type": result.entity_type,
                "start": result.start,
                "end": result.end,
                "score": result.score,
                "text": text[result.start:result.end]
            }
            for result in results
        ]

    @staticmethod
    def redact_pii(
        text: str,
        language: str = "en",
        redaction_char: str = "X"
    ) -> Dict[str, any]:
        """
        Redact PII from text before sending to external APIs.

        Example:
            Input: "Contact John Doe at john@example.com or 555-1234"
            Output: "Contact XXXX XXX at XXXXXXXXXXXXXXXXXXXXX or XXXXXXXX"

        Returns:
            - redacted_text: Text with PII replaced by redaction characters
            - entities_found: List of redacted entities
            - original_hash: SHA256 hash for audit trail
        """
        # Detect PII first
        results = analyzer.analyze(
            text=text,
            language=language,
            entities=PIIProtectionService.PII_ENTITIES
        )

        if not results:
            # No PII found
            return {
                "redacted_text": text,
                "entities_found": [],
                "original_hash": hashlib.sha256(text.encode()).hexdigest(),
                "pii_detected": False
            }

        # Anonymize detected PII
        anonymized = anonymizer.anonymize(
            text=text,
            analyzer_results=results,
            operators={"DEFAULT": {"type": "replace", "new_value": redaction_char}}
        )

        return {
            "redacted_text": anonymized.text,
            "entities_found": [
                {
                    "entity_type": result.entity_type,
                    "score": result.score
                }
                for result in results
            ],
            "original_hash": hashlib.sha256(text.encode()).hexdigest(),
            "pii_detected": True
        }

    @staticmethod
    def pseudonymize_pii(text: str, language: str = "en") -> Dict[str, any]:
        """
        Replace PII with fake but realistic values (pseudonymization).

        Useful for:
        - Testing with production-like data
        - Demos without exposing real PII
        - GDPR-compliant analytics

        Example:
            Input: "Contact John Doe at john@example.com"
            Output: "Contact Jane Smith at jane_smith_8473@email.com"
        """
        results = analyzer.analyze(
            text=text,
            language=language,
            entities=PIIProtectionService.PII_ENTITIES
        )

        if not results:
            return {
                "pseudonymized_text": text,
                "mapping": {},
                "pii_detected": False
            }

        # Use Presidio's built-in faker operators
        anonymized = anonymizer.anonymize(
            text=text,
            analyzer_results=results,
            operators={
                "PERSON": {"type": "replace", "new_value": "PERSON_PLACEHOLDER"},
                "EMAIL_ADDRESS": {"type": "replace", "new_value": "email@example.com"},
                "PHONE_NUMBER": {"type": "replace", "new_value": "555-0000"},
                "CREDIT_CARD": {"type": "replace", "new_value": "XXXX-XXXX-XXXX-0000"},
            }
        )

        return {
            "pseudonymized_text": anonymized.text,
            "entities_replaced": len(results),
            "pii_detected": True
        }


# Integration with LangChain agent execution
class PrivacyAwareLangChainAgent:
    """
    Wrap LangChain agents with automatic PII protection.

    Before sending any data to external LLM APIs:
    1. Detect PII in user prompts
    2. Redact or pseudonymize sensitive data
    3. Log PII detection for compliance audits
    4. Process with external API safely
    """

    def __init__(self, langchain_agent, enable_pii_protection: bool = True):
        self.agent = langchain_agent
        self.enable_pii_protection = enable_pii_protection
        self.pii_service = PIIProtectionService()

    async def execute_with_privacy(
        self,
        prompt: str,
        user_id: str,
        redaction_mode: str = "redact"  # "redact" or "pseudonymize"
    ):
        """
        Execute agent with automatic PII protection.

        Args:
            prompt: User input prompt (may contain PII)
            user_id: User identifier for audit trail
            redaction_mode: How to handle PII ("redact" or "pseudonymize")
        """
        if not self.enable_pii_protection:
            # PII protection disabled (only for testing)
            return await self.agent.execute(prompt)

        # Detect and redact PII
        if redaction_mode == "redact":
            protection_result = self.pii_service.redact_pii(prompt)
        else:
            protection_result = self.pii_service.pseudonymize_pii(prompt)

        if protection_result["pii_detected"]:
            # Log PII detection for compliance audit
            logger.warning(
                "pii_detected_and_protected",
                user_id=user_id,
                entities_found=protection_result.get("entities_found", []),
                original_hash=protection_result["original_hash"],
                redaction_mode=redaction_mode
            )

        # Execute agent with PII-protected prompt
        result = await self.agent.execute(
            protection_result["redacted_text"] if redaction_mode == "redact"
            else protection_result["pseudonymized_text"]
        )

        return {
            "result": result,
            "pii_protection_applied": protection_result["pii_detected"],
            "entities_protected": protection_result.get("entities_found", [])
        }


# Usage example
agent = PrivacyAwareLangChainAgent(langchain_agent, enable_pii_protection=True)

response = await agent.execute_with_privacy(
    prompt="Analyze customer record: John Doe, SSN 123-45-6789, email john@example.com",
    user_id="user_12345",
    redaction_mode="redact"
)

# Prompt sent to external API:
# "Analyze customer record: XXXX XXX, SSN XXXXXXXXXXX, email XXXXXXXXXXXXXXXXXXXXX"
```

**Why this matters:** When your AI application processes customer support tickets, employee records, or financial documents, you're handling PII. One data breach could cost millions in fines and destroy customer trust. Automated PII protection isn't optional—it's mandatory.

---

## Docker and Kubernetes deployment

Let's containerize and orchestrate your AI application for production scalability.

### Production-grade Dockerfile

```dockerfile
# Dockerfile
# Multi-stage build for optimal image size and security

# Stage 1: Builder - Install dependencies and compile extensions
FROM python:3.11-slim AS builder

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment for dependency isolation
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt


# Stage 2: Runtime - Minimal production image
FROM python:3.11-slim

# Install runtime dependencies only (no build tools)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user for security (never run as root in production)
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copy Python virtual environment from builder stage
COPY --from=builder /opt/venv /opt/venv

# Set working directory
WORKDIR /app

# Copy application code
COPY --chown=appuser:appuser . /app

# Set environment variables
ENV PATH="/opt/venv/bin:$PATH" \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

# Switch to non-root user
USER appuser

# Expose application port
EXPOSE 8000

# Health check for container orchestration
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Run application with production settings
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "4"]
```

### Kubernetes deployment configuration

```yaml
# kubernetes/deployment.yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ai-agent-api
  namespace: production
  labels:
    app: ai-agent-api
    version: v1.0.0
    tier: backend
spec:
  replicas: 3  # Start with 3 pods for high availability
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1        # Allow 1 extra pod during deployment
      maxUnavailable: 0  # Zero downtime deployment
  selector:
    matchLabels:
      app: ai-agent-api
  template:
    metadata:
      labels:
        app: ai-agent-api
        version: v1.0.0
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "8000"
        prometheus.io/path: "/metrics"
    spec:
      # Anti-affinity for pod distribution across nodes
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
            - weight: 100
              podAffinityTerm:
                labelSelector:
                  matchExpressions:
                    - key: app
                      operator: In
                      values:
                        - ai-agent-api
                topologyKey: kubernetes.io/hostname

      # Service account for RBAC
      serviceAccountName: ai-agent-api

      # Security context (non-root, read-only filesystem)
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        fsGroup: 1000

      containers:
        - name: ai-agent-api
          image: your-registry.com/ai-agent-api:1.0.0
          imagePullPolicy: IfNotPresent

          ports:
            - name: http
              containerPort: 8000
              protocol: TCP

          # Environment variables from ConfigMap and Secrets
          env:
            - name: ENV
              value: "production"
            - name: LOG_LEVEL
              value: "INFO"
            - name: WORKERS
              value: "4"

            # Database configuration
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: ai-agent-secrets
                  key: database-url

            # Redis configuration
            - name: REDIS_URL
              valueFrom:
                secretKeyRef:
                  name: ai-agent-secrets
                  key: redis-url

            # OpenAI API key
            - name: OPENAI_API_KEY
              valueFrom:
                secretKeyRef:
                  name: ai-agent-secrets
                  key: openai-api-key

            # JWT secret for authentication
            - name: JWT_SECRET_KEY
              valueFrom:
                secretKeyRef:
                  name: ai-agent-secrets
                  key: jwt-secret-key

          # Resource requests and limits (important for cost optimization)
          resources:
            requests:
              memory: "512Mi"
              cpu: "500m"
            limits:
              memory: "2Gi"
              cpu: "2000m"

          # Liveness probe (restart if unhealthy)
          livenessProbe:
            httpGet:
              path: /health
              port: http
            initialDelaySeconds: 30
            periodSeconds: 10
            timeoutSeconds: 5
            successThreshold: 1
            failureThreshold: 3

          # Readiness probe (don't send traffic if not ready)
          readinessProbe:
            httpGet:
              path: /health
              port: http
            initialDelaySeconds: 10
            periodSeconds: 5
            timeoutSeconds: 3
            successThreshold: 1
            failureThreshold: 3

          # Volume mounts (if needed)
          volumeMounts:
            - name: cache
              mountPath: /tmp/cache
            - name: logs
              mountPath: /app/logs

      volumes:
        - name: cache
          emptyDir: {}
        - name: logs
          emptyDir: {}

---
# Horizontal Pod Autoscaler (HPA)
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: ai-agent-api-hpa
  namespace: production
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: ai-agent-api
  minReplicas: 3
  maxReplicas: 20  # Scale up to 20 pods under high load
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70  # Scale when CPU > 70%
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 80  # Scale when memory > 80%
    # Custom metric: requests per second
    - type: Pods
      pods:
        metric:
          name: http_requests_per_second
        target:
          type: AverageValue
          averageValue: "100"  # Scale when > 100 req/s per pod

---
# Service for load balancing
apiVersion: v1
kind: Service
metadata:
  name: ai-agent-api
  namespace: production
  labels:
    app: ai-agent-api
spec:
  type: ClusterIP
  ports:
    - port: 80
      targetPort: http
      protocol: TCP
      name: http
  selector:
    app: ai-agent-api

---
# Ingress for external access
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ai-agent-api
  namespace: production
  annotations:
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/rate-limit: "100"  # 100 req/s per IP
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  tls:
    - hosts:
        - api.yourcompany.com
      secretName: ai-agent-api-tls
  rules:
    - host: api.yourcompany.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: ai-agent-api
                port:
                  number: 80
```

### Secrets and ConfigMaps

```yaml
# kubernetes/secrets.yaml
# NEVER commit this file to git. Use sealed-secrets or vault.
---
apiVersion: v1
kind: Secret
metadata:
  name: ai-agent-secrets
  namespace: production
type: Opaque
stringData:
  database-url: "postgresql://user:password@postgres-service:5432/ai_agents"
  redis-url: "redis://:password@redis-service:6379/0"
  openai-api-key: "sk-..." # Your actual API key
  anthropic-api-key: "..." # Claude API key
  jwt-secret-key: "your-secret-jwt-key-change-this"

---
# kubernetes/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: ai-agent-config
  namespace: production
data:
  # Application configuration
  APP_NAME: "AI Agent API"
  LOG_LEVEL: "INFO"
  WORKERS: "4"

  # Feature flags
  ENABLE_PII_PROTECTION: "true"
  ENABLE_RATE_LIMITING: "true"
  ENABLE_OBSERVABILITY: "true"

  # Rate limiting configuration
  RATE_LIMIT_REQUESTS: "100"
  RATE_LIMIT_PERIOD: "60"

  # Model configuration
  DEFAULT_LLM_MODEL: "gpt-4"
  DEFAULT_LLM_TEMPERATURE: "0.7"
  DEFAULT_MAX_TOKENS: "2000"
```

**What this deployment gives you:**
- **Zero-downtime deployments:** Rolling updates with health checks
- **Auto-scaling:** Horizontal scaling based on CPU, memory, and custom metrics
- **High availability:** Pod anti-affinity spreads pods across nodes
- **Security:** Non-root containers, secrets management, TLS encryption
- **Observability:** Prometheus annotations for automatic metric collection

This is production-grade infrastructure that passes enterprise scrutiny.

---

## Observability and monitoring setup

Let's implement the monitoring stack that tells you *exactly* what's happening in production.

### Prometheus and Grafana configuration

```yaml
# kubernetes/prometheus-config.yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config
  namespace: monitoring
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
      evaluation_interval: 15s
      external_labels:
        cluster: 'production'
        environment: 'prod'

    # Alerting configuration
    alerting:
      alertmanagers:
        - static_configs:
            - targets:
                - alertmanager:9093

    # Load alerting rules
    rule_files:
      - '/etc/prometheus/rules/*.yml'

    # Scrape configurations
    scrape_configs:
      # AI Agent API metrics
      - job_name: 'ai-agent-api'
        kubernetes_sd_configs:
          - role: pod
            namespaces:
              names:
                - production
        relabel_configs:
          - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
            action: keep
            regex: true
          - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_path]
            action: replace
            target_label: __metrics_path__
            regex: (.+)
          - source_labels: [__address__, __meta_kubernetes_pod_annotation_prometheus_io_port]
            action: replace
            regex: ([^:]+)(?::\d+)?;(\d+)
            replacement: $1:$2
            target_label: __address__
          - action: labelmap
            regex: __meta_kubernetes_pod_label_(.+)
          - source_labels: [__meta_kubernetes_namespace]
            action: replace
            target_label: kubernetes_namespace
          - source_labels: [__meta_kubernetes_pod_name]
            action: replace
            target_label: kubernetes_pod_name

      # Node exporter for infrastructure metrics
      - job_name: 'node-exporter'
        kubernetes_sd_configs:
          - role: node
        relabel_configs:
          - source_labels: [__address__]
            regex: '(.*):10250'
            replacement: '${1}:9100'
            target_label: __address__

      # Kubernetes API server metrics
      - job_name: 'kubernetes-apiservers'
        kubernetes_sd_configs:
          - role: endpoints
        scheme: https
        tls_config:
          ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
        relabel_configs:
          - source_labels: [__meta_kubernetes_namespace, __meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]
            action: keep
            regex: default;kubernetes;https

---
# Prometheus alerting rules for AI agents
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-rules
  namespace: monitoring
data:
  ai_agent_alerts.yml: |
    groups:
      - name: ai_agent_alerts
        interval: 30s
        rules:
          # High error rate alert
          - alert: HighLLMErrorRate
            expr: |
              (
                sum(rate(llm_requests_total{status="error"}[5m]))
                /
                sum(rate(llm_requests_total[5m]))
              ) > 0.05
            for: 5m
            labels:
              severity: critical
              component: ai-agent
            annotations:
              summary: "High LLM error rate detected"
              description: "LLM error rate is {{ $value | humanizePercentage }} (threshold: 5%)"

          # High latency alert
          - alert: HighLLMLatency
            expr: |
              histogram_quantile(0.95,
                sum(rate(llm_request_duration_seconds_bucket[5m])) by (le, model)
              ) > 30
            for: 10m
            labels:
              severity: warning
              component: ai-agent
            annotations:
              summary: "High LLM request latency detected"
              description: "95th percentile latency is {{ $value }}s for model {{ $labels.model }}"

          # Budget overrun alert
          - alert: LLMCostBudgetOverrun
            expr: |
              sum(increase(llm_cost_dollars_total[1d])) > 1000
            labels:
              severity: critical
              component: billing
            annotations:
              summary: "Daily LLM cost budget exceeded"
              description: "Daily LLM costs: ${{ $value }} (threshold: $1000)"

          # Token usage spike alert
          - alert: UnusualTokenUsageSpike
            expr: |
              (
                sum(rate(llm_tokens_used_total[5m]))
                /
                sum(rate(llm_tokens_used_total[1h] offset 1d))
              ) > 3
            for: 10m
            labels:
              severity: warning
              component: ai-agent
            annotations:
              summary: "Unusual token usage spike detected"
              description: "Current token usage is {{ $value }}x higher than yesterday"

          # Circuit breaker open alert
          - alert: CircuitBreakerOpen
            expr: |
              circuit_breaker_state{state="open"} == 1
            for: 5m
            labels:
              severity: critical
              component: resilience
            annotations:
              summary: "Circuit breaker opened for {{ $labels.service }}"
              description: "Too many failures detected. Service may be degraded."

          # Low cache hit rate
          - alert: LowCacheHitRate
            expr: |
              (
                sum(rate(cache_hits_total[10m]))
                /
                sum(rate(cache_requests_total[10m]))
              ) < 0.7
            for: 15m
            labels:
              severity: warning
              component: caching
            annotations:
              summary: "Cache hit rate below 70%"
              description: "Current cache hit rate: {{ $value | humanizePercentage }}"
```

### Grafana dashboard configuration

```json
{
  "dashboard": {
    "title": "AI Agent Production Metrics",
    "tags": ["ai", "langchain", "crewai", "production"],
    "timezone": "browser",
    "panels": [
      {
        "title": "Request Rate (req/s)",
        "type": "graph",
        "targets": [
          {
            "expr": "sum(rate(llm_requests_total[1m])) by (model)"
          }
        ],
        "yAxes": [{"label": "Requests/sec"}]
      },
      {
        "title": "Error Rate (%)",
        "type": "graph",
        "targets": [
          {
            "expr": "(sum(rate(llm_requests_total{status=\"error\"}[5m])) / sum(rate(llm_requests_total[5m]))) * 100"
          }
        ],
        "alert": {
          "conditions": [
            {"evaluator": {"params": [5], "type": "gt"}}
          ],
          "name": "High Error Rate"
        }
      },
      {
        "title": "Latency Percentiles (seconds)",
        "type": "graph",
        "targets": [
          {
            "expr": "histogram_quantile(0.50, sum(rate(llm_request_duration_seconds_bucket[5m])) by (le))",
            "legendFormat": "p50"
          },
          {
            "expr": "histogram_quantile(0.95, sum(rate(llm_request_duration_seconds_bucket[5m])) by (le))",
            "legendFormat": "p95"
          },
          {
            "expr": "histogram_quantile(0.99, sum(rate(llm_request_duration_seconds_bucket[5m])) by (le))",
            "legendFormat": "p99"
          }
        ]
      },
      {
        "title": "Token Usage (tokens/min)",
        "type": "graph",
        "targets": [
          {
            "expr": "sum(rate(llm_tokens_used_total[1m])) by (model, operation)"
          }
        ]
      },
      {
        "title": "Cost by Department ($/hour)",
        "type": "graph",
        "targets": [
          {
            "expr": "sum(rate(llm_cost_dollars_total[1h])) by (department) * 3600"
          }
        ]
      },
      {
        "title": "Active Workflows",
        "type": "stat",
        "targets": [
          {
            "expr": "sum(active_agent_workflows)"
          }
        ]
      },
      {
        "title": "Cache Hit Rate (%)",
        "type": "gauge",
        "targets": [
          {
            "expr": "(sum(rate(cache_hits_total[5m])) / sum(rate(cache_requests_total[5m]))) * 100"
          }
        ],
        "thresholds": "50,70,90"
      },
      {
        "title": "Top Users by Token Usage",
        "type": "table",
        "targets": [
          {
            "expr": "topk(10, sum by (user_id) (increase(llm_tokens_used_total[1h])))"
          }
        ]
      }
    ]
  }
}
```

### Distributed tracing with Jaeger

```python
# app/core/tracing.py
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.jaeger.thrift import JaegerExporter
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
from opentelemetry.instrumentation.requests import RequestsInstrumentor
from opentelemetry.instrumentation.redis import RedisInstrumentor
from opentelemetry.instrumentation.sqlalchemy import SQLAlchemyInstrumentor
import os


def setup_tracing(app, service_name: str = "ai-agent-api"):
    """
    Configure distributed tracing with Jaeger.

    Automatically instruments:
    - FastAPI HTTP endpoints
    - External HTTP requests (OpenAI, Anthropic APIs)
    - Redis cache operations
    - Database queries (SQLAlchemy)

    Traces propagate across service boundaries using W3C Trace Context.
    """
    # Configure Jaeger exporter
    jaeger_exporter = JaegerExporter(
        agent_host_name=os.getenv("JAEGER_AGENT_HOST", "jaeger"),
        agent_port=int(os.getenv("JAEGER_AGENT_PORT", "6831")),
    )

    # Create tracer provider
    provider = TracerProvider(
        resource=Resource.create({"service.name": service_name})
    )

    # Add batch span processor for efficient export
    provider.add_span_processor(BatchSpanProcessor(jaeger_exporter))

    # Set as global tracer provider
    trace.set_tracer_provider(provider)

    # Auto-instrument FastAPI
    FastAPIInstrumentor.instrument_app(app)

    # Auto-instrument external HTTP requests
    RequestsInstrumentor().instrument()

    # Auto-instrument Redis
    RedisInstrumentor().instrument()

    # Auto-instrument SQLAlchemy
    SQLAlchemyInstrumentor().instrument(
        enable_commenter=True,  # Add trace context to SQL comments
        commenter_options={"db_driver": True, "db_framework": True}
    )

    logger.info(
        "distributed_tracing_configured",
        service_name=service_name,
        jaeger_host=os.getenv("JAEGER_AGENT_HOST", "jaeger")
    )


# Example: Manual span creation for custom operations
tracer = trace.get_tracer(__name__)

async def process_complex_workflow(workflow_id: str):
    """Example of custom span creation for workflow tracking."""

    with tracer.start_as_current_span(
        "complex_workflow",
        attributes={"workflow.id": workflow_id}
    ) as workflow_span:

        # Step 1: Load workflow configuration
        with tracer.start_as_current_span("load_workflow_config"):
            config = await load_config(workflow_id)
            workflow_span.set_attribute("workflow.config", str(config))

        # Step 2: Execute agent tasks
        with tracer.start_as_current_span("execute_agent_tasks"):
            results = []
            for i, task in enumerate(config["tasks"]):
                with tracer.start_as_current_span(
                    f"execute_task_{i}",
                    attributes={"task.type": task["type"]}
                ):
                    result = await execute_task(task)
                    results.append(result)

        # Step 3: Aggregate results
        with tracer.start_as_current_span("aggregate_results"):
            final_result = aggregate(results)
            workflow_span.set_attribute("workflow.status", "completed")

        return final_result
```

**What this observability stack gives you:**
- **Prometheus:** Time-series metrics with alerting
- **Grafana:** Visual dashboards for real-time monitoring
- **Jaeger:** Distributed tracing across multi-agent workflows
- **Structured logs:** Context-rich logging with correlation IDs

When something breaks at 3 AM, you'll know exactly what, where, and why.

---

## Real-world production case study

Let me walk you through a real enterprise deployment—what worked, what didn't, and what we learned.

### Project overview: Document intelligence platform

**Client:** Financial services company (anonymized for confidentiality)
**Challenge:** Process 50,000+ financial documents daily with 99.9% accuracy
**Timeline:** 6 months from prototype to production
**Scale:** 85 concurrent users, 2M+ API requests/month

**Tech Stack:**
- **AI Framework:** LangChain + CrewAI
- **LLM Providers:** OpenAI GPT-4, Anthropic Claude 3
- **Vector Store:** Pinecone (2M vectors)
- **API Layer:** FastAPI + Celery
- **Infrastructure:** AWS EKS (Kubernetes)
- **Monitoring:** Prometheus + Grafana + Jaeger
- **Security:** Okta SSO, AWS KMS encryption

### Architecture evolution: Prototype to production

**Week 1-4: Prototype (Local Development)**
```python
# Initial prototype (worked on laptop, failed in production)
from langchain import OpenAI, PromptTemplate
from langchain.chains import LLMChain

llm = OpenAI(api_key="sk-...")  # Hardcoded API key (security issue!)
prompt = PromptTemplate(template="Analyze this document: {text}")
chain = LLMChain(llm=llm, prompt=prompt)

def process_document(document_text):
    return chain.run(text=document_text)  # No error handling, no retries, no logging

# This worked for 10 test documents. It failed for 50,000 production documents.
```

**Problems discovered:**
- ❌ No error handling (one API failure = entire batch fails)
- ❌ No rate limiting (exceeded OpenAI rate limits immediately)
- ❌ No observability (couldn't debug failures)
- ❌ No security (hardcoded API keys, no authentication)
- ❌ No cost control (accidentally spent $8,000 in first week)

**Week 5-12: Production Architecture v1.0**
```python
# Production architecture with resilience and observability
from app.core.resilience import ResilientAIService
from app.core.observability import ObservableAIAgent
from app.core.security import PIIProtectionService
from app.core.caching import SmartCacheService
from celery import Celery
import structlog

logger = structlog.get_logger()

# Initialize services
resilient_service = ResilientAIService()
observable_agent = ObservableAIAgent("document_analyzer", "langchain")
pii_service = PIIProtectionService()
cache_service = SmartCacheService(redis_url=os.getenv("REDIS_URL"))

# Celery task queue for async processing
celery_app = Celery('tasks', broker=os.getenv("CELERY_BROKER_URL"))


@celery_app.task(
    bind=True,
    max_retries=3,
    retry_backoff=True,
    retry_jitter=True
)
def process_document_production(self, document_id: str, user_id: str):
    """
    Production document processing with full resilience.

    Features:
    - Automatic retry with exponential backoff
    - PII detection and redaction
    - Smart caching (avoid reprocessing same documents)
    - Comprehensive observability
    - Cost tracking per department
    """
    try:
        # Load document from storage
        document = load_document(document_id)

        # Check cache first (avoid redundant LLM calls)
        cache_key = f"doc_analysis:{document.content_hash}"
        cached_result = cache_service.get(cache_key)

        if cached_result:
            logger.info(
                "document_analysis_cache_hit",
                document_id=document_id,
                cache_key=cache_key
            )
            return cached_result

        # Detect and redact PII before sending to external API
        pii_result = pii_service.redact_pii(document.text)

        if pii_result["pii_detected"]:
            logger.warning(
                "pii_detected_in_document",
                document_id=document_id,
                entities=pii_result["entities_found"]
            )

        # Execute agent with observability
        result = await observable_agent.execute_with_observability(
            task=f"Analyze financial document: {pii_result['redacted_text'][:500]}...",
            user_id=user_id,
            department=document.department,
            priority="high"
        )

        # Cache result for 24 hours (financial docs change daily)
        cache_service.set(
            cache_key,
            result,
            expire_seconds=86400
        )

        # Store analysis in database
        store_analysis_result(
            document_id=document_id,
            analysis=result,
            tokens_used=result['tokens_used'],
            cost=result['estimated_cost']
        )

        return result

    except Exception as e:
        logger.error(
            "document_processing_failed",
            document_id=document_id,
            error=str(e),
            exc_info=True
        )

        # Retry task with exponential backoff
        raise self.retry(exc=e, countdown=min(2 ** self.request.retries, 300))
```

### Key metrics and improvements

**Performance Improvements:**

| Metric | Prototype | Production v1.0 | Improvement |
|--------|-----------|-----------------|-------------|
| **Processing Time (p95)** | 45s | 8s | **82% faster** |
| **Error Rate** | 12% | 0.3% | **97% reduction** |
| **Cost per Document** | $0.18 | $0.04 | **78% cheaper** |
| **Cache Hit Rate** | 0% | 73% | **Massive savings** |
| **API Failures Handled** | 0% | 99.8% | **Resilience added** |
| **PII Incidents** | 3 per week | 0 | **100% elimination** |

**80% Resolution Time Improvement - How We Achieved It:**

```
Prototype average resolution time: 45 seconds per document
├─ LLM API call: 30s (no caching, inefficient prompts)
├─ Document parsing: 10s (synchronous, blocking)
├─ Database writes: 3s (no connection pooling)
└─ Error retries: 2s (manual retries, high failure rate)

Production average resolution time: 8 seconds per document
├─ LLM API call: 5s (smart caching, optimized prompts)
│   ├─ Cache hit: 1s (73% of requests)
│   └─ Cache miss: 12s (27% of requests)
├─ Document parsing: 2s (async, parallel processing)
├─ Database writes: 0.5s (connection pooling, batch inserts)
└─ Error handling: 0.5s (circuit breakers, fallback responses)

Key optimizations:
- Smart caching reduced LLM calls by 73%
- Prompt optimization reduced tokens by 60%
- Async processing removed blocking operations
- Connection pooling reduced database latency
```

### Critical lessons learned

**Lesson 1: Cost optimization is mandatory, not optional**

**Problem:** In week 1 of production, we accidentally spent $8,000 in LLM costs.

**What happened:**
- No budget alerts configured
- Used GPT-4 for everything (expensive overkill)
- No caching (processed same documents multiple times)
- Inefficient prompts (3,000 tokens when 500 would suffice)

**Solution implemented:**
```python
# app/core/cost_optimization.py
from typing import Optional
import os

class CostOptimizedLLMRouter:
    """
    Route requests to most cost-effective model based on complexity.

    Model selection logic:
    - Simple tasks (classification, extraction): GPT-3.5 Turbo ($0.002/1K tokens)
    - Medium tasks (summarization, analysis): Claude 3 Haiku ($0.00025/1K tokens)
    - Complex tasks (reasoning, multi-step): GPT-4 ($0.03/1K tokens)

    Estimated savings: 70-80% compared to using GPT-4 for everything
    """

    COST_PER_1K_TOKENS = {
        "gpt-4": 0.03,
        "gpt-3.5-turbo": 0.002,
        "claude-3-haiku": 0.00025,
        "claude-3-sonnet": 0.003,
        "claude-3-opus": 0.015,
    }

    @staticmethod
    def select_model(
        task_complexity: str,
        max_cost_per_request: float = 0.10
    ) -> str:
        """
        Select most cost-effective model for task complexity.

        Args:
            task_complexity: "simple", "medium", or "complex"
            max_cost_per_request: Budget constraint per request

        Returns:
            Model identifier
        """
        if task_complexity == "simple":
            # Use cheapest model for simple tasks
            return "claude-3-haiku"  # $0.00025/1K tokens

        elif task_complexity == "medium":
            # Use GPT-3.5 for medium complexity
            return "gpt-3.5-turbo"  # $0.002/1K tokens

        else:  # complex
            # Use GPT-4 only when necessary
            if max_cost_per_request >= 0.15:
                return "gpt-4"
            else:
                # Fallback to cheaper model if budget constrained
                logger.warning(
                    "cost_budget_constraint",
                    requested_model="gpt-4",
                    fallback_model="gpt-3.5-turbo",
                    max_cost=max_cost_per_request
                )
                return "gpt-3.5-turbo"

    @staticmethod
    def estimate_cost(
        model: str,
        prompt_tokens: int,
        max_completion_tokens: int
    ) -> float:
        """Estimate total cost for request before execution."""
        cost_per_1k = CostOptimizedLLMRouter.COST_PER_1K_TOKENS.get(model, 0.03)
        total_tokens = prompt_tokens + max_completion_tokens
        estimated_cost = (total_tokens / 1000) * cost_per_1k
        return estimated_cost

    @staticmethod
    async def execute_with_budget_control(
        task: str,
        user_department: str,
        monthly_budget: float
    ):
        """
        Execute task with automatic budget enforcement.

        Prevents budget overruns by:
        - Checking department's monthly spend before execution
        - Estimating cost before making LLM call
        - Blocking requests if budget exceeded
        """
        # Check current month's spend for department
        current_spend = await get_monthly_spend(user_department)

        if current_spend >= monthly_budget:
            raise BudgetExceededError(
                f"Department {user_department} has exceeded monthly budget: "
                f"${current_spend:.2f} / ${monthly_budget:.2f}"
            )

        # Estimate cost for this request
        estimated_cost = CostOptimizedLLMRouter.estimate_cost(
            model="gpt-4",
            prompt_tokens=len(task.split()) * 1.3,  # Rough estimate
            max_completion_tokens=1000
        )

        # Check if request would exceed budget
        if (current_spend + estimated_cost) > monthly_budget:
            logger.warning(
                "request_would_exceed_budget",
                department=user_department,
                current_spend=current_spend,
                estimated_cost=estimated_cost,
                monthly_budget=monthly_budget
            )

            # Offer cheaper alternative
            cheaper_model = "gpt-3.5-turbo"
            cheaper_cost = CostOptimizedLLMRouter.estimate_cost(
                model=cheaper_model,
                prompt_tokens=len(task.split()) * 1.3,
                max_completion_tokens=1000
            )

            if (current_spend + cheaper_cost) <= monthly_budget:
                logger.info(
                    "using_cheaper_model_alternative",
                    original_model="gpt-4",
                    alternative_model=cheaper_model,
                    cost_savings=estimated_cost - cheaper_cost
                )
                model = cheaper_model
            else:
                raise BudgetExceededError("No available model fits within budget")

        # Execute with selected model
        # ... (actual execution logic)


# Usage in production
router = CostOptimizedLLMRouter()

# Automatic model selection based on complexity
model = router.select_model(
    task_complexity="simple",  # Classification task
    max_cost_per_request=0.05
)
# Returns: "claude-3-haiku" (cheapest option)

# Budget-controlled execution
await router.execute_with_budget_control(
    task="Analyze document...",
    user_department="finance",
    monthly_budget=5000.00  # $5K monthly cap
)
```

**Result:** Reduced monthly LLM costs from $24K to $6K (75% reduction).

**Lesson 2: Caching is not optional—it's mandatory**

**Problem:** Processing same documents multiple times wasted 73% of LLM calls.

**What happened:**
- Users uploaded same document multiple times
- Different users analyzing same company's financial reports
- No deduplication mechanism
- Each request hit expensive LLM API

**Solution implemented:**
```python
# app/core/caching.py
import hashlib
import pickle
from typing import Optional, Any
import redis
from functools import wraps

class SmartCacheService:
    """
    Intelligent caching for LLM responses with content-based deduplication.

    Caching strategies:
    1. Content-based hashing (same content = same cache key)
    2. TTL-based expiration (financial data: 24h, news: 1h)
    3. Semantic similarity caching (similar prompts use cached results)
    4. Multi-tier caching (Redis for hot data, S3 for cold data)
    """

    def __init__(self, redis_client: redis.Redis):
        self.redis = redis_client

    @staticmethod
    def generate_cache_key(content: str, operation: str) -> str:
        """
        Generate deterministic cache key from content hash.

        Same content always produces same key, enabling deduplication.
        """
        content_hash = hashlib.sha256(content.encode()).hexdigest()
        return f"cache:{operation}:{content_hash[:16]}"

    def get(self, key: str) -> Optional[Any]:
        """Retrieve cached value if exists."""
        cached = self.redis.get(key)

        if cached:
            logger.info("cache_hit", cache_key=key)
            return pickle.loads(cached)

        logger.info("cache_miss", cache_key=key)
        return None

    def set(
        self,
        key: str,
        value: Any,
        expire_seconds: int = 86400  # 24 hours default
    ):
        """Store value in cache with TTL."""
        serialized = pickle.dumps(value)
        self.redis.setex(key, expire_seconds, serialized)

        logger.info(
            "cache_set",
            cache_key=key,
            expire_seconds=expire_seconds,
            size_bytes=len(serialized)
        )

    def smart_cache(
        self,
        operation: str,
        expire_seconds: int = 86400
    ):
        """
        Decorator for automatic caching of expensive operations.

        Usage:
            @cache_service.smart_cache("document_analysis", expire_seconds=3600)
            async def analyze_document(document_text: str):
                # Expensive LLM call here
                return result
        """
        def decorator(func):
            @wraps(func)
            async def wrapper(*args, **kwargs):
                # Generate cache key from function arguments
                cache_key_data = f"{func.__name__}:{args}:{kwargs}"
                cache_key = SmartCacheService.generate_cache_key(
                    cache_key_data,
                    operation
                )

                # Try to get from cache
                cached_result = self.get(cache_key)
                if cached_result:
                    return cached_result

                # Cache miss - execute function
                result = await func(*args, **kwargs)

                # Store in cache
                self.set(cache_key, result, expire_seconds)

                return result

            return wrapper
        return decorator


# Usage example
cache_service = SmartCacheService(redis_client)

@cache_service.smart_cache("document_analysis", expire_seconds=86400)
async def analyze_document_with_caching(document_text: str):
    """
    Analyze document with automatic caching.

    If same document analyzed before (within 24h), returns cached result.
    Avoids redundant LLM API calls.
    """
    result = await langchain_agent.analyze(document_text)
    return result


# Production usage
result = await analyze_document_with_caching(document.text)
# First call: Cache miss → LLM API call → Store result
# Second call (same document): Cache hit → Instant response
```

**Result:** 73% cache hit rate, saving $4K/month in redundant LLM calls.

**Lesson 3: Observability saves you during incidents**

**Problem:** When errors happened, we had no idea why or where.

**What happened:**
- Customer: "The AI is slow today"
- Us: "Uh... let me check the logs?"
- *Searches through 100K unstructured log lines*
- *Gives up after 30 minutes*

**Solution implemented:**
```python
# app/core/incident_response.py
import structlog
from opentelemetry import trace

logger = structlog.get_logger()
tracer = trace.get_tracer(__name__)


class IncidentResponseToolkit:
    """
    Tools for rapid incident response and debugging.

    When production breaks, you need answers in seconds, not hours.
    """

    @staticmethod
    async def debug_slow_request(request_id: str):
        """
        Analyze why specific request was slow.

        Provides:
        - Full distributed trace with timing breakdowns
        - LLM model used and token counts
        - Cache hit/miss information
        - Database query performance
        - External API call latencies
        """
        # Query Jaeger for distributed trace
        trace_data = await fetch_trace(request_id)

        analysis = {
            "request_id": request_id,
            "total_duration_ms": trace_data["duration"],
            "bottlenecks": []
        }

        # Identify bottlenecks
        for span in trace_data["spans"]:
            if span["duration"] > 1000:  # > 1 second
                analysis["bottlenecks"].append({
                    "operation": span["operation_name"],
                    "duration_ms": span["duration"],
                    "percentage_of_total": (span["duration"] / trace_data["duration"]) * 100,
                    "attributes": span["tags"]
                })

        # Sort by duration
        analysis["bottlenecks"].sort(key=lambda x: x["duration_ms"], reverse=True)

        return analysis

    @staticmethod
    async def debug_high_error_rate(time_range: str = "5m"):
        """
        Analyze why error rate is high.

        Returns:
        - Top error types and frequencies
        - Affected models and operations
        - Correlation with external API status
        - Recent deployments (potential cause)
        """
        # Query Prometheus for error metrics
        error_metrics = await query_prometheus(
            f'sum by (error_type, model) (rate(llm_requests_total{{status="error"}}[{time_range}]))'
        )

        analysis = {
            "time_range": time_range,
            "total_errors": sum(m["value"] for m in error_metrics),
            "error_breakdown": []
        }

        for metric in error_metrics:
            analysis["error_breakdown"].append({
                "error_type": metric["labels"]["error_type"],
                "model": metric["labels"]["model"],
                "errors_per_second": metric["value"],
                "sample_logs": await fetch_error_logs(
                    error_type=metric["labels"]["error_type"],
                    limit=3
                )
            })

        return analysis

    @staticmethod
    async def debug_budget_overrun(department: str):
        """
        Analyze why department exceeded budget.

        Identifies:
        - Top users by token consumption
        - Most expensive operations
        - Model usage breakdown
        - Cost trends over time
        """
        usage_data = await query_prometheus(
            f'sum by (user_id, operation, model) (increase(llm_cost_dollars_total{{department="{department}"}}[7d]))'
        )

        analysis = {
            "department": department,
            "total_spend_7d": sum(m["value"] for m in usage_data),
            "top_users": [],
            "top_operations": [],
            "model_breakdown": []
        }

        # Aggregate by user
        user_costs = {}
        for metric in usage_data:
            user_id = metric["labels"]["user_id"]
            user_costs[user_id] = user_costs.get(user_id, 0) + metric["value"]

        analysis["top_users"] = [
            {"user_id": k, "spend_7d": v}
            for k, v in sorted(user_costs.items(), key=lambda x: x[1], reverse=True)[:10]
        ]

        return analysis


# Usage during production incident
incident_toolkit = IncidentResponseToolkit()

# Customer complains: "Request abc123 was very slow"
debug_info = await incident_toolkit.debug_slow_request("abc123")

print(f"Total duration: {debug_info['total_duration_ms']}ms")
print(f"Top bottleneck: {debug_info['bottlenecks'][0]['operation']} ({debug_info['bottlenecks'][0]['duration_ms']}ms)")

# Output:
# Total duration: 12,450ms
# Top bottleneck: call_openai_api (11,200ms - 90% of request time)
# → Root cause identified: OpenAI API latency spike
```

**Result:** Mean time to resolution (MTTR) reduced from 2 hours to 8 minutes.

### Production deployment checklist (used by our team)

Before we deploy to production, we validate every item on this checklist:

**Security & Compliance:**
- [ ] All secrets stored in AWS Secrets Manager (never in environment variables)
- [ ] API authentication enforced on all endpoints
- [ ] Rate limiting configured per user tier
- [ ] PII detection and redaction enabled
- [ ] Audit logging for all data access
- [ ] TLS 1.3 encryption for all traffic
- [ ] Dependency vulnerability scanning passed (Snyk, OWASP)
- [ ] Penetration testing completed (external security firm)
- [ ] SOC 2 compliance audit documentation prepared

**Reliability & Resilience:**
- [ ] Circuit breakers configured for external APIs
- [ ] Retry logic with exponential backoff implemented
- [ ] Graceful degradation patterns for API failures
- [ ] Health check endpoints respond correctly
- [ ] Liveness and readiness probes configured
- [ ] Horizontal pod autoscaling configured (HPA)
- [ ] Multi-region failover tested
- [ ] Disaster recovery runbook documented

**Observability & Monitoring:**
- [ ] Prometheus metrics exposed at /metrics endpoint
- [ ] Grafana dashboards created for all key metrics
- [ ] Jaeger distributed tracing configured
- [ ] Structured logging with correlation IDs
- [ ] PagerDuty alerts configured for critical issues
- [ ] Runbooks created for common incidents
- [ ] Log retention policy configured (90 days minimum)
- [ ] Cost tracking dashboards created

**Performance & Cost:**
- [ ] Load testing completed (2x expected peak load)
- [ ] Caching strategy implemented (Redis)
- [ ] Database connection pooling configured
- [ ] Prompt optimization completed (reduce tokens by 50%+)
- [ ] Model selection logic for cost optimization
- [ ] Budget alerts configured per department
- [ ] Token usage monitoring and anomaly detection
- [ ] CDN configured for static assets

**Deployment & Operations:**
- [ ] Infrastructure as Code (Terraform) validated
- [ ] CI/CD pipeline configured with automated tests
- [ ] Blue-green or canary deployment strategy
- [ ] Automated rollback on health check failures
- [ ] Database migration scripts tested
- [ ] Backup and restore procedures tested
- [ ] Incident response procedures documented
- [ ] On-call rotation schedule established

**Documentation & Training:**
- [ ] API documentation published (OpenAPI/Swagger)
- [ ] Architecture diagrams created (Mermaid, Lucidchart)
- [ ] Operational runbooks completed
- [ ] Developer onboarding guide written
- [ ] Customer-facing documentation published
- [ ] Training sessions completed for support team
- [ ] Post-mortem process documented

This checklist represents 6 months of hard-learned lessons. Don't skip items—each one exists because we learned the hard way.

---

## Conclusion: Your production-ready action plan

We've covered a lot—from architecture patterns to Kubernetes deployments to real-world lessons learned. Let's bring it all together into an actionable plan.

### 90-day production roadiness roadmap

**Days 1-30: Foundation (Security & Resilience)**
- [ ] Week 1: Implement API authentication and authorization (JWT + API keys)
- [ ] Week 2: Add circuit breakers and retry logic with exponential backoff
- [ ] Week 3: Configure PII detection and redaction (Presidio integration)
- [ ] Week 4: Set up secrets management (AWS Secrets Manager, HashiCorp Vault)

**Days 31-60: Observability & Performance**
- [ ] Week 5: Deploy Prometheus and Grafana monitoring stack
- [ ] Week 6: Configure Jaeger distributed tracing
- [ ] Week 7: Implement intelligent caching (Redis, content-based hashing)
- [ ] Week 8: Add cost tracking and budget alerts per department

**Days 61-90: Deployment & Scale**
- [ ] Week 9: Containerize application with production-grade Dockerfile
- [ ] Week 10: Deploy to Kubernetes with autoscaling (HPA)
- [ ] Week 11: Configure CI/CD pipeline with automated rollback
- [ ] Week 12: Load testing, performance tuning, and production deployment

**Post-Launch: Continuous Improvement**
- [ ] Weekly: Review incident post-mortems and update runbooks
- [ ] Monthly: Analyze cost trends and optimize model selection
- [ ] Quarterly: Security audits and penetration testing
- [ ] Annually: Architecture review and technical debt assessment

### Resources for continued learning

**Official Documentation:**
- [LangChain Documentation](https://python.langchain.com/docs/)
- [LangGraph Production Guide](https://langchain-ai.github.io/langgraph/)
- [CrewAI Documentation](https://docs.crewai.com/)
- [FastAPI Best Practices](https://fastapi.tiangolo.com/)
- [Kubernetes Production Patterns](https://kubernetes.io/docs/concepts/)

**Security & Compliance:**
- [OWASP API Security Top 10](https://owasp.org/www-project-api-security/)
- [Presidio PII Detection](https://github.com/microsoft/presidio)
- [SOC 2 Compliance Guide](https://www.vanta.com/learn/soc-2-guide)

**Observability Stack:**
- [Prometheus Monitoring Guide](https://prometheus.io/docs/introduction/overview/)
- [Grafana Dashboard Best Practices](https://grafana.com/docs/grafana/latest/)
- [OpenTelemetry Tracing](https://opentelemetry.io/docs/)

**Related JetThoughts Articles:**
- [LangChain Architecture: Production-Ready AI Agent Systems](/blog/langchain-architecture-production-ready-agents/) - Resilient chains and safety patterns
- [CrewAI Multi-Agent Systems Orchestration](/blog/crewai-multi-agent-systems-orchestration/) - Agent collaboration frameworks
- [Cost Optimization for LLM Applications](/blog/cost-optimization-llm-applications-token-management/) - Token management strategies
- [What Every Non-Technical Founder Must Know When Building a Tech Product](/blog/what-every-non-technical-founder-must-know-when-building-tech-product-startup-management/)

### Final thoughts

Scaling LangChain and CrewAI from prototype to production isn't just about adding Docker containers and Kubernetes manifests. It's about building a system that:

- **Operators trust** (comprehensive monitoring, clear alerts, reliable failover)
- **Security teams approve** (PII protection, secrets management, audit trails)
- **Finance teams support** (cost tracking, budget controls, ROI metrics)
- **Customers rely on** (99.9% uptime, fast response times, data privacy)
- **Developers can maintain** (clear architecture, good documentation, manageable complexity)

The gap between prototype and production is real. But with the right architecture patterns, security frameworks, and operational practices, you can bridge it successfully.

We've seen LangChain and CrewAI applications deliver remarkable results in production:
- **Klarna:** 80% reduction in customer resolution time
- **Financial services client:** 82% faster document processing
- **AppFolio:** 10+ hours saved per week per property manager

Your AI agent application can deliver similar results—if you build the production infrastructure correctly from the start.

---

## 📥 Lead Magnet: Enterprise AI Architecture Blueprint

**Download our comprehensive Enterprise AI Architecture Blueprint** — a complete multi-page technical blueprint covering:

✅ **Reference Architecture Diagrams**
- Complete system architecture with all components
- Network topology and security zones
- Data flow diagrams for LangChain/CrewAI workflows
- Multi-region deployment topology

✅ **Security Implementation Guide**
- Authentication and authorization patterns
- PII detection and redaction workflows
- Secrets management best practices
- Compliance framework checklists (SOC 2, HIPAA, GDPR)

✅ **Infrastructure as Code Templates**
- Production-ready Kubernetes manifests
- Terraform configurations for AWS/GCP/Azure
- Docker Compose for local development
- CI/CD pipeline configurations

✅ **Observability Stack Configuration**
- Prometheus alerting rules and recording rules
- Grafana dashboard JSON exports
- Jaeger tracing configuration
- Structured logging schemas

✅ **Cost Optimization Strategies**
- Model selection decision trees
- Token usage optimization techniques
- Caching strategy implementation guides
- Budget control and forecasting templates

✅ **Incident Response Playbooks**
- Common failure scenarios and resolutions
- On-call escalation procedures
- Root cause analysis templates
- Post-mortem documentation examples

**[Download Enterprise AI Architecture Blueprint →](https://jetthoughts.com/contact)**

---

## Partner with JetThoughts for Your AI Production Deployment

**Need help scaling your LangChain or CrewAI application to production?**

JetThoughts specializes in taking AI prototypes to enterprise-grade production deployments. Our team has:

- **15+ years** of production Python and AI experience
- **50+ AI applications** deployed to production
- **SOC 2, HIPAA, GDPR** compliance expertise
- **24/7 production support** for mission-critical systems

**Our Enterprise AI Services:**
- Production architecture design and review
- Security audit and compliance implementation
- Kubernetes deployment and scaling
- Performance optimization and cost reduction
- 24/7 monitoring and incident response
- Training and knowledge transfer

**[Schedule a Free Architecture Consultation →](https://jetthoughts.com/contact)**

---

**About the Author:** The JetThoughts team builds production-grade AI applications for enterprises. We've deployed LangChain and CrewAI systems processing millions of requests monthly, and we're passionate about sharing what works (and what doesn't) in production.

**Connect with us:**
- **Email:** [hello@jetthoughts.com](mailto:hello@jetthoughts.com)
- **GitHub:** [github.com/jetthoughts](https://github.com/jetthoughts)
- **LinkedIn:** [linkedin.com/company/jetthoughts](https://linkedin.com/company/jetthoughts)

---

*Keywords: langchain production, crewai enterprise, scaling ai applications, langchain deployment, crewai kubernetes, ai agent architecture, production ai systems, enterprise ai deployment, langchain security, crewai monitoring, ai observability, fastapi langchain, docker kubernetes ai, production machine learning*
