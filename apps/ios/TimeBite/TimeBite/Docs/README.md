# AgentBeats TimeBite

## What this repo is

This repository is a thin benchmark layer derived from the main TimeBite platform app.
It should stay lightweight and avoid becoming a second full product codebase.

The canonical product source is expected to live in `timebite-platform` later.
This repo only keeps the evaluation shell, mock data, and submission docs.

## Environment shape

The app preserves the four-tab surface from TimeBite:

- Action
- Track
- Goals
- Dash

Only the Action tab has real interaction right now.
The other tabs are intentionally sparse placeholders that frame the environment.

## Measurable actions

The benchmark currently measures:

- Start an action
- Stop an action
- Complete an action
- Select a target action
- Reset the mock environment

Each transition creates a local `AgentActionLog` entry.

## Agent evaluation mapping

The environment is meant to answer a narrow question:

1. Can an agent choose the right action?
2. Can it drive the action through visible state changes?
3. Can it leave a clean log trail?
4. Can it keep the environment consistent while doing so?

That makes the repo useful for hackathon demos and benchmark runs, not production work.

## Quick demo script for May 24

1. Open the app in the iOS simulator.
2. Go to Action.
3. Select the primary action.
4. Tap Start.
5. Tap Stop.
6. Tap Start again.
7. Tap Complete.
8. Open Track to show telemetry.
9. Open Goals to show the benchmark framing.
10. Open Dash to show the score and porting note.

## Notes

- Mock data only.
- Offline only.
- No backend, auth, or integrations.
- Shared product UI should be ported from `timebite-platform` later.
