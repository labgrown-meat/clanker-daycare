---
name: dream
description: Consolidate learnings docs written since the last dream into short-term and long-term memory, with user approval at each gate. Use weekly or after several sessions.
user-invocable: true
---
# Dream

Follow `memory-protocol` for memory locations and file format.

## Steps

1. **Window.** Find the newest report in `thoughts/shared/dreams/`. Its `window_end`
   is this dream's `window_start`. With no report, start from the oldest learnings doc.
2. **Read.** Read every learnings doc dated after `window_start`. Set `window_end` to
   the newest doc's date.
3. **Short-term intake.** Group user corrections and memory candidates by theme. For
   each theme, propose one action, citing the learnings docs:
   - create a short-term memory;
   - update one (increment `updates`, set `last_dreamed`);
   - merge two;
   - cross-link related memories.

   A theme seen in several sessions is strong evidence. Propose a single occurrence
   only if the user stated it as a standing rule.

   **Gate:** show the proposals; apply only the approved ones.
4. **Graduation.** List short-term memories with `updates` of at least 3 and `created`
   more than 7 days ago. For each, propose one:
   - move to `long-term/` and add an `INDEX.md` line. The "when to load" hint names
     the task or file pattern that needs it, e.g. "editing `errors.rs` in the payments service";
   - migrate it into a steering file or skill.

   **Gate:** apply only the approved ones.
5. **Record.** Write the dream report, even when nothing changed.

## Output

`thoughts/shared/dreams/<YYYY-MM-DD>-dream.md`:

```markdown
---
date: YYYY-MM-DD
window_start: YYYY-MM-DD
window_end: YYYY-MM-DD
learnings_read: <count>
---
# Dream YYYY-MM-DD

## Overview

<what changed in 1–2 sentences>

## Applied

- <action>: `<memory file>` (evidence: <learnings docs>)

## Rejected

- <proposal>: <user's reason>

## Graduated

- `<memory file>` → <long-term, or the steering file or skill>
```
