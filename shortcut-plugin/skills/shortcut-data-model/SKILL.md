---
name: shortcut-data-model
description: "Use when: the user asks how Shortcut is organized, what entity relationships exist, explains Shortcut terminology, or needs a first-time orientation. Covers Objective→Epic→Story→Task/Subtask hierarchy, workflows, iterations, teams, labels, custom fields, and ID types."
user-invocable: true
argument-hint: "e.g. 'how do epics relate to stories?'"
---

# Shortcut Data Model

## Entity hierarchy

```
Objective (Milestone)
└── Epic
    └── Story
        ├── Task (checklist item)
        └── Sub-story (child Story)
```

- **Objective** — top-level strategic goal. Epics roll up to objectives.
- **Epic** — a body of work containing multiple stories. Belongs to at most one objective.
- **Story** — the primary unit of work. Types: `feature`, `bug`, `chore`.
- **Task** — a checklist item inside a story. Not a separate entity; has no workflow state.
- **Sub-story** — a full Story linked as a child of another Story via `parent_story_id`.

## Supporting entities

| Entity | Purpose |
|--------|---------|
| **Iteration** | Time-boxed sprint. Stories are assigned to iterations. |
| **Workflow** | Ordered list of states a story moves through. |
| **Workflow State** | A single step in a workflow (e.g. "In Development"). |
| **Team (Group)** | A group of members with a shared set of workflows. |
| **Project** | An organizational container; stories belong to a project. |
| **Label** | A tag applied to stories or epics for cross-cutting categorization. |
| **Custom Field** | Workspace-defined metadata on stories (e.g. Priority, Region). |
| **Member** | A user in the workspace. |
| **Document** | A freeform Markdown document (not attached to a specific story). |

## ID types

| Entity | ID type | Example |
|--------|---------|---------|
| stories | integer | `1042` |
| epics | integer | `88` |
| iterations | integer | `14` |
| labels | integer | `5` |
| objectives (milestones) | integer | `3` |
| workflows | integer | `500000014` |
| projects | integer | `117` |
| teams (groups) | UUID string | `"a1b2c3d4-..."` |
| members | UUID string | `"e5f6g7h8-..."` |
| documents | UUID string | `"i9j0k1l2-..."` |
| custom-fields | UUID string | `"m3n4o5p6-..."` |

## Workflow state types

Every workflow state has a `type`:

| Type | Meaning |
|------|---------|
| `unstarted` | Work not yet begun |
| `started` | Work in progress |
| `done` | Work complete |

## Workflow vs iteration

- A **workflow** defines the possible states (columns) a story can be in.
- An **iteration** defines the time box (sprint) a story is scheduled in.
- These are independent: a story can be in a sprint and in any workflow state.

## Teams and workflows

Each team (group) has one or more associated workflow IDs stored in its `workflow_ids` field. To find a team's default workflow states:
1. Call `teams-get-by-id` → read `workflow_ids[0]`
2. Call `workflows-get-by-id` with that ID → read the `states` array

## Story relations

Stories can be linked with directional verbs:
- `"relates to"` — generic association
- `"blocks"` / `"blocked by"` — dependency
- `"duplicates"` / `"duplicated by"` — duplicate tracking
