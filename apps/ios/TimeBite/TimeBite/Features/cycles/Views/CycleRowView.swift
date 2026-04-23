//
//  CycleRowView.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//

import SwiftUI

struct CycleRowView: View {
    let lane: FocusLane
    let startAction: () -> Void
    let stopAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(lane.category.title)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(lane.category.color)
                    Text(lane.displayTitle)
                        .font(.headline)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text(CycleComputation.formatDuration(lane.remainingSeconds))
                        .font(.headline.monospacedDigit())
                    Text("of \(CycleComputation.formatDuration(lane.targetSeconds))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            ProgressBar(
                progress: min(Double(lane.spentSeconds) / Double(max(lane.targetSeconds, 1)), 1),
                tint: lane.category.color
            )

            HStack {
                Text(lane.isActive ? "Active now" : "Ready")
                    .font(.subheadline)
                    .foregroundStyle(lane.isActive ? lane.category.color : .secondary)

                Spacer()

                if lane.isActive {
                    Button("Stop", role: .destructive, action: stopAction)
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                } else {
                    Button("Start", action: startAction)
                        .buttonStyle(.borderedProminent)
                        .tint(lane.category.color)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 12, y: 6)
        )
    }
}
