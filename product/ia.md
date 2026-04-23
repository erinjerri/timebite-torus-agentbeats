# TimeBite — Information Architecture (Hackathon Demo)

Goal: a 3-minute judge-proof demo with 4 screens. Keep navigation obvious and shallow.

## Screens (lean IA)

### 1) Intent Setup
Purpose: set today’s priorities so the agent + dashboard have context.

**Primary actions**
- Set 3 active projects (names)
- Set weekly caps (hours) per project
- Set today’s intent (1–2 lines)

**Outputs**
- Stored intent + caps
- Enables AI reallocation messaging

---

### 2) Timer Arena
Purpose: start focusing immediately; ring shows progress and momentum.

**Primary actions**
- Start / pause / resume timer
- Select active project (which project gets the time)

**Outputs**
- Time spent attributed to a project
- Live ring updates (Timer + Dashboard)

---

### 3) Dashboard
Purpose: “wow” screen; shows 3 projects as rings + score + AI reallocation.

**Must show**
- 3 active projects
- Weekly caps
- Ring progress per project
- Completion score (0–100)
- AI reallocation suggestion + apply button

**Primary actions**
- Apply AI reallocation (e.g., move 2h from low priority → Hackathon)

**Outputs**
- Updated caps/plan (rings update immediately)
- Telemetry event for suggestion + apply

---

### 4) Reflection
Purpose: close the loop with an outcome and score.

**Primary actions**
- Done / Partial / Missed for each project (or “intent lanes”)
- Optional note

**Outputs**
- Reflection score
- Telemetry event

## Navigation
Use a bottom `TabView` with 4 tabs:
1. Intent
2. Arena
3. Dashboard
4. Reflect

No deeper stacks for the hackathon demo.

