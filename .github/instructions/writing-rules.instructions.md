---
description: Rules for prose, code comments, and commit messages.
applyTo: "**"
---
# Writing rules

## Prose (docs, PR descriptions, chat)

- Plain, direct sentences. No filler or embellishment.
- Quote identifiers, paths, and commands with single backticks.
- Docs open with an "Overview". Do not list what is out of scope.

## Code comments

- Explain *why*, not *what*. Skip comments the code already makes clear.
- No edit history in code ("changed X to Y", "previously ..."). History belongs in
  commit messages.

## Commit messages

Follow the target repo's convention. Without one: imperative subject under 72
characters, blank line, body explaining why.
