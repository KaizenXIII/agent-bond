# agent-bond

A collection of reusable Claude Code sub-agents for common development tasks.

## Overview

`agent-bond` is a repository of Claude Code agent definitions stored under `.claude/agents/`. These agents extend Claude Code with specialized, scoped behaviors that can be invoked on demand. Each agent is defined as a Markdown file with a YAML front matter header that declares its name, description, available tools, and optionally a preferred model.

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Agents](#agents)
- [Project Structure](#project-structure)
- [Adding New Agents](#adding-new-agents)
- [Contributing](#contributing)
- [License](#license)

## Features

- Drop-in agent definitions compatible with Claude Code's sub-agent system
- Each agent is self-contained with its own tool permissions and instructions
- Agents can be invoked by name during any Claude Code session
- Works at both project level (`.claude/agents/`) and user level (`~/.claude/agents/`)

## Prerequisites

- [Claude Code](https://claude.ai/code) CLI installed and authenticated

## Installation

Clone the repository and copy the agent definitions into your project or home directory:

```bash
git clone https://github.com/kevinwu/agent-bond.git
```

**Project-level** (agents available in one project):

```bash
cp -r agent-bond/.claude/agents/ /path/to/your/project/.claude/agents/
```

**User-level** (agents available in all projects):

```bash
cp -r agent-bond/.claude/agents/ ~/.claude/agents/
```

Claude Code automatically discovers agent definitions in both locations.

## Agents

### `greeter`

A simple hello world agent that greets the user and summarizes the project structure. Useful for verifying that the sub-agent system is working correctly.

- **Tools:** `Read`, `Glob`
- **Usage:** Ask Claude Code to invoke the greeter agent to confirm agents are loading properly.

```
"Use the greeter agent to check the project."
```

### `readme-gen`

Reviews a repository's codebase and generates or updates a comprehensive `README.md`. Analyzes project structure, detects the language and framework, reads key source files, and produces an accurate README. The agent outputs the README content for review before writing, so you can inspect and request changes first.

- **Tools:** `Read`, `Grep`, `Glob`
- **Model:** `inherit` (uses the model of the invoking session)
- **Usage:** Ask Claude Code to use the readme-gen agent to create or update a project README.

```
"Can you generate a README for this repo?"
"The README is missing some sections, can you update it?"
```

## Project Structure

```
.claude/
  agents/
    greeter.md      # Hello world / smoke-test agent
    readme-gen.md   # README generation agent
README.md
```

## Adding New Agents

Create a new Markdown file under `.claude/agents/` with a YAML front matter header followed by the agent's instructions:

```markdown
---
name: my-agent
description: Brief description of what this agent does and when to use it.
tools: Read, Grep, Bash
model: inherit          # optional; omit to use the session default
---

Your agent instructions go here.
```

The `description` field supports multi-line YAML and can include `<example>` blocks to help Claude Code decide when to invoke the agent automatically:

```markdown
---
name: my-agent
description: >
  Does X when Y happens.

  <example>
  Context: User needs X
  user: "Can you do X?"
  assistant: "I'll use the my-agent agent to handle that."
  </example>
tools: Read, Bash
---
```

Refer to the [Claude Code documentation](https://docs.anthropic.com/claude-code) for the full list of supported tools and model options.

## Contributing

1. Fork the repository
2. Create a branch for your new agent (`git checkout -b add-my-agent`)
3. Add your agent definition under `.claude/agents/`
4. Open a pull request with a description of what the agent does and when it should be used

## License

License not yet specified. Add a `LICENSE` file to this repository to clarify terms of use.

---

> *The code who loved me. 2026-03-15 09:42*
