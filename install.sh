#!/bin/bash
# install.sh - Install ai-bu-meeting-notes commands for Claude Code

set -e

COMMANDS_DIR="$HOME/.claude/commands"

echo "Installing meeting notes commands to $COMMANDS_DIR ..."

mkdir -p "$COMMANDS_DIR"

cp commands/meeting-notes.md "$COMMANDS_DIR/meeting-notes.md"
cp commands/action-items.md "$COMMANDS_DIR/action-items.md"
cp commands/meeting-email.md "$COMMANDS_DIR/meeting-email.md"

echo "Done. The following commands are now available in Claude Code:"
echo "  /meeting-notes    - Full structured meeting notes"
echo "  /action-items     - Extract action items only"
echo "  /meeting-email    - Generate a follow-up email"
echo ""
echo "Usage: paste your rough notes after the command, e.g.:"
echo "  /meeting-notes talked about Q3 roadmap, john owns the API work due friday..."
