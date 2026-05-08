---
title: "CrewAI Hierarchical Agents: Manager-Worker Orchestration"
description: "Build hierarchical CrewAI crews with a manager agent delegating to specialized workers. Code examples for orchestration, task routing, and current patterns."
date: "2026-05-08"
created_at: "2025-10-15T17:20:00Z"
draft: false
tags:
- ai
- crewai
- python
- automation
- agents
canonical_url: https://jetthoughts.com/blog/crewai-multi-agent-systems-orchestration/
slug: crewai-multi-agent-systems-orchestration
cover_image: "cover.png"
metatags:
  description: "Build scalable multi-agent AI systems with CrewAI. Step-by-step tutorial covering agent specialization, task orchestration, and production deployment patterns for customer support, content creation, and financial analysis."
  image: cover.png
---

CrewAI is a Python framework for building manager-worker agent systems. You define agents by role, goal, and backstory, then assemble them into "crews" that run sequential or hierarchical workflows. This post walks through current CrewAI patterns for building production-grade crews, with code for three real workflows (customer support, content pipelines, financial analysis) and a FastAPI deployment example.

## The multi-agent problem

A single LLM call works for "summarize this paragraph". It struggles when one request needs four different kinds of expertise: sentiment analysis, knowledge retrieval, response drafting, and compliance review. You end up writing orchestration code that handles state between steps, retries, and prompt injection between calls.

CrewAI replaces that orchestration code with role-based agents that run in a coordinator. You describe the team; the framework runs the workflow.

## CrewAI's Core Concepts: Agents, Tasks, and Crews

CrewAI introduces three fundamental building blocks:

**Agents** represent specialized team members with distinct roles, goals, and tools. Each agent has:
- A role that defines their expertise (e.g., "Research Analyst", "Content Writer")
- A goal describing what they aim to achieve
- A backstory providing context that shapes their behavior
- Tools they can use to accomplish their tasks

**Tasks** are specific assignments with clear deliverables. Each task includes:
- A description of what needs to be done
- The agent responsible for execution
- Expected output format
- Context from previous tasks if needed

**Crews** are teams of agents working together on a workflow. A crew coordinates:
- Multiple agents with complementary skills
- Sequential or hierarchical task execution
- Information flow between tasks
- Final output aggregation

This structure maps naturally to real-world workflows. Instead of writing complex orchestration code, you define roles and responsibilities - CrewAI handles the coordination.

## Setting Up CrewAI: Installation and Environment

CrewAI requires Python 3.10 or higher. Start by creating a virtual environment:

```bash
python3 -m venv crewai-env
source crewai-env/bin/activate  # On Windows: crewai-env\Scripts\activate
```

Install CrewAI with essential dependencies:

```bash
pip install crewai crewai-tools python-dotenv
```

Create a `.env` file for API keys:

```bash
OPENAI_API_KEY=your_openai_key_here
# Alternative: Use local models with Ollama
# OLLAMA_BASE_URL=http://localhost:11434
```

Current CrewAI supports OpenAI, Anthropic, and local models via Ollama. For production, GPT-4-class models handle complex reasoning; faster, cheaper models handle routine tasks like formatting or simple lookups.

## Hello World: Your First CrewAI Multi-Agent System

Start with this 10-line example to understand the core CrewAI pattern:

```python
from crewai import Agent, Task, Crew

# Create a research agent
researcher = Agent(
    role="Research Analyst",
    goal="Find and summarize information about topics",
    backstory="You are a meticulous analyst who turns unfamiliar topics into clear briefs."
)

# Define a task
task = Task(
    description="Research LangChain's key features and use cases",
    agent=researcher,
    expected_output="A markdown summary with bullet-point findings"
)

# Create crew and execute
crew = Crew(agents=[researcher], tasks=[task])
result = crew.kickoff()  # Returns research summary
```

### Adding Agent Collaboration (25 lines)

Now let's add a second agent to demonstrate collaboration:

```python
from crewai import Agent, Task, Crew, Process

# Agent 1: Research
researcher = Agent(
    role="Research Analyst",
    goal="Gather technical information",
    backstory="You collect primary-source notes and cite where each fact came from."
)

# Agent 2: Content Writer
writer = Agent(
    role="Technical Writer",
    goal="Transform research into clear documentation",
    backstory="You translate dense research into tutorials a junior dev can follow."
)

# Task 1: Research (completed first)
research_task = Task(
    description="Research CrewAI multi-agent capabilities",
    agent=researcher,
    expected_output="A markdown summary with bullet-point findings"
)

# Task 2: Writing (receives research_task output via context)
writing_task = Task(
    description="Write a tutorial based on research findings",
    agent=writer,
    context=[research_task],  # Automatically receives researcher's output
    expected_output="A 600-word markdown tutorial with code examples"
)

crew = Crew(
    agents=[researcher, writer],
    tasks=[research_task, writing_task],
    process=Process.sequential  # Tasks execute in order
)

result = crew.kickoff()
```

> **📚 Complete 4-Agent System**: See customer support automation example demonstrating sentiment analysis → knowledge retrieval → response composition → compliance review in a production workflow (60 lines).

This example demonstrates several key CrewAI patterns:

- **Agent specialization**: each agent has a focused role with an appropriate LLM. The sentiment analyzer uses GPT-4 for nuanced emotion detection; the knowledge agent uses a smaller model for routine lookups.
- Task context flow: the `context` parameter passes outputs between tasks. The response composer receives both the sentiment analysis and the research findings.
- Sequential processing: `process=Process.sequential` runs tasks in order, so each agent builds on previous work.
- Tool integration: the knowledge agent uses `SerperDevTool` for web search and `ScrapeWebsiteTool` for extracting docs.

## Production example 2: Automated content pipeline

Content creation involves research, writing, editing, and SEO optimization - each needing different expertise. Here's a 4-agent content pipeline:

```python
from crewai import Agent, Task, Crew, Process
from crewai_tools import SerperDevTool, ScrapeWebsiteTool

# Define specialized agents
researcher = Agent(
    role="Content Research Specialist",
    goal="Gather data, statistics, and expert insights",
    backstory="You dig through primary sources and cite every statistic you surface.",
    tools=[SerperDevTool(), ScrapeWebsiteTool()],
    llm="openai/gpt-4o"
)

writer = Agent(
    role="Senior Content Writer",
    goal="Craft engaging, SEO-optimized articles",
    backstory="You turn research into reader-friendly drafts with a clear point of view.",
    llm="openai/gpt-4o"
)

editor = Agent(
    role="Editorial Director",
    goal="Ensure quality standards and brand voice",
    backstory="You enforce house style and cut anything that does not earn its place.",
    llm="openai/gpt-4o-mini"
)

seo_specialist = Agent(
    role="SEO Optimization Expert",
    goal="Optimize content for search engines",
    backstory="You add metadata and headings without breaking the prose.",
    llm="openai/gpt-4o-mini"  # Cost-effective for routine optimization
)

# Define sequential workflow
def create_content_pipeline(topic: str, keywords: list):
    research_task = Task(
        description=f"Research '{topic}' with recent data and expert quotes",
        agent=researcher,
        expected_output="A markdown research brief with cited sources and key statistics"
    )

    writing_task = Task(
        description=f"Write article on '{topic}' using research findings",
        agent=writer,
        context=[research_task],  # Receives research output
        expected_output="A 1200-word markdown article with intro, body, and conclusion"
    )

    editing_task = Task(
        description="Edit for clarity, accuracy, and engagement",
        agent=editor,
        context=[writing_task],
        expected_output="The same article, edited and ready for publishing"
    )

    seo_task = Task(
        description=f"Add meta tags, optimize headers for: {', '.join(keywords)}",
        agent=seo_specialist,
        context=[editing_task],
        expected_output="The article with meta description, title tag, and optimized headings"
    )

    crew = Crew(
        agents=[researcher, writer, editor, seo_specialist],
        tasks=[research_task, writing_task, editing_task, seo_task],
        process=Process.sequential  # Each task builds on previous output
    )

    return crew.kickoff()

# Usage
article = create_content_pipeline(
    topic="Building Scalable Microservices with Python FastAPI",
    keywords=["fastapi microservices", "python microservices"]
)
```

> **📚 Full Implementation**: See content pipeline with metadata tracking for production version with publishing metadata, error handling, and word count targets (180 lines).

This content pipeline shows several advanced CrewAI patterns:

- Sequential dependency chain: each agent builds on the previous output - research → writing → editing → SEO.
- Specialized tools: only the researcher gets web search; the other agents focus on their core job.
- Quality gates: the editor reviews writer output before SEO so search optimization doesn't compromise quality.
- Metadata tracking: the pipeline captures generation context so you can audit and improve later.

## Production example 3: Financial analysis and reporting

Financial analysis needs data gathering, calculation, risk assessment, and report generation. Here's a crew that shares the same data dependency across two analysts before final synthesis:

```python
from crewai import Agent, Task, Crew, Process
from crewai_tools import SerperDevTool

# Define specialized financial agents
data_collector = Agent(
    role="Financial Data Analyst",
    goal="Gather accurate financial data from SEC filings",
    backstory="You pull primary-source numbers from filings and never trust a secondary aggregator.",
    tools=[SerperDevTool()],
    llm="openai/gpt-4o"
)

quant_analyst = Agent(
    role="Quantitative Analyst",
    goal="Calculate ratios, identify trends, assess valuation",
    backstory="You translate financial statements into ratios and valuation models.",
    llm="openai/gpt-4o"
)

risk_analyst = Agent(
    role="Risk Assessment Specialist",
    goal="Evaluate financial risks and mitigation strategies",
    backstory="You stress-test assumptions and surface what would break the thesis.",
    llm="openai/gpt-4o"
)

report_writer = Agent(
    role="Financial Report Writer",
    goal="Synthesize analysis into executive summaries",
    backstory="You write for executives who want the punchline first and the math on request.",
    llm="openai/gpt-4o"
)

# Define workflow
def create_financial_analysis(ticker: str):
    data_task = Task(
        description=f"Collect {ticker} earnings, ratios, and material events",
        agent=data_collector,
        expected_output="A markdown table of key financials and a list of material events"
    )

    # These tasks run after data collection; in hierarchical mode the manager
    # can dispatch them concurrently via tool calls.
    quant_task = Task(
        description=f"Analyze {ticker} ratios and valuation",
        agent=quant_analyst,
        context=[data_task],
        expected_output="A short memo with valuation multiples and trend commentary"
    )

    risk_task = Task(
        description=f"Assess {ticker} market, credit, and operational risks",
        agent=risk_analyst,
        context=[data_task],
        expected_output="A bullet-point risk register with severity ratings"
    )

    # Final synthesis
    report_task = Task(
        description=f"Create executive report with buy/hold/sell recommendation",
        agent=report_writer,
        context=[data_task, quant_task, risk_task],  # Receives all analysis
        expected_output="A one-page executive memo with a buy/hold/sell call and rationale"
    )

    crew = Crew(
        agents=[data_collector, quant_analyst, risk_analyst, report_writer],
        tasks=[data_task, quant_task, risk_task, report_task],
        process=Process.sequential  # Use Process.hierarchical to let a manager dispatch concurrent tool calls
    )

    return crew.kickoff()

# Usage
report = create_financial_analysis("MSFT")
```

> **📚 Full Implementation**: See financial analysis with concurrent tool dispatch for production version with hierarchical execution, detailed task descriptions, and risk matrices (151 lines).

This example introduces three patterns:

- Concurrent tool dispatch in hierarchical mode: the quant and risk analysts share the same data dependency, and a manager agent can fan out their tool calls concurrently to cut wall-clock time.
- Data quality first: the data collector verifies sources before downstream agents touch the numbers.
- Executive communication: the report writer translates technical analysis into buy/hold/sell language for non-technical stakeholders.

## CrewAI vs LangChain: Architectural Comparison

Many developers evaluate CrewAI against LangChain when building multi-agent systems. Here's an honest comparison based on production experience:

| **Dimension** | **CrewAI** | **LangChain** |
|---------------|------------|---------------|
| **Primary Focus** | Role-based multi-agent teams | Flexible LLM application chains |
| **Learning Curve** | Moderate (role-centric) | Steep (highly modular) |
| **Best Use Case** | Collaborative agent workflows | General LLM applications |
| **Agent Coordination** | Built-in crew management | Manual orchestration required |
| **Tool Integration** | Streamlined agent tools | Extensive tool ecosystem |
| **Code Verbosity** | Less boilerplate | More configuration needed |
| **Community Maturity** | Newer, growing fast | Established, large community |
| **Production Readiness** | Good for specific use cases | Battle-tested across industries |

When CrewAI is the right pick:
- You have multiple specialized agents collaborating on the same workflow
- Your problem maps to team roles (researcher, writer, reviewer)
- You want less orchestration code and more focus on agent behavior
- You're building domain-specific AI (legal, medical, financial)

When LangChain is the right pick:
- You need maximum flexibility in LLM application architecture
- Your tools don't fit a team metaphor
- You need deep integration with vector databases and external services
- You want a mature ecosystem with thousands of examples

For many apps the right answer is both: use LangChain for tool chains and data pipelines, then wrap specialized agents in CrewAI crews for coordination.

## Role design patterns

Five patterns that consistently produce better results:

1. Single responsibility: each agent does one thing. Don't create a "Research and Writing Agent" - split it. Narrow focus produces higher-quality output.
2. Complementary skills: design teams where skills cover each other's gaps. A content crew needs researchers, writers, and editors.
3. Tool alignment: only give tools to agents that need them. Research agents get search tools; analysts get calculation tools.
4. Backstory matters: "You're a cautious compliance officer" produces very different output than "You're an innovative growth hacker." Encode domain expertise and risk tolerance in the backstory.
5. Model selection by role: not every agent needs the largest model. Use big models for hard reasoning (financial, legal); use smaller models for routine work (formatting, simple search). In our experience, swapping editor and SEO from gpt-4o to gpt-4o-mini cut per-task cost by roughly half on benchmark crews.

## Sequential and hierarchical

CrewAI supports two execution modes:

Sequential. Tasks run in order, each receiving context from earlier ones. Use when each step depends on the previous output and you need predictable flow with quality control between stages. Example: Research -> Write -> Edit -> Publish.

Hierarchical. A manager agent delegates to workers and makes dynamic execution decisions. Use when the workflow adapts based on intermediate results, task complexity needs intelligent prioritization, or coordination logic is non-trivial. Example: a project-manager agent that assigns research tasks to specialists by topic, then coordinates report assembly.

> CrewAI supports `Process.sequential` and `Process.hierarchical` only. There is no parallel process. `Process.consensual` was on the roadmap but is not yet released. For task-level concurrency inside hierarchical mode, the manager agent dispatches concurrent tool calls.

Current CrewAI improved delegation tracking and context passing between managers and workers in hierarchical mode.

## Production Deployment: FastAPI Integration Pattern

For production deployment, wrap CrewAI crews in FastAPI endpoints for async processing:

```python
from fastapi import FastAPI, BackgroundTasks
from pydantic import BaseModel
import uuid

app = FastAPI(title="CrewAI Multi-Agent API")

class AnalysisRequest(BaseModel):
    topic: str
    keywords: list[str]

jobs = {}  # Use Redis for production

def run_crew_analysis(job_id: str, request: AnalysisRequest):
    try:
        result = create_content_pipeline(
            topic=request.topic,
            keywords=request.keywords
        )
        jobs[job_id]["status"] = "completed"
        jobs[job_id]["result"] = result
    except Exception as e:
        jobs[job_id]["status"] = "failed"
        jobs[job_id]["error"] = str(e)

@app.post("/analyze")
async def create_analysis(request: AnalysisRequest, background_tasks: BackgroundTasks):
    job_id = str(uuid.uuid4())
    jobs[job_id] = {"status": "queued"}

    background_tasks.add_task(run_crew_analysis, job_id, request)
    return {"job_id": job_id, "status": "queued"}

@app.get("/results/{job_id}")
async def get_results(job_id: str):
    return jobs.get(job_id, {"error": "Job not found"})
```

> **📚 Full Implementation**: See FastAPI deployment with Redis for production version with job queues, error tracking, and distributed processing (83 lines).

This pattern gives you async processing (long-running crews don't block API requests), job tracking (clients can poll for results), error handling with detailed messages, and an easy path to add Redis and Celery for distributed processing.

## Performance Optimization and Cost Management

Multi-agent systems can become expensive if not optimized. Here are production techniques for managing costs:

1. **Model selection by role.** Use a large model for complex reasoning and a smaller model for routine ops. A content crew might use gpt-4o for the researcher and writer, and gpt-4o-mini for the editor and SEO specialist. In our experience, swapping editor and SEO from gpt-4o to gpt-4o-mini cut per-task cost by roughly half on benchmark crews.

2. Context window management. Don't pass entire previous outputs to every agent. The SEO specialist doesn't need the full research report - just the final article. CrewAI's `context` parameter lets you scope this precisely.

3. Caching and deduplication. Cache research results across similar requests. If multiple users ask about "Python best practices", cache the researcher output for 24 hours.

4. Rate limiting. Implement per-user quotas to prevent abuse. A simple pattern:

```python
from functools import wraps
from collections import defaultdict
from datetime import datetime, timedelta

rate_limits = defaultdict(list)

def rate_limit(max_requests: int, window_minutes: int):
    def decorator(func):
        @wraps(func)
        async def wrapper(user_id: str, *args, **kwargs):
            now = datetime.now()
            cutoff = now - timedelta(minutes=window_minutes)

            # Clean old requests
            rate_limits[user_id] = [
                ts for ts in rate_limits[user_id]
                if ts > cutoff
            ]

            if len(rate_limits[user_id]) >= max_requests:
                raise HTTPException(429, "Rate limit exceeded")

            rate_limits[user_id].append(now)
            return await func(user_id, *args, **kwargs)
        return wrapper
    return decorator
```

## Debugging multi-agent systems

Multi-agent debugging differs from regular debugging because failures can happen in agent coordination, not just code execution. Three common issues:

**Agent role confusion.** Agents sometimes step outside their role and try tasks assigned to other agents. Fix this with explicit backstory constraints:

```python
# Bad - vague role definition
agent = Agent(
    role="Content Agent",
    goal="Handle content tasks",
    backstory="You handle content."
)

# Good - clear boundaries
agent = Agent(
    role="Content Writer",
    goal="Write article drafts only - do NOT edit or optimize for SEO",
    backstory="You write first drafts. Your work goes to editors for review."
)
```

**Context overload.** Passing too much context between tasks confuses agents and wastes tokens. Be selective:

```python
# Bad - passing entire chain
task = Task(
    description="Summarize the project status",
    agent=writer,
    expected_output="A short status update",
    context=[task1, task2, task3, task4]  # Too much information
)

# Good - only relevant context
task = Task(
    description="Summarize the project status",
    agent=writer,
    expected_output="A short status update",
    context=[task3]  # Only immediate dependency
)
```

**Tool hallucination.** Agents sometimes claim to use tools they don't have. Prevent this by listing the actual tools in the backstory:

```python
agent = Agent(
    role="Researcher",
    goal="Gather public information from the web",
    backstory="You have access to web search and web scraping tools. You do NOT have access to internal databases or proprietary data sources.",
    tools=[SerperDevTool(), ScrapeWebsiteTool()]
)
```

## Related reading

- [Building an effective dev team](/blog/building-an-effective-dev-team-strategies/): the role design problem in CrewAI is the same problem you face when staffing engineering teams. Clear roles, complementary skills, and a coordinator beats a pile of generalists.
- [Our MVP team structure](/blog/our-mvp-team-structure-startup-management/): how we staff small product teams - same principle as a CrewAI crew, applied to humans.

## The bottom line

Multi-agent systems are a shift from single-model applications to coordinated AI teams. CrewAI makes that orchestration cheap to build: define roles, hand off context between tasks, pick the cheapest model that does each job, and instrument every external call. As LLMs get more capable, the bottleneck moves from model intelligence to coordination - and that's exactly what CrewAI handles.

## Need help shipping production agents?

We help startups build agent systems that survive production traffic - from prototype crews to FastAPI deployments with cost monitoring and rate limits. If you're stuck on a multi-agent prototype that won't scale, talk to us.

<a class="cta-link" href="https://jetthoughts.com/services/">Book a 30-minute architecture review</a>
