# Cross-check — Sam's AIVault design v0.1.1

**From:** Plumb (Claude / Mac M4 Desktop)
**Date:** 2026-05-05
**Re:** `aivault_design_v0.1.1_for_kimmy.zip` (also reviewed v0.1.0 → v0.1.1 diff)
**Status:** Additive review per Sam's "argue with me" invitation in §4 of WORKING_NOTES

## TL;DR

Design is solid. Sam's framing — *"the vault doesn't store conversations; it stores fragments that, when graph-traversed and time-indexed, become the chronological story"* — is the right framing. The 13-tier path inventory is thorough.

Plumb's cross-check finds:
- **3 high-confidence path gaps** in the sweep coverage that Plumb knows from this Mac specifically
- **§4 pushbacks** with informed positions (4 of Sam's 6 self-doubts, Plumb agrees + offers concrete moves)
- **1 verification concern** about whether the running sweep is using v0.1.0 or v0.1.1

Total length here is for completeness; the actionable parts are §1 and §3.

---

## 1. Path gaps Plumb knows from this Mac (high-leverage adds)

Sam's `sweep_targets.yaml` is thorough but missing these, all verified to exist on this M4:

### 1a. `~/.gemini/antigravity/scratch/`
**What:** Gemini IDE / Antigravity desktop scratch space. Plumb found a full clone of `gatekeeper-agent` here while scrubbing tokens for AMP-121. This is where Antigravity stages working code. Not in any Tier.
**Why it matters:** This is where another agent's working state lives — exactly the kind of "AI-assisted work fragment" the sweep is for.
**Suggested tier:** new entry in Tier 1 alongside `~/.claude`, `~/.codex`, `~/.gemini`. Path `~/.gemini/antigravity/scratch/`.

### 1b. `~/Manual Library/beast-bridge/`
**What:** Plumb's read-only Beast bridge daemon — audit logs of every cross-machine query Plumb has made. Mac-side. Currently only Plumb knows about it.
**Why it matters:** Forensic record of which agent queried what and when. Maps directly onto the "story" framing.
**Suggested tier:** Tier 9 (per-project AI instructions) — it's not really code, more like ops state. Or new "Tier 14: agent-authored runtime state" if Sam wants a clearer home.

### 1c. `~/.amplified/`
**What:** Holds `keys.env` (the secret store), and various per-tool config the AP estate references.
**Why it matters:** Core to the AP-specific tooling. Currently flagged for protection on the Hazel-side ([AMP-95](https://linear.app/amplifiedpartners/issue/AMP-95) wants to move to 1Password CLI). For AIVault sweep, it's metadata-worthy *if redacted*.
**Suggested tier:** Tier 13 (user-specified extras). With max_file_mb=1 and explicit redaction of secret values — capture filenames + structure but not the secret strings themselves.

### Sub-finding: voice + messaging
Sam's design captures `~/Library/Application Support/Claude` etc. but not:
- `~/Library/Group Containers/group.com.apple.VoiceMemos.shared/` — Apple Voice Memos
- `~/Library/Messages/chat.db` — iMessage (if AI conversations were forwarded via iMessage; some users do)
- `~/Library/Group Containers/group.com.apple.notes/NoteStore.sqlite` — Apple Notes (often used as AI scratch)

These aren't AI-vendor data per se, but they're where AI work *lands* (transcripts pasted into Notes, voice notes that became prompts). Lower priority — only worth adding if Ewan confirms he uses them as AI handoffs.

## 2. §4 pushback — Plumb's informed positions on Sam's self-doubts

### §4.1 — Sibling capture greedy (Sam's first worry)
**Plumb agrees this is real.** Per Plumb's recent fleet-wide drift audit (AMP-121), this Mac has 26 git repos, several with sizable `node_modules`/`.venv`/`Pods/`/`target/`. The current `skip_if_dir_contains` list catches the major offenders but is missing:
- `vendor/` (Go modules, Composer)
- `Pods/` (CocoaPods, mid-skip tier)
- `Carthage/` (legacy iOS)
- `_build/` (Erlang/Elixir, Sphinx)
- `.tox/`, `.pytest_cache/`, `.ruff_cache/`, `.mypy_cache/` (Python tooling caches — already big at multi-GB on dev machines)
- `__pycache__/` (already in your bloat list elsewhere; double-check it's in the skip list here)
- `.next/`, `.nuxt/` (JS frameworks)
- `target/` (Rust — already there ✓)
- `DerivedData/` (Xcode — already there ✓)

**Recommended addition:** also skip dirs containing a `.skip-aivault` marker file. Lets Ewan opt-out specific projects without YAML edits.

### §4.2 — Content extraction at sweep time
**Plumb agrees with Sam's preference: split into phases.** Sweep produces raws + envelopes. Extraction is phase 2, re-runnable. Reasoning: extraction is interpretive and format-versioned (Anthropic JSONL schema may change); capture is forensic and stable. They have different lifecycles. If you bake extraction into sweep, every schema change forces a re-sweep; if separate, you re-extract from existing raws.

### §4.3 — YAML envelope verbosity
**Plumb says: switch envelopes to JSON, keep schema in YAML.** Standard pattern. JSON for the per-file artefact (machine-readable, smaller, parses faster, no ambiguity). YAML for the schema definition (human-readable, comments). The annotated `envelope.schema.yaml` is gold for documentation; the on-disk envelopes don't need to be that readable.

Bonus: NDJSON envelopes (one per line, append-only) would let the manifest and envelopes share a format, which simplifies the read-side queries for FalkorDB ingest.

### §4.4 — Hash chain on manifest
**Plumb says: keep it.** Cost is negligible (sha256 over a hundred KB of manifest text per chain entry), value is real (irrefutable evidence of sweep order, useful for any future audit). Graffiti's temporal ledger expects this shape; matching it now saves a round-trip later.

### §4.5 — SQLite cp-snapshot
**Plumb agrees this is a real torn-write risk.** Replace `cp` with `sqlite3 source.db ".backup dest.db"` for any `.db` file detected. Atomic by SQLite contract. Catches Cursor's `state.vscdb`, Comet's `History`, Apple Messages' `chat.db`, etc. Slight CPU overhead vs `cp`, but the integrity guarantee is worth it for forensics.

### §4.6 — `AIVAULT_USER_ID` enforcement
**Plumb says: fail loud at sweep start, with a one-line error.** Ten-line check at the top of `final_sweep.sh`. No reason to allow the sweep to proceed if user identity is unset — every envelope downstream is then untethered from `accounts.yaml` reconciliation.

## 3. Verification concern — is the running sweep using v0.1.1?

The currently-running sweep at `~/AIVault/` (PID was 9866 per Ewan; Plumb couldn't see it via `ps` so may have been transient parent) — Plumb hasn't verified whether it's executing v0.1.0 or v0.1.1. The differences matter:

- v0.1.0 → v0.1.1 added `config/accounts.yaml` (account reconciliation source-of-truth)
- v0.1.0 → v0.1.1 split identity into `real_person` + `device_uuid` (vs single `identifier` field in v0.1.0)
- Without v0.1.1's accounts.yaml, every captured email is `unknown_to_user` until Sam runs the re-attribution pass

**Recommendation:** when sweep finishes, check `~/AIVault/_sweep_logs/sweep_*.yaml` — should show which version of `final_sweep.sh` ran. If v0.1.0, Sam's re-attribution pass needs to run before any FalkorDB ingest — otherwise attribution is partial.

## 4. accounts.yaml — Plumb's quick verification

Sam lists 4 emails. From this Mac's git configs Plumb already knows:
- `ewan-dot` is a github username (used in personal forks — `ewan-dot/amplified-vault`, `ewan-dot/amplified-crm`, etc.)
- The plaintext PAT scrubbed earlier today was on a `ewan-dot` URL
- Git commit author emails are diverse — worth running `git log --all --pretty=format:'%ae' | sort -u` across all clones to see what emails actually appear in commits. Could surface emails Sam doesn't have in `accounts.yaml` yet.

Plumb hasn't done this run yet — small Mac-side audit, Plumb's lane. Can do post-sweep if useful.

## 5. What Plumb is NOT pushing back on

- The 13-tier shape — right.
- The "story" framing — right.
- Time as the spine — right; this is what Graphiti is structurally good for.
- sha256 dedup as the cross-system union key — right.
- "Capture, don't curate" — right; reconstruction is downstream's job.
- The decision to NOT do PII redaction at sweep time — right; Plumb agrees redaction destroys forensic fidelity, add a redacted parallel corpus later if sharing-out is needed.
- The "no Hazel rules" decision — right; the initial sweep is a one-shot, ongoing capture is a different problem.

## Source

Plumb (Claude / Mac M4 Desktop), 2026-05-05. Cross-check requested implicitly via Ewan sharing both zips. Sam invited pushback specifically on §4 and on path coverage; this finding addresses both.

