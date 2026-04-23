import Foundation

enum HabitCadence: String, Codable, CaseIterable, Identifiable {
    case daily
    case weekly

    var id: String { rawValue }

    var title: String {
        rawValue.capitalized
    }
}

struct HabitEntry: Identifiable, Codable, Hashable {
    var id: UUID
    var title: String
    var cadence: HabitCadence
    var streakDays: Int
    var targetCount: Int
    var completedCount: Int
    var lastCompletedAt: Date?
    var note: String
    var isPinned: Bool

    init(
        id: UUID = UUID(),
        title: String,
        cadence: HabitCadence,
        streakDays: Int,
        targetCount: Int,
        completedCount: Int,
        lastCompletedAt: Date? = nil,
        note: String,
        isPinned: Bool = false
    ) {
        self.id = id
        self.title = title
        self.cadence = cadence
        self.streakDays = streakDays
        self.targetCount = targetCount
        self.completedCount = completedCount
        self.lastCompletedAt = lastCompletedAt
        self.note = note
        self.isPinned = isPinned
    }

    var progress: Double {
        guard targetCount > 0 else { return 0 }
        return min(Double(completedCount) / Double(targetCount), 1)
    }

    var countLabel: String {
        "\(completedCount)/\(targetCount) \(cadence.title.lowercased())"
    }

    var streakLabel: String {
        "\(streakDays)d streak"
    }
}
