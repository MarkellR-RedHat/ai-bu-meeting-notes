# ai-bu-meeting-notes

Claude Code slash commands that transform rough meeting notes into structured, actionable output. Paste your messy notes, get clean results.

## What It Does

Three commands for different levels of meeting note processing:

- `/meeting-notes` - Full structured output: summary, decisions, action items table, open questions, and follow-up recommendations
- `/action-items` - Extracts only the action items as a table with owners and due dates
- `/meeting-email` - Generates a ready-to-send follow-up email with decisions and action items

All three commands handle messy input gracefully. Typos, incomplete sentences, abbreviations, and stream-of-consciousness formatting are all fine.

## Install

```bash
git clone https://github.com/MarkellR-RedHat/ai-bu-meeting-notes.git
cd ai-bu-meeting-notes
chmod +x install.sh
./install.sh
```

This copies the command files to `~/.claude/commands/` so they are available globally in Claude Code.

## Usage

In Claude Code, type the command followed by your raw meeting notes:

```
/meeting-notes standup today. john said api work is on track, should be done by friday.
sara raised concern about test coverage, we agreed to add integration tests before release.
need to figure out deployment timeline. mike volunteered to own the rollback plan.
next sync probably needed mid next week.
```

## Example

**Input (rough notes):**

```
q3 planning call. talked about llm-d roadmap and scaling targets.
decided to target 1000 concurrent users by end of q3.
paul owns the load testing, needs it done by july 15.
maria will update the architecture doc, no hard deadline but before next planning.
open q: do we need a dedicated redis cluster or can we share?
also unclear on budget for additional gpu nodes.
followup meeting probably needed to sort out infra costs.
```

**Output from `/meeting-notes`:**

```
## Meeting Summary
Q3 planning call focused on the llm-d roadmap and scaling targets. The team
aligned on a concurrency goal and assigned key workstreams. Infrastructure
questions around Redis and GPU budget remain open.

## Decisions Made
1. Target 1000 concurrent users by end of Q3.
2. Integration of load testing into the release process.

## Action Items
| # | Action Item                        | Owner | Due Date          |
|---|------------------------------------|-------|-------------------|
| 1 | Complete load testing              | Paul  | July 15           |
| 2 | Update architecture doc            | Maria | Before next planning |

## Open Questions / Parking Lot
- Do we need a dedicated Redis cluster or can we share the existing one?
- Budget allocation for additional GPU nodes is unclear.

## Follow-up Meeting Needed?
Y. Suggested topics:
1. Infrastructure cost breakdown for GPU nodes and Redis
2. Review load testing results (if available)
3. Finalize Q3 milestone dates
```

**Output from `/action-items` (same input):**

```
| # | Action Item                        | Owner | Due Date          |
|---|------------------------------------|-------|-------------------|
| 1 | Complete load testing              | Paul  | July 15           |
| 2 | Update architecture doc            | Maria | Before next planning |
```

**Output from `/meeting-email` (same input):**

```
Subject: Follow-up: Q3 Planning Call

Hi team,

Thanks for joining the Q3 planning call. Here is a summary of what we covered.

**Decisions:**
- Target 1000 concurrent users by end of Q3
- Load testing will be integrated into the release process

**Action Items:**
- Paul: Complete load testing by July 15
- Maria: Update architecture doc before next planning session

**Open Items:**
- We still need to determine whether a dedicated Redis cluster is required
  or if we can share the existing one.
- Budget for additional GPU nodes needs clarification.

I think we should schedule a follow-up to sort out the infrastructure costs
and finalize milestone dates. I will send a calendar invite for next week.

Thanks,
[Your name]
```

## Project Structure

```
ai-bu-meeting-notes/
  commands/
    meeting-notes.md    # Full structured meeting notes
    action-items.md     # Action items only
    meeting-email.md    # Follow-up email generator
  install.sh            # Installer script
  README.md             # This file
```

## License

Apache-2.0
