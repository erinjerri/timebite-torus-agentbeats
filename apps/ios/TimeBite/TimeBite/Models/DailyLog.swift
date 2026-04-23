import Foundation

struct DailyLog: Identifiable, Codable, Hashable {
    var id: String
    var date: Date
    var focusMinutesTarget: Int
    var focusMinutesCompleted: Int
    var actionsStarted: Int
    var actionsStopped: Int
    var actionsCompleted: Int
    var transitionsRecorded: Int
    var lastEventAt: Date?
    var summary: String

    init(
        id: String = Self.dayKey(for: .now),
        date: Date = .now,
        focusMinutesTarget: Int,
        focusMinutesCompleted: Int,
        actionsStarted: Int,
        actionsStopped: Int,
        actionsCompleted: Int,
        transitionsRecorded: Int,
        lastEventAt: Date? = nil,
        summary: String
    ) {
        self.id = id
        self.date = date
        self.focusMinutesTarget = focusMinutesTarget
        self.focusMinutesCompleted = focusMinutesCompleted
        self.actionsStarted = actionsStarted
        self.actionsStopped = actionsStopped
        self.actionsCompleted = actionsCompleted
        self.transitionsRecorded = transitionsRecorded
        self.lastEventAt = lastEventAt
        self.summary = summary
    }

    static func dayKey(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
