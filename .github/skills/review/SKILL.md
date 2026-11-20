---
name: review
description: Review a change (uncommitted work, a branch, or a PR) for bugs, rule violations, and missing tests, and write a report to `thoughts/shared/reviews/`. Use when asked to review a change.
user-invocable: true
---
# Review

## Steps

1. Identify the change: uncommitted work by default, or the branch, commit range, or
   PR the user names. Ask if unclear.
2. Read the target repo's instruction files, and the plan if one exists.
3. Check, in order:
   1. Correctness: bugs, edge cases, error handling.
   2. Rules: the target repo's instructions and this workspace's steering.
   3. Tests: missing or weak tests, per `testing-standards`.
   4. Plan: changes the plan did not call for, or phases it skipped.
4. Report only real issues, each with `path:line`, the problem, and a fix. Skip
   anything the formatter or linter handles.
5. Write the report. Give the user its path and the findings.

## Output

`thoughts/shared/reviews/<YYYY-MM>/<YYYY-MM-DD>-<topic-slug>.md`:

```markdown
---
date: YYYY-MM-DD
repos: [<repo>]
change: <branch, commit range, or PR>
plan: <path or none>
---
# Review: <change>

## Overview

<verdict in 1–2 sentences>

## Findings

### <high|medium|low>: <title>

`path/to/file:123`. <problem>. Fix: <fix>.
```
