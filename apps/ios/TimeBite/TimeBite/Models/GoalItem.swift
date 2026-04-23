import Foundation

enum GoalState: String, Codable, CaseIterable, Identifiable {
    case active
    case atRisk
    case complete

    var id: String { rawValue }

    var title: String {
        switch self {
        case .active:
            "Active"
        case .atRisk:
            "At Risk"
        case .complete:
            "Complete"
        }
    }
}

struct GoalItem: Identifiable, Codable, Hashable {
    var id: UUID
    var title: String
    var detail: String
    var targetValue: Int
    var achievedValue: Int
    var dueDate: Date
    var state: GoalState
    var linkedActionTitle: String
    var emphasis: Int

    init(
        id: UUID = UUID(),
        title: String,
        detail: String,
        targetValue: Int,
        achievedValue: Int,
        dueDate: Date,
        state: GoalState,
        linkedActionTitle: String,
        emphasis: Int = 0
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.targetValue = targetValue
        self.achievedValue = achievedValue
        self.dueDate = dueDate
        self.state = state
        self.linkedActionTitle = linkedActionTitle
        self.emphasis = emphasis
    }

    var progress: Double {
        guard targetValue > 0 else { return 0 }
        return min(Double(achievedValue) / Double(targetValue), 1)
    }

    var achievedLabel: String {
        "\(achievedValue)/\(targetValue)"
    }

    var dueLabel: String {
        dueDate.formatted(date: .abbreviated, time: .omitted)
    }
}
