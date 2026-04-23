# TimeBite — AgentBeats Hackathon Spec

## One-liner
TimeBite is a measurable focus environment where an agent helps you pick the next task, run a timer, and visually track progress on a torus/ring.

## Demo thesis (what judges should remember)
We turn “I should do X” into **measured time** with **agent guidance**, a **ring timer**, and **reflection + telemetry** that proves the system works.

## Scope: core demo features (ONLY)
1. **Daily Intent setup** (what matters today)
2. **Agent task suggestion** (the next best task recommendation)
3. **Timer start / pause / resume**
4. **Torus / ring progress UI**
5. **Reflection scoring** (end-of-session outcome)
6. **Telemetry logging** (events + success metrics)

## Out of scope (AgentBeats submission)
- Multi-user accounts, cloud sync, auth
- Long-term analytics dashboards
- “Open chat” assistant or arbitrary planning generation

## Post-hackathon roadmap (timebite-platform)
- Deep integrations (Notion / Calendar / etc.)
- Complex recurrence and scheduling (calendar, dependencies)

## Demo narrative (happy path)
1. Set **Daily Intent**: pick 2–3 outcomes for today.
2. Tap “Agent Suggest” to pick the next task.
3. Start the timer; ring shows progress and remaining time.
4. Pause/resume once to show control.
5. Finish; submit a quick reflection (done/partial/missed) + score.
6. Show telemetry events and a simple success metric (e.g., completion rate).

## Definition of done (hackathon-grade)
- Judges can run the iOS app and see the ring timer working end-to-end.
- A “suggested next task” is visible and plausibly agent-driven (even if heuristic-backed for demo).
- Reflection capture and telemetry events exist (file, console, or JSONL).
- Repo has clear specs, demo flow, and submission docs.

## Repo pointers
- Specs: `specs/requirements.md`
- Demo flow: `product/demo-flow.md`
- Judge script: `product/judge-script.md`
- System overview: `architecture/system.md`
- Telemetry: `architecture/telemetry.md` + `telemetry/README.md`
