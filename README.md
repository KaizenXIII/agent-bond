# 00-agents

A collection of Bond-themed [Claude Code](https://docs.anthropic.com/claude-code) sub-agents. Drop them into any project and invoke them by name to get specialized help -- a field operative, a quartermaster, and a right hand who writes your READMEs.

Claude Code discovers agent definitions automatically from `.claude/agents/`. This repo gives you a ready-made set you can copy into any project or install globally. No build system, no runtime dependencies -- just Markdown files with YAML front matter.

## Table of Contents

- [Quick Start](#quick-start)
- [Agents](#agents)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Adding New Agents](#adding-new-agents)
- [Contributing](#contributing)
- [License](#license)

## Quick Start

```bash
# Clone the repo
git clone https://github.com/KaizenXIII/00-agents.git

# Copy agents into your project
mkdir -p /path/to/your/project/.claude/agents
cp -r 00-agents/.claude/agents/ /path/to/your/project/.claude/agents/

# Start Claude Code and invoke an agent
# "bond, refactor this module"
# "hey moneypenny, what's this project about?"
# "q, analyze this build failure"
```

## Agents

### Bond

007 -- the field operative. A general-purpose agent for executing missions. Confident, concise, and resourceful -- Bond gets straight to the point and adapts to whatever task is at hand.

> **Note:** Bond's operational handbook is still being written. He runs on instinct and good taste for now.

- **Tools:** Read, Grep, Glob, Write, Edit, Bash
- **Model:** session default
- **Invoke with:** `bond`, `james`, `007`

```
"bond, take care of this"
"007, refactor this module"
```

### Moneypenny

Bond's right hand at MI6. Operates in two modes:

**Greeter** -- scans the project structure and gives you a brief summary of what it found. Useful for getting oriented in an unfamiliar codebase.

**README Generator** -- analyzes the full codebase (structure, language/framework, source files, config) and generates or updates a comprehensive `README.md`. Always signs off with a Bond-inspired tagline.

- **Tools:** Read, Grep, Glob, Write
- **Model:** session default
- **Invoke with:** `moneypenny`, `money-penny`, `money`, `penny`, `mp`

```
"hey moneypenny, what's this project about?"
"Can you generate a README for this repo?"
"The README is missing some sections, can you update it?"
```

### Q

The quartermaster -- MI6's tech wizard. A testing, validation, and quality specialist. Writes tests, runs suites, diagnoses failures, validates that changes actually work, reviews code for security vulnerabilities, checks for performance anti-patterns, and advises on testing strategy. Precise and methodical with a dry wit -- Q doesn't let anything leave the lab without proper testing.

Operates in six modes:

1. **Write tests** -- detects the existing framework and writes tests following project conventions
2. **Run and diagnose** -- executes test suites, reads failures, identifies whether the bug is in the test or the source
3. **Validate work** -- builds, lints, runs tests, spot-checks logic, checks security and performance, and delivers a clear verdict
4. **Test strategy advice** -- recommends approaches based on the testing trophy (mostly integration, some unit, few E2E)
5. **Security review** -- checks for OWASP-style vulnerabilities: injection, auth issues, data exposure, input validation gaps, dependency risks, and configuration problems. Rates findings by severity with concrete fixes
6. **Performance review** -- scans for common anti-patterns: N+1 queries, unbounded operations, missing indexes, blocking I/O, memory issues, and redundant work. Focuses on issues that matter at the project's actual scale

- **Tools:** Read, Grep, Glob, Write, Edit, Bash
- **Model:** opus
- **Invoke with:** `q`, `quartermaster`

```
"q, write tests for this module"
"q, these tests are failing -- figure out why"
"q, check that this works"
"quartermaster, what's our testing strategy?"
"q, review this for security issues"
"q, any performance concerns here?"
```

## Installation

**Project-level** -- agents available in a single project:

```bash
mkdir -p /path/to/your/project/.claude/agents
cp -r 00-agents/.claude/agents/ /path/to/your/project/.claude/agents/
```

**User-level** -- agents available across all your projects:

```bash
mkdir -p ~/.claude/agents
cp -r 00-agents/.claude/agents/ ~/.claude/agents/
```

Claude Code automatically discovers agents in both locations. No configuration required.

## Project Structure

```
.claude/
  agents/
    bond.md           # Field operative -- general-purpose agent
    moneypenny.md     # Greeter + README generator
    q.md              # Testing, validation, security, and performance specialist
scripts/
  validate-agents.sh  # Validates agent file structure
.gitignore
CLAUDE.md             # Project-level Claude Code config and conventions
LICENSE               # MIT License
README.md
```

## Adding New Agents

Create a Markdown file under `.claude/agents/` with YAML front matter and a body containing the agent's instructions:

```markdown
---
name: my-agent
description: Brief description of what this agent does.
tools: Read, Grep, Bash
---

Your agent instructions go here.
```

The `description` field supports multi-line YAML and `<example>` blocks that help Claude Code decide when to invoke the agent automatically:

```markdown
---
name: my-agent
description: >
  Does X when Y happens.
  Also known as "alias-one", "alias-two".

  <example>
  Context: User needs X
  user: "Can you do X?"
  assistant: "I'll use the my-agent agent to handle that."
  </example>
tools: Read, Bash
---
```

### Agent body structure

Follow this convention for the body of the agent file:

1. Identity statement ("You are X -- ...")
2. Voice and tone section
3. Operating modes (`## Mode N: Name`)
4. Rules section at the end

### Tool access policy

- Agents that execute code or modify files: `Read, Grep, Glob, Write, Edit, Bash`
- Read-and-generate agents (e.g. Moneypenny): `Read, Grep, Glob, Write`
- Do not grant `Bash` or `Edit` unless the agent's role requires it

### Validation

Run the validation script after adding or modifying any agent file:

```bash
bash scripts/validate-agents.sh
```

It checks that YAML front matter exists, required fields (`name`, `description`, `tools`) are present and non-empty, and the body contains instructions. Accepts an optional directory argument (defaults to `.claude/agents`).

There is no other test suite -- validation is the only quality gate.

See the [Claude Code documentation](https://docs.anthropic.com/claude-code) for the full list of supported tools and model options.

## Contributing

1. Fork the repository
2. Create a branch for your agent (`git checkout -b add-my-agent`)
3. Add your agent definition under `.claude/agents/`
4. Run `bash scripts/validate-agents.sh` to verify your agent file
5. Open a pull request describing what the agent does and when it should be used

## License

[MIT](LICENSE)

---
> *The name is README. Updated README.*
