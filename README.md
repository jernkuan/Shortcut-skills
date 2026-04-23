# Shortcut Copilot Plugin

A GitHub Copilot agent plugin for [Shortcut](https://shortcut.com) that lets developers and PMs interact with their Shortcut workspace directly from VS Code — no browser tab switching, no copy-pasting story IDs.

## What it does

Talk to Shortcut in plain English through VS Code Copilot Chat:

- Create and update stories, tasks, and epics
- Move stories through workflow states
- Triage your current sprint
- Search before you create (duplicates avoided automatically)
- Generate git branch names from stories
- Manage iterations, labels, custom fields, and documents
- Track objectives and link epics to them

All API calls go directly to `https://api.app.shortcut.com/api/v3` — no MCP server, no middleware.

## Prerequisites

- VS Code with GitHub Copilot Chat enabled
- A Shortcut account with API access
- `SHORTCUT_API_TOKEN` set in your environment (get it from Shortcut → Settings → API Tokens)

```bash
export SHORTCUT_API_TOKEN=your-token-here
```

The plugin will warn you at session start if this variable is missing.

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/jernkuan/shortcut-skills.git
cd shortcut-skills
```

### 2. Set your API token

Get your token from **Shortcut → Settings → API Tokens**, then add it to your shell profile:

```bash
# ~/.zshrc or ~/.bashrc
export SHORTCUT_API_TOKEN=your-token-here
```

Reload your shell or run `source ~/.zshrc` after adding it.

### 3. Register the plugin with VS Code Copilot

Open your VS Code user or workspace settings (`Cmd+Shift+P` → "Open User Settings (JSON)") and add the path to the `shortcut-plugin/` directory:

```json
{
  "github.copilot.chat.plugins": [
    "/path/to/shortcut-skills/shortcut-plugin"
  ]
}
```

Replace `/path/to/shortcut-skills` with the actual path where you cloned the repo.

### 4. Reload VS Code

Restart VS Code (or run `Developer: Reload Window` from the command palette) for the plugin to be picked up.

### 5. Verify

Open Copilot Chat and type:

```
@shortcut-engineer who am I?
```

If the plugin is loaded correctly, it will call the Shortcut API and return your workspace member details. If you see a warning about `SHORTCUT_API_TOKEN`, check step 2.

## Structure

```
shortcut-plugin/
  plugin.json                           # Plugin manifest
  instructions/
    shortcut.instructions.md            # Always-on rules applied to every request
  agents/
    shortcut-engineer.agent.md          # @shortcut-engineer — story lifecycle
    shortcut-pm.agent.md                # @shortcut-pm — planning, epics, docs
  skills/
    shortcut-data-model/SKILL.md        # Entity hierarchy, ID types, terminology
    shortcut-story-craft/SKILL.md       # Story templates, sizing, best practices
    shortcut-triage/SKILL.md            # Sprint health checks, search recipes
    shortcut-workflow/SKILL.md          # Moving stories through workflow states
  hooks/
    hooks.json                          # SessionStart hook
  scripts/
    session-start.sh                    # Checks for SHORTCUT_API_TOKEN on startup
  tools/
    shortcut-api.tool.json              # 56 HTTP tool definitions for the Shortcut REST API
```

## Agents

### `@shortcut-engineer`

For developers. Handles the day-to-day story lifecycle.

- Create, update, search, and comment on stories
- Move stories through workflow states
- Manage tasks, subtasks, and story relations
- Assign/unassign yourself, get git branch names
- Read epics and iterations (no create/delete)

### `@shortcut-pm`

For product managers. Full access including destructive operations.

- Everything the engineer agent can do, plus:
- Create, update, and delete iterations (sprints)
- Delete epics (with confirmation protocol)
- Create and manage Shortcut documents
- Track objectives and link epics to them

> **Destructive operations** (`epics-delete`, `iterations-delete`) require an exact confirmation phrase before executing. The agent will show you the entity details and ask you to type `delete epic <name>` or `delete iteration <name>` to proceed.

## Skills

Skills provide structured guidance and can be invoked directly in Copilot Chat.

| Skill | When to use |
|-------|------------|
| `shortcut-data-model` | Understanding Shortcut's entity hierarchy and ID types |
| `shortcut-story-craft` | Writing well-formed stories with templates and acceptance criteria |
| `shortcut-triage` | Sprint health checks, finding blocked or unowned work |
| `shortcut-workflow` | Moving stories between states correctly |

## Tool coverage

56 tools across 11 groups:

| Group | Count |
|-------|-------|
| stories | 20 |
| epics | 6 |
| iterations | 8 |
| labels | 3 |
| workflows | 3 |
| projects | 3 |
| users | 3 |
| documents | 5 |
| teams | 2 |
| objectives | 2 |
| custom-fields | 1 |

## Example usage

```
@shortcut-engineer triage the current sprint

@shortcut-engineer create a bug story: login times out after 30 minutes of inactivity

@shortcut-engineer move story 1042 to In Review

@shortcut-pm create a two-week iteration starting 2025-05-05

@shortcut-pm what epics are linked to the Q2 Growth objective?
```

## Key behaviours

- **Search before create** — the agents always search for existing entities before creating new ones
- **Workflow state validation** — states are fetched from the API before any story update; IDs are never guessed
- **Custom field discovery** — `custom-fields-list` is called before setting any custom fields
- **No hardcoded tokens** — `SHORTCUT_API_TOKEN` is always read from the environment
- **Pagination awareness** — if a response has more pages, the agent tells you
