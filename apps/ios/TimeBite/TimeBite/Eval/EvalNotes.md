# Eval Notes

## Scenario

The seed scenario is `AgentBeats Hackathon Run`.
The target action is the primary Action-tab item.

## Observables

- Selected action
- Action state
- Start events
- Stop events
- Complete events
- Event timestamps
- Daily telemetry
- Planner/executor snapshot hooks

## Scoring shape

The score is intentionally simple and easy to inspect:

- Completing the target action matters most.
- Recording start and stop transitions matters next.
- Having a non-empty log trail matters.
- Keeping the daily log updated matters.

## Expected behavior

The environment should make it obvious when state changes happen.
That means the UI should never hide the current action state or the event trail.
It should remain a scaffold, not a full product UI.

## Demo order

1. Action tab
2. Track tab
3. Goals tab
4. Dash tab

## Implementation note

The benchmark is mock-data only.
There is no backend, auth, or external sync layer in this version.
Shared product code should be ported in from `timebite-platform` later.
Planner/executor integrations should read from the snapshot-based hook surface in `AgentHooks.swift`.
