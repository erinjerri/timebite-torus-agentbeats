# TimeBite Platform

TimeBite is a **cycle-based time system** for modeling how time is actually spent across life categories — not just planned.

It connects:

- planning (HTML / Notion-style systems)
- execution (Cycle Matrix)
- visualization (Cycles Dashboard)
- feedback (score, insights, agents)

Built across:

- **iOS** — primary product surface (TestFlight → App Store)
- **visionOS** — spatial computing (torus, 3D cycles)
- **macOS** — debugging + power-user interface (future)

---

## TL;DR

- **What:** A system that shows how your time is actually spent  
- **Core:** Planner → Cycle Matrix → Cycles Dashboard → Feedback  
- **Agent:** Constrained assistant (tight RAG, not open chat)  
- **Status:** Active development + research monorepo  

---

## Core System

### 1. Cycle Matrix (Backend)

The **source of truth** for time allocation.

Structure:

- rows → time segments  
- columns → categories  
- values → time spent  

This powers:

- dashboard state
- scoring
- agent decisions
- telemetry

---

### 2. TimeBite Cycles (UI System)

User-facing representation of time distribution.

Includes:

- category allocation (bars)
- contribution grid (GitHub-style history)
- cycle score + imbalance feedback
- reality check (actual vs intended)

---

### 3. Cycle Planner Engine (NEW)

Bridges long-term planning → execution.

Inputs:

- HTML planners (Claude-generated)
- Notion-style structured plans (future)

Purpose:

- convert plans into real system state
- connect planning ↔ execution
- enable agent-aware scheduling

---

### 4. Constrained Assistant (Tight RAG)

The assistant is **not a chatbot**.

It can only:

- execute allowed UI actions
- retrieve documentation

It cannot:

- hallucinate
- generate arbitrary plans
- mutate system state freely

---

## Cycles Dashboard (UI Concept)

TimeBite surfaces time as a **structured system**, not just tasks.

---

### Daily Cycles

```text
[ Today ]

Engineering — 3h 20m ███████░░
Writing     — 1h 45m ████░░░░░
Health      — 0h 50m ██░░░░░░░
Admin       — 2h 10m █████░░░░
Personal    — 0h 30m █░░░░░░░░

[ Last 30 Days ]

██ ░░ ██ ██ ░░ ██
██ ██ ██ ░░ ░░ ██
░░ ██ ██ ██ ░░ ░░
██ ░░ ░░ ██ ██ ██

Today Score: 68 / 100

Balance: 70  
Consistency: 65  
Intent vs Actual: 72
```

**Reality check:** “You spent 58% of your time on Engineering. Health was underutilized.”

---

### Architecture overview

```
Planner (HTML / Notion)
        ↓
Planner Engine (backend)
        ↓
Cycle Matrix (system state)
        ↓
Apps (iOS / visionOS / macOS)
        ↓
User actions + agent actions
        ↓
Cycle updates + telemetry
        ↓
Cycles Dashboard (UI feedback)
```

---

## This repository

This repo (`timebite-torus-agentbeats`) holds **docs, specs, schemas, research**, and AgentBeats-related work (Green / Purple agents). The tree below is the **target** monorepo layout for `timebite-platform/`.

---

## Target platform structure (`timebite-platform/`)

Top-level layout (GitHub-friendly: each block is a short tree so lines don’t wrap oddly).

```
timebite-platform/
├── apps/
├── backend/
├── shared/
├── docs/
├── specs/
├── research/
└── scripts/
```

### `apps/ios/timebite-ios/`

```
timebite-ios/
├── App/
│   ├── TimeBiteApp.swift
│   ├── RootView.swift
│   ├── AppState.swift
│   └── Navigation/
│       ├── TabRouter.swift
│       └── RouteDefinitions.swift
├── Features/
│   ├── cycles/
│   │   ├── Views/
│   │   │   ├── CyclesDashboardView.swift
│   │   │   ├── CycleRowView.swift
│   │   │   ├── CycleBarView.swift
│   │   │   ├── CycleScoreCard.swift
│   │   │   ├── RealityCheckView.swift
│   │   │   └── DailySummaryView.swift
│   │   ├── ViewModels/
│   │   │   ├── CyclesViewModel.swift
│   │   │   └── CycleComputation.swift
│   │   ├── Models/
│   │   │   ├── Cycle.swift
│   │   │   ├── Category.swift
│   │   │   └── CycleSnapshot.swift
│   │   └── Components/
│   │       ├── ProgressBar.swift
│   │       └── PercentageLabel.swift
│   ├── tasks/
│   ├── planner/
│   ├── insights/
│   └── assistant/
├── Services/
│   ├── API/
│   ├── Storage/
│   ├── Assistant/
│   └── Integrations/
└── Shared/
```

### `apps/visionos/timebite-visionos/`

```
timebite-visionos/
├── App/
│   ├── TimeBiteVisionApp.swift
│   └── SpatialRootView.swift
├── Features/
│   ├── torus/
│   │   ├── Views/
│   │   │   ├── TorusView.swift
│   │   │   ├── Ring3DView.swift
│   │   │   └── SpatialCyclesView.swift
│   │   ├── Models/
│   │   └── ViewModels/
│   └── gestures/
│       ├── HandTrackingManager.swift
│       └── GestureRouter.swift
└── Shared/
```

### `apps/macos/timebite-macos/`

```
timebite-macos/
├── App/
│   ├── TimeBiteMacApp.swift
│   └── DesktopRootView.swift
├── Features/
│   ├── cycles/
│   ├── planner/
│   ├── insights/
│   └── debug/
│       ├── TelemetryView.swift
│       └── LogsViewer.swift
└── Services/
```

### `apps/web/timebite-web/`

```
timebite-web/
└── (package root)
```

### `backend/`

```
backend/
├── api/
│   └── main.py
├── services/
│   ├── cycles/
│   │   ├── cycle_matrix.py
│   │   ├── cycle_engine.py
│   │   └── scoring.py
│   ├── planner/
│   │   ├── parser.py
│   │   ├── schema.py
│   │   ├── mapper.py
│   │   └── importer.py
│   ├── agents/
│   │   ├── green_agent/
│   │   ├── purple_agent/
│   │   └── shared/
│   ├── assistant/
│   │   ├── orchestrator.py
│   │   ├── intent_classifier.py
│   │   ├── ui_action_whitelist.py
│   │   └── documentation_router.py
│   ├── retrieval/
│   │   ├── ingest_docs.py
│   │   ├── chunking.py
│   │   ├── embeddings.py
│   │   ├── vector_store.py
│   │   └── retriever.py
│   └── telemetry/
│       ├── logger.py
│       └── runs.jsonl
└── data/
```

---

## Further documentation

- [docs/system-architecture.md](docs/system-architecture.md) — system diagrams and architecture notes  
- [docs/to-do-list.md](docs/to-do-list.md) — development timeline  

---

## Acknowledgments

AgentBeats Hackathon organizers · Apple visionOS team · Nebius AI for inference infrastructure · Lambda Labs for compute resources  

---

## Citation

If you use TimeBite in research, please cite:

```bibtex
@software{timebite_torus_2025,
  title={TimeBite Torus: A Computer-Use Agent Evaluation Environment},
  author={Erin Pangilinan},
  year={2025},
  url={https://github.com/erinjerri/timebite-torus-agentbeats}
}
```
