import json
from datetime import datetime
from pathlib import Path

LOG_DIR = Path("data/telemetry_runs")
LOG_DIR.mkdir(parents=True, exist_ok=True)

def log_event(event):

    file = LOG_DIR / "runs.jsonl"

    with open(file, "a") as f:
        f.write(json.dumps({
            "timestamp": datetime.utcnow().isoformat(),
            **event
        }) + "\n")