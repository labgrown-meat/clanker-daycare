---
name: research
description: Investigate how code or a system works and write the findings to `thoughts/shared/research/`. Use when asked to research, investigate, or understand something before planning a change.
user-invocable: true
---
# Research

Answer the user's question with evidence and write it down, so `/plan` starts from a
file.

## Steps

1. Restate the question in one sentence. If it is ambiguous, ask before searching.
2. Read the target repo's instruction files.
3. Find earlier docs on the topic with `thoughts-locator`; extract what still applies
   with `thoughts-analyzer`.
4. Investigate the code with `codebase-locator` (where), `codebase-analyzer` (how), and
   `codebase-pattern-finder` (examples). Run independent searches in parallel.
5. Describe the code as it is. Do not propose changes.
6. Write the doc. Give the user its path and a 3–5 line summary.

## Output

`thoughts/shared/research/<YYYY-MM>/<YYYY-MM-DD>-<topic-slug>.md`:

```markdown
---
date: YYYY-MM-DD
repos: [<repo>@<short-commit>]
question: <one sentence>
---
# <Topic>

## Overview

<direct answer in a few sentences>

## Findings

- <finding> (`path/to/file:123`)

## Open questions

<only what the user raised or the evidence could not settle; otherwise "None">
```

Every finding cites a `path:line`. Mark anything unverified.
