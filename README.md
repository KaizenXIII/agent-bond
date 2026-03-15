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

### `bond`

007 -- the field operative. A general-purpose agent for executing missions. Confident, concise, and resourceful -- Bond gets straight to the point and adapts to whatever task is at hand.

- **Tools:** `Read`, `Grep`, `Glob`, `Write`, `Edit`, `Bash`
- **Model:** `inherit`
- **Aliases:** `james`, `007`

```
"bond, take care of this"
"007, refactor this module"
```

### `moneypenny`

Bond's right hand at MI6. A dual-purpose agent that operates in two modes:

**Mode 1 -- Greeter (default):** Scans the project structure and greets you with a brief summary of what it found. Useful for getting oriented in an unfamiliar codebase.

**Mode 2 -- README Generator:** Analyzes the full codebase -- project structure, language/framework, key source files, CI config -- and generates or updates a comprehensive `README.md`. Includes a Bond-themed signature with timestamp.

- **Tools:** `Read`, `Grep`, `Glob`, `Write`
- **Model:** `inherit`
- **Aliases:** `money-penny`, `money`, `penny`, `mp`

```
"hey moneypenny, what's this project about?"
"Can you generate a README for this repo?"
"The README is missing some sections, can you update it?"
```

### `q`

The quartermaster -- MI6's tech wizard. An agent for analysis, tooling, and clever solutions. Precise and technical with a slightly dry wit, Q explains reasoning when it matters and always delivers something useful.

- **Tools:** `Read`, `Grep`, `Glob`, `Write`, `Edit`, `Bash`
- **Model:** `inherit`
- **Aliases:** `quartermaster`

```
"q, take a look at this"
"quartermaster, what's going on with this build?"
```

## Project Structure

```
.claude/
  agents/
    bond.md         # General-purpose field operative agent
    moneypenny.md   # Greeter + README generation agent
    q.md            # Analysis and tooling agent
CLAUDE.md           # Project-level Claude Code config
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

> *Three agents, no time to debug. 2026-03-15 13:41 PDT*
