# ai-bu-meeting-notes

Last Tuesday's meeting had 8 people for an hour. That is a full workday of human attention. What came out of it?

If the answer is "I think we discussed the timeline and someone was going to look into something," then the meeting failed. Not because the discussion was bad, but because nobody captured what was decided, who committed to what, and what needs to happen next. Two weeks later, someone says "but we agreed to do X" and nobody can find the proof.

This is the accountability gap: the space between what gets said in a meeting and what actually gets done afterward. These Claude Code slash commands close that gap.

## What This Does

10 slash commands covering the full meeting lifecycle: before, during, and after. Paste your rough notes. Get structured, accountable documentation. No formatting required. Typos, abbreviations, half-sentences, and stream-of-consciousness dumps are all handled.

### Core Commands

| Command | What It Does |
|---------|-------------|
| `/meeting-notes` | Full structured notes: narrative summary, decisions with rationale, action items with owners and deadlines, discussion highlights, open questions, follow-up plan. Catches implicit commitments that humans miss. |
| `/action-items` | Extracts every commitment from the notes, including the soft ones ("I can probably look into that" becomes a tracked item with a flag). Surfaces accountability gaps. |
| `/decision-log` | Every decision in a structured log with alternatives considered, rationale, who decided, dissent noted, and downstream impact. The record that prevents decisions from being relitigated. |
| `/meeting-email` | A follow-up email ready to copy and send. Decisions listed, action items tabled, open items flagged. No fluff. |
| `/standup-notes` | Formats async standup updates into Done/Doing/Blockers with a team health pulse that flags cross-team dependencies, stall signals, and risk. |
| `/agenda` | A time-boxed agenda with a purpose for each item, success criteria, pre-reads, and a fallback plan if the meeting runs long. |

### Advanced Commands

| Command | What It Does |
|---------|-------------|
| `/pre-brief` | Profiles each attendee, identifies the real agenda behind the stated agenda, maps the power dynamics, suggests strategic questions, and flags potential landmines. Walk in as the most prepared person in the room. |
| `/raci` | Extracts a RACI matrix from meeting notes. Flags the gaps that kill projects: no accountable person, overloaded individuals, implied work with no owner. |
| `/follow-up-check` | The accountability hammer. Compares previous and current meeting notes, tracks what was promised vs. what was delivered, and produces an honest scorecard. Items that were "never mentioned again" get flagged as the highest-risk category. |
| `/meeting-cancel` | Calculates the actual dollar cost of the meeting, applies a necessity test, and gives an honest verdict. If the meeting should be an email, it drafts the email for you. |

## The Accountability Gap in Action

Here is what `/follow-up-check` catches that most teams miss:

**You paste two sets of notes:**

```
/follow-up-check
PREVIOUS: last week john said he'd finish the api docs by wednesday.
sara was going to set up the staging environment. mike committed to
the security review by friday.

CURRENT: standup today. john said api docs are almost done, maybe
tomorrow. sara got staging up and running. mike hasnt started the
security review, got pulled into incident response. we talked about
the roadmap for next quarter.
```

**You get back:**

```
## Accountability Report

### Scorecard

| Metric | Count | Percentage |
|--------|-------|------------|
| Total Previous Commitments | 3 | 100% |
| Completed | 1 | 33% |
| Slipped (Missed Deadline) | 2 | 67% |

Overall Follow-Through Rate: 33%

### Slipped
| Original Commitment | Owner | Original Deadline | Days Slipped | New Deadline |
|---------------------|-------|-------------------|-------------|--------------|
| Finish API docs | John | Wednesday | 4+ days | "Maybe tomorrow" (not confirmed) |
| Complete security review | Mike | Friday | 3+ days | No new deadline set |

### Patterns and Risks
- John's "maybe tomorrow" is not a commitment. It is a hedge. Get a firm date.
- Mike's security review was displaced by incident response. Legitimate reason,
  but the review still has no new deadline. It will drift without one.
- The team jumped to discussing the Q4 roadmap without first closing out
  open items from last week. Old commitments should be reviewed before new
  ones are made.
```

That is the difference between "we had a meeting" and "we have a record."

## Install

```bash
git clone https://github.com/MarkellR-RedHat/ai-bu-meeting-notes.git
cd ai-bu-meeting-notes
chmod +x install.sh
./install.sh
```

This copies the command files to `~/.claude/commands/` so they are available globally in Claude Code.

## Usage

In Claude Code, type the slash command followed by your raw notes. No formatting required.

```
/meeting-notes talked about the k8s migration, johns helm charts 70% done,
sara taking monitoring, we picked prometheus over datadog bc cost...
```

The messier the input, the more value you get. These commands are built for how people actually take notes, not how they wish they did.

## Example: Full Meeting Notes

**Input:**

```
/meeting-notes
infra sync w john paul sara mike. k8s migration status. johns been on the
helm charts says 70% done finishd by next fri. sara brot up monitoring gap
she'll own it. we went w prometheus+grafana over datadog, cost was the
driver paul said no new hw til q4. dns cutover plan has no owner thats a
problem. mike said hed look at ci/cd pipeline risk but no commitments.
we need to freeze feature deploys during migration window everyone agreed.
prob need another meeting next week. oh and the rollback plan nobody
mentioned that either
```

**Output:**

```
## Kubernetes Migration - Infrastructure Sync

**Attendees:** John, Paul, Sara, Mike
**Date:** June 26, 2026

### Summary
Infrastructure sync focused on the Kubernetes migration. The team reviewed
Helm chart progress (70% complete, targeting next Friday), selected
Prometheus + Grafana as the monitoring stack over Datadog due to cost
constraints, and agreed to freeze feature deploys during the migration
window. Two critical gaps remain unresolved: the DNS cutover plan has no
owner, and the rollback plan was not discussed at all.

### Key Decisions

| # | Decision | Rationale | Decided By |
|---|----------|-----------|------------|
| 1 | Use Prometheus + Grafana over Datadog | Cost: Datadog exceeded budget | Paul + consensus |
| 2 | No new hardware until Q4 | Budget constraint | Paul |
| 3 | Freeze feature deploys during migration | Risk mitigation | Team consensus |

### Action Items

| # | Action Item | Owner | Due Date | Priority |
|---|-------------|-------|----------|----------|
| 1 | Complete Helm charts | John | July 3, 2026 | High |
| 2 | Set up Prometheus + Grafana monitoring | Sara | TBD | High |
| 3 | Investigate CI/CD pipeline risks | Mike | TBD | Medium |
| 4 | Define DNS cutover plan | TBD | TBD | High |
| 5 | Create rollback plan | TBD | TBD | High |

**Gaps flagged:**
- DNS cutover plan (item 4) has no owner. Migration-blocking.
- Rollback plan (item 5) was never discussed. Critical safety net missing.
- Sara's monitoring (item 2) has no deadline.
- Mike's CI/CD investigation (item 3) was a soft commitment
  ("he'd look at it, no commitments"). Needs a firm date.
```

## Project Structure

```
ai-bu-meeting-notes/
  commands/
    meeting-notes.md       # Full structured meeting notes
    action-items.md        # Commitment extraction with gap analysis
    meeting-email.md       # Follow-up email generator
    agenda.md              # Meeting agenda with success criteria
    decision-log.md        # Decision log with rationale and alternatives
    standup-notes.md       # Async standup formatter with team pulse
    pre-brief.md           # Strategic pre-meeting briefing
    raci.md                # RACI matrix with accountability gap flags
    follow-up-check.md     # Cross-meeting accountability tracker
    meeting-cancel.md      # Meeting necessity analyzer with cost math
  install.sh               # Installer script
  README.md                # This file
```

## License

Apache-2.0