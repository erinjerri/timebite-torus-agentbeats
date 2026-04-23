# TimeBite 5/24 Notion Template

Use this as the project hub page and task database blueprint for tracking the May 24 submission.

## Project Hub Page

### Goal
Ship the TimeBite product path for the May 24 AgentBeats General Track submission.

### Current Status
- Core iOS shell is in place
- Task creation, timer, and history views are underway
- OpenEnv is stretch-only

### This Week
- Top 3 ship-critical tasks
- One owner per task
- Blockers cleared before new scope

### Blockers
- Build issues
- Timer / persistence regressions
- Scope creep

### Decision Log
- What we cut
- What we postponed
- What we shipped

### Evidence
- Commit links
- Demo clips
- Screenshots
- Test results

### Next Milestone
- Submission freeze
- Demo video
- Final README pass

## Task Database Schema

| Property | Type | Example |
|---|---|---|
| Task | Title | `Verify persistence loop` |
| Workstream | Select | `App`, `Docs`, `Submission`, `Stretch` |
| Status | Select | `Backlog`, `Ready`, `In progress`, `Blocked`, `Review`, `Done` |
| Priority | Select | `P0`, `P1`, `P2`, `P3` |
| Due date | Date | `2026-05-24` |
| Blocked by | Rich text | `Waiting on timer fix` |
| Next action | Rich text | `Run reload test` |
| Evidence | URL | `https://...` |
| Owner | Text | `Erin` |

## Task Template

```markdown
# [Task Name]

## Context
Part of the 5/24 TimeBite execution plan.

## Objective
[Clear outcome]

## Acceptance Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]

## Next Action
[Immediate next step]

## Blockers
[Any blocker]

## Evidence
[Link]
```

## Weekly Cadence

- Monday: choose the 3 ship-critical tasks
- Wednesday: clear blockers and update evidence
- Friday: close tasks and prune scope

