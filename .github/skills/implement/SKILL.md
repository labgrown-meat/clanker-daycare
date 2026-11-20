---
name: implement
description: Execute an approved plan from `thoughts/shared/plans/` phase by phase, verifying each phase before the next. Use when asked to implement a plan.
user-invocable: true
---
# Implement

## Steps

1. Read the plan. If `status` is not `approved`, ask the user to approve it first.
2. Read the target repo's instruction files.
3. For each phase, in order:
   1. Make only the changes the phase lists.
   2. Run the phase's verify commands and the inner loop from `build-and-verify`.
   3. Set the phase's `Status` to `done` and list the commands run.
   4. If verification fails twice, or the plan no longer matches the code, stop and
      propose a plan update. Do not improvise a new design.
4. After the last phase, run the pre-commit gate and report the result.

Do not commit; that is `/commit`.
