# 00-agents

A collection of Bond-themed [Claude Code](https://docs.anthropic.com/claude-code) sub-agents. Drop them into any project and invoke them by name to get specialized help -- a field operative, a quartermaster, and a right hand who writes your READMEs.

Claude Code discovers agent definitions automatically from `.claude/agents/`. This repo gives you a ready-made set you can copy into any project or install globally.

## Table of Contents

- [Quick Start](#quick-start)
- [Agents](#agents)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Adding New Agents](#adding-new-agents)
- [Contributing](#contributing)

## Quick Start

```bash
# Clone the repo
git clone https://github.com/KaizenXIII/00-agents.git

# Copy agents into your project
cp -r 00-agents/.claude/agents/ /path/to/your/project/.claude/agents/

# Start Claude Code and invoke an agent
# "bond, refactor this module"
# "hey moneypenny, what's this project about?"
# "q, analyze this build failure"
```

## Agents

### Bond

007 -- the field operative. A general-purpose agent for executing missions. Confident, concise, and resourceful -- Bond gets straight to the point and adapts to whatever task is at hand.

- **Tools:** Read, Grep, Glob, Write, Edit, Bash
- **Model:** inherits from session
- **Invoke with:** `bond`, `james`, `007`

```
"bond, take care of this"
"007, refactor this module"
```

### Moneypenny

Bond's right hand at MI6. Operates in two modes:

**Greeter** -- scans the project structure and gives you a brief summary of what it found. Useful for getting oriented in an unfamiliar codebase.

**README Generator** -- analyzes the full codebase (structure, language/framework, source files, CI config) and generates or updates a comprehensive `README.md` with a Bond-themed signature.

- **Tools:** Read, Grep, Glob, Write
- **Model:** session default
- **Invoke with:** `moneypenny`, `money-penny`, `money`, `penny`, `mp`

```
"hey moneypenny, what's this project about?"
"Can you generate a README for this repo?"
"The README is missing some sections, can you update it?"
```

### Q

The quartermaster -- MI6's tech wizard. An agent for analysis, tooling, and clever solutions. Precise and technical with a slightly dry wit, Q explains reasoning when it matters and always delivers something useful.

- **Tools:** Read, Grep, Glob, Write, Edit, Bash
- **Model:** inherits from session
- **Invoke with:** `q`, `quartermaster`

```
"q, take a look at this"
"quartermaster, what's going on with this build?"
```

## Installation

**Project-level** -- agents available in a single project:

```bash
cp -r 00-agents/.claude/agents/ /path/to/your/project/.claude/agents/
```

**User-level** -- agents available across all your projects:

```bash
cp -r 00-agents/.claude/agents/ ~/.claude/agents/
```

Claude Code automatically discovers agents in both locations. No configuration required.

## Project Structure

```
.claude/
  agents/
    bond.md           # Field operative -- general-purpose agent
    moneypenny.md     # Greeter + README generator
    q.md              # Analysis and tooling agent
CLAUDE.md             # Project-level Claude Code config
README.md
```

## Adding New Agents

Create a Markdown file under `.claude/agents/` with YAML front matter:

```markdown
---
name: my-agent
description: Brief description of what this agent does.
tools: Read, Grep, Bash
model: inherit
---

Your agent instructions go here.
```

The `description` field supports multi-line YAML and `<example>` blocks that help Claude Code decide when to invoke the agent automatically:

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

See the [Claude Code documentation](https://docs.anthropic.com/claude-code) for the full list of supported tools and model options.

## Contributing

1. Fork the repository
2. Create a branch for your agent (`git checkout -b add-my-agent`)
3. Add your agent definition under `.claude/agents/`
4. Open a pull request describing what the agent does and when it should be used

---

> *Commits are forever. 2026-03-15 14:02 PDT*
