---
name: handover
description: Distill the current session into a learnings doc in `thoughts/shared/learnings/`, with user corrections first. Use at the end of a session.
user-invocable: true
---
# Handover

Write for a teammate who was not in the session.

## Steps

1. Review the whole conversation.
2. Write the learnings doc. Do not edit any other file in this step.
3. Present the promotion candidates. Apply a steering or skill promotion only if the
   user approves it. Leave memory candidates for `/dream`.

## Rules

- Quote every redirect, rejection, and re-ask in the user's exact words.
- Each correction ends with a one-line rule that applies beyond this task.
- Write "None" in an empty section; do not invent content.

## Output

`thoughts/shared/learnings/<YYYY-MM>/<YYYY-MM-DD>-<session-slug>.md`:

```markdown
---
date: YYYY-MM-DD
repos: [<repo>]
plan: <path or none>
---
# <Session title>

## Overview

<what was done, with links to research, plan, and review docs>

## User corrections

- "<user's exact words>"
  - Context: <what the agent did>
  - Rule: <one line>

## Domain knowledge

- <facts and vocabulary of the problem space>

## System map

- <how projects and services fit together>

## Praxis

- <exact commands, workflows, preferences>

## Promotion candidates

| Target | Location | Rule | Status |
|---|---|---|---|
| steering | `.github/instructions/<file>` | <rule> | proposed |
| skill | `.github/skills/<name>/SKILL.md` | <rule> | proposed |
| memory | for `/dream` | <rule> | deferred |
```
