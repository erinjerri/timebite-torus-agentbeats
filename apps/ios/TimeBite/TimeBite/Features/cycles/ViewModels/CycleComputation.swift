//
//  CycleComputation.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//

import Foundation

enum CycleComputation {
    static func snapshot(for plan: DailyPlan) -> CycleSnapshot {
        let orderedLanes = plan.lanes
            .sorted(by: { $0.category.sortOrder < $1.category.sortOrder })
            .map {
                LaneSnapshot(
                    id: $0.id,
                    category: $0.category,
                    title: $0.displayTitle,
                    targetSeconds: $0.targetSeconds,
                    remainingSeconds: $0.remainingSeconds,
                    spentSeconds: $0.spentSeconds,
                    isActive: $0.isActive
                )
            }

        let activeLane = orderedLanes.first(where: \.isActive)
        return CycleSnapshot(
            lanes: orderedLanes,
            activeLaneTitle: activeLane?.title,
            activeRemainingSeconds: activeLane?.remainingSeconds ?? 0
        )
    }

    static func percentage(for lane: LaneSnapshot) -> Int {
        Int((lane.fractionSpent * 100).rounded())
    }

    static func formatDuration(_ seconds: Int) -> String {
        let hours = seconds / 3_600
        let minutes = (seconds % 3_600) / 60
        let secs = seconds % 60

        if hours > 0 {
            return "\(hours)h \(minutes)m"
        }

        if minutes > 0 {
            return secs > 0 ? "\(minutes)m \(secs)s" : "\(minutes)m"
        }

        return "\(secs)s"
    }
}
