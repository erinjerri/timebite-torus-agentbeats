//
//  CycleDashboardView.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//

import SwiftUI

struct CycleDashboardView: View {
    let plan: DailyPlan

    private var viewModel: CyclesViewModel {
        CyclesViewModel(plan: plan)
    }

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                ForEach(Array(viewModel.snapshot.lanes.enumerated()), id: \.element.id) { index, lane in
                    RingTrackView(lineWidth: 22, inset: CGFloat(index) * 30)
                    RingSegmentView(
                        progress: lane.fractionSpent,
                        color: lane.category.color,
                        lineWidth: 22,
                        inset: CGFloat(index) * 30
                    )
                }

                VStack(spacing: 6) {
                    Text(viewModel.activeTitle)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Text(viewModel.centerDetail)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 24)
            }
            .frame(width: 280, height: 280)
            .padding(.top, 12)

            VStack(spacing: 12) {
                ForEach(viewModel.snapshot.lanes) { lane in
                    CycleBarView(snapshot: lane)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

private struct RingTrackView: View {
    let lineWidth: CGFloat
    let inset: CGFloat

    var body: some View {
        Circle()
            .stroke(Color(.systemGray5), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .padding(inset)
    }
}

private struct RingSegmentView: View {
    let progress: Double
    let color: Color
    let lineWidth: CGFloat
    let inset: CGFloat

    var body: some View {
        Circle()
            .trim(from: 0, to: max(progress, 0.02))
            .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .rotationEffect(.degrees(-90))
            .padding(inset)
    }
}
