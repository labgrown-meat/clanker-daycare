---
description: How to find and run build, test, and pre-commit commands.
applyTo: "**"
---
# Build and verify

## Finding the commands

Use the target repo's documented commands. Look, in order, in its instruction files,
`README`, `CONTRIBUTING`, and build config (`Cargo.toml`, `package.json`, `Makefile`,
`justfile`, ...). If no command is documented, ask; do not guess.

## Inner loop

While editing, run the fastest command that covers the change: build or type-check
the touched package and run its targeted tests.

## Pre-commit gate

Before `/commit`, run the repo's full gate: format, lint, build, and the tests that
cover the change. Commit only when the gate passes. If a failure existed before the
change, show it to the user before committing.

Then re-read the target repo's instruction files (`AGENTS.md`, `CLAUDE.md`,
`.github/copilot-instructions.md`, `.github/instructions/**/*.instructions.md`, and
any nested `AGENTS.md` covering the changed files) and check the change against each
rule. Fix any violation and rerun the gate before committing.

Do not install dependencies or change toolchain versions unless the task requires it.

## Reporting

State the exact commands run and their result.
