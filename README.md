# ai-bu-meeting-notes

Claude Code slash commands that transform rough meeting notes into structured, actionable output. Paste your messy notes, get clean results.

## What It Does

Six commands for different levels of meeting note processing:

- `/meeting-notes` - Full structured output: summary, decisions, action items table, open questions, and follow-up recommendations
- `/action-items` - Extracts only the action items as a table with owners and due dates
- `/meeting-email` - Generates a ready-to-send follow-up email with decisions and action items
- `/agenda` - Generates a meeting agenda with time allocations from a topic and attendee list
- `/decision-log` - Extracts only the decisions from meeting notes or any document into a structured log
- `/standup-notes` - Formats rough standup input into clean Done/Doing/Blockers updates

All commands handle messy input gracefully. Typos, incomplete sentences, abbreviations, and stream-of-consciousness formatting are all fine. Missing owners and due dates get marked as TBD. Relative dates like "next Thursday" get converted to absolute dates.

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

## Before/After Examples

These examples show what the commands do with truly rough input. No cleanup needed on your end.

---

### Example 1: Messy meeting notes with typos and half-sentences

**Input:**

```
/meeting-notes
ok so we had the infra sync, john paul sara and mike were there. talked abt
the k8s migratoin. johns been working on the helm charts, says hes abt 70%
done should be finishd by next fri. sara brot up that we dont have monitoring
sorted yet - she'll take that. we decidd to go w/ prometheus+grafana stack
instead of datadog bc cost. paul said budget is tight so no new hw purchases
til q4. need to figure out the dns cutover plan nobodys owning that yet.
also theres a concern about the ci/cd pipeline breaking during migration
but we didnt rly resolve that. mike said hed look into it but no promises lol.
prob need another sync next week to nail down the timeline. oh also we agred
to freeze feature deploys during the migration window
```

**Output from `/meeting-notes`:**

```
## Meeting Summary
Infrastructure sync covering the Kubernetes migration. The team reviewed Helm chart
progress, selected a monitoring stack, and agreed to freeze feature deploys during the
migration window. DNS cutover ownership and CI/CD pipeline risks remain unresolved.

## Decisions Made
1. Use Prometheus + Grafana for monitoring instead of Datadog due to cost.
2. No new hardware purchases until Q4 (budget constraint).
3. Freeze feature deploys during the migration window.

## Action Items
| # | Action Item                              | Owner | Due Date     |
|---|------------------------------------------|-------|--------------|
| 1 | Finish Helm charts for k8s migration     | John  | July 3, 2025 |
| 2 | Set up Prometheus + Grafana monitoring   | Sara  | TBD          |
| 3 | Investigate CI/CD pipeline risks         | Mike  | TBD          |
| 4 | Define DNS cutover plan                  | TBD   | TBD          |

## Open Questions / Parking Lot
- Who owns the DNS cutover plan?
- How do we prevent CI/CD pipeline breakage during migration?

## Follow-up Meeting Needed?
Y. Suggested topics:
1. Finalize migration timeline and DNS cutover plan
2. CI/CD pipeline risk mitigation
3. Review Helm chart progress
```

---

### Example 2: Abbreviation-heavy standup dump

**Input:**

```
/standup-notes
john: finishd the pr for auth svc, got it merged. today working on the
rate limiting middleware. no blockers rn.

sara: yesterday was debugging that flaky test in the payments module, turns
out it was a race condition w/ the db conn pool. fixd it. today starting
on the new billing api endpoints. blocked on the api spec tho - need
product to finalize it.

mike: was out sick yesterday. today catching up on code reviews and then
picking up the logging ticket. need access to the staging kibana instance,
been waiting on IT for 3 days now
```

**Output from `/standup-notes`:**

```
### John

**Done (since last standup):**
- Finished and merged PR for auth service

**Doing (today/next):**
- Working on rate limiting middleware

**Blockers:**
- None

### Sara

**Done (since last standup):**
- Debugged and fixed flaky test in payments module (race condition with DB connection pool)

**Doing (today/next):**
- Starting on new billing API endpoints

**Blockers:**
- Blocked on API spec - need product team to finalize it

### Mike

**Done (since last standup):**
- Out sick yesterday

**Doing (today/next):**
- Catching up on code reviews
- Picking up the logging ticket

**Blockers:**
- Needs access to staging Kibana instance (waiting on IT for 3 days)

> **Blockers need attention:** Sara is blocked on the billing API spec (needs product team).
> Mike needs staging Kibana access (IT request pending 3 days).
```

---

### Example 3: Decision extraction from a long thread

**Input:**

```
/decision-log
long planning meeting today. we went back and forth on the deployment
strategy. in the end we decided to go with blue-green deploys instead of
canary bc we dont have the traffic volume to make canary meaningful. also
agreed that all services need health check endpoints before we can do
any of this, thats non negotiable. there was debate about whether to use
istio or linkerd for the service mesh. we're going w linkerd, simpler and
the team has more exp with it. oh and we said no to the vendor proposal
from CloudWatch consulting, too expensive for what they offer.
```

**Output from `/decision-log`:**

```
| # | Decision | Context / Rationale | Owner | Date |
|---|----------|---------------------|-------|------|
| 1 | Use blue-green deployment strategy instead of canary | Traffic volume too low for canary deployments to be meaningful | TBD | TBD |
| 2 | All services must implement health check endpoints before migration | Non-negotiable prerequisite for deployment strategy | TBD | TBD |
| 3 | Use Linkerd for service mesh instead of Istio | Simpler tooling and more team experience with Linkerd | TBD | TBD |
| 4 | Reject CloudWatch consulting vendor proposal | Too expensive relative to the value offered | TBD | TBD |
```

---

### Example 4: Generating a meeting agenda

**Input:**

```
/agenda
need to plan a 1hr meeting about the q3 perf testing strategy. attendees
are john sara mike and lisa from the perf team. goals: agree on which
services to test first, pick a load testing tool, and set target SLOs.
we had some prior art with gatling but ppl were complaining it was hard
to maintain the scripts
```

**Output from `/agenda`:**

```
## Meeting Agenda: Q3 Performance Testing Strategy

**Date:** TBD
**Duration:** 60 minutes
**Attendees:** John, Sara, Mike, Lisa (Perf Team)

**Goal:** Align on performance testing priorities for Q3, select a load testing
tool, and define target SLOs for key services.

| Time | Duration | Topic | Lead |
|------|----------|-------|------|
| 0:00 | 3 min | Welcome and agenda review | TBD |
| 0:03 | 10 min | Review current state: Gatling experience and pain points | Lisa |
| 0:13 | 15 min | Evaluate load testing tools (Gatling, k6, Locust, others) | All |
| 0:28 | 15 min | Prioritize services for Q3 testing | All |
| 0:43 | 12 min | Define target SLOs per service | All |
| 0:55 | 5 min | Action items, owners, and next steps | TBD |

### Pre-reads / Prep
- Review existing Gatling scripts and known maintenance issues
- Bring a shortlist of services each person thinks should be tested first

### Desired Outcomes
- Agreed-upon load testing tool for Q3
- Ranked list of services to test first
- Draft SLO targets for top-priority services
- Clear owners and next steps
```

## Project Structure

```
ai-bu-meeting-notes/
  commands/
    meeting-notes.md    # Full structured meeting notes
    action-items.md     # Action items only
    meeting-email.md    # Follow-up email generator
    agenda.md           # Meeting agenda generator
    decision-log.md     # Decision log extractor
    standup-notes.md    # Async standup formatter
  install.sh            # Installer script
  README.md             # This file
```

## License

Apache-2.0
