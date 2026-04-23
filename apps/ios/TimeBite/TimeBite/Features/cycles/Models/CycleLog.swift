//
//  CycleLog.swift
//  TimeBite
//
//  Created by Erin Jerri on 4/3/26.
//

import Foundation

final class CycleLog {
    var id: UUID
    var laneRaw: String
    var taskTitle: String
    var startedAt: Date
    var endedAt: Date?
    var durationSeconds: Int
    var plan: DailyPlan?

    init(
        lane: FocusCategory,
        taskTitle: String,
        startedAt: Date,
        endedAt: Date? = nil,
        durationSeconds: Int = 0
    ) {
        self.id = UUID()
        self.laneRaw = lane.rawValue
        self.taskTitle = taskTitle
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.durationSeconds = durationSeconds
    }

    var lane: FocusCategory {
        get { FocusCategory(rawValue: laneRaw) ?? .app }
        set { laneRaw = newValue.rawValue }
    }
}
