# Per-Repo MCP Setup

Persistent MCP backends (searxng, milvus) run as Docker services defined
in `compose.mcp.yml`. One `make mcp-up` starts everything.

## Prerequisites

- Docker (Desktop or colima)
- Homebrew (for ollama)

## One-Time Setup

```bash
# Install system dependencies
brew bundle                    # installs ollama, bun, hugo, rbenv, ruby-build

# Pull Docker images (optional — compose will pull on first up)
docker compose -f compose.mcp.yml pull
```

## Daily Use

```bash
make mcp-up      # Start ollama (brew) + searxng/milvus (docker compose)
make mcp-status  # Health check
make mcp-down    # Stop Docker services
```

## Architecture

```
apm.yml                          # Declares all MCP servers
compose.mcp.yml                  # Docker services: searxng, milvus, etcd, minio
Makefile (mcp-up/mcp-down)       # Orchestration: brew + docker compose
Brewfile                         # System deps: ollama, bun, hugo, rbenv
```

- **Stdio MCPs** (claude-context, context7, brave-search, etc.): auto-started by the AI tool's MCP client. No infrastructure needed.
- **Ollama**: managed via `brew services`. Started by `brew bundle` (restart_service: true).
- **SearXNG + Milvus**: Docker services in `compose.mcp.yml`. Started by `make mcp-up`.
