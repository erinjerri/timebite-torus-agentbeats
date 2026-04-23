import Foundation

struct AgentTaskScenario: Identifiable, Codable, Hashable {
    var id: UUID
    var title: String
    var mission: String
    var targetActionTitle: String
    var environmentPrinciple: String
    var successCriteria: [String]
    var demoScript: [String]
    var scoringNotes: String

    init(
        id: UUID = UUID(),
        title: String,
        mission: String,
        targetActionTitle: String,
        environmentPrinciple: String,
        successCriteria: [String],
        demoScript: [String],
        scoringNotes: String
    ) {
        self.id = id
        self.title = title
        self.mission = mission
        self.targetActionTitle = targetActionTitle
        self.environmentPrinciple = environmentPrinciple
        self.successCriteria = successCriteria
        self.demoScript = demoScript
        self.scoringNotes = scoringNotes
    }

    func score(actions: [ActionItem], logs: [AgentActionLog], dailyLog: DailyLog) -> Int {
        guard let target = actions.first(where: { $0.title.caseInsensitiveCompare(targetActionTitle) == .orderedSame }) else {
            return 0
        }

        var score = 0

        if target.state == .completed {
            score += 35
        } else if target.state == .stopped {
            score += 20
        } else if target.state == .running {
            score += 15
        }

        let targetLogs = logs.filter { $0.actionId == target.id }
        if targetLogs.contains(where: { $0.eventKind == .started }) {
            score += 20
        }
        if targetLogs.contains(where: { $0.eventKind == .stopped }) {
            score += 15
        }
        if targetLogs.contains(where: { $0.eventKind == .completed }) {
            score += 20
        }

        if dailyLog.transitionsRecorded >= 3 {
            score += 5
        }
        if dailyLog.focusMinutesCompleted > 0 {
            score += 5
        }

        return min(score, 100)
    }

    var overviewLine: String {
        "Target: \(targetActionTitle)"
    }
}
