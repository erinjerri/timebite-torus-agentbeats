# Telemetry (Hackathon Demo)

Telemetry is part of the product: it proves what happened during the demo and enables simple metrics.

## Where logs live (current)
- Python helper writes JSONL to `data/telemetry_runs/runs.jsonl` via `services/telemetry.py`.

## Event format (recommended)
JSONL: one JSON object per line.

Required fields:
- `timestamp` (ISO-8601)
- `event_name` (string)

Strongly recommended fields:
- `session_id` (string)
- `day_key` (e.g., `yyyy-mm-dd`)
- `task_id`, `task_title`, `task_category` (when relevant)
- `intent` (when relevant)
- `duration_seconds`, `remaining_seconds` (timer events)
- `reflection` + `score` (reflection events)

## Event names (core demo)
- `intent_set`
- `task_created`
- `task_suggested`
- `timer_started`
- `timer_paused`
- `timer_resumed`
- `timer_completed`
- `reflection_submitted`

## Minimal metrics (demo-ready)
- **Completion rate**: timers completed / timers started
- **Suggestion uptake**: suggested tasks started / suggestions shown
- **Reflection submit rate**: reflections submitted / sessions started
- **Reflection score**: simple 0–100 outcome score

## Reliability requirements
- Telemetry must never crash the app.
- Logging must succeed offline.
- For demo, keep logs bounded (overwrite per run or rotate per day).

## Demo-friendly output options
Choose one:
1. **JSONL file** (best): inspectable + greppable.
2. **Console logs**: fastest to implement, but harder to prove.
3. **In-app debug screen**: best UX, but costs time.

## Implementation note
This repo currently has a Python JSONL logger (`services/telemetry.py`). For the iOS demo, prefer a lightweight Swift logger that writes JSONL into the app’s Documents directory (and optionally mirrors to console).

