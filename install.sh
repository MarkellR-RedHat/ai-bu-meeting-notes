#!/bin/bash
# install.sh - Install ai-bu-meeting-notes commands for Claude Code

set -e

COMMANDS_DIR="$HOME/.claude/commands"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

echo ""
echo -e "${BOLD}${CYAN}ai-bu-meeting-notes${NC}"
echo -e "${DIM}Claude Code slash commands for meeting productivity${NC}"
echo "================================================="
echo ""

# Check if Claude Code commands directory exists or can be created
if [ -d "$COMMANDS_DIR" ]; then
  echo -e "${DIM}Found existing commands directory at ${COMMANDS_DIR}${NC}"
else
  echo -e "${YELLOW}Creating commands directory at ${COMMANDS_DIR}${NC}"
fi
mkdir -p "$COMMANDS_DIR"

echo ""
echo -e "${BOLD}Installing commands...${NC}"
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
SKIPPED=0

for cmd in "${COMMANDS[@]}"; do
  if [ -f "commands/${cmd}.md" ]; then
    cp "commands/${cmd}.md" "$COMMANDS_DIR/${cmd}.md"
    echo -e "  ${GREEN}+${NC} ${cmd}"
    INSTALLED=$((INSTALLED + 1))
  else
    echo -e "  ${RED}!${NC} ${cmd} ${DIM}(file not found, skipped)${NC}"
    SKIPPED=$((SKIPPED + 1))
  fi
done

echo ""
echo -e "${GREEN}${BOLD}Installed ${INSTALLED} commands.${NC}"
if [ "$SKIPPED" -gt 0 ]; then
  echo -e "${YELLOW}Skipped ${SKIPPED} commands (files not found).${NC}"
fi

echo ""
echo -e "${BOLD}Available commands:${NC}"
echo ""
echo -e "  ${BOLD}Core${NC}"
echo -e "  ${CYAN}/meeting-notes${NC}      Full structured meeting notes with decisions, actions, and follow-ups"
echo -e "  ${CYAN}/action-items${NC}       Extract every commitment, including the ones humans miss"
echo -e "  ${CYAN}/decision-log${NC}       Pull decisions into a structured log with rationale and alternatives"
echo -e "  ${CYAN}/meeting-email${NC}      Generate a copy-paste-ready follow-up email"
echo -e "  ${CYAN}/standup-notes${NC}      Format async standup updates with team health pulse"
echo -e "  ${CYAN}/agenda${NC}             Generate a time-boxed agenda with success criteria"
echo ""
echo -e "  ${BOLD}Advanced${NC}"
echo -e "  ${CYAN}/pre-brief${NC}          Get a strategic briefing before your meeting"
echo -e "  ${CYAN}/raci${NC}               Extract a RACI matrix and flag accountability gaps"
echo -e "  ${CYAN}/follow-up-check${NC}    Compare meetings to track what shipped, slipped, or got dropped"
echo -e "  ${CYAN}/meeting-cancel${NC}     Honest assessment: should this meeting be an email?"
echo ""
echo -e "${DIM}Usage: paste your rough notes after the command, e.g.:${NC}"
echo -e "${DIM}  /meeting-notes talked about Q3 roadmap, john owns the API work due friday...${NC}"
echo ""
