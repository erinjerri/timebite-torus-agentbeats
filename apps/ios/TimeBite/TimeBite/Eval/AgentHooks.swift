import Foundation

struct AgentExecutionSnapshot: Codable, Hashable {
    var scenarioTitle: String
    var mission: String
    var selectedActionTitle: String?
    var activeActionTitle: String?
    var transitionCount: Int
    var benchmarkScore: Int
    var latestEvent: String?
}

protocol AgentPlannerHook {
    func plannedSteps(for snapshot: AgentExecutionSnapshot) -> [String]
}

protocol AgentExecutorHook {
    func execute(step: String, in snapshot: AgentExecutionSnapshot) -> String
}

extension AgentBeatsEnvironment {
    var executionSnapshot: AgentExecutionSnapshot {
        AgentExecutionSnapshot(
            scenarioTitle: scenario.title,
            mission: scenario.mission,
            selectedActionTitle: selectedAction?.title,
            activeActionTitle: activeAction?.title,
            transitionCount: transitionCount,
            benchmarkScore: benchmarkScore,
            latestEvent: actionLog.first?.headline
        )
    }
}
