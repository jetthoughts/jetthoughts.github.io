# Makefile — JetThoughts Site
#
# APM declares MCP dependencies in apm.yml (what agents need).
# This Makefile RUNS the persistent backends via docker-compose + brew.
# Stdio-based MCPs are auto-started by the AI tool — no target needed.
#
# Quick start:
#   apm install      # Install agent primitives (instructions, agents, prompts)
#   make mcp-up      # Start persistent MCP backends (via docker-compose)
#   make mcp-status  # Verify everything is running
#   code .           # Open in Claude/Copilot/Cursor/etc.

.PHONY: mcp-up mcp-down mcp-status help

help:
	@echo "JetThoughts Site — Development Commands"
	@echo ""
	@echo "  make mcp-up       Start all MCP backends (ollama + docker compose)"
	@echo "  make mcp-down     Stop Docker-based backends"
	@echo "  make mcp-status   Health check all MCP backends"
	@echo ""
	@echo "Docker services defined in compose.mcp.yml"
	@echo "Ollama managed via brew services"
	@echo "MCP servers declared in apm.yml → dependencies.mcp"

mcp-up:
	@echo "==> Starting MCP backends..."
	@echo ""
	# Ollama — local LLM/embeddings via Homebrew
	@brew services start ollama 2>/dev/null && echo "   ✓ ollama started" || echo "   ! ollama not installed — run: brew install ollama"
	@echo ""
	# Docker-based MCP services (searxng, milvus, etcd, minio)
	@docker-compose -f compose.mcp.yml up -d
	@echo ""
	@$(MAKE) mcp-status

mcp-down:
	@echo "==> Stopping MCP backends..."
	@docker-compose -f compose.mcp.yml down
	@echo "   ollama: left running (brew services stop ollama to stop)"
	@echo "==> MCP backends stopped"

mcp-status:
	@echo "==> MCP Backend Status"
	@echo ""
	@printf "   %-14s " "ollama :11434"; \
		curl -s -o /dev/null -w "%{http_code}" http://localhost:11434/api/tags 2>/dev/null | grep -q 200 && echo "✓ running" || echo "✗ down"
	@printf "   %-14s " "searxng :8080"; \
		curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/healthz 2>/dev/null | grep -q 200 && echo "✓ running" || echo "✗ down"
	@printf "   %-14s " "milvus :19530"; \
		nc -z -w 2 localhost 19530 2>/dev/null && echo "✓ running" || echo "✗ down"
	@echo ""
