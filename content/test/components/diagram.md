---
title: "Diagram Test Page"
date: 2024-01-15T10:00:00Z
draft: false
---

# Test Page for Diagram Rendering

This page tests Mermaid diagram rendering.

## Simple Mermaid Flowchart

```mermaid
graph TD
    A[Start] --> B{Is it working?}
    B -->|Yes| C[Great!]
    B -->|No| D[Debug]
    D --> A
```

## Mermaid Sequence Diagram

```mermaid
sequenceDiagram
    participant User
    participant Browser
    participant Server
    User->>Browser: Request Page
    Browser->>Server: HTTP Request
    Server-->>Browser: HTML Response
    Browser-->>User: Rendered Page
```