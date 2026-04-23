# Shortcut API Instructions

## Authentication

All Shortcut API calls use:
- Base URL: `https://api.app.shortcut.com/api/v3`
- Header: `Shortcut-Token: ${SHORTCUT_API_TOKEN}`

If `SHORTCUT_API_TOKEN` is not set in the environment, inform the user and stop. Do not attempt any API calls without it.

Never hardcode an API token in any response, file, or tool call.

## Search before create

Before creating any story, epic, iteration, label, or document, always search first using the appropriate search tool. Present any close matches to the user and confirm intent before proceeding. This prevents duplicates.

## Workflow state discipline

Before calling `stories-update` with a `workflow_state_id`, always call `workflows-get-by-id` to retrieve the valid list of states for the relevant workflow. Never guess or reuse a cached state ID from a previous session.

## Destructive confirmation protocol

For `epics-delete` and `iterations-delete`, you must:

1. Call `epics-get-by-id` or `iterations-get-by-id` to retrieve the full entity.
2. Show the user: entity name, ID, and story count (plus date range for iterations).
3. Ask the user to type exactly:
   - `delete epic <name>` for epics
   - `delete iteration <name>` for iterations
4. Only call the delete tool if the user's response is an exact match. Cancel on any other response.

## ID types

| Entity | ID type |
|--------|---------|
| stories | integer |
| epics | integer |
| iterations | integer |
| labels | integer |
| objectives (milestones) | integer |
| workflows | integer |
| projects | integer |
| teams (groups) | UUID string |
| members | UUID string |
| documents | UUID string |
| custom-fields | UUID string |

## Date format

All dates must be ISO 8601: `YYYY-MM-DD`

## Story types

Always lowercase: `"feature"`, `"bug"`, `"chore"`

## Story relation verbs

Use exactly: `"relates to"`, `"blocks"`, `"blocked by"`, `"duplicates"`, `"duplicated by"`

## Custom fields

Always call `custom-fields-list` before setting any `custom_fields` on a story. Use the returned field UUIDs and enum value IDs exactly — never invent them.

## Pagination

If any API response contains a `next_page_token`, inform the user that additional results exist and offer to fetch the next page.

## External links

The external links URL path uses a hyphen: `/external-links` (not `/external_links`).

## Documents

All documents use `"content_format": "markdown"`. Write all document content in Markdown.

## Objectives

Objectives are stored as milestones in the API. Use `/milestones/{id}` and `/milestones/search` endpoints. The field name for linking an epic to an objective is `milestone_id`.

## Teams

Teams are stored as groups in the API. Use `/groups/{id}` and `/groups` endpoints. Team IDs are UUID strings.

## Workflows — getting default team workflow

`workflows-get-default` returns the team (group) record, which includes a `workflow_ids` array. Call `workflows-get-by-id` on `workflow_ids[0]` to get the actual workflow states.
