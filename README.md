# ai-bu-meeting-notes

Claude Code slash commands that turn your worst meeting notes into your best documentation. Paste the mess. Get the magic.

10 commands covering the full meeting lifecycle: before, during, and after.

## Commands

### Core

| Command | What It Does |
|---------|-------------|
| `/meeting-notes` | Full structured notes: narrative summary, decisions with rationale, action items with owners/dates/priority/dependencies, discussion highlights, open questions, follow-up plan |
| `/action-items` | Extracts every commitment from the notes, including implicit ones humans miss ("we should probably..." becomes a tracked item). Flags accountability gaps. |
| `/decision-log` | Pulls every decision into a structured log with alternatives considered, rationale, who decided, and downstream impact |
| `/meeting-email` | Generates a professional follow-up email, ready to copy-paste and send. No fluff, no filler. |
| `/standup-notes` | Formats async standup updates into Done/Doing/Blockers with a team health pulse that flags cross-team dependencies and risk signals |
| `/agenda` | Generates a time-boxed agenda with purpose for each item, success criteria, pre-reads, and a fallback plan if the meeting runs long |

### Advanced

| Command | What It Does |
|---------|-------------|
| `/pre-brief` | "Prepare me for this meeting." Profiles each attendee, identifies the real agenda behind the stated agenda, suggests strategic questions, recommends your position on key topics, and flags potential landmines. |
| `/raci` | Extracts a RACI matrix from meeting notes. Flags the gaps that kill projects: no accountable person, overloaded individuals, missing stakeholders. |
| `/follow-up-check` | The accountability hammer. Takes previous and current meeting notes, tracks what was promised vs. what was delivered, and produces an honest scorecard. Items that were "never mentioned again" get flagged loudly. |
| `/meeting-cancel` | "Should this meeting be an email?" Gives an honest verdict with the total person-hours cost. If yes to meeting, provides a tighter agenda. If no, drafts the async alternative ready to send. |

## Install

```bash
git clone https://github.com/MarkellR-RedHat/ai-bu-meeting-notes.git
cd ai-bu-meeting-notes
chmod +x install.sh
./install.sh
```

This copies the command files to `~/.claude/commands/` so they are available globally in Claude Code.

## Usage

In Claude Code, type the slash command followed by your raw notes. No formatting required. Typos, abbreviations, incomplete sentences, and stream-of-consciousness dumps are all handled.

```
/meeting-notes talked about the k8s migration, johns helm charts 70% done,
sara taking monitoring, we picked prometheus over datadog bc cost...
```

## Example Output

These examples show real input and actual output. The input is intentionally messy because that is what real notes look like.

---

### `/meeting-notes` - Full structured meeting notes

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
owner, and the rollback plan was not discussed at all. A follow-up is
needed next week to close these gaps before the migration window.

### Key Decisions

| # | Decision | Rationale | Decided By | Impact |
|---|----------|-----------|------------|--------|
| 1 | Use Prometheus + Grafana for monitoring instead of Datadog | Cost: Datadog pricing exceeded budget constraints | Paul (budget authority), team consensus | Monitoring architecture for all migrated services |
| 2 | No new hardware purchases until Q4 | Budget constraint | Paul | Limits infrastructure options for migration |
| 3 | Freeze feature deploys during migration window | Risk mitigation: avoid compounding changes during migration | Team consensus | All feature teams blocked during migration window |

### Action Items

| # | Action Item | Owner | Due Date | Priority | Dependencies |
|---|-------------|-------|----------|----------|--------------|
| 1 | Complete Helm charts for k8s migration | John | July 3, 2026 | High | None |
| 2 | Set up Prometheus + Grafana monitoring stack | Sara | TBD | High | Needs timeline |
| 3 | Investigate CI/CD pipeline risks during migration | Mike | TBD | Medium | None |
| 4 | Define and document DNS cutover plan | TBD | TBD | High | Blocks migration execution |
| 5 | Create rollback plan for migration | TBD | TBD | High | Should be in place before migration begins |

**Gaps flagged:**
- DNS cutover plan (item 4) has no owner. This is a migration-blocking deliverable with no one driving it.
- Rollback plan (item 5) was never discussed. This is a critical safety net that does not exist yet.
- Sara's monitoring work (item 2) has no deadline. Should be scoped relative to migration timeline.
- Mike's CI/CD investigation (item 3) was a soft commitment ("look into it, no promises"). Needs to be firmed up.

### Discussion Highlights

- **Helm Charts:** John reported 70% completion on Helm charts for the
  k8s migration. On track for next Friday. No blockers raised.
- **Monitoring Gap:** Sara identified that monitoring is not set up for
  the new environment. She volunteered to own it. The team chose
  Prometheus + Grafana over Datadog specifically because of cost.
- **Budget Constraints:** Paul stated no new hardware purchases until Q4.
  This constrains the migration to existing infrastructure capacity.
- **CI/CD Risk:** Concern raised about CI/CD pipeline breaking during
  migration. Mike offered to look into it but explicitly did not commit
  to a deliverable or timeline.

### Open Questions and Parking Lot
- Who owns the DNS cutover plan? (Raised by the group, no volunteer)
- What is the rollback plan if the migration fails? (Not discussed at all)
- What is the migration window timeline? (Feature freeze agreed but no dates set)
- What is the scope of Sara's monitoring work? (All services? Critical path only?)

### Follow-Up Required
Yes. Suggested timing: next week (before July 3 Helm chart completion).

Agenda for follow-up:
1. Assign owner for DNS cutover plan and review initial approach
2. Define rollback plan: what triggers a rollback, who executes it, what is the process
3. Review Helm chart progress (should be near-complete)
4. Set timeline for monitoring setup and migration window dates

Who needs to be there: John, Paul, Sara, Mike (same group)
```

---

### `/action-items` - Catches the commitments humans miss

**Input:**

```
/action-items
product review meeting. lisa presented the roadmap, we liked most of it
but the analytics feature needs more thought. tom said he'd review the
competitor analysis by wednesday. someone should update the pricing page
before the launch. we should probably do user testing on the new onboarding
flow. maria mentioned she can get us beta testers if we need them. the
legal review is still pending, been stuck for 2 weeks. oh and jake said
"i guess the docs are on me then" when nobody else volunteered
```

**Output:**

```
### Action Items Extracted

| # | Action Item | Owner | Due Date | Priority | Dependencies |
|---|-------------|-------|----------|----------|--------------|
| 1 | Review competitor analysis and share findings | Tom | July 1, 2026 | High | None |
| 2 | Update pricing page before launch | TBD | Before launch (date TBD) | High | Launch date needs to be confirmed |
| 3 | Plan and conduct user testing on new onboarding flow | TBD | TBD | Medium | Needs beta testers |
| 4 | Coordinate beta testers for onboarding user testing | Maria | TBD | Medium | Depends on user testing plan (item 3) |
| 5 | Unblock legal review (stuck for 2 weeks) | TBD | ASAP | High | Identify who in legal is holding this up |
| 6 | Write/update documentation | Jake | TBD | Medium | None |
| 7 | Rethink analytics feature approach and bring revised proposal | TBD | TBD | Medium | Needs clearer requirements |

### Accountability Gaps
- **Pricing page update (item 2):** No owner for a launch-blocking task. This will not get done unless someone claims it.
- **User testing (item 3):** No owner, no timeline. Maria offered beta testers but nobody is driving the overall effort.
- **Legal review (item 5):** Stuck for 2 weeks with no escalation path identified. Who is responsible for unblocking this?
- **Analytics feature (item 7):** The team flagged it needs more thought but nobody owns the rethink. This will show up in the next meeting in the same state.
- **Jake's docs (item 6):** Volunteered reluctantly ("I guess that's on me"). Confirm this is actually his responsibility and give him a deadline.

### Quick Stats
- Total action items: 7
- Items with owners: 3 / Items needing assignment: 4
- Items with deadlines: 1 / Items needing dates: 6
- High priority items: 3
```

---

### `/pre-brief` - Walk in as the most prepared person in the room

**Input:**

```
/pre-brief
meeting tomorrow about whether to build or buy an observability platform.
attendees: VP of Eng (diana), platform team lead (raj), SRE manager (chen),
and someone from finance (priya). we've been using a patchwork of open source
tools but keep having outages that take too long to diagnose. datadog quote
came in at 800k/year. raj has been pushing to build something internal.
```

**Output:**

```
## Pre-Brief: Build vs. Buy Observability Platform

**Meeting Type (inferred):** Decision
**What This Meeting Is Really About:** This is a resource allocation decision
disguised as a technical discussion. The real question is whether the org
is willing to spend $800K/year on a vendor, invest engineering headcount
into building an internal platform, or find a middle path. The outages are
the forcing function, but the budget and team capacity are the actual
constraints.

### Attendee Map

**Diana** - VP of Engineering
- **Likely cares about:** Reducing outage impact (this reflects on her org), controlling costs, not overcommitting engineering resources to infrastructure when product work is waiting
- **Will probably push for:** A pragmatic solution that solves the outage problem quickly. May lean toward buy if the build timeline is too long.
- **Watch for:** May ask for a phased approach. Will want to see ROI framing, not just technical merits.
- **Win condition:** A clear decision with a timeline and cost projection she can defend to her leadership

**Raj** - Platform Team Lead
- **Likely cares about:** Technical control, avoiding vendor lock-in, his team's relevance and growth. Building this platform would be a flagship project for his team.
- **Will probably push for:** Build. He has been advocating for this already. Expect a technical argument about customization and long-term flexibility.
- **Watch for:** May underestimate build timeline and maintenance burden. May frame vendor solutions as technically inferior without acknowledging the speed advantage.
- **Win condition:** Getting approval (and headcount) to build an internal observability platform

**Chen** - SRE Manager
- **Likely cares about:** Reducing mean time to detection and resolution. The outages are hitting his team hardest. Needs tools that work NOW, not in 6 months.
- **Will probably push for:** Whatever gets deployed fastest. May favor buy for speed, but could be swayed by a build approach that starts delivering value incrementally.
- **Watch for:** May have strong opinions on specific capabilities (distributed tracing, log correlation, alerting) based on recent outage pain. Listen to these closely.
- **Win condition:** A concrete timeline for when his team gets better tooling, regardless of build vs. buy

**Priya** - Finance
- **Likely cares about:** Total cost of ownership, not just sticker price. Will compare the $800K/year vendor cost against the fully-loaded cost of engineers building it.
- **Will probably push for:** Whichever option has a clearer, more predictable cost model. May challenge Raj to price out the build option realistically (headcount, opportunity cost, maintenance).
- **Watch for:** May ask pointed questions about hidden costs on both sides. Could be a swing vote.
- **Win condition:** A decision backed by defensible numbers she can put in a budget forecast

### Key Questions to Ask

1. "What is our actual cost of outages today, in engineering hours and customer impact?" - *Why this matters:* Establishes the baseline cost of doing nothing, which is the real comparison point for both options.
2. "Raj, if we build, what can we ship in 30 days that starts reducing MTTR?" - *Why this matters:* Forces the build option to show incremental value, not just a 12-month roadmap.
3. "If we go with Datadog, what is our exit cost if we outgrow it in 2 years?" - *Why this matters:* Vendor lock-in is a real concern. Quantifying the switching cost makes the discussion concrete.
4. "Chen, which specific capability gap is causing the most pain in outage diagnosis right now?" - *Why this matters:* Narrows the conversation from "observability platform" to the specific problem that needs solving first.
5. "What headcount does the build option require, and what does that team NOT work on as a result?" - *Why this matters:* Forces opportunity cost into the conversation. Building has a price beyond salaries.
6. "Is there a hybrid option: buy for immediate relief, build specific components where we need customization?" - *Why this matters:* This may be the pragmatic middle ground that gets everyone to yes.

### Decisions That Need to Be Made

**Decision: Build, buy, or hybrid approach for observability**
- **Options:** (1) Buy Datadog at $800K/year (2) Build internal platform (3) Hybrid: buy now, build targeted components over time
- **Recommended position:** Push for the hybrid approach. Buy gives Chen's team immediate relief. Building targeted components (custom dashboards, internal integrations) lets Raj's team add value without a multi-year commitment. Revisit in 6 months with data on what the vendor covers well and where gaps remain.
- **Who has the final call:** Diana (budget and resourcing authority), with Priya's sign-off on financials

### Potential Landmines

- **Raj frames this as all-or-nothing:** If the conversation becomes "build everything vs. buy everything," the hybrid option gets lost. Mitigation: Introduce the hybrid framing early.
- **Outage war stories derail the discussion:** Chen or others start recounting specific outages in detail. Mitigation: Acknowledge the pain, redirect to "what capability would have prevented this" to keep it forward-looking.
- **Build timeline gets hand-waved:** "We can probably have something in a few months" is not a plan. Mitigation: Ask for a specific 30/60/90 day deliverable list.
- **Finance kills the buy option on sticker price alone:** $800K/year sounds expensive in isolation. Mitigation: Frame against the cost of outages and the fully-loaded cost of the build option.

### Information to Have Ready

- Current outage frequency and average resolution time for the past quarter
- Number of engineers on Raj's platform team and their current project commitments
- The Datadog quote details: what is included, what costs extra, contract terms
- Any existing internal tooling that partially covers observability (even if patchy)

### Your Ideal Outcome

Walk out with a decision in principle (buy, build, or hybrid) with a 30-day
action plan. Diana approves the direction, Priya confirms the budget model
is workable, Raj has clear scope for his team's contribution, and Chen has
a concrete date when his team gets better tooling. No second meeting needed.
```

---

### `/meeting-cancel` - Should this meeting be an email?

**Input:**

```
/meeting-cancel
weekly status sync, 1 hour, 12 attendees. agenda says: review project
status updates, discuss blockers, align on priorities for next week.
each person gives a 5 min update on what their team is doing.
```

**Output:**

```
## Meeting Assessment: Weekly Status Sync

### The Honest Verdict

**Should this meeting happen?** NO

**Cost of this meeting:** 12 attendees x 1 hour = 12 person-hours per week (624 person-hours per year)

**One-sentence rationale:** Twelve people sitting through eleven status
updates they do not need to hear, to deliver one update they could have
typed in 3 minutes, is not a meeting. It is a hostage situation.

---

### If NO: Here Is the Async Alternative

**Format:** Slack thread or shared doc (weekly cadence)

**Draft of the Async Communication:**

Subject: Replacing the Weekly Status Sync with Async Updates

Hi all,

Starting this week, we are replacing the 1-hour weekly status sync with
an async update. Here is how it works:

**Every Monday by 11am**, post your update in #team-status-updates using
this format:

> **[Your Name / Team]**
> **Shipped last week:** (what got done)
> **Shipping this week:** (what is planned)
> **Blockers:** (what is stuck and who can help)
> **Needs discussion:** (anything that requires a live conversation)

**Rules:**
- Updates should take 3-5 minutes to write
- Read the thread. React with an emoji if you have read someone's update.
- If something in the "Needs discussion" section affects you, reply in-thread
  to coordinate a focused 15-minute call with just the relevant people
- If there are no blockers and no discussion items by Tuesday noon, we skip
  the week entirely

**Escalation path:** If we cannot resolve a blocker async by Wednesday,
I will schedule a 15-minute call with only the people involved. Not 12
people. Just the ones who need to talk.

**What to Do with the Freed-Up Time:**
- Each person gets back ~50 minutes per week (minus 5 minutes for the async update)
- That is 600 minutes of engineering time returned to the team per week
- Spend it on the work you were going to report on in the meeting
```

---

### `/follow-up-check` - The accountability report

**Input:**

```
/follow-up-check
PREVIOUS: last week john said he'd finish the api docs by wednesday.
sara was going to set up the staging environment. mike committed to
the security review by friday. we decided to use postgres instead of
mongo and someone needed to update the terraform configs. also lisa
was supposed to schedule the vendor demo.

CURRENT: standup today. john said api docs are almost done, maybe
tomorrow. sara got staging up and running, looks good. mike hasnt
started the security review yet, got pulled into incident response.
we talked about the roadmap for next quarter. nobody mentioned
terraform or the vendor demo.
```

**Output:**

```
## Accountability Report

**Previous Meeting:** Last week
**Current Meeting:** Today

### Scorecard

| Metric | Count | Percentage |
|--------|-------|------------|
| Total Previous Commitments | 5 | 100% |
| Completed | 1 | 20% |
| In Progress (On Track) | 0 | 0% |
| Slipped (Missed Deadline) | 2 | 40% |
| Blocked | 0 | 0% |
| Never Mentioned (At Risk) | 2 | 40% |

**Overall Follow-Through Rate:** 20%

### Detailed Tracking

#### Completed
| # | Original Commitment | Owner | Original Deadline | Status | Notes |
|---|---------------------|-------|-------------------|--------|-------|
| 1 | Set up staging environment | Sara | Last week | Done | "Looks good" per standup |

#### Slipped
| # | Original Commitment | Owner | Original Deadline | Days Slipped | Reason | New Deadline |
|---|---------------------|-------|-------------------|-------------|--------|--------------|
| 1 | Finish API docs | John | Wednesday (last week) | 4+ days | Not stated | "Maybe tomorrow" (unconfirmed) |
| 2 | Complete security review | Mike | Friday (last week) | 3+ days | Pulled into incident response | No new deadline set |

#### Never Mentioned (Requires Immediate Attention)
These items were committed to in the previous meeting but did not come up
at all in the current meeting. They are at high risk of being dropped.

| # | Original Commitment | Owner | Original Deadline | Recommended Action |
|---|---------------------|-------|-------------------|--------------------|
| 1 | Update Terraform configs for Postgres migration | TBD | TBD | This was tied to a confirmed decision (Postgres over Mongo). The migration cannot proceed without this. Assign an owner immediately. |
| 2 | Schedule vendor demo | Lisa | TBD | Lisa was not mentioned in today's standup at all. Confirm whether this is still needed and whether Lisa has taken any action. |

### Patterns and Risks

- **Follow-through rate is 20%.** Only 1 of 5 commitments was completed.
  This is a concerning pattern if it repeats.
- **Slipped items have soft new deadlines.** John's "maybe tomorrow" is
  not a commitment. Mike has no new deadline at all. Both need firm dates.
- **"Never mentioned" items are tied to a confirmed decision.** The
  Postgres migration was decided last week. The Terraform work that enables
  it has no owner and was not discussed. This decision is at risk of
  stalling silently.
- **New topics crowded out accountability.** The team discussed the Q4
  roadmap without first closing out open items from last week.

### Recommendations

1. Open the next meeting by reviewing this accountability report before
   adding new topics. Old commitments should be resolved before new ones
   are made.
2. Assign an owner for the Terraform config update today. This is blocking
   a confirmed architectural decision.
3. Get a firm delivery date from John on the API docs (not "maybe tomorrow").
4. Get a firm delivery date from Mike on the security review, accounting
   for his incident response workload.
5. Follow up with Lisa directly on the vendor demo. If it is no longer
   needed, remove it from the tracker.
```

## Project Structure

```
ai-bu-meeting-notes/
  commands/
    meeting-notes.md       # Full structured meeting notes
    action-items.md        # Action item extraction with gap analysis
    meeting-email.md       # Follow-up email generator
    agenda.md              # Meeting agenda with success criteria
    decision-log.md        # Decision log with rationale and alternatives
    standup-notes.md       # Async standup formatter with team pulse
    pre-brief.md           # Strategic pre-meeting briefing
    raci.md                # RACI matrix extraction with gap flags
    follow-up-check.md     # Cross-meeting accountability tracker
    meeting-cancel.md      # "Should this meeting be an email?" analyzer
  install.sh               # Installer script
  README.md                # This file
```

## License

Apache-2.0
