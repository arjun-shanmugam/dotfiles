---
name: todoist
description: >
  Execute a Todoist task (and its subtasks) by name. In plan mode, reads the task
  + all child tasks and their descriptions, drafts a detailed plan with checkpoints,
  and executes on approval; otherwise executes directly. Posts checkpoint status
  comments, tracks deliverable iterations in the parent task's comments, and marks
  the task complete when done.
triggers:
  - "/todoist"
  - "todoist"
mcp_servers: []
---

# /todoist

Execute a Todoist task and any subtasks, driven by the task's name.

**Input:** `task_name` — the skill argument (the name of an existing Todoist task).

## Access notes

- There is no Todoist MCP. All Todoist access goes through the helper script
  `scripts/todoist.py` (Todoist REST API v1).
- The token is read from `TODOIST_API_TOKEN` or `~/.config/todoist-nvim-dev/token`.
- Name search is **client-side** — the server's search filter is unreliable, so
  `find` fetches all open tasks and matches `content` locally.
- Run the helper with the skill directory's script path, e.g.
  `python3 ~/.claude/skills/todoist/scripts/todoist.py <subcommand> ...`.

## Step 1 - Resolve the task

Run `todoist.py find "<task_name>"`.

- First line `NO_MATCH` (exit 3): tell the user no matching task was found and stop.
- First line `MULTIPLE (n)` (exit 4): the following `id<TAB>content` lines are the
  candidates. Use AskUserQuestion to have the user pick one; stop until they choose.
- First line `MATCH` (exit 0): the next line is `id<TAB>content`. Capture the `id`
  as the **parent task id**.

## Step 2 - Read everything

Run `todoist.py tree <parent_id>`. Read the parent task's content and full
description, and every child task with its description, very, very carefully
before doing anything else. This is the source of truth for what to build.

## Step 3 - Branch on mode

**If you are currently in plan mode:**
- Produce a very detailed plan that covers the parent task and ALL subtasks.
- The plan must define explicit **checkpoints** tied to plan steps/phases. State
  that at each checkpoint you will post a comment (Step 4) to the task currently
  being worked, summarizing status and progress since the last checkpoint.
- Write the plan to the plan file and call ExitPlanMode. Do NOT create any task.
- Only begin execution after the user approves and explicitly tells you to execute.

**If you are not in plan mode:**
- Skip planning and the approval gate. Begin executing immediately, applying the
  same checkpoint, iteration, and completion behavior below.

## Step 4 - Execute with checkpoints

Work through the parent task and its subtasks. After each plan step/phase
completes, post a checkpoint:

```
todoist.py comment <current_task_id> "<status + what changed since last checkpoint>"
```

"Current task" is the specific subtask being worked when subtasks exist; otherwise
it is the parent task.

## Step 5 - Iterations

If the user asks you to iterate on the deliverable, record each iteration as a
comment on the **parent task**, describing what they asked for and what you did:

```
todoist.py comment <parent_id> "<iteration: request -> change made>"
```

## Step 6 - Completion

When the final deliverable is done:
- If there are subtasks, close each finished one: `todoist.py complete <subtask_id>`.
- Post a final summary comment on the parent task.
- Mark the parent complete: `todoist.py complete <parent_id>`.

## Helper reference

```
todoist.py find "<name>"          # resolve task by name (client-side match)
todoist.py tree <id>              # task + description + all subtasks/descriptions
todoist.py comments <id>          # list existing comments (prior checkpoints/iterations)
todoist.py comment <id> "<text>"  # post a comment (checkpoints, iterations)
todoist.py complete <id>          # close (complete) a task
```
