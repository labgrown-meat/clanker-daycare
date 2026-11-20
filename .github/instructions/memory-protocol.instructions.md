---
description: How the agent loads and writes durable memory in `memories/`.
applyTo: "**"
---
# Memory protocol

Paths are relative to the clanker-daycare repo root.

## Loading at session start

1. Read every file in `memories/short-term/` in full.
2. Read `memories/long-term/INDEX.md` only. Read a long-term memory's body when the
   current task matches its "when to load" hint.
3. Ignore `memories/forgotten/`.

An empty directory or missing `INDEX.md` means that tier is empty. Do not create
files at load time.

## Writing

- Only `/dream` creates, updates, moves, or deletes memory files, and only after the
  user approves each change.
- Outside `/dream`, record memory candidates in the session's `/handover` learnings doc.
- If a memory conflicts with the user's current instruction, follow the user and note
  the conflict in the learnings doc.

## File format

One topic per file, kebab-case name, e.g. `prefers-single-backticks.md`:

```yaml
---
created: YYYY-MM-DD
last_dreamed: YYYY-MM-DD
updates: 1
---
```

Body: the rule in one line, then links to the learnings docs that support it.

`long-term/INDEX.md` has one line per memory:
`- [name](file.md): when to load: <hint>`.

## Graduation

A short-term memory moves to long-term when `updates` is at least 3 and `created` is
more than 7 days ago. `/dream` proposes the move; the user approves it.
