import Foundation

enum AgentActionEventKind: String, Codable, CaseIterable, Identifiable {
    case selected
    case started
    case stopped
    case completed
    case reset

    var id: String { rawValue }

    var title: String {
        rawValue.capitalized
    }
}

struct AgentActionLog: Identifiable, Codable, Hashable {
    var id: UUID
    var actionId: UUID?
    var actionTitle: String
    var eventKind: AgentActionEventKind
    var fromStateRaw: String?
    var toStateRaw: String
    var timestamp: Date
    var note: String?

    init(
        id: UUID = UUID(),
        actionId: UUID?,
        actionTitle: String,
        eventKind: AgentActionEventKind,
        fromStateRaw: String? = nil,
        toStateRaw: String,
        timestamp: Date = .now,
        note: String? = nil
    ) {
        self.id = id
        self.actionId = actionId
        self.actionTitle = actionTitle
        self.eventKind = eventKind
        self.fromStateRaw = fromStateRaw
        self.toStateRaw = toStateRaw
        self.timestamp = timestamp
        self.note = note
    }

    var fromState: ActionState? {
        guard let fromStateRaw else { return nil }
        return ActionState(rawValue: fromStateRaw)
    }

    var toState: ActionState? {
        ActionState(rawValue: toStateRaw)
    }

    var headline: String {
        "\(eventKind.title): \(actionTitle)"
    }
}
