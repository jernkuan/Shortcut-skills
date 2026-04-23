---
name: shortcut-story-craft
description: "Use when: the user wants to create a story, write a ticket, draft acceptance criteria, add a task, or improve a story description. Provides templates, sizing guidelines, and best practices for well-formed Shortcut stories."
user-invocable: true
argument-hint: "e.g. 'help me write a story for dark mode'"
---

# Shortcut Story Craft

## Story title formula

**Verb + specific outcome** — describe what gets delivered, not what gets done.

| Good | Avoid |
|------|-------|
| `Add dark mode toggle to user settings` | `Dark mode` |
| `Fix login timeout after 30 minutes of inactivity` | `Fix bug` |
| `Expose /api/v2/users endpoint with pagination` | `API work` |

## Story types

| Type | Use when |
|------|---------|
| `feature` | Adding new user-visible functionality |
| `bug` | Something is broken relative to expected behavior |
| `chore` | Internal work: refactor, dependency update, infra, tests |

Always lowercase.

## Feature story description template

```markdown
## Context
Why this work matters. Who is affected. What triggers this need.

## What to build
Specific description of the change. Include UI, API contract, data changes as relevant.

## Acceptance criteria
- [ ] Criterion 1 — observable, testable outcome
- [ ] Criterion 2
- [ ] Criterion 3

## Out of scope
What is explicitly NOT included in this story.
```

## Bug story description template

```markdown
## What's broken
Clear description of the incorrect behavior.

## Steps to reproduce
1. Step one
2. Step two
3. Observe: [what happens]

## Expected behavior
What should happen instead.

## Environment
Browser/platform/version where the bug occurs.

## Acceptance criteria
- [ ] The bug no longer reproduces following the steps above
- [ ] Regression test added (if applicable)
```

## Sizing table

| Points | Scope |
|--------|-------|
| 1 | Trivial — less than a few hours |
| 2 | Small — half a day |
| 3 | Medium — one day |
| 5 | Large — two to three days |
| 8 | X-Large — consider splitting |

Stories estimated at 8 or more points are strong candidates for splitting.

## Story splitting heuristics

Split a story when it:
- Can be delivered and demoed independently in parts
- Has acceptance criteria that span more than one deploy boundary
- Requires work across more than two system layers with independent testability
- Has an estimate of 8+ points

## Tasks vs subtasks vs sub-stories

| Mechanism | Use when |
|-----------|---------|
| **Task** (checklist) | Small implementation steps within a single story; owned by the same person |
| **Sub-story** | Independent deliverable that can be assigned separately or has its own workflow state |

## Task checklist patterns

```markdown
- [ ] Write unit tests
- [ ] Update API documentation
- [ ] Add feature flag
- [ ] QA sign-off
- [ ] Update changelog
```
