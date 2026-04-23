---
name: shortcut-triage
description: "Use when: the user asks what to work on, wants to see their current iteration, needs to find stories by state or owner, wants to identify blocked or unassigned work, or asks for a sprint health check."
user-invocable: true
argument-hint: "e.g. 'triage the current sprint' or 'find my unstarted stories'"
---

# Shortcut Triage

## Sprint triage workflow

1. **Find the active iteration** — call `iterations-get-active`
2. **Get all stories** — call `iterations-get-stories` with the iteration ID
3. **Group by workflow state type**:
   - `unstarted` — not yet started
   - `started` — in progress
   - `done` — complete
4. **Flag problem stories**:
   - Unstarted stories with no owner
   - Started stories with no recent activity (stale)
   - Stories with no estimate
   - Stories in a `blocked by` relation with no resolution
5. **Report** using the summary table below

## Triage summary table template

| Status | Count | Notes |
|--------|-------|-------|
| Done | N | |
| In progress | N | List any stale (>3 days no update) |
| Unstarted | N | List any unowned |
| No estimate | N | |
| Blocked | N | List blocker story IDs |

## Backlog health check patterns

- **Unowned stories**: search for stories with no `owner_ids` in the current iteration
- **Overdue stories**: stories with a `deadline` before today not in a `done` state
- **Unestimated stories**: stories with no `estimate` field set
- **Stale in-progress**: stories in a `started` state with no updates in the last 3+ days

## Common search recipes

| Goal | Query approach |
|------|---------------|
| My open stories | Use `stories-search` with your name or mention name |
| Bugs with no owner | Search for `type:bug` and filter on empty `owner_ids` |
| Stories in a specific iteration | Use `iterations-get-stories` |
| Stories by label | Use `labels-get-stories` |
| Blocked stories | Search for stories with `blocked by` relations |
| Stories by epic | Use `epics-get-by-id` then look at associated stories |
| My stories across all iterations | Search by owner UUID from `users-get-current` |

## Quick triage questions

Ask these to orient quickly:

1. What iteration is currently active?
2. How many stories are unstarted vs in-progress vs done?
3. Which in-progress stories have no recent activity?
4. Are there any unowned unstarted stories?
5. Are there any blocked stories with no movement?
6. How many stories are unestimated?
