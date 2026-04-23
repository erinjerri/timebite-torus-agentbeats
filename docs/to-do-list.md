# TimeBite Torus AgentBeats - 5/24 Execution Plan

Start Date: March 21

This document is the working roadmap for **TimeBite Torus**, with the **May 24 AgentBeats General Track submission** as the primary target.

OpenEnv is still listed as a benchmark goal, but only as a stretch target now. The current priority is to stabilize the product, finish the submission-ready app surface, and keep the planning system tight enough that we can ship without guesswork.

## What the repo already has

Based on the current code in the repo, the project is no longer at "blank slate" stage.

### Already in place

- Tab-based iOS shell with Dashboard, Plan, Action, and Calendar flows
- Task creation UI with category suggestions and duration presets
- Active timer ring plus start/stop task control
- JSON-backed local task storage
- Timer engine that updates remaining time and persists task state
- Category, status, capture-source, and formatting models for task tracking
- Green-agent backend with `/process`, `/health`, and `/evaluate`
- Local telemetry + task file output in the green backend sandbox

### Still not done

- OpenEnv runner and evaluation harness
- Submission packaging and release polish
- Docs cleanup to match the current app state
- Any build cleanup needed for duplicate `* 2.swift` files in the worktree
- Final benchmark or demo story for the May 24 submission

## Key Deadlines

| Milestone | Date |
|-----------|------|
| AgentBeats General Track submission | May 24 |
| OpenEnv benchmark submission | Stretch only |

## Current Priorities

### 1. Ship the core product path

The app should make it easy to:

- create a task
- start or stop it
- review the day
- understand category balance

The current Swift work is already pointed in that direction, so the job now is mainly stabilization and cleanup instead of another major pivot.

### 2. Keep OpenEnv as optional stretch work

OpenEnv should not block the 5/24 deadline.

Use it only if:

- the core product is stable
- the repo is in a shippable state
- there is time left after submission-critical work

### 3. Product-manage the remaining work

Track tasks by:

- workstream
- owner
- priority
- blocker
- next action
- evidence link

That gives us a fast way to see what is truly blocking the deadline versus what is just nice to have.

## Weekly Ship Checklist

Use this as the operating rhythm until the 5/24 freeze.

### Monday

- Pick 3 ship-critical tasks only
- Confirm one owner per task
- Write the next action for each task
- Mark anything fuzzy as blocked or deferred

### Wednesday

- Re-check the highest-risk task
- Clear blockers before starting new work
- Update evidence links and progress notes
- Cut any task that is drifting out of scope

### Friday

- Close finished tasks
- Move incomplete work into next week or stretch
- Update the decision log
- Decide whether OpenEnv still deserves time

## 5/24 Roadmap

### Phase A - Stabilize the Current App

Goal: make the current TimeBite flow boring and reliable.

| Task | Status | Notes |
|---|---|---|
| Resolve any duplicate source files in the worktree | ⬜ Pending | watch for `* 2.swift` copies and other accidental duplicates |
| Verify the new AppState / TaskStore persistence loop | ⬜ Pending | create, save, reload, and resume active task state |
| Confirm timer behavior for start, stop, pause, and completion | ⬜ Pending | make sure `TimeBiteEngine` stays consistent after reload |
| Check calendar/history rendering against saved task data | ⬜ Pending | ensure grouped task history reads cleanly |
| Validate category suggestion and manual override behavior | ⬜ Pending | keep plan flow low-friction |

### Phase B - Submission-Ready Product Surface

Goal: present the app like a real product, not a rough prototype.

| Task | Status | Notes |
|---|---|---|
| Tighten the dashboard summary and empty states | ⬜ Pending | reduce clutter, make progress obvious |
| Finalize copy for Plan / Action / Calendar tabs | ⬜ Pending | keep labels consistent with the product story |
| Polish the demo path for task creation and execution | ⬜ Pending | one clean flow we can show quickly |
| Add or verify lightweight tests for core state transitions | ⬜ Pending | especially save/load and timer transitions |

### Phase C - Docs and Submission Assets

Goal: make the repo easy to understand for judges and teammates.

| Task | Status | Notes |
|---|---|---|
| Update README to match the current product direction | ⬜ Pending | remove stale milestone language |
| Refresh architecture docs if the implementation diverges | ⬜ Pending | keep docs aligned with code |
| Capture a short demo script and submission narrative | ⬜ Pending | emphasize task planning, timer execution, and feedback |
| Freeze a submission candidate branch | ⬜ Pending | no new feature work after freeze |

### Phase D - Stretch: OpenEnv

Goal: only if the core product is already stable.

| Task | Status | Notes |
|---|---|---|
| Implement OpenEnv runner | ⬜ Pending | `evaluation/openenv_runner.py` |
| Adapt the agent interface to OpenEnv tasks | ⬜ Pending | execution wrapper only |
| Run one baseline evaluation pass | ⬜ Pending | use it for learning, not scope creep |

## Repo Left Off Snapshot

The latest in-progress code appears to have moved the app from a simple timer demo into a fuller task-management shell.

### App layer

- `apps/ios/TimeBite/TimeBite/App/AppState.swift`
  - now loads and saves tasks
  - keeps all tasks plus today's tasks in memory
  - binds the engine to the active task
  - exposes create/start/stop/reset helpers

- `apps/ios/TimeBite/TimeBite/App/RootView.swift`
  - now has Dashboard, Plan, Action, and Calendar tabs
  - includes task composer, active ring, task list, and history grouping

- `apps/ios/TimeBite/TimeBite/Services/Core/TimeBiteEngine.swift`
  - now runs the timer loop
  - updates remaining seconds
  - finalizes tasks on completion
  - persists via update callbacks

### Model layer

- `apps/ios/TimeBite/TimeBite/Features/tasks/Models/TaskCategory.swift`
  - adds category, duration preset, status, and capture-source enums

- `apps/ios/TimeBite/TimeBite/Features/cycles/Models/FocusLane.swift`
  - acts as the serialized task model
  - stores timing, status, and metadata fields

- `apps/ios/TimeBite/TimeBite/Features/tasks/ViewModels/TaskCategorizer.swift`
  - provides keyword-based category suggestions

- `apps/ios/TimeBite/TimeBite/Features/tasks/ViewModels/TaskTimeFormatter.swift`
  - formats timer values for the UI

### Backend / benchmark layer

- `services/agents/green/backend/main.py`
  - exposes `/process`, `/health`, and `/evaluate`
  - writes local task and telemetry JSON

- `services/agents/green/agent.toml`
  - declares the green agent environment and capabilities

- `services/agents/green/scenario.toml`
  - defines the benchmark pairing for the current scenario

## Notion Progress Template

Use this as the canonical structure for the Notion project page or task database.

### Project page sections

1. Goal
2. Current status
3. This week
4. Blockers
5. Decision log
6. Evidence
7. Next milestone

### Task database properties

| Property | Type | Purpose |
|---|---|---|
| Task | Title | Short actionable task name |
| Workstream | Select | App, Backend, Benchmark, Docs, Submission, Stretch |
| Status | Select | Backlog, Ready, In progress, Blocked, Review, Done |
| Priority | Select | P0, P1, P2, P3 |
| Due date | Date | Deadline or checkpoint |
| Blocked by | Rich text | Short blocker note or dependency |
| Next action | Rich text | Immediate next step |
| Evidence | URL | Link to screenshot, commit, PR, or demo |
| Owner | Text | Human owner or agent owner |

### Task page template

```markdown
# [Task Name]

## Context
Part of the 5/24 TimeBite execution plan.

## Objective
[What needs to change or ship]

## Acceptance Criteria
- [ ] [Concrete outcome 1]
- [ ] [Concrete outcome 2]

## Next Action
[The very next step]

## Blockers
[Anything blocking this task]

## Evidence
[Link to commit, screenshot, PR, or note]
```

### Suggested status values

- Backlog
- Ready
- In progress
- Blocked
- Review
- Done

### Suggested workstreams

- App
- Backend
- Benchmark
- Docs
- Submission
- Stretch

### Weekly operating cadence

- Monday: choose the 3 ship-critical tasks
- Wednesday: clear blockers and review evidence
- Friday: close tasks, update the decision log, and prune scope

## Infrastructure and Research Tasks

| Task | Status | Notes |
|---|---|---|
| Evaluate remaining model/runtime cost | ⬜ Pending | only if it affects shipping |
| Add token usage tracking | ⬜ Pending | useful for budget control |
| Keep benchmark replay support in mind | ⬜ Pending | optional until the core ship path is stable |
| Monitor AgentBeats updates | ⬜ Pending | only what affects May 24 |
