#!/bin/bash
# install.sh - Install ai-bu-meeting-notes slash commands for Claude Code
#
# Copies command files to ~/.claude/commands/ so they are available
# globally in any Claude Code session.

set -e

COMMANDS_DIR="$HOME/.claude/commands"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)/commands"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

echo ""
echo -e "${BOLD}${CYAN}ai-bu-meeting-notes${NC}"
echo -e "${DIM}Close the gap between what gets said and what gets done${NC}"
echo ""

# Verify source commands exist
if [ ! -d "$SOURCE_DIR" ]; then
  echo -e "${RED}Error: commands/ directory not found.${NC}"
  echo -e "Run this script from the ai-bu-meeting-notes project root:"
  echo -e "  cd ai-bu-meeting-notes && ./install.sh"
  exit 1
fi

# Create target directory if needed
if [ -d "$COMMANDS_DIR" ]; then
  echo -e "${DIM}Using ${COMMANDS_DIR}${NC}"
else
  echo -e "Creating ${COMMANDS_DIR}"
  mkdir -p "$COMMANDS_DIR"
fi

echo ""

COMMANDS=(
  "meeting-notes"
  "action-items"
  "meeting-email"
  "agenda"
  "decision-log"
  "standup-notes"
  "pre-brief"
  "raci"
  "follow-up-check"
  "meeting-cancel"
)

INSTALLED=0
FAILED=0

for cmd in "${COMMANDS[@]}"; do
  src="$SOURCE_DIR/${cmd}.md"
  if [ -f "$src" ]; then
    if cp "$src" "$COMMANDS_DIR/${cmd}.md" 2>/dev/null; then
      echo -e "  ${GREEN}installed${NC}  /${cmd}"
      INSTALLED=$((INSTALLED + 1))
    else
      echo -e "  ${RED}failed${NC}     /${cmd}  (could not copy to $COMMANDS_DIR)"
      FAILED=$((FAILED + 1))
    fi
  else
    echo -e "  ${RED}missing${NC}    /${cmd}  (source file not found)"
    FAILED=$((FAILED + 1))
  fi
done

echo ""

if [ "$FAILED" -gt 0 ]; then
  echo -e "${YELLOW}${INSTALLED} installed, ${FAILED} failed.${NC}"
  echo -e "Check that the commands/ directory contains all .md files."
  exit 1
fi

echo -e "${GREEN}${BOLD}All ${INSTALLED} commands installed.${NC}"
echo ""
echo -e "${BOLD}Try it now:${NC}"
echo ""
echo -e "  Open Claude Code and type:"
echo ""
echo -e "  ${CYAN}/meeting-notes${NC} talked about Q3 roadmap, john owns the API"
echo -e "  work due friday, we picked option B for auth..."
echo ""
