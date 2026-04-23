# Judge Script (AgentBeats)

## 15-second hook
TimeBite is a measurable focus environment: set today’s intent, let an agent suggest the next task, run a ring timer, then reflect and log telemetry so progress is provable.

## 60-second walkthrough
1. Set Intent + confirm 3 projects.
2. Start a timer in the Arena; ring shows progress.
3. Open Dashboard; show 3 rings + weekly caps + score.
4. Apply AI reallocation (+2h to Hackathon); rings update live.
5. Submit reflection and show a score.
6. Show telemetry events and one metric.

## 2-minute version (recommended)
**Problem:** Most productivity tools track plans, not reality.  
**Solution:** TimeBite tracks *measured time* with agent guidance and ring UI that makes progress tangible.  
**Why now:** Agents can nudge the next action, but we need guardrails and measurement.  
**Demo:** (run the happy path)  
**Proof:** Telemetry shows the full sequence of intent → focus → reallocation → outcome.  

## Judge Q&A cheat sheet
- **What is “agent” here?** A constrained recommender that suggests the next best task, backed by deterministic rules for demo reliability (upgradeable to an LLM).
- **What makes this different?** It’s a closed loop: intent → action → measured time → reflection → telemetry.
- **Why a ring/torus?** It makes remaining time and momentum visible without reading a list.
