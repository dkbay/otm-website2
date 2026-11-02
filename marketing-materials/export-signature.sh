#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
HUGO="${HUGO:-hugo}"
TEMPLATE="$SCRIPT_DIR/email-templates/signature.html"
OUTPUT="$SCRIPT_DIR/out/email-templates/signature.html"

discordUrl=$(cd "$REPO_ROOT/frontend" && "$HUGO" config --format json | jq -er '.params.social.discord')

mkdir -p "$(dirname "$OUTPUT")"
sed "s#__DISCORD_URL__#${discordUrl}#g" "$TEMPLATE" > "$OUTPUT"

if grep -q '__DISCORD_URL__' "$OUTPUT"; then
  echo "error: $OUTPUT still holds __DISCORD_URL__" >&2
  exit 1
fi
echo "  wrote $OUTPUT"
