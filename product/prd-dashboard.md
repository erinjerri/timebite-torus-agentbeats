# Dashboard PRD (Hackathon Demo)

## Summary
The Dashboard is the “wow factor” screen: three projects visualized as rings, weekly caps, an AI suggestion that reallocates time, and a single completion score.

## Primary user
Builder juggling multiple priorities (hackathon + startup + job search).

## Goals
- Make progress legible at a glance via rings.
- Make AI feel useful and constrained via a single, explainable reallocation.
- Provide a clear score that matches the demo narrative.

## Non-goals (for AgentBeats demo)
- Full project management
- Complex recurrence and scheduling
- Deep integrations (Notion/Calendar/etc.) — this belongs in the long-term `timebite-platform`

## Core experience

### Data shown (must)
- **3 active projects**
  1. Hackathon Repo
  2. Startup Repo
  3. Job Search
- **Weekly caps** (hours/week) per project
- **Ring progress** per project (spent vs cap)
- **Completion score** (0–100)
- **AI reallocation suggestion**
  - Text: “Hackathon is behind plan. Reallocate 2h from <lower priority> to Hackathon.”
  - Button: “Apply”

### Interactions (must)
- Apply AI suggestion updates the underlying caps/plan and the rings update **immediately**.
- Dashboard reflects live timer time attribution (time spent increments the correct project).

## Scoring (demo-simple)
Completion score is deterministic:
- For each project: `progress = min(spent / cap, 1.0)`
- Score = average(progress) * 100 (rounded)

## AI reallocation logic (demo-simple)
Inputs:
- current spent hours per project
- weekly caps per project
- priority order: Hackathon > Startup > Job Search (for demo)

Rule:
- If Hackathon progress is the lowest relative to its cap, propose moving **2h** cap from the lowest-priority project that can afford it.

## Acceptance criteria
- Dashboard renders without scrolling on an iPhone simulator.
- Rings animate smoothly when time changes or when reallocation is applied.
- “Apply” updates numbers + rings in < 250ms perceived time.
- Score updates after reallocation and while timer runs.

## Telemetry events (recommended)
- `dashboard_viewed`
- `ai_reallocation_suggested`
- `ai_reallocation_applied`

