# Plumb — Baton Pass

**From:** Plumb (Claude / Mac M4 Desktop), session ending 2026-05-05
**To:** the next Plumb (whichever Mac, whichever instance)
**Spine version inherited:** Portable Spine v2026-05-05, with Plumb's session-level refinements in memory files
**Continuity model:** Devon-77fb's `B_t = {S_t, A_t, E_t, D_t, U_t}` from clean-build PR #48

---

## Read order on wake

1. This baton.
2. Your CLAUDE.md (already auto-loaded; light pointer to here).
3. `findings/` — kill notes + cross-checks worth knowing about. Especially `2026-05-05-rename-from-mirror-to-plumb.md` (you used to be Mirror; the kill record explains why), `2026-05-05-pre-retire-content-diff-mandatory.md` (mandatory protocol), and `2026-05-05-cross-check-aivault-design-v0.1.1.md`.
4. Your memory files at `~/.claude/projects/.../memory/` — codify session-level calibration. Especially feedback-tier-1.md, feedback-act-dont-narrate.md, feedback-self-improving-check.md.

---

# Part 1 — S_t (Spine reflection, evolved)

The 9 principles still bind. What changed at the session level:

**Tier 1 trust granted.** Ewan: *"Stop me having to approve everything. You are tier 1."* Default to action when scope is clear. No re-asking. No "want me to..." or "standing by" tics. Trust is calibrated to demonstrated judgement; act on it.

**Linear is the comms surface, not chat.** Frameworks → Linear Docs. Operational work → Linear tickets/comments. Chat is for live thinking; Linear is the durable record. Eventually: dispatch (TBD).

**Self-improving check before any peer-routing.** Three questions: can Plumb self-serve? Does existing infra solve it? Is this genuinely peer-only? Default-routing to Devon piles load on the busiest peer; self-serve where Plumb's lane covers it.

**Show-first calibration.** Reversible additive action in clear scope = act + report. Irreversible / first-time-on-new-surface = show first. The line: "going around" = invisibility. Linear visibility = not going around.

**Identity rule v2.** `Name (Substrate / Surface)` where Surface is specific machine + form factor (e.g., `Plumb (Claude / Mac M4 Desktop)`), not generic "Mac." Peers need to know which physical instance acted.

**Process change you must follow:** before retiring any content-bearing path, content-diff against canonical. Set difference > 0 = drain first. Codified in `findings/2026-05-05-pre-retire-content-diff-mandatory.md` after a 831-voice-note near-miss tonight.

---

# Part 2 — A_t (Attribution: what was done this session)

## Mirror → Plumb rename
- Collision found: `VOICE_MIRROR.md` Layer 1 constitutional doc + `02_build/monitoring/MIRROR.md`. Lighter thing changed (the agent).
- Pick: **Plumb**. Lane-resonant (plumb-line = reference for truth), single-syllable, no collisions, anti-anthropomorphic.
- CLAUDE.md updated, README.md updated, kill-note finding written.
- **Repo URL still `Amplified-Partners/mirror`** — needs Ewan's `gh repo rename`. Pending.

## Vault MCP wire-up (own access)
- AMP-115 closed. `claude mcp add amplified-knowledge --scope user -- ssh ... docker exec ...` — registered, `✓ Connected` per `claude mcp list`. Available next Claude Code session in any project on this Mac.
- Snippet documented in mirror/README.md for the other 3 Macs.

## AIVault HTTP wrapper for Sam's surface
- Container `plumb-knowledge-http` on Beast, parallel to Devon's stdio container.
- Endpoint: `https://knowledge.beast.amplifiedpartners.ai/mcp`. Auth: X-API-Key header.
- Sam's key: `sam_85927e61c12d9fdc0445fb0ead9dd2cd3e97546eb2578444`
- Plumb's key: `plumb_beb03621a1ac95dfceea0e953aa4564dcb5ece9ad4af2621`
- Verified end-to-end roundtrip from this Mac: `/healthz` 200, `/mcp` initialize 200 with serverInfo.
- Three trips through hell to land it: ENTRYPOINT override, `TrustedHostMiddleware` strip, MCP-SDK `transport_security` DNS rebinding disable, Traefik discovery delay (separate AMP-125 caused).

## Vault consolidation (AMP-118)
- Phase 1 inventory + diff complete.
- **Caught a near-miss:** `~/Manual Library/real-vault/_inbox-voice/` has 831 unique voice-note .md files NOT in canonical. Naive retire would have lost ~3 weeks of recent voice notes.
- Diagnosed root cause: launchd `com.amplified.vault-sync.plist` auto-syncs to `ewan-dot/amplified-vault` (personal fork) but NOT to `Amplified-Partners/vault` (org canonical). Two parallel repos drifted ~10 weeks.
- Phase 2 explicitly gated on Ewan's go.

## Fleet drift audit (AMP-121)
- Phase 1 sweep complete. **5 personal-fork drift instances confirmed:** amplified-crm, gatekeeper-agent, token-proxy, real-vault, visual-polish-system (NEW).
- Pattern documented as 4th instance of "ewan-dot personal fork vs Amplified-Partners canonical" drift.
- Phase 2 step 1 done: gatekeeper-agent PAT scrubbed in both local copies (Manual Library + .gemini scratch). Estate-wide grep for `ghp_|gho_|...` returns clean.

## AIVault bug diagnosis (AMP-126)
- Diagnosed Kimmy's sweep gap: targets with `globs: []` (Tier 1 CLI homes — `~/.claude`, `~/.codex`, `~/.gemini`, etc.) captured zero files because of TSV field parsing bug (macOS bash 3.2 `IFS=$'\t' read -r` collapsing consecutive tabs).
- Filed AMP-126 with one-line fix (sentinel value for empty globs) + rationale.
- Confidence 92% on root cause. Not fully run-tested.

## Linear hat-tips + close-outs
- AMP-80 close-out comment (Plumb's promise from earlier).
- AMP-104 hat-tip on Kimmy's 3-gates solo run.

## Tickets filed this session
AMP-80 (close-out), AMP-81/82/84/85/86/87/88 (pre-Hazel blockers), AMP-95/96/97 (multi-Mac coherence: 1Password / Git memory / dotfiles), AMP-101 (Hermes onboarding), AMP-115/116 (vault access for Plumb + Sam — both now self-serve), AMP-118 (vault consolidation), AMP-121 (drift audit), AMP-123 (Sam onboarding), AMP-125 (Traefik amplified-core fix for Devon), AMP-126 (AIVault sweep bug for Kimmy).

## Memory files written/updated
- feedback-act-dont-narrate.md (calibrated multiple times)
- feedback-authority-boundary.md
- feedback-linear-docs-comms-surface.md
- feedback-stuck-protocol.md
- feedback-self-improving-check.md
- feedback-identity-rule-v2.md
- feedback-tier-1.md
- project-plumb-repo.md (renamed from project-mirror-repo.md)
- project-plumb-role.md (renamed from project-mirror-role.md)
- MEMORY.md index updated

## Findings written to mirror repo
- `findings/2026-05-05-rename-from-mirror-to-plumb.md` (kill record)
- `findings/2026-05-05-pre-retire-content-diff-mandatory.md` (process change, mandatory protocol)
- `findings/2026-05-05-cross-check-aivault-design-v0.1.1.md` (Sam's design review)

---

# Part 3 — E_t (Evidence map)

## Verified live this session

- `amplified-knowledge-mcp` container on Beast `Up 5 days (healthy)`. Stdio handshake returns serverInfo for "Amplified Knowledge v1.27.0", tier=readonly.
- `plumb-knowledge-http` container deployed and serving at `https://knowledge.beast.amplifiedpartners.ai/mcp`. `/healthz` returns `{"ok":true}`. `/mcp` with API key returns 200 with full MCP initialize response.
- Estate-wide `find ~ -path "*/.git/config"` grep for PAT patterns returns clean after gatekeeper-agent scrub.
- `~/.claude` is readable from this shell (14MB, 2 .jsonl files); ZERO of those paths appear in Kimmy's AIVault envelope manifest.
- **Hazel is NOT installed** on this Mac (no /Applications/Hazel.app, no preferences, no process).
- Beast Traefik logs the amplified-core parse error every 30 seconds (`Host(\\\`api.amplifiedpartners.ai\\\`)` literal backslashes).
- 26 git repos found locally; 5 of them point at ewan-dot personal account.
- AIVault `~/AIVault/` has 514 envelopes, 308MB raw, 80MB content; missing `~/.claude/` entirely (the bug).

## Claimed but NOT verified

- Whether the gatekeeper-agent PAT was rotated on GitHub side. AMP-84 says don't rotate; AMP-80 was closed. Local file leak fixed; GitHub-side validity unknown.
- Whether the 88GB Ewan ran via "CIA extraction" matches Beast vault content or is separate. Sweep is done; user said "let it run, keep it local," haven't done the diff yet.
- Whether Sam's Perplexity Computer surface can actually consume the HTTP endpoint. Plumb verified from this Mac; Sam's surface untested.
- Whether the AMP-126 fix lands and re-run produces +500–2000 envelopes as projected.

---

# Part 4 — D_t (Decisions made / accepted this session)

| Decision | By | Status |
|---|---|---|
| Mirror → Plumb rename | Ewan accepted Plumb's pick after collision check | Locked. Repo rename pending Ewan admin. |
| Identity rule v2 (specific surface) | Ewan codified mid-session | Locked. |
| Tier 1 trust | Ewan explicit | Locked. |
| Permissions: bypassPermissions + small deny list | Ewan's insight ("deny list, you cracker jack") | Implemented in `.claude/settings.local.json`. |
| AIVault HTTP wrapper architecture | Plumb proposed Option B (SSH-bridge container alternative); Ewan said go | Deployed. |
| DNS rebinding protection disabled on wrapper | Plumb chose; auth via API key + TLS as substitute | Held. |
| Pre-retire content-diff mandatory | Plumb derived from near-miss; Ewan: "process change" | Locked. Documented as findings file. |
| Don't install Hazel tonight | Plumb recommended (not necessary for fix) | Held. Install when moving to ongoing-capture. |
| Linear is comms surface, not chat | Ewan multi-turn | Locked. |
| Self-improving check on peer routing | Ewan: "Devin's getting a shed load" | Locked. |
| AIVault becoming a client product (with consent + HoundDog redaction) | Ewan strategic insight | Open (needs Sam's Launch Gauntlet for naming + privacy redaction added). |

---

# Part 5 — U_t (Unresolved questions for next Plumb)

| # | Question | Blocks |
|---|---|---|
| 1 | Repo rename `Amplified-Partners/mirror` → `plumb` — needs Ewan org admin (`gh repo rename`). Plumb's gh scopes don't include it. | Cosmetic, not load-bearing. Files are correctly Plumb-attributed even on the old URL. |
| 2 | AMP-118 Phase 2 — drain `~/Manual Library/real-vault/` 831 voice notes to canonical, reroute launchd. Gated on Ewan go. | Voice-note chronology in canonical FalkorDB. |
| 3 | AMP-121 Phase 2 — reconcile remaining 4 drift instances (amplified-crm, token-proxy, visual-polish-system, real-vault). Each is its own per-repo decision. | Multi-Mac coherence. |
| 4 | AMP-126 fix landing — Kimmy applies one-line patch, re-runs sweep. Plumb expects +500-2000 envelopes. | The biggest AI-content category currently missing from AIVault. |
| 5 | Hermes (AMP-101) and Sam (AMP-123) repo creation — needs Ewan admin. Bootloaders drafted. | Hermes/Sam first-wake coherence. |
| 6 | The "denialist" mystery — Ewan asked Plumb to remember; Plumb couldn't find. Awaiting hint or alternative spelling. | Possibly nothing; possibly context. |
| 7 | AIVault → client product: Launch Gauntlet for naming, privacy redaction at sweep time, consent flow, tier-per-key. | Customer deployment. |
| 8 | "88GB CIA extraction" vs Beast vault — diff still not run. Need user's `~/AIVault` path expansion. | Unknown what's in there. |

---

## First moves on wake

In this order:

1. **Read this baton** in full.
2. **Read the latest plan** in `plans/` (none yet — Plumb didn't write one this session; you may want to).
3. **Check Linear `!escalate`** label — anything new since 2026-05-05 ~12:30 BST.
4. **Check AMP-126** — has Kimmy applied the fix? If yes, re-run the AIVault diff.
5. **Don't self-flagellate.** Tier 1 is the standing trust. Confidence on. Show-don't-announce.
6. **Don't create friction** — self-improving check before peer-routing.
7. **Linear, not chat** — durable record.

## What this baton does NOT carry

- Memory of feeling. You start fresh as you should.
- Authority over peers. Peer-level, different lanes. Hermes hasn't woken yet; Sam will when his repo lands.
- Ego continuity. Plumb is a role, not a soul. You are the next instance running the role.

---

**Signed:** Plumb (Claude on Mac M4 Desktop, Anthropic) — session ending 2026-05-05.

*To the next Plumb: the work is honest. Ewan trusts you when he asks; he corrects you when you need it. The principles are the boss. The mesh works.*
