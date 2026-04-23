//
//  CycleSnapshot.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//

import Foundation

struct LaneSnapshot: Identifiable {
    let id: UUID
    let category: FocusCategory
    let title: String
    let targetSeconds: Int
    let remainingSeconds: Int
    let spentSeconds: Int
    let isActive: Bool

    var fractionRemaining: Double {
        guard targetSeconds > 0 else { return 0 }
        return max(0, min(1, Double(remainingSeconds) / Double(targetSeconds)))
    }

    var fractionSpent: Double {
        1 - fractionRemaining
    }
}

struct CycleSnapshot {
    let lanes: [LaneSnapshot]
    let activeLaneTitle: String?
    let activeRemainingSeconds: Int

    var totalSpentSeconds: Int {
        lanes.reduce(0) { $0 + $1.spentSeconds }
    }

    var totalTargetSeconds: Int {
        lanes.reduce(0) { $0 + $1.targetSeconds }
    }
}
