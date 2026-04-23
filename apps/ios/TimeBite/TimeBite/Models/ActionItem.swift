import Foundation

enum ActionState: String, Codable, CaseIterable, Identifiable {
    case ready
    case running
    case stopped
    case completed

    var id: String { rawValue }

    var title: String {
        switch self {
        case .ready:
            "Ready"
        case .running:
            "Running"
        case .stopped:
            "Stopped"
        case .completed:
            "Completed"
        }
    }

    var isActive: Bool {
        self == .running
    }

    var isTerminal: Bool {
        self == .completed
    }
}

struct ActionItem: Identifiable, Codable, Hashable {
    var id: UUID
    var title: String
    var context: String
    var estimateMinutes: Int
    var state: ActionState
    var accumulatedSeconds: Int
    var startedAt: Date?
    var stoppedAt: Date?
    var completedAt: Date?
    var isPinned: Bool
    var order: Int
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        context: String,
        estimateMinutes: Int,
        state: ActionState = .ready,
        accumulatedSeconds: Int = 0,
        startedAt: Date? = nil,
        stoppedAt: Date? = nil,
        completedAt: Date? = nil,
        isPinned: Bool = false,
        order: Int = 0,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.context = context
        self.estimateMinutes = estimateMinutes
        self.state = state
        self.accumulatedSeconds = accumulatedSeconds
        self.startedAt = startedAt
        self.stoppedAt = stoppedAt
        self.completedAt = completedAt
        self.isPinned = isPinned
        self.order = order
        self.updatedAt = updatedAt
    }

    var estimatedSeconds: Int {
        max(estimateMinutes, 1) * 60
    }

    func activeRuntimeSeconds(at date: Date = .now) -> Int {
        guard state == .running, let startedAt else { return accumulatedSeconds }
        let liveSeconds = Int(date.timeIntervalSince(startedAt))
        return accumulatedSeconds + max(liveSeconds, 0)
    }

    func progress(at date: Date = .now) -> Double {
        guard estimatedSeconds > 0 else { return 0 }
        return min(Double(activeRuntimeSeconds(at: date)) / Double(estimatedSeconds), 1)
    }

    var spentMinutes: Int {
        activeRuntimeSeconds() / 60
    }

    var phaseLabel: String {
        state.title
    }

    var completionLabel: String {
        "\(spentMinutes)m / \(estimateMinutes)m"
    }
}
