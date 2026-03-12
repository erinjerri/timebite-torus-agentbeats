:::writing{variant=“standard” id=“todo1”}

TimeBite Torus AgentBeats — Development To-Do List

Milestones
	•	Mar 20 — TestFlight build uploaded
	•	Mar 20–23 — Apple App Review appointment request submitted
	•	Apr 5 — Computer-Use agent stable
	•	Apr 12 — AgentBeats Computer-Use submission
	
# Week 1 — Architecture + Build Stabilization (Mar 12–Mar 16)

Task
Status
Notes
Audit green agent architecture
⬜ Pending
Confirm planner, memory, and runtime modules imported from previous repo
Create purple-agent-computer-use branch
⬜ Pending
git checkout -b purple-agent-computer-use
Create purple agent directory
⬜ Pending
agents/purple/
Implement ComputerUseAgent scaffold
⬜ Pending
agents/purple/computer_use_agent.py
Implement fallback adapter
⬜ Pending
agents/purple/adapters/fallback_adapter.py
Implement purple entrypoint runtime
⬜ Pending
agents/purple/entrypoint.py
Define task schema for planner → agent communication
⬜ Pending
agents/schema/task.py
Verify green planner outputs compatible task format
⬜ Pending
Connect green planner to purple agent
Stabilize visionOS build
⬜ Pending
Ensure app launches in simulator
Verify torus visualization renders
⬜ Pending
Confirm spatial UI works

# Week 2 — TestFlight + Apple Review Preparation (Mar 17–Mar 23) 

Task
Status
Notes
Create TestFlight candidate build
⬜ Pending
Xcode → Product → Archive
Upload build to App Store Connect
⬜ Pending
Verify processing succeeds
Enable internal TestFlight testing
⬜ Pending
Invite Apple ID testers
Test basic UI navigation
⬜ Pending
Confirm torus UI interactions
Test agent trigger workflow
⬜ Pending
Stub action execution if needed
Fix TestFlight blocking bugs
⬜ Pending
Prioritize crashes only
Record demo workflow
⬜ Pending
60–90 second demo
Submit App Review appointment request
⬜ Pending
Include TestFlight link

# Week 3 — Computer-Use Agent Baseline (Mar 24–Mar 30)
Task
Status
Notes
Implement Computer-Use benchmark runner
⬜ Pending
evaluation/computer_use_runner.py
Run baseline Computer-Use evaluation
⬜ Pending
Capture success/failure logs
Cluster failures
⬜ Pending
navigation / tool / timeout
Patch top 3 failure modes
⬜ Pending
Improve reliability
Implement deterministic mode
⬜ Pending
Seed locking for reproducibility
Add retry logic + guardrails
⬜ Pending
Improve agent robustness
Run benchmark pass #2
⬜ Pending
Compare score deltas

# Week 4 — System Integration (Mar 31–Apr 6)

Task
Status
Notes
Integrate purple agent into green runtime
⬜ Pending
Planner → agent pipeline
Connect torus visualization to agent actions
⬜ Pending
Update visualization on task events
Implement action registry
⬜ Pending
agents/purple/actions/
Optimize agent performance
⬜ Pending
Reduce latency
Run full benchmark again
⬜ Pending
Candidate evaluation

# Week 5 — Submission Preparation (Apr 7–Apr 12)
Task
Status
Notes
Prepare demo scenario
⬜ Pending
User task → agent execution → torus update
Write architecture documentation
⬜ Pending
docs/architecture.md
Document evaluation results
⬜ Pending
Benchmark metrics
Record final demo video
⬜ Pending
1–2 minute walkthrough
Final bug fixes
⬜ Pending
Stability only
Freeze submission candidate
⬜ Pending
Final commit before submission
Submit AgentBeats Computer-Use project
⬜ Pending
Apr 12 deadline

# Optional Post-Submission Work (Apr 13+) 

Task
Status
Notes
Expand τ²-Bench harness
⬜ Pending
Additional evaluation
Expand OpenEnv evaluation
⬜ Pending
Multi-environment testing
Improve planning + reasoning
⬜ Pending
Agent architecture improvements
Prepare General Track submission
⬜ Pending
Deadline May 24

