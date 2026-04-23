# AgentBeats TimeBite Pitch

TimeBite is the canonical platform app.
This repository is the hackathon and benchmark layer that sits beside it for evaluation work.

The layer keeps the familiar four-tab shape, but it is intentionally minimal.
Its job is to expose a measurable task environment, capture action logs, and support agent/evaluator demos.

## Why it matters

- It gives agents a visible place to act.
- It turns state transitions into measurable signals.
- It avoids backend and integration noise during hackathon runs.

## What is being evaluated

- Can the agent pick the right action?
- Can it start, stop, and complete that action?
- Can it leave a readable log trail?
- Can it keep the environment consistent while doing it?

## Submission framing

This is not a second product app.
It is a benchmark shell that will reuse shared models and UI from `timebite-platform` later.

The pitch is simple:

> A visible local environment gives us a cleaner way to evaluate agent execution before we scale into the full platform app.
