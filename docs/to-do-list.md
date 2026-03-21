# TimeBite Torus AgentBeats — Development To-Do List

Start Date: March 21

This document tracks the development roadmap for **TimeBite Torus**, a computer-use agent environment built as part of the **Create Your Reality Agent (CYRA)** project.

The project was initially designed for the **AgentBeats Computer-Use track**, but the primary submission target is now the **AgentBeats General Track (May 24)**.

Additional benchmark integrations include:

• τ²-Bench (Sierra)  
• OpenEnv  

---

# Key Deadlines

| Milestone | Date |
|-----------|------|
Apple TestFlight build for App Review | Mar 24 |
AgentBeats Computer-Use (stretch goal) | Mar 22 |
τ²-Bench (Sierra) submission | Mar 30 |
OpenEnv benchmark submission | Apr 12 |
AgentBeats General Track submission | May 24 |

---

# Phase 1 — System Stabilization + Apple App Review
Mar 21 – Mar 24

Goal:  
Stabilize the app, ensure the agent runtime works, and submit a **TestFlight build for Apple App Review**.

### Agent Infrastructure

Task | Status | Notes
---|---|---
Audit Green Agent architecture | ⬜ Pending | confirm planner + memory modules imported from previous repo
Verify Purple Agent scaffold | ⬜ Pending | `services/agents/purple/computer_use_agent.py`
Verify Purple entrypoint runtime | ⬜ Pending | `services/agents/purple/entrypoint.py`
Confirm planner → agent task schema | ⬜ Pending | planner output compatibility
Connect Green planner to Purple executor | ⬜ Pending | planner → execution pipeline
Verify fallback adapter | ⬜ Pending | `services/agents/purple/adapters/fallback_adapter.py`

### LLM Integration

Task | Status | Notes
---|---|---
Create `.env` configuration | ⬜ Pending | add Nebius API key
Implement LLM client adapter | ⬜ Pending | `services/llm/llm_client.py`
Integrate Nebius inference endpoint | ⬜ Pending | OpenAI-compatible API
Add token limits + timeout controls | ⬜ Pending | prevent runaway requests
Add daily spend guardrail | ⬜ Pending | `NEBIUS_DAILY_BUDGET_USD`

### Telemetry + Logging

Task | Status | Notes
---|---|---
Create telemetry logging system | ⬜ Pending | JSONL logging
Create telemetry directory | ⬜ Pending | `data/telemetry_runs`
Log agent runs | ⬜ Pending | prompt + action metadata
Verify logging during agent execution | ⬜ Pending | ensure runs recorded

### App Stability

Task | Status | Notes
---|---|---
Stabilize visionOS build | ⬜ Pending | confirm simulator launch
Verify torus visualization renders | ⬜ Pending | spatial UI test
Test agent trigger workflow | ⬜ Pending | stub action execution if needed
Fix TestFlight blocking bugs | ⬜ Pending | prioritize crashes only

### App Review Preparation

Task | Status | Notes
---|---|---
Create TestFlight candidate build | ⬜ Pending | Xcode → Archive
Upload build to App Store Connect | ⬜ Pending | verify processing
Enable internal TestFlight testing | ⬜ Pending | invite testers
Record demo workflow | ⬜ Pending | 60-90 second demo
Submit Apple App Review request | ⬜ Pending | include TestFlight link

---

# Phase 2 — τ²-Bench Integration
Mar 25 – Mar 30

Goal:  
Run a baseline evaluation using **τ²-Bench**.

### Evaluation Harness

Task | Status | Notes
---|---|---
Implement τ²-Bench runner | ⬜ Pending | `evaluation/tau_bench_runner.py`
Adapt agent interface to τ² harness | ⬜ Pending | execution wrapper
Run baseline evaluation | ⬜ Pending | capture logs
Store benchmark telemetry | ⬜ Pending | structured output

### Failure Analysis

Task | Status | Notes
---|---|---
Cluster evaluation failures | ⬜ Pending | navigation / tool / timeout
Patch top failure modes | ⬜ Pending | reliability improvements
Run second evaluation pass | ⬜ Pending | compare results

### Coordination

Task | Status | Notes
---|---|---
Reach out to Sierra τ² team | ⬜ Pending | Discord support
Confirm benchmark integration | ⬜ Pending | environment compatibility

---

# Phase 3 — OpenEnv Integration
Mar 31 – Apr 12

Goal:  
Run the agent inside OpenEnv environments.

### Environment Integration

Task | Status | Notes
---|---|---
Implement OpenEnv runner | ⬜ Pending | `evaluation/openenv_runner.py`
Adapt agent interface for environment tasks | ⬜ Pending | execution wrapper
Run OpenEnv scenarios | ⬜ Pending | multi-environment tasks
Collect evaluation logs | ⬜ Pending | store telemetry

### Reliability Improvements

Task | Status | Notes
---|---|---
Improve action robustness | ⬜ Pending | retry + guardrails
Improve agent planning | ⬜ Pending | reasoning improvements
Run OpenEnv evaluation pass #2 | ⬜ Pending | measure improvement

---

# Phase 4 — AgentBeats General Track Submission
Apr 13 – May 24

Goal:  
Prepare the final system submission.

### Architecture

Task | Status | Notes
---|---|---
Finalize agent architecture | ⬜ Pending | planner + executor improvements
Implement model routing | ⬜ Pending | cheap vs strong models
Improve computer-use reliability | ⬜ Pending | reduce failures

### Documentation

Task | Status | Notes
---|---|---
Finalize system architecture doc | ⬜ Pending | `docs/system-architecture.md`
Document evaluation results | ⬜ Pending | benchmark metrics
Update README for final submission | ⬜ Pending | repo overview

### Demo + Submission

Task | Status | Notes
---|---|---
Prepare demo scenario | ⬜ Pending | task → agent → torus update
Record final demo video | ⬜ Pending | 1-2 minute walkthrough
Final bug fixes | ⬜ Pending | stability only
Freeze submission candidate | ⬜ Pending | final commit
Submit AgentBeats project | ⬜ Pending | May 24 deadline

---

# Infrastructure and Research Tasks

Task | Status | Notes
---|---|---
Evaluate Nebius cost + performance | ⬜ Pending |
Add token usage tracking | ⬜ Pending |
Implement evaluation replay runner | ⬜ Pending |
Explore Lambda Labs grant | ⬜ Pending |
Monitor AgentBeats Discord announcements | ⬜ Pending |