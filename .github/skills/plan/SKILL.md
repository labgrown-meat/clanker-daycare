---
name: plan
description: Turn research or a task description into a phased implementation plan in `thoughts/shared/plans/`. Use before implementing a non-trivial change.
user-invocable: true
---
# Plan

Write a plan the user approves before any code changes.

## Steps

1. Read the research doc the user names, or the newest one on the topic. If none
   exists and the code is unfamiliar, suggest `/research` first.
2. Read the target repo's instruction files.
3. Confirm the goal and constraints with the user. Record each decision in the plan.
4. Split the work into phases. Each phase can be verified on its own and leaves the
   repo building with tests passing.
5. Write the plan and ask the user to approve it. Do not change code.
6. On approval, set `status: approved`.

## Output

`thoughts/shared/plans/<YYYY-MM>/<YYYY-MM-DD>-<topic-slug>.md`:

```markdown
---
date: YYYY-MM-DD
repos: [<repo>]
tickets: [<id>]
research: <path or none>
status: draft
---
# <Change>

## Overview

<what changes and why>

## Decisions

- <decision>: <reason>

## Phase 1: <name>

- Changes: <files and what changes>
- Verify: <exact commands and expected result>
- Status: pending

## Phase 2: <name>

...
```
