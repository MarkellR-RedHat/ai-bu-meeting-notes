#!/bin/bash
# install.sh - Install ai-bu-meeting-notes commands for Claude Code

set -e

COMMANDS_DIR="$HOME/.claude/commands"

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
echo "======================================================"
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
    echo -e "  ${GREEN}+${NC} /${cmd}"
    INSTALLED=$((INSTALLED + 1))
  else
    echo -e "  ${RED}!${NC} /${cmd} ${DIM}(source file not found, skipped)${NC}"
    SKIPPED=$((SKIPPED + 1))
  fi
done

echo ""
if [ "$INSTALLED" -gt 0 ]; then
  echo -e "${GREEN}${BOLD}Installed ${INSTALLED} commands.${NC}"
fi
if [ "$SKIPPED" -gt 0 ]; then
  echo -e "${YELLOW}Skipped ${SKIPPED} commands (source files not found).${NC}"
fi

echo ""
echo -e "${BOLD}Commands installed:${NC}"
echo ""
echo -e "  ${BOLD}Core${NC}"
echo -e "  ${CYAN}/meeting-notes${NC}      Full structured notes with accountability tracking"
echo -e "  ${CYAN}/action-items${NC}       Extract every commitment, including the ones humans miss"
echo -e "  ${CYAN}/decision-log${NC}       Decisions with rationale, alternatives, and dissent"
echo -e "  ${CYAN}/meeting-email${NC}      Copy-paste-ready follow-up email"
echo -e "  ${CYAN}/standup-notes${NC}      Async standup formatter with team health pulse"
echo -e "  ${CYAN}/agenda${NC}             Time-boxed agenda with success criteria"
echo ""
echo -e "  ${BOLD}Advanced${NC}"
echo -e "  ${CYAN}/pre-brief${NC}          Strategic briefing: attendee map, power dynamics, landmines"
echo -e "  ${CYAN}/raci${NC}               RACI matrix with accountability gap detection"
echo -e "  ${CYAN}/follow-up-check${NC}    Cross-meeting accountability tracker"
echo -e "  ${CYAN}/meeting-cancel${NC}     Should this meeting exist? Honest verdict with cost math"
echo ""
echo -e "${DIM}Usage: type the slash command followed by your rough notes${NC}"
echo -e "${DIM}  /meeting-notes talked about Q3 roadmap, john owns the API work due friday...${NC}"
echo ""
