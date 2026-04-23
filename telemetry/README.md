# Telemetry Folder

This folder is for **telemetry docs and demo artifacts** (not production analytics).

## Canonical log location (current helper)
- `data/telemetry_runs/runs.jsonl` (append-only JSONL)

## Python logger helper
The repository includes a tiny JSONL logger at `services/telemetry.py`.

Expected usage pattern:
- The app/agent emits a dict-like event payload.
- Logger adds a `timestamp` and appends to `runs.jsonl`.

## Recommended event payload (minimum)
```json
{
  "event_name": "timer_started",
  "session_id": "demo-2026-04-20-001",
  "task_title": "Write hackathon demo",
  "task_category": "work",
  "duration_seconds": 1500
}
```

## Demo rule of thumb
If it’s something you claim in the demo (suggestion, start, pause, completion, reflection), it should create a telemetry event.

