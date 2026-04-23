//
//  PercentageLabel.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//

import SwiftUI

struct PercentageLabel: View {
    let snapshot: LaneSnapshot

    var body: some View {
        Text("\(CycleComputation.percentage(for: snapshot))% · \(CycleComputation.formatDuration(snapshot.remainingSeconds)) left")
            .font(.caption.monospacedDigit())
            .foregroundStyle(.secondary)
    }
}
