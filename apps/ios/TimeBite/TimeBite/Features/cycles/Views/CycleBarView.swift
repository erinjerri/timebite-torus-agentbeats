//
//  CycleBarView.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//

import SwiftUI

struct CycleBarView: View {
    let snapshot: LaneSnapshot

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Label(snapshot.category.title, systemImage: snapshot.isActive ? "timer" : "circle.fill")
                    .foregroundStyle(snapshot.category.color)
                    .font(.subheadline.weight(.semibold))
                Spacer()
                PercentageLabel(snapshot: snapshot)
            }

            ProgressBar(progress: snapshot.fractionSpent, tint: snapshot.category.color)
        }
    }
}
