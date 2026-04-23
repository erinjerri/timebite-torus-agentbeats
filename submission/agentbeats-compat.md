# AgentBeats Compatibility Check (Green + Purple)

This repo contains both:
- **🟢 Green agent** scaffolding (evaluator)
- **🟣 Purple agent** scaffolding (participant)

Source of truth for requirements:
- `docs.agentbeats.dev` tutorial (A2A server + Docker packaging + registration)
- `rdi.berkeley.edu/agentx-agentbeats` competition overview (phase expectations)

## Key platform requirements (condensed)
- Agents must be exposed as **A2A servers**.
- Agents must be **Dockerized** for reproducible runs.
- Docker image ENTRYPOINT must accept:
  - `--host`
  - `--port`
  - `--card-url`
- Both green and purple agents must be registered on `agentbeats.dev` using their published container images.

## This repo status

### 🟣 Purple agent (participant)
- A2A server entrypoint: `services/agents/purple/a2a_server.py`
- Dockerfile: `services/agents/purple/Dockerfile`
- Dependencies: `services/agents/purple/requirements.txt`
- Behavior (demo-first): returns a deterministic `{from_project,to_project,hours,reason}` JSON proposal.

### 🟢 Green agent (evaluator)
- A2A server entrypoint: `services/agents/green/a2a_server.py`
- Dockerfile: `services/agents/green/Dockerfile`
- Dependencies: `services/agents/green/requirements.txt`
- Behavior (demo-first): sends a reallocation prompt to the purple participant and scores it deterministically.

## Local run (dev sanity)

Start purple:
```bash
python -m services.agents.purple.a2a_server --host 127.0.0.1 --port 9010 --card-url http://127.0.0.1:9010/
```

Start green:
```bash
python -m services.agents.green.a2a_server --host 127.0.0.1 --port 9011 --card-url http://127.0.0.1:9011/
```

Then send an assessment request (shape matches the tutorial model):
```json
{
  "participants": {
    "purple": "http://127.0.0.1:9010/"
  },
  "config": {}
}
```

## Important note
This compatibility layer is **minimal and demo-safe**: it is designed to satisfy A2A/Docker interface requirements and provide a coherent “reallocation” capability signal. To be competitive on real leaderboards, expand tasks, tools, and scoring beyond this baseline.

