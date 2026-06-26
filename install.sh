#!/bin/bash
# install.sh - Install ai-bu-meeting-notes commands for Claude Code

set -e

COMMANDS_DIR="$HOME/.claude/commands"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

echo ""
echo -e "${BOLD}ai-bu-meeting-notes installer${NC}"
echo "=============================="
echo ""
echo -e "Installing commands to ${BLUE}$COMMANDS_DIR${NC} ..."
echo ""

mkdir -p "$COMMANDS_DIR"

COMMANDS=(
  "meeting-notes"
  "action-items"
  "meeting-email"
  "agenda"
  "decision-log"
  "standup-notes"
)

for cmd in "${COMMANDS[@]}"; do
  cp "commands/${cmd}.md" "$COMMANDS_DIR/${cmd}.md"
  echo -e "  ${GREEN}+${NC} ${cmd}"
done

echo ""
echo -e "${GREEN}Done.${NC} The following commands are now available in Claude Code:"
echo ""
echo -e "  ${BOLD}/meeting-notes${NC}    Full structured meeting notes"
echo -e "  ${BOLD}/action-items${NC}     Extract action items table"
echo -e "  ${BOLD}/meeting-email${NC}    Generate a follow-up email"
echo -e "  ${BOLD}/agenda${NC}           Generate a meeting agenda with time allocations"
echo -e "  ${BOLD}/decision-log${NC}     Extract decisions into a decision log"
echo -e "  ${BOLD}/standup-notes${NC}    Format async standup updates"
echo ""
echo "Usage: paste your rough notes after the command, e.g.:"
echo "  /meeting-notes talked about Q3 roadmap, john owns the API work due friday..."
echo ""
