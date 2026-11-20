---
name: commit
description: Commit the current changes in the target repo with a message in the repo's style. Use when asked to commit.
user-invocable: true
---
# Commit

## Steps

1. Run the pre-commit gate from `build-and-verify`. Stop if it fails.
2. Review `git status` and `git diff`. Stage only changes from this session; list any
   other changes and ask about them.
3. Match the message to the repo's convention: its instruction files, then
   `git log --oneline -15`. Without a convention, use `writing-rules`. Include ticket
   ids from the plan if the convention uses them.
4. Show the message and file list. Commit after the user approves.

Never push, amend, or rewrite history unless the user asks.
