---
config:
  layout: dagre
---
flowchart TB

%% ========== Client ==========
subgraph Client["visionOS / iOS Client"]
    User(("User"))
    SpeechApple["Speech Recognition<br/>Speech.framework"]
    Vision["Vision Input<br/>VisionKit/CoreML"]
    TaskSchema["TaskSchema<br/>Unified Intent"]
end

User --> SpeechApple --> TaskSchema
User --> Vision --> TaskSchema

%% ========== Reasoning ==========
subgraph AppleFM["Apple Foundation Models"]
    FM["LLM Reasoning<br/>+ Function Calling"]
end

TaskSchema --> FM

%% ========== MCP ==========
subgraph MCPServer["MCP Server"]
    Registry["Tool Registry"]
    Validator["Schema Validation"]
    Router["Execution Router"]
    Hooks["Telemetry Hooks"]
end

FM --> Registry
Registry --> Validator
Validator --> Router
Router --> Hooks

%% ========== Tools ==========
subgraph Tools["Tool Targets"]
    Swift["On-device Swift Tools"]
    API["FastAPI Backend"]
end

Router --> Swift
Router --> API

%% ========== Telemetry ==========
subgraph Telemetry["Lambda.ai"]
    Store[("JSON Traces<br/>Scores + Trajectories")]
end

Hooks --> Store

%% ========== Agents (Conceptual) ==========
subgraph Agents["AgentBeats Agents (Logical Roles)"]
    Purple["Purple Agent<br/>Solver"]
    Green["Green Agent<br/>Judge"]
    Controller["AgentBeats Controller / SDK"]
end

%% --- Observational / Control Links ---
Purple -.observes.-> FM
Purple -.invokes tools via.-> MCPServer
Green -.evaluates traces.-> Store
Controller -.configures.-> Purple
Controller -.configures.-> Green