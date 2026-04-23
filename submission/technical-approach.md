# Technical Approach (Demo-First)

## Core loop
**Intent → Suggestion → Timer → Ring UI → Reflection → Telemetry**

## iOS app (SwiftUI)
- Timer experience is designed around a single active task at a time for demo clarity.
- Ring progress UI is implemented as a trimmed circle that updates as remaining time changes.
- Task metadata is intentionally minimal (title, category, duration, state) to keep the demo reliable.

## Agent suggestion (constrained + explainable)
- The “agent” is constrained to recommending the next task (not open-ended chat).
- For demo reliability, suggestions can be backed by deterministic heuristics:
  - match Daily Intent keywords
  - balance across categories
  - pick the shortest/highest-impact task first
- Each suggestion must render a 1-line “why” explanation.

## Reflection scoring (simple + fast)
- Outcomes: Done / Partial / Missed.
- Score: deterministic mapping to 0–100 for a clean demo story.

## Telemetry logging (proof + metrics)
- Emit JSONL events for:
  - intent_set, task_suggested, timer_started/paused/resumed/completed, reflection_submitted
- Use telemetry to compute at least one metric live (or in a quick terminal view).

## Why this approach wins a hackathon demo
- Clear product story in 3 minutes.
- Visual “wow” from the ring timer.
- Agent is useful but bounded.
- Telemetry proves claims and enables measurable success.

