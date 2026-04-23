# TimeBite — Requirements (Demo Scope)

This document is **requirements-first** and intentionally limited to the hackathon demo.

## Success criteria (project-level)
- A first-time judge can complete the demo flow in **≤ 3 minutes** without guidance.
- The app visibly shows **progress** while a task timer runs.
- The system produces telemetry that supports at least one demo metric (completion %, reflection score, or time-on-task).

## Feature 1 — Daily Intent setup

### User story
As a user, I want to set my Daily Intent so my time and agent suggestions align with what matters today.

### Requirements
- User can enter (or select) **2–3 focus outcomes** for the day.
- Daily Intent persists for “today” (device-local is fine for demo).
- Daily Intent is visible on the main screen (or in a single tap).

### Acceptance criteria
- User can create/update intent in under 30 seconds.
- Relaunching the app retains today’s intent.

### Success metric
- `% of sessions with intent set` (target: ≥ 80% for demo runs).

### Edge cases
- Empty input → show validation or reasonable defaults.
- New day rollover → intent resets/archives without crashing.

### Implementation notes
- Keep storage local (e.g., file, UserDefaults, lightweight store). Avoid auth/cloud.

---

## Feature 2 — Agent task suggestion

### User story
As a user, I want the system to suggest the next best task so I can start focusing immediately.

### Requirements
- A “Suggest” action produces a **single recommended task**.
- Suggestion is explainable with a short reason (“because it matches your intent / category balance / time remaining”).
- Suggestions respect Daily Intent and available task list.

### Acceptance criteria
- Tapping “Suggest” updates the UI within 1 second (heuristic or cached is OK).
- Suggestion can be accepted with one tap to start the timer.

### Success metric
- `% of suggested tasks started` (target: ≥ 50% for demo runs).

### Edge cases
- No tasks exist → suggest creating a task (or provide a demo task).
- All tasks completed → suggest reflection or planning tomorrow.

### Implementation notes
- Demo-grade agent may be: heuristic rules, local LLM call, or a small orchestrator.
- Start with deterministic logic; swap to real agent if time allows.

---

## Feature 3 — Timer start / pause / resume

### User story
As a user, I want to start, pause, and resume a timer so I can track real focus time without losing progress.

### Requirements
- User can start a timer for a selected task.
- User can pause and resume without resetting elapsed time.
- When the timer hits 0, task is marked completed (or “done” state is visible).

### Acceptance criteria
- Timer continues accurately for at least 2 minutes without drift visible to a judge.
- Pause/resume updates UI state clearly (running vs paused).

### Success metric
- `% of started timers that reach completion` (target: ≥ 60% for demo runs).

### Edge cases
- Starting a different task while one is running prompts stop/switch behavior.
- App backgrounding → timer state restores without crashing.

### Implementation notes
- Keep it simple: 1 active timer at a time.

---

## Feature 4 — Ring progress UI (2D Activity Ring + 3D torus)

### User story
As a user, I want to see progress visually as a ring (2D) or torus (3D) so I can feel momentum and understand remaining time at a glance.

### Requirements
- **2D (iOS/watchOS/macOS):** Activity Rings-style **progress ring** renders progress continuously while timer runs.
- **3D (visionOS):** A spatial **torus** renders progress/depletion in a similarly legible way.
- Ring/torus color reflects the task category (or intent lane).
- Remaining time is readable in the center (or adjacent, for 3D).

### Acceptance criteria
- At least 3 discrete states are visible: idle, running, completed/paused.
- Ring updates at least once per second (or smoothly).

### Success metric
- “Time-to-understand” (judge can describe what the ring means within 10 seconds).

### Edge cases
- Very short timers (≤ 1 minute) still animate correctly.
- Accessibility: text remains legible (dynamic type safe for demo).

### Implementation notes
- For hackathon reliability, ship 2D ring everywhere; add 3D torus only if it’s stable.
- iOS ring can use `Circle().trim(...)` (fast + controllable).

---

## Feature 5 — Reflection scoring

### User story
As a user, I want to reflect and score my outcome so the system can improve suggestions and show progress over time.

### Requirements
- Reflection is captured at the end of a session/day.
- User selects outcome per intent lane: **Done / Partial / Missed**.
- System computes a simple reflection score (0–100) for the demo.

### Acceptance criteria
- Reflection entry takes ≤ 20 seconds.
- The resulting score is displayed and stored locally for “today.”

### Success metric
- `% of sessions with reflection submitted` (target: ≥ 50% for demo runs).

### Edge cases
- User skips reflection → allow “skip” but log telemetry.
- Partial info (only 1 lane scored) → still produce a score.

### Implementation notes
- Keep scoring deterministic (e.g., Done=1, Partial=0.5, Missed=0).

---

## Feature 6 — Telemetry logging

### User story
As a builder (and judge), I want telemetry logs so I can verify agent decisions and user progress objectively.

### Requirements
- Log key events as JSON (or JSONL) with timestamps.
- Events cover: intent set, task suggested, timer started/paused/resumed/stopped, reflection submitted.
- Telemetry is easy to find in the repo after a demo run.

### Acceptance criteria
- Telemetry file is created automatically on first event.
- Each event includes `timestamp`, `event_name`, and minimal context.

### Success metric
- `% of demo runs with complete telemetry sequence` (target: 100%).

### Edge cases
- Logging failure must not crash the app.
- File growth is bounded (rotate or overwrite for demo).

### Implementation notes
- JSONL is preferred for append-only writes and easy inspection.
