# ai-bu-meeting-notes

## The Problem

Last Tuesday's meeting had 8 people for an hour. That is a full workday of human attention. What came out of it?

"I think we discussed the timeline and someone was going to look into something."

Two weeks later, someone says "but we agreed to do X" and nobody can find the proof. Decisions get relitigated. Action items vanish. The same meeting happens again.

This is the **accountability gap**: the space between what gets said in a meeting and what actually gets done afterward.

## Before and After

**Before** (what you actually typed during the meeting):

```
infra sync w john paul sara mike. k8s migration status. johns been on the
helm charts says 70% done finishd by next fri. sara brot up monitoring gap
she'll own it. we went w prometheus+grafana over datadog, cost was the
driver paul said no new hw til q4. dns cutover plan has no owner thats a
problem. mike said hed look at ci/cd pipeline risk but no commitments.
```

**After** (what `/meeting-notes` gives you back):

```
## Kubernetes Migration - Infrastructure Sync

Attendees: John, Paul, Sara, Mike

### Key Decisions
| # | Decision                              | Rationale             | Decided By       |
|---|---------------------------------------|-----------------------|------------------|
| 1 | Use Prometheus + Grafana over Datadog | Cost exceeded budget  | Paul + consensus |
| 2 | Freeze feature deploys during window  | Risk mitigation       | Team consensus   |

### Action Items
| # | Action Item                    | Owner | Due Date       | Priority |
|---|--------------------------------|-------|----------------|----------|
| 1 | Complete Helm charts           | John  | July 3, 2026   | High     |
| 2 | Set up monitoring stack        | Sara  | TBD            | High     |
| 3 | Investigate CI/CD pipeline     | Mike  | TBD            | Medium   |
| 4 | Define DNS cutover plan        | TBD   | TBD            | High     |

Gaps flagged:
- DNS cutover plan has no owner. Migration-blocking.
- Rollback plan was never discussed. Critical safety net missing.
- Mike's CI/CD investigation was a soft commitment ("he'd look at it").
  Needs a firm date.
```

Typos, abbreviations, half-sentences, stream-of-consciousness dumps. All handled. The messier the input, the more value you get.

## Quick Start

```bash
git clone https://github.com/MarkellR-RedHat/ai-bu-meeting-notes.git
cd ai-bu-meeting-notes
./install.sh
```

Then open Claude Code and try your first command:

```
/meeting-notes talked about Q3 roadmap, john owns the API work due friday,
we picked option B for the auth flow, no one volunteered for docs yet...
```

## Commands

10 slash commands covering the full meeting lifecycle: before, during, and after.

### Core

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/meeting-notes` | Structured notes with decisions, action items, owners, deadlines | Right after any meeting |
| `/action-items` | Extract every commitment, including soft ones people try to dodge | When you need a clean task list |
| `/decision-log` | Decisions with rationale, alternatives considered, and dissent noted | When decisions keep getting relitigated |
| `/meeting-email` | Copy-paste follow-up email with decisions and action items | Before you forget what happened |
| `/standup-notes` | Async standup formatter with team health pulse | Daily standups, async or sync |
| `/agenda` | Time-boxed agenda with success criteria and fallback plan | Before the meeting, not during |

### Advanced

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/pre-brief` | Attendee profiles, real agenda, power dynamics, strategic questions | Before high-stakes meetings |
| `/raci` | RACI matrix with accountability gap detection | When ownership is unclear |
| `/follow-up-check` | Cross-meeting accountability tracker and scorecard | Start of recurring meetings |
| `/meeting-cancel` | Meeting cost calculator and necessity test | When you suspect the meeting should be an email |

## What Follow-Up Tracking Looks Like

`/follow-up-check` catches what most teams miss. Paste two sets of notes (previous and current) and get back an honest scorecard:

```
## Accountability Report

| Metric                      | Count | Percentage |
|-----------------------------|-------|------------|
| Total Previous Commitments  | 3     | 100%       |
| Completed                   | 1     | 33%        |
| Slipped (Missed Deadline)   | 2     | 67%        |

Overall Follow-Through Rate: 33%

### Slipped
| Original Commitment      | Owner | Days Slipped | Status                          |
|--------------------------|-------|--------------|---------------------------------|
| Finish API docs          | John  | 4+ days      | "Maybe tomorrow" (not confirmed)|
| Complete security review | Mike  | 3+ days      | No new deadline set             |

### Patterns and Risks
- John's "maybe tomorrow" is not a commitment. It is a hedge. Get a firm date.
- Mike's security review was displaced by incident response. Legitimate reason,
  but the review still has no new deadline. It will drift without one.
```

That is the difference between "we had a meeting" and "we have a record."

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
