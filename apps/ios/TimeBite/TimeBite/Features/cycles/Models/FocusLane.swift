//
//  FocusLane.swift
//  TimeBite
//
//  Created by Erin Jerri on 4/3/26.
//

import Foundation

final class FocusLane: Identifiable, Codable {
    var id: UUID
    var categoryRaw: String
    var displayTitle: String
    var targetSeconds: Int
    var remainingSeconds: Int
    var spentSeconds: Int
    var isActive: Bool
    var lastTickAt: Date?
    var plan: DailyPlan?
    var dayKey: String
    var createdAt: Date
    var startedAt: Date?
    var endedAt: Date?
    var statusRaw: String
    var taskCategoryRaw: String
    var captureSourceRaw: String

    init(
        category: FocusCategory,
        displayTitle: String,
        targetSeconds: Int,
        remainingSeconds: Int? = nil,
        spentSeconds: Int = 0,
        isActive: Bool = false
    ) {
        self.id = UUID()
        self.categoryRaw = category.rawValue
        self.displayTitle = displayTitle
        self.targetSeconds = targetSeconds
        self.remainingSeconds = remainingSeconds ?? targetSeconds
        self.spentSeconds = spentSeconds
        self.isActive = isActive
        self.dayKey = ""
        self.createdAt = .now
        self.startedAt = nil
        self.endedAt = nil
        self.statusRaw = TaskStatus.ready.rawValue
        self.taskCategoryRaw = TaskCategory.work.rawValue
        self.captureSourceRaw = TaskCaptureSource.typed.rawValue
    }

    init(
        dayKey: String,
        title: String,
        category: TaskCategory,
        durationMinutes: Int,
        captureSource: TaskCaptureSource = .typed,
        createdAt: Date = .now
    ) {
        self.id = UUID()
        self.categoryRaw = Self.legacyCategory(for: category).rawValue
        self.displayTitle = title
        self.targetSeconds = max(durationMinutes, 1) * 60
        self.remainingSeconds = self.targetSeconds
        self.spentSeconds = 0
        self.isActive = false
        self.lastTickAt = nil
        self.plan = nil
        self.dayKey = dayKey
        self.createdAt = createdAt
        self.startedAt = nil
        self.endedAt = nil
        self.statusRaw = TaskStatus.ready.rawValue
        self.taskCategoryRaw = category.rawValue
        self.captureSourceRaw = captureSource.rawValue
    }

    var category: FocusCategory {
        get { FocusCategory(rawValue: categoryRaw) ?? .app }
        set { categoryRaw = newValue.rawValue }
    }

    var taskCategory: TaskCategory {
        get { TaskCategory(rawValue: taskCategoryRaw) ?? .work }
        set { taskCategoryRaw = newValue.rawValue }
    }

    var title: String {
        get { displayTitle }
        set { displayTitle = newValue }
    }

    var durationMinutes: Int {
        get { max(targetSeconds, 1) / 60 }
        set { targetSeconds = max(newValue, 1) * 60; remainingSeconds = targetSeconds }
    }

    var status: TaskStatus {
        get { TaskStatus(rawValue: statusRaw) ?? .ready }
        set { statusRaw = newValue.rawValue }
    }

    var captureSource: TaskCaptureSource {
        get { TaskCaptureSource(rawValue: captureSourceRaw) ?? .typed }
        set { captureSourceRaw = newValue.rawValue }
    }

    var totalSeconds: Int {
        max(targetSeconds, 1)
    }

    var progress: Double {
        remainingFraction
    }

    var remainingFraction: Double {
        guard totalSeconds > 0 else { return 0 }
        return min(max(Double(remainingSeconds) / Double(totalSeconds), 0), 1)
    }

    var isRunningTask: Bool {
        status == .running
    }

    var isCompletedTask: Bool {
        status == .completed
    }

    var isRunning: Bool {
        isRunningTask
    }

    var isCompleted: Bool {
        isCompletedTask
    }

    private static func legacyCategory(for taskCategory: TaskCategory) -> FocusCategory {
        switch taskCategory {
        case .admin:
            .app
        case .work:
            .income
        case .fitness:
            .brand
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case categoryRaw
        case displayTitle
        case targetSeconds
        case remainingSeconds
        case spentSeconds
        case isActive
        case lastTickAt
        case dayKey
        case createdAt
        case startedAt
        case endedAt
        case statusRaw
        case taskCategoryRaw
        case captureSourceRaw
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        categoryRaw = try container.decode(String.self, forKey: .categoryRaw)
        displayTitle = try container.decode(String.self, forKey: .displayTitle)
        targetSeconds = try container.decode(Int.self, forKey: .targetSeconds)
        remainingSeconds = try container.decode(Int.self, forKey: .remainingSeconds)
        spentSeconds = try container.decode(Int.self, forKey: .spentSeconds)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        lastTickAt = try container.decodeIfPresent(Date.self, forKey: .lastTickAt)
        dayKey = try container.decode(String.self, forKey: .dayKey)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        startedAt = try container.decodeIfPresent(Date.self, forKey: .startedAt)
        endedAt = try container.decodeIfPresent(Date.self, forKey: .endedAt)
        statusRaw = try container.decode(String.self, forKey: .statusRaw)
        taskCategoryRaw = try container.decode(String.self, forKey: .taskCategoryRaw)
        captureSourceRaw = try container.decode(String.self, forKey: .captureSourceRaw)
        plan = nil
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(categoryRaw, forKey: .categoryRaw)
        try container.encode(displayTitle, forKey: .displayTitle)
        try container.encode(targetSeconds, forKey: .targetSeconds)
        try container.encode(remainingSeconds, forKey: .remainingSeconds)
        try container.encode(spentSeconds, forKey: .spentSeconds)
        try container.encode(isActive, forKey: .isActive)
        try container.encodeIfPresent(lastTickAt, forKey: .lastTickAt)
        try container.encode(dayKey, forKey: .dayKey)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(startedAt, forKey: .startedAt)
        try container.encodeIfPresent(endedAt, forKey: .endedAt)
        try container.encode(statusRaw, forKey: .statusRaw)
        try container.encode(taskCategoryRaw, forKey: .taskCategoryRaw)
        try container.encode(captureSourceRaw, forKey: .captureSourceRaw)
    }
}
