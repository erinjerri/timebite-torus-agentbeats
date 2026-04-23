//
//  DailySummaryView.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//

import SwiftUI

struct DailySummaryView: View {
    @EnvironmentObject private var appState: AppState

    let plan: DailyPlan
    let reflection: Reflection

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                CycleDashboardView(plan: plan)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Reality Check")
                        .font(.title3.bold())

                    ResultRow(title: plan.appFocus, result: reflection.appResult, tint: FocusCategory.app.color)
                    ResultRow(title: plan.incomeFocus, result: reflection.incomeResult, tint: FocusCategory.income.color)

                    if let brandFocus = plan.brandFocus, let brandResult = reflection.brandResult {
                        ResultRow(title: brandFocus, result: brandResult, tint: FocusCategory.brand.color)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Note")
                        .font(.title3.bold())
                    Text(reflection.note)
                        .foregroundStyle(.secondary)
                }

                Button("Reset Today") {
                    appState.resetTodayPlan()
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .navigationTitle("Today Complete")
    }
}

private struct ResultRow: View {
    let title: String
    let result: ReflectionResult
    let tint: Color

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(result.title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(tint)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}
