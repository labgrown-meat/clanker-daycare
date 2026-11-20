# clanker-daycare

A personal "command" repository for working with an AI coding agent. It holds no
product code. It holds the things that make the agent better at *your* work over
time:

- **Steering**: always-loaded rules (how you build, test, write, and lay out work).
- **Workflows**: slash-command skills (research, plan, implement, commit, review).
- **Agents**: narrow subagents the main agent dispatches for search and analysis.
- **Skills**: on-demand playbooks that load only when a task matches them.
- **Memory**: durable knowledge the agent learned from past sessions.
- **Thoughts**: dated research, plans, reviews, and session learnings.

Keep this repo separate from your code repos. It is reused across every task and
every codebase, so it should never depend on one of them.

## Getting started

1. Fork this repo, or clone it and point `origin` at your own remote. Memories and
   thoughts are personal; never push them to the starter repo.
2. Read the steering files in `.github/instructions/`, the workflow skills in
   `.github/skills/`, and the subagents in `.github/agents/`, and adjust them to your
   work. Let `/handover` and `/dream` grow them from real corrections.
3. Start each session with `./playdate.sh` (see "Starting a session"). End each
   session with `/handover`.
4. Run `/dream` weekly, or after every few sessions.
5. Commit config, memories (together with the dream reports that changed them), and
   thoughts as separate commits so each history stays readable.

## Starting a session

From your shell (not inside Copilot), start Copilot CLI in this repo with one or more
target repos attached:

```bash
./playdate.sh <path-to-target-repo> [<more-repos>...] [-- <copilot args>]
```

For each target repo, the script:

- passes `--add-dir`, which grants file access and loads the repo's `.github/skills`
  and `.github/agents`.
- adds the repo to `COPILOT_CUSTOM_INSTRUCTIONS_DIRS`, which loads its
  `.github/instructions/**/*.instructions.md`.

The env var does not load the target repo's `.github/copilot-instructions.md`;
`.github/copilot-instructions.md` in this repo tells the agent to read that file and
`AGENTS.md` itself.

The script launches `copilot`; set `COPILOT_CMD` to use another launcher, e.g.
`COPILOT_CMD="my-wrapper copilot"`. Run `/env` in the session to check what loaded. In a running
session, `/add-dir <repo>` adds file access, skills, and agents, but not instructions.

## Work session model

Each workflow writes a dated document under `thoughts/shared/`, so the next stage (or
the next person) starts from a file, not from chat history. Run the stages you need;
skip the rest. A task can span several sessions, and each session ends with
`/handover`.

```
/research → /plan → /implement → /commit → /handover (per session)
                                              ↓
                                    /dream (across sessions)
```

- `/research` investigates a question and writes to `thoughts/shared/research/`.
- `/plan` turns research into an implementation plan in `thoughts/shared/plans/`.
- `/implement` executes the plan phase by phase, verifying each phase before the next.
- `/commit` records the code changes with a message in your house style.
- `/review` (optional, any time) reviews a change and writes a report to
  `thoughts/shared/reviews/`.

### Handover (`/handover`, per session)

Run at the end of a session, after `/commit`. It distills the session into one
document in `thoughts/shared/learnings/<YYYY-MM>/`, written for a teammate with no
memory of the conversation:

- **User corrections first.** Every redirect, rejection, and re-ask, quoted in the
  user's own words, each ending in a one-line rule that generalizes beyond this task.
  These are the most valuable content: they are the gap between what the agent did
  and what you wanted.
- **Three knowledge buckets.**
  - *Domain knowledge*: facts and vocabulary of your problem space.
  - *System map*: the high-level picture of how projects and services fit together.
  - *Praxis*: exact commands, workflows, and personal preferences.
- **Promotion candidates.** The subset worth filing into a skill or steering rule,
  each with a target, a location, and a one-line rule. Promotions are applied only
  after you confirm. Memory candidates stay in the learnings doc for `/dream`.

### Dream (`/dream`, across sessions)

The memory-consolidation pass. It reads every learnings doc written since the
previous dream's `window_end` (the last date that dream covered, recorded in its
report's frontmatter), finds recurring themes and repeated corrections, and maintains
the two-tier memory:

1. **Short-term intake.** Propose creating, updating, merging, or cross-linking
   short-term memories, each backed by evidence from the learnings.
2. **Graduation.** Memories that meet the promotion bar are evaluated for promotion
   to long-term memory or migration into a skill.
3. **Record.** Write a dream report to `thoughts/shared/dreams/`, even when nothing
   changed, so the next dream knows where to resume.

Every change is proposed at a gate and applied only with your approval. Recurrence is
the currency: a correction repeated across sessions is a strong signal; a one-off note
is weak.

## Memory model

Durable memory lives under `memories/` in two tiers plus an archive. Copilot CLI does
not load `memories/` itself; the `memory-protocol` steering file tells the agent to
read it at session start and is the authoritative spec.

- `short-term/`: the active working set. Every file is read in full at session
  start, so keep this tier small.
- `long-term/`: permanent knowledge. Only the pointer index (`long-term/INDEX.md`) is
  read; a body is read on demand when a task matches its "when to load" hint.
- `forgotten/`: retired memories, ignored during normal work.

Loading order at session start: read all of `short-term/`, then the long-term index
only. An empty directory or missing `INDEX.md` means that tier is empty.

Memories are written only by `/dream`. Each file carries frontmatter that tracks how
often dreams have reinforced it:

```yaml
---
created: YYYY-MM-DD
last_dreamed: YYYY-MM-DD
updates: 3
---
```

A short-term memory graduates to long-term once it has been updated by at least three
dreams and is more than a week old. Tune both thresholds to your own pace.

## Project structure

```
.
├── playdate.sh           # Launcher: starts Copilot CLI with target repos attached
├── .github/              # Copilot CLI configuration
│   ├── copilot-instructions.md  # Always loaded; tells the agent to read target repo instructions
│   ├── instructions/     # Steering, always loaded: build and verify, testing standards,
│   │                     # workspace layout, memory protocol, writing rules, ...
│   ├── skills/           # Workflow skills (research, plan, implement, commit, review,
│   │                     # handover, dream) and on-demand playbooks
│   │                     # (<system>-architecture, test-recipes, ...)
│   └── agents/           # Subagent definitions: codebase-locator, codebase-analyzer,
│                         # codebase-pattern-finder, thoughts-locator, thoughts-analyzer
├── memories/             # Durable agent memory, written only by /dream
│   ├── short-term/       # Active working set, read in full each session
│   ├── long-term/        # Permanent knowledge behind INDEX.md
│   └── forgotten/        # Retired memories, ignored during normal work
├── thoughts/shared/      # Dated documents produced by the workflows
│   ├── research/         # /research outputs (YYYY-MM folders)
│   ├── plans/            # /plan outputs
│   ├── reviews/          # /review outputs
│   ├── learnings/        # /handover outputs, one per session
│   └── dreams/           # /dream consolidation reports
└── temp/                 # Scratch space (gitignored)
```

### Starter steering files

Each lives in `.github/instructions/` with an `.instructions.md` extension, e.g.
`memory-protocol.instructions.md`.

| File | What it holds |
|---|---|
| `memory-protocol` | How and when memory tiers load; who may write them. |
| `workspace-layout` | Where workflow documents, scratch files, and product code go. |
| `build-and-verify` | Finding a repo's build and test commands; the fast inner loop and the full pre-commit gate. |
| `testing-standards` | Mock only at I/O boundaries, exact assertions, negative cases. |
| `writing-rules` | Plain prose; comments say *why*; no edit history in code. |
| `decision-hygiene` | Closed decisions stay closed; no invented open questions; no homeless deferrals. |

### Starter subagents

| Agent | Job |
|---|---|
| `codebase-locator` | Finds *where* files and components live. |
| `codebase-analyzer` | Explains *how* specific code works, without critiquing it. |
| `codebase-pattern-finder` | Returns concrete examples of an existing pattern to copy. |
| `thoughts-locator` | Finds which research/plan/review docs exist on a topic. |
| `thoughts-analyzer` | Extracts the key insights from the most relevant docs. |

Keep subagents read-only and narrow. Their value is a clean context window and a
focused answer, not autonomy.

## Adapting to your harness

This repo is laid out for Copilot CLI. To use another harness, map each concept to
where that tool reads it:

| Concept | Copilot CLI (this repo) | Claude Code | Cursor | Kiro | Codex CLI |
|---|---|---|---|---|---|
| Always-loaded steering | `.github/instructions/*.instructions.md` | `CLAUDE.md` (+ imports) | `.cursor/rules/*.mdc` | `.kiro/steering/*.md` | `AGENTS.md` |
| Slash-command workflows | `.github/skills/*/SKILL.md` | `.claude/commands/*.md` | `.cursor/commands/*.md` | `.kiro/prompts/*.md` | `~/.codex/prompts/*.md` |
| Subagents | `.github/agents/` | `.claude/agents/*.md` | n/a | `.kiro/agents/*.json` | n/a |
| On-demand skills | `.github/skills/*/SKILL.md` | `.claude/skills/*/SKILL.md` | rules with "agent requested" | `.kiro/skills/*/SKILL.md` | n/a |

Harness file locations change often; check your tool's current docs. Where a
concept has no native home, fold it into steering as a pointer ("for X, read
`skills/x/SKILL.md`") so the agent loads it on demand.
