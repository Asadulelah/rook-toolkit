#!/usr/bin/env bash
# Rook Toolkit installer — macOS. Safe to run more than once.
# Built by Asadulelah, 2026-07-28.
set -uo pipefail

B=$'\033[1m'; D=$'\033[2m'; G=$'\033[32m'; Y=$'\033[33m'; R=$'\033[31m'; N=$'\033[0m'
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRAIN="${ROOK_BRAIN:-$HOME/musahib-brain}"
ok=0; warn=0; fail=0
pass(){ printf "  ${G}OK  ${N} %s\n" "$1"; ok=$((ok+1)); }
note(){ printf "  ${Y}WARN${N} %s\n" "$1"; warn=$((warn+1)); }
bad(){  printf "  ${R}FAIL${N} %s\n" "$1"; fail=$((fail+1)); }

printf "\n${B}Rook Toolkit \xe2\x99\x9c${N}  built by ${B}Asad${N}\n${D}%s${N}\n\n" "$HERE"

# ── the brain ──────────────────────────────────────────────
printf "${B}Brain${N}\n"
if [ -d "$BRAIN" ] && [ -f "$BRAIN/CLAUDE.md" ]; then
  pass "found at $BRAIN"
else
  bad "musahib-brain not found at $BRAIN"
  printf "        ${D}Clone it first:${N}  git clone https://github.com/Asadulelah/musahib-brain.git ~/musahib-brain\n"
  printf "        ${D}Or point me at it:${N}  ROOK_BRAIN=/path/to/brain ./install.sh\n\n"
fi

# ── python ─────────────────────────────────────────────────
printf "\n${B}Fathom transcripts${N}\n"
if command -v python3 >/dev/null 2>&1; then
  pass "python3 $(python3 --version 2>&1 | awk '{print $2}')  (transcript grabber needs nothing else)"
else
  bad "python3 missing  ->  brew install python3"
fi

# ── uv + browser-harness ───────────────────────────────────
printf "\n${B}Your browser${N}\n"
if ! command -v uv >/dev/null 2>&1; then
  printf "  ${D}installing uv...${N}\n"
  curl -LsSf https://astral.sh/uv/install.sh | sh >/dev/null 2>&1 || true
  export PATH="$HOME/.local/bin:$PATH"
fi
if command -v uv >/dev/null 2>&1; then pass "uv $(uv --version 2>&1 | awk '{print $2}')"; else bad "uv install failed — see https://astral.sh/uv"; fi

if command -v browser-harness >/dev/null 2>&1; then
  pass "browser-harness already installed"
else
  BH="$HOME/Developer/browser-harness"
  printf "  ${D}installing browser-harness...${N}\n"
  mkdir -p "$HOME/Developer"
  [ -d "$BH" ] || git clone -q https://github.com/browser-use/browser-harness "$BH" 2>/dev/null
  if [ -d "$BH" ]; then
    (cd "$BH" && uv tool install -e . >/dev/null 2>&1) || true
    export PATH="$HOME/.local/bin:$PATH"
    command -v browser-harness >/dev/null 2>&1 && pass "browser-harness installed -> $BH" || note "installed but not on PATH — add \$HOME/.local/bin to PATH"
  else
    note "could not clone browser-harness (no network?) — see docs/BROWSER.md"
  fi
fi

# ── apify ──────────────────────────────────────────────────
printf "\n${B}Scraping + email verification${N}\n"
if command -v npm >/dev/null 2>&1; then
  if command -v apify >/dev/null 2>&1; then
    pass "apify CLI present"
  else
    printf "  ${D}installing apify-cli...${N}\n"
    npm install -g apify-cli >/dev/null 2>&1 && pass "apify CLI installed" || note "apify install failed — run: npm install -g apify-cli"
  fi
  if [ -f "$HOME/.apify/auth.json" ]; then
    pass "apify logged in as $(python3 -c "import json,pathlib;print(json.loads(pathlib.Path.home().joinpath('.apify','auth.json').read_text())['username'])" 2>/dev/null || echo '?')"
  else
    note "apify not logged in yet  ->  make a FREE account at apify.com, then run: apify login"
  fi
else
  bad "npm missing  ->  install Node from nodejs.org"
fi

# ── wire skills + tools into the brain ─────────────────────
printf "\n${B}Wiring into the brain${N}\n"
if [ -d "$BRAIN/.claude/skills" ]; then
  n=0
  for s in "$HERE"/skills/*/; do
    name="$(basename "$s")"
    rm -rf "$BRAIN/.claude/skills/$name"
    cp -R "$s" "$BRAIN/.claude/skills/$name" && n=$((n+1))
  done
  pass "$n skills installed  (/transcript /browse /leads)"
  mkdir -p "$BRAIN/tools"
  cp -R "$HERE"/tools/* "$BRAIN/tools/" 2>/dev/null && pass "tools copied to $BRAIN/tools/" || note "tools copy incomplete"
  printf "%s\n" "$HERE" > "$BRAIN/.rook/TOOLKIT" 2>/dev/null || true
else
  note "brain not found, skills not wired — clone the brain, then re-run this"
fi

# ── result ─────────────────────────────────────────────────
printf "\n${D}────────────────────────────────────${N}\n"
printf "  ${G}%d ok${N}   ${Y}%d warnings${N}   ${R}%d failures${N}\n\n" "$ok" "$warn" "$fail"

if [ "$fail" -eq 0 ]; then
  printf "  ${B}Two things left, both need you:${N}\n\n"
  printf "  1. ${B}Connect your browser${N}  ${D}(2 min)${N}\n"
  printf "     Open Brave or Chrome, go to ${B}chrome://inspect/#remote-debugging${N},\n"
  printf "     tick ${B}Allow remote debugging${N}, click Allow on the popup.\n"
  printf "     ${D}Then test:${N}  browser-harness <<< 'print(page_info())'\n\n"
  printf "  2. ${B}Free Apify account${N}  ${D}(3 min)${N}\n"
  printf "     Sign up at ${B}apify.com${N}, then run:  ${B}apify login${N}\n\n"
  printf "  ${D}Full walkthrough: docs/SETUP.md${N}\n"
  printf "  ${D}Built by Asad. LICENSE.md${N}\n\n"
else
  printf "  ${B}Fix the failures above, then run ./install.sh again.${N}\n\n"; exit 1
fi
