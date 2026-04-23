# Sprint — Current (Hackathon Demo Sprint)

## Sprint goal
Ship a **polished judge-ready demo** of TimeBite’s ring timer + agent suggestion + measurable telemetry.

## Demo checklist order (build in this order)
1. Daily Intent setup (fast UX, persistent)
2. Agent Suggest (deterministic + explainable)
3. Start/pause/resume timer (clean states)
4. Ring progress UI polish (legibility + smoothness)
5. Reflection scoring (quick capture + score)
6. Telemetry (JSONL + one metric)

## “What’s in the room” (current repo)
- iOS app lives at `apps/ios/TimeBite/`
- Python telemetry helper exists at `services/telemetry.py` writing to `data/telemetry_runs/runs.jsonl`

## Current sprint tasks (top priority)
- Add a dedicated **Daily Intent** UI entry point on main screen.
- Add **Agent Suggest** UI (button + suggestion card + accept-to-start).
- Add explicit **Pause** button (stop → pause is OK, but make it obvious).
- Wire **Reflection** capture + score (Done/Partial/Missed → 0–100).
- Implement **iOS telemetry** (or bridge to existing JSONL) for demo events.

## Cut list (if behind schedule)
- Any multi-screen navigation refactors
- LLM calls (stick to heuristic agent)
- VisionKit capture (leave as placeholder)

