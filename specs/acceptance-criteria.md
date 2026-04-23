# TimeBite — Acceptance Criteria (Must-pass for Demo)

## Must-pass (demo blocker if failing)

### Daily Intent
- **AC-INTENT-01**: User can create/update today’s intent in one screen (or one modal).
- **AC-INTENT-02**: Today’s intent persists across app relaunch.

### Agent suggestion
- **AC-AGENT-01**: “Suggest” produces exactly one recommended task (or a clear empty-state message).
- **AC-AGENT-02**: UI shows a 1-line reason for the suggestion.
- **AC-AGENT-03**: User can accept the suggestion and start focusing with ≤ 2 taps.

### Timer + ring
- **AC-TIMER-01**: User can start a timer and see remaining time decrement.
- **AC-TIMER-02**: User can pause and resume without resetting.
- **AC-RING-01**: Ring visually represents progress while running.

### Reflection scoring
- **AC-REFLECT-01**: User can submit reflection in ≤ 20 seconds.
- **AC-REFLECT-02**: A score is displayed (even if simple) and stored locally.

### Telemetry
- **AC-TELEM-01**: Telemetry file is created automatically.
- **AC-TELEM-02**: Events are timestamped and include enough context to replay the demo flow.

## Nice-to-have (only if time remains)
- **NH-01**: “Reset demo” button for consistent judge runs.
- **NH-02**: Lightweight metrics view (“completion rate today”).
- **NH-03**: One screenshot/GIF in README.

