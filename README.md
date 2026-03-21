# TimeBite Torus — AgentBeats General Track Submission

A beta prototype of the **TimeBite** app, part of the **Create Your Reality Agent (CYRA)** project.

TimeBite Torus is an experimental system for evaluating **AI agents performing structured work tasks inside an interactive application environment**.

The project was originally developed for the **AgentBeats Computer-Use track**, which evaluates how agents plan and execute actions within real software environments. The system is now being expanded and submitted to the **AgentBeats General Track (May 2025)**.

In TimeBite, the **application itself becomes the evaluation environment**.

Rather than evaluating agents on abstract benchmarks alone, agents interact directly with a productivity interface where their actions change the state of the system.

---

# Abstract

Most productivity tools represent work using lists or calendars. These interfaces provide limited insight into how time is actually distributed across different types of work.

TimeBite introduces a **torus-based visualization** where each ring represents a category of work:

• Engineering  
• Writing  
• Research  
• Communication  

At the beginning of a work cycle, every ring begins fully shaded, representing the available time capacity for that category.

When work begins:

Agent triggers task
↓
Timer starts
↓
Category capacity decreases
↓
Torus visualization updates

As the timer progresses, the ring gradually empties, representing the remaining time available for that category.

This creates a **dynamic environment for evaluating agent behavior**.

Instead of measuring only completed tasks, TimeBite explores a different question:

**How effectively can an AI agent allocate working time across categories of effort?**

This allows the system to function both as a **productivity tool** and as an **experimental environment for evaluating computer-use agents operating inside real applications**.

---

# Agent Architecture

TimeBite uses a **two-agent architecture**.

### Green Agent — Planner

The Green Agent interprets user intent and generates structured task plans.

Responsibilities:

• understanding user input  
• generating task plans  
• structuring execution context  

---

### Purple Agent — Executor

The Purple Agent executes actions inside the application environment.

Responsibilities:

• performing actions inside the system  
• triggering timers and updates  
• interacting with the application state  

---

Together they form an execution loop:

User Input
↓
Green Agent (planning)
↓
Purple Agent (execution)
↓
Application state changes
↓
Torus visualization updates

The torus visualization provides a real-time representation of how agent decisions affect the allocation of working time.

---

# System Architecture

The system separates:

• interface  
• planning  
• execution  
• inference  
• telemetry  
• evaluation

Architecture overview:
User Interaction
↓
TimeBite UI (visionOS / iOS)
↓
Green Agent — Planner
↓
Purple Agent — Executor
↓
LLM Client Adapter
↓
Nebius Inference API
↓
Agent Actions
↓
Application State + Torus Visualization
↓
Telemetry Logs
↓
Evaluation Benchmarks

These benchmarks allow TimeBite agents to be tested across:

• computer-use tasks  
• structured environment simulations  
• multi-step planning scenarios

---

# Repository Structure - North Star (ideal)
timebite-torus-agentbeats
│
├── README.md
├── LICENSE
├── .gitignore
├── requirements.txt
├── .env.example
│
├── apps
│   └── ios
│       └── TimeBite
│           ├── TimeBiteApp.swift
│           ├── ContentView.swift
│           ├── TorusVisualization
│           │   ├── TorusRenderer.swift
│           │   └── TorusStateManager.swift
│           └── Agents
│               └── AgentTriggerBridge.swift
│
├── services
│   │
│   ├── agents
│   │   │
│   │   ├── green
│   │   │   ├── planner.py
│   │   │   ├── memory.py
│   │   │   └── context_builder.py
│   │   │
│   │   └── purple
│   │       ├── computer_use_agent.py
│   │       ├── entrypoint.py
│   │       │
│   │       ├── adapters
│   │       │   ├── fallback_adapter.py
│   │       │   └── llm_adapter.py
│   │       │
│   │       ├── actions
│   │       │   ├── action_registry.py
│   │       │   ├── timer_action.py
│   │       │   └── navigation_action.py
│   │       │
│   │       └── policies
│   │           └── execution_guardrails.py
│   │
│   ├── llm
│   │   ├── llm_client.py
│   │   ├── model_router.py
│   │   └── prompt_templates.py
│   │
│   ├── telemetry
│   │   ├── telemetry_logger.py
│   │   ├── cost_tracking.py
│   │   └── run_schema.py
│   │
│   └── config
│       ├── config.py
│       └── environment.py
│
├── evaluation
│   │
│   ├── computer_use
│   │   └── computer_use_runner.py
│   │
│   ├── tau_bench
│   │   └── tau_bench_runner.py
│   │
│   ├── openenv
│   │   └── openenv_runner.py
│   │
│   └── replay
│       └── replay_telemetry_runs.py
│
├── data
│   │
│   ├── telemetry_runs
│   │   └── *.jsonl
│   │
│   └── benchmark_results
│       ├── tau_bench
│       └── openenv
│
├── scripts
│   ├── run_agent_local.py
│   ├── run_tau_bench.py
│   └── run_openenv.py
│
├── docs
│   │
│   ├── system-architecture.md
│   ├── repo-tree.md
│   ├── benchmarks.md
│   └── to-do-list.md
│
└── notebooks
    ├── evaluation_analysis.ipynb
    └── telemetry_visualization.ipynb

# System Architecture
Detailed system diagrams and architecture explanations are available in: docs/system-architecture.md

# Development Timeline

These benchmarks allow TimeBite agents to be tested across:

• computer-use tasks  
• structured environment simulations  
• multi-step planning scenarios

The project development timeline is tracked in: docs/to-do-list.md

Key milestone:

**Mar 24 — TestFlight build for Apple App Review**

---

# Acknowledgments

AgentBeats Hackathon organizers for the evaluation framework  
Apple visionOS team for the platform and developer tools  
OpenAI for research on agent evaluation architectures  
Nebius AI for inference infrastructure  
Lambda Labs for compute resources  

---

# Citation

If you use TimeBite in research, please cite:
@software{timebite_torus_2025,
title={TimeBite Torus: A Computer-Use Agent Evaluation Environment},
author={Erin Pangilinan},
year={2025},
url={https://github.com/erinjerri/timebite-torus-agentbeats}
}