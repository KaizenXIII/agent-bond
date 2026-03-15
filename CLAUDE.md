# 00-agents

A collection of Bond-themed Claude Code sub-agents. This is a content-only repo — Markdown agent definitions, not application code. No build system, no runtime dependencies.

## Validation

Run after adding or modifying any agent file:

```bash
./scripts/validate-agents.sh
```

Checks: YAML front matter exists, required fields present (`name`, `description`, `tools`), name non-empty, body non-empty. Accepts optional directory argument (defaults to `.claude/agents`).

There is no other test suite — validation is the only quality gate.

## Agent file conventions

All agent definitions live in `.claude/agents/` and must follow this structure:

### YAML front matter

- `name` — agent identifier (lowercase, hyphenated)
- `description` — multi-line using YAML `>` folded scalar. Include aliases as `Also known as "x", "y"`. Include `<example>` blocks for auto-invocation
- `tools` — comma-separated list of allowed tools
- `model` — optional. Omit to inherit the session default

### Body structure

1. Identity statement ("You are X — ...")
2. `### Voice and tone` section
3. `## Mode N: Name` sections for each operating mode
4. `## Rules` section at the end

### Tool access policy

- Agents that execute code or modify files: `Read, Grep, Glob, Write, Edit, Bash`
- Read-and-generate agents (e.g. moneypenny): `Read, Grep, Glob, Write`
- Do not grant `Bash` or `Edit` unless the agent's role requires it

## Agents

| Agent | Role | Invoke with |
|-------|------|-------------|
| **bond** | General-purpose field operative | `bond`, `james`, `007` |
| **moneypenny** | Project briefings + README generation | `moneypenny`, `mp`, `penny`, `money` |
| **q** | Testing, validation, quality | `q`, `quartermaster` |

## Common tasks

### Add a new agent

1. Create `.claude/agents/{name}.md` with YAML front matter and body
2. Follow the body structure: identity, voice, modes, rules
3. Run `./scripts/validate-agents.sh`
4. Update README.md — add agent to the Agents section and Project Structure

### Modify an existing agent

1. Edit the file in `.claude/agents/`
2. Run `./scripts/validate-agents.sh`
3. If name, aliases, or capabilities changed, update README.md

## Style notes

- Bond references: one or two per agent response, tasteful, never forced
- Agent descriptions should be concise — clarity over cleverness
- No emojis in agent definitions or generated output
- Moneypenny always signs off with a short Bond-inspired tagline

## Git conventions

- Branch: `main` (direct commits, no PR process currently)
- Commit messages: imperative mood, concise summary
  - e.g. "Add bond and q agents, fix moneypenny timestamp issue"
- No CI/CD pipeline — validation is manual

## Do not

- Add package managers, build tools, or runtime dependencies
