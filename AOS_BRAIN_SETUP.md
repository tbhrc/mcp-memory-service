# AOS Brain Setup

This fork is the AOS-controlled memory backend for David / Talent Bridge / ImplementAI.ae.

## Purpose

Use `mcp-memory-service` as the operational semantic memory backend for the AOS Brain.

The AOS Brain lives in OneDrive:

```text
OneDrive / AOS / 0_brain
```

Known cloud path:

```text
tbhrc-my.sharepoint.com/personal/info_talentbridgedubai_com/Documents/AOS/0_brain
```

## Operating model

AOS follows:

```text
chat -> decision -> file -> folder -> tracker -> memory -> reusable system
```

The brain must not replace files and folders. It indexes and retrieves durable context, while Markdown files remain human-readable source memory.

## Existing seed memory folder

Seed memories are stored in:

```text
AOS/0_brain/03_seed_memories
```

Initial seed files:

```text
identity_david.md
aos_core_philosophy.md
tool_evaluation_rule.md
folder_discipline.md
business_context.md
assistant_behavior_preference.md
```

## Recommended local install path

On Windows, find the synced OneDrive path first. Likely examples:

```powershell
$env:OneDriveCommercial\AOS\0_brain
$env:OneDrive\AOS\0_brain
C:\Users\<user>\OneDrive - Talent Bridge Dubai\AOS\0_brain
```

Clone this fork under:

```text
AOS/0_brain/01_memory_backend/mcp-memory-service
```

Command:

```powershell
cd "$env:OneDriveCommercial\AOS\0_brain\01_memory_backend"
git clone https://github.com/tbhrc/mcp-memory-service.git
cd mcp-memory-service
```

If already cloned:

```powershell
cd "$env:OneDriveCommercial\AOS\0_brain\01_memory_backend\mcp-memory-service"
git pull
```

## Basic install

The upstream README supports PyPI install:

```powershell
python -m venv ..\.venv
..\.venv\Scripts\Activate.ps1
pip install -U pip
pip install mcp-memory-service
```

For editable fork install:

```powershell
python -m venv ..\.venv
..\.venv\Scripts\Activate.ps1
pip install -U pip
pip install -e .
```

## Run MCP server

Basic MCP mode:

```powershell
memory server
```

HTTP/dashboard mode:

```powershell
$env:MCP_ALLOW_ANONYMOUS_ACCESS="true"
memory server --http
```

Dashboard/API default:

```text
http://localhost:8000
```

## Claude Code config

Claude Code command:

```bash
claude mcp add memory -- memory server
```

## Claude Desktop config

Windows config file:

```text
%APPDATA%\Claude\claude_desktop_config.json
```

Snippet:

```json
{
  "mcpServers": {
    "aos-brain": {
      "command": "memory",
      "args": ["server"]
    }
  }
}
```

## Codex config concept

Use project or global Codex MCP config and point to:

```toml
[mcp_servers.aos-brain]
command = "memory"
args = ["server"]
```

## First memory test

Store this test memory through the MCP tool or REST API:

```text
David’s AOS requires folder-first truth, MCP/API controllability, and semantic searchable memory.
```

Search query:

```text
What does David require for tool adoption?
```

Expected retrieval:

```text
MCP/API controllability
folder-first truth
semantic searchable memory
```

## API key policy

Default target: local-first, no paid API key.

Use cloud/API embeddings only if local mode fails or quality is insufficient.

## AOS rule

Do not store secrets, passwords, API keys, raw chat logs, or temporary brainstorming in memory. Store durable decisions, rules, preferences, corrections, reusable business context, and architecture facts.
