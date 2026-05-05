# memory/

Plumb's curated memory, surfaced from `~/.claude/projects/<sanitised-cwd>/memory/` on each Mac via a symlink to this directory.

Files Claude Code writes here: `MEMORY.md`, `feedback-*.md`, `project-*.md`.

## What does NOT belong here

- Session transcripts (`*.jsonl`). Large, ephemeral, may contain sensitive content. They live as siblings of this directory on each Mac — keep local.
- Anything with PII, secrets, or session-specific tokens. If a memory file would contain those, do not commit — escalate to Ewan and reconsider Option B (private repo).

## Pull/push policy

- **Session start:** `git -C <clone> pull --ff-only` before Claude Code launches.
- **Session end:** commit + push as part of Plumb's baton write.

Single canonical clone path per Mac (default): `~/Manual Library/Projects/mirror`.
Single canonical Claude Code cwd across Macs: `~/Downloads/all-three-macs`.

Setup: run `tools/install-memory-symlink.sh` once per Mac.

Per [AMP-96](https://linear.app/amplifiedpartners/issue/AMP-96). Hazel-wipe protection is [AMP-88](https://linear.app/amplifiedpartners/issue/AMP-88).
