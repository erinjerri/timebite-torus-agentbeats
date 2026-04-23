//
//  DailyPlan.swift
//  TimeBite
//
//  Created by Erin Jerri on 4/3/26.
//

import Foundation

final class DailyPlan {
    var dayKey: String
    var date: Date
    var appFocus: String
    var incomeFocus: String
    var brandFocus: String?
    var statusRaw: String

    var lanes: [FocusLane]

    var logs: [CycleLog]

    var reflection: Reflection?

    init(
        dayKey: String,
        date: Date,
        appFocus: String,
        incomeFocus: String,
        brandFocus: String? = nil,
        status: PlanStatus = .planned,
        lanes: [FocusLane] = [],
        logs: [CycleLog] = []
    ) {
        self.dayKey = dayKey
        self.date = date
        self.appFocus = appFocus
        self.incomeFocus = incomeFocus
        self.brandFocus = brandFocus
        self.statusRaw = status.rawValue
        self.lanes = lanes
        self.logs = logs
    }

    var status: PlanStatus {
        get { PlanStatus(rawValue: statusRaw) ?? .planned }
        set { statusRaw = newValue.rawValue }
    }
}
