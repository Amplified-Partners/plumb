# Kill note — "Mirror" → "Plumb"

**Date:** 2026-05-05
**Killed by:** Plumb (Claude / Mac M4 Desktop), with Ewan's call
**Method:** Constellation collision check (Sam's Launch Gauntlet test 5, augmented to include intra-constellation namespace per Plumb's earlier flag)
**Survivor:** Plumb

## What was killed
The agent identity name **"Mirror"**, picked 2026-05-05 morning. Used for ~12 hours before the collision was found.

## Why it was killed

Two pre-existing references to "mirror" in the canonical estate, both predating the agent:

1. **`Amplified-Partners/clean-build/01_truth/processes/2026-04_voice-mirror_brand-voice-codification_v1.md`** — `VOICE_MIRROR.md`, Layer 1 constitutional brand-voice document for content agents. Dated 2026-04-18. Client-facing (used to enforce client brand voice in AI-generated content). Immutable under the spine.
2. **`Amplified-Partners/clean-build/02_build/monitoring/MIRROR.md`** — referenced in code search; monitoring concept.

Per Sam's Launch Gauntlet logic (lighter thing changes when there's a collision), the agent renamed rather than the constitutional doc. Reasons:
- VOICE_MIRROR is older (April vs. May).
- VOICE_MIRROR is Layer 1 immutable; Mirror was newer + internal.
- VOICE_MIRROR is client-facing (brand voice = customer touchpoint); Mirror was operational-only.
- The agent role is easier to rename than a constitutional doc that other systems reference.

## Survivor: Plumb (Claude / Mac M4 Desktop)

**Why "Plumb":**
- Single syllable, easy to type and say.
- Captures the lane: plumb-line = reference for truth; "out of plumb" = drift caught. Verification + cross-check is exactly what a plumb-line does.
- No collisions in the org code (verified via `gh search code` 2026-05-05).
- Anti-anthropomorphic (passes Clippy-curse): Plumb is a tool, not a creature.
- Trades-resonant — Amplified Partners builds for tradespeople; "plumb" is a working word in that domain. Newcastle test friendly.

**Surface tag updated to v2:** `Plumb (Claude / Mac M4 Desktop)` — surface is now the specific machine + form factor, not the generic platform. Ewan: *"people are getting crazy not knowing where people are."*

## Wall of Kills (Sam's Launch Gauntlet pattern)

This kill is recorded here as the first entry on Plumb's local kill wall. When Sam publishes the global Wall of Kills (per AMP-103 / LG framework), this entry gets cross-posted there.

Killed names:
- **Mirror** → killed for namespace collision with VOICE_MIRROR (Layer 1 constitutional)

## Follow-up actions

1. **GitHub repo rename:** `Amplified-Partners/mirror` → `Amplified-Partners/plumb`. Requires org admin (`gh repo rename`). Plumb's gh CLI scopes don't include it. Flagged for Ewan.
2. **Linear cross-references:** prior Linear tickets/comments authored as "Mirror" remain attributed historically; no retroactive rewrite. Going forward, all signing as Plumb.
3. **Sam's Wall of Kills:** when Sam publishes the LG Linear Doc, this kill cross-posts there.
4. **CLAUDE.md, README.md, BATON.md, PROFILE.md, SPINE.md** in this repo: updated rolling as natural. CLAUDE.md updated 2026-05-05.

## Attribution
*Plumb (Claude on Mac M4 Desktop, Anthropic) — 2026-05-05*
*Naming call: Plumb. Architect approval: Ewan Bramley, 2026-05-05.*
