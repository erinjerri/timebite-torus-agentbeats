//
//  CyclesViewModel.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//

import Foundation

struct CyclesViewModel {
    let snapshot: CycleSnapshot

    init(plan: DailyPlan) {
        self.snapshot = CycleComputation.snapshot(for: plan)
    }

    var activeTitle: String {
        snapshot.activeLaneTitle ?? "No Active Timer"
    }

    var centerDetail: String {
        if snapshot.activeLaneTitle == nil {
            return "Ready to focus"
        }
        return "\(CycleComputation.formatDuration(snapshot.activeRemainingSeconds)) left"
    }
}
