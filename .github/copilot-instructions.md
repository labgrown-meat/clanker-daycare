## Target repo instructions

When a task targets a repo outside this workspace, read its instruction files before
reading or changing its code:

- `AGENTS.md`, `CLAUDE.md`
- `.github/copilot-instructions.md`
- `.github/instructions/**/*.instructions.md`

Also check subdirectories of the repo for their own `AGENTS.md`.

If the target repo's rules conflict with this workspace's rules, the target repo's
rules win for that repo's code.
