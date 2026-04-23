---
name: shortcut-workflow
description: "Use when: the user wants to move a story to a different state, asks what workflow states are available, needs to mark a story done or in-review, or wants to understand how Shortcut workflow transitions work."
user-invocable: true
argument-hint: "e.g. 'move story 1234 to in review'"
---

# Shortcut Workflow

## Four-step transition protocol

To move a story to a new workflow state, always follow these steps:

1. **Get the story** — call `stories-get-by-id` to retrieve the story's current `workflow_id` and `workflow_state_id`
2. **Get the workflow** — call `workflows-get-by-id` using the story's `workflow_id` to retrieve all available states with their IDs and names
3. **Present states to the user** — list the available states with IDs so the user can confirm the target state
4. **Update the story** — call `stories-update` with the confirmed `workflow_state_id`

Never skip steps 1–3. Never guess a `workflow_state_id`.

## Workflow state types

| Type | Meaning | Examples |
|------|---------|---------|
| `unstarted` | Work not begun | Ready for Development, Backlog |
| `started` | Work in progress | In Development, In Review, QA |
| `done` | Work complete | Completed, Deployed |

Each state has a unique integer ID within its workflow.

## Epic workflow states

Epic workflow states are **separate** from story workflow states. Epics have their own state field (`state`) with values `"to do"`, `"in progress"`, and `"done"`. These are not workflow state IDs — they are string literals set directly on the epic via `epics-update`.

Do not attempt to use story workflow state IDs on epics or vice versa.

## Bulk transitions

Shortcut has no bulk transition API. To move multiple stories to a new state, you must call `stories-update` once per story. Inform the user of this limitation if they ask to move many stories at once. Offer to iterate through them one at a time with confirmation, or process them sequentially.

## Common transition scenarios

| User intent | Steps |
|-------------|-------|
| "Mark story 123 as done" | Get story → get workflow → find done-type state → update |
| "Move to in review" | Get story → get workflow → find started-type state named review → update |
| "What states can I move this story to?" | Get story → get workflow → list all states |
| "Start working on story 456" | Get story → get workflow → find started-type state → update + assign self |
