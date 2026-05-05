#!/usr/bin/env bash
# install-memory-symlink.sh — make Plumb's memory/ a symlink to this git clone.
#
# Idempotent. Run once per Mac. Migrates ~/.claude/projects/<sanitised-cwd>/memory/
# into the clone, then replaces the local dir with a symlink.
#
# Per AMP-96. Run BEFORE Claude Code's first session in the canonical cwd —
# otherwise Claude Code will create a real dir and the symlink will collide.
#
# Devon-de39 | 2026-05-05 | session devin-de399f26f0e04f7a86776e750a2c0444

set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/Amplified-Partners/mirror.git}"
CLONE_PATH="${CLONE_PATH:-$HOME/Manual Library/Projects/mirror}"
CWD="${CWD:-$HOME/Downloads/all-three-macs}"

# Claude Code sanitises the cwd by replacing every '/' with '-'. Leading slash
# becomes a leading dash. Verified against AMP-88 evidence:
#   /Users/ewanbramley/Downloads/all-three-macs
#   → -Users-ewanbramley-Downloads-all-three-macs
SANITISED="$(printf '%s' "$CWD" | sed 's|/|-|g')"
LOCAL_MEMORY="$HOME/.claude/projects/$SANITISED/memory"
TARGET_MEMORY="$CLONE_PATH/memory"

cat <<EOF
config
  cwd            $CWD
  sanitised dir  $SANITISED
  local memory   $LOCAL_MEMORY
  clone path     $CLONE_PATH
  target memory  $TARGET_MEMORY
EOF

# 1. clone if absent, otherwise pull
if [ ! -d "$CLONE_PATH/.git" ]; then
  echo "cloning $REPO_URL → $CLONE_PATH"
  mkdir -p "$(dirname "$CLONE_PATH")"
  git clone "$REPO_URL" "$CLONE_PATH"
else
  echo "clone exists; pulling latest"
  git -C "$CLONE_PATH" pull --ff-only
fi

# 2. ensure target memory dir exists
mkdir -p "$TARGET_MEMORY"

# 3. handle whatever the local memory path currently is
if [ -L "$LOCAL_MEMORY" ]; then
  current="$(readlink "$LOCAL_MEMORY")"
  if [ "$current" = "$TARGET_MEMORY" ]; then
    echo "already symlinked correctly — done."
    exit 0
  fi
  echo "existing symlink → $current; replacing"
  rm "$LOCAL_MEMORY"
elif [ -d "$LOCAL_MEMORY" ]; then
  echo "local memory is a real dir; migrating files into clone"
  shopt -s nullglob dotglob
  for f in "$LOCAL_MEMORY"/*; do
    base="$(basename "$f")"
    case "$base" in
      *.jsonl|*.log|*.tmp|.DS_Store)
        # ephemeral noise — already covered by memory/.gitignore.
        # delete (don't just skip) so the dir can be removed and the symlink created.
        echo "  skip+rm: $base"
        rm -f "$f"
        continue
        ;;
    esac
    if [ -e "$TARGET_MEMORY/$base" ]; then
      echo "  conflict: $base already in clone — keeping local at $f.local"
      mv "$f" "$f.local"
    else
      mv "$f" "$TARGET_MEMORY/$base"
      echo "  moved:   $base"
    fi
  done
  if [ -z "$(ls -A "$LOCAL_MEMORY")" ]; then
    rmdir "$LOCAL_MEMORY"
  else
    echo "WARNING: $LOCAL_MEMORY not empty after migration — not removing."
    echo "         inspect remaining files before rerunning:"
    ls -la "$LOCAL_MEMORY"
    exit 1
  fi
fi

# 4. parent dir must exist for symlink
mkdir -p "$(dirname "$LOCAL_MEMORY")"

# 5. symlink
ln -s "$TARGET_MEMORY" "$LOCAL_MEMORY"
echo "symlinked: $LOCAL_MEMORY → $TARGET_MEMORY"

# 6. surface anything to commit
if [ -n "$(git -C "$CLONE_PATH" status --porcelain memory/)" ]; then
  cat <<EOF

memory/ has uncommitted changes after migration. commit + push:
  cd "$CLONE_PATH"
  git add memory/
  # set user.name to your Mac-specific surface per Plumb's identity rule v2.
  # e.g. 'Plumb (Claude on Mac M4 Desktop, Anthropic)' / 'Mac M3 Pro Laptop' / etc.
  git -c user.name="Plumb (Claude on $(hostname -s 2>/dev/null || echo Mac), Anthropic)" commit -m 'memory: migrate from local Mac'
  git push
EOF
fi

echo "done."
