//
//  DemoDashboardView.swift
//  TimeBite
//

import SwiftUI

struct DemoDashboardView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                header
                aiSuggestionCard

                Text("Active Projects")
                    .font(.title3.bold())

                ForEach(appState.projects) { project in
                    DemoProjectCard(project: project)
                }
            }
            .padding()
        }
        .navigationTitle("Dashboard")
        .onAppear {
            appState.refreshAiSuggestionIfNeeded()
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("This week")
                .font(.title3.bold())

            HStack(spacing: 12) {
                DemoMetricPill(label: "Score", value: "\(appState.completionScore)/100")
                DemoMetricPill(label: "Intent", value: appState.dailyIntent.isEmpty ? "Not set" : "Set")
            }

            Text(appState.dailyIntent.isEmpty ? "Set today’s intent to guide the agent." : appState.dailyIntent)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .lineLimit(3)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }

    private var aiSuggestionCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label("AI Reallocation", systemImage: "sparkles")
                    .font(.headline)
                Spacer()
                Text("Demo-safe")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }

            if let suggestion = appState.aiReallocationSuggestion {
                Text(suggestion.summary)
                    .font(.subheadline)

                Text(suggestion.reason)
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Button("Apply (+\(suggestion.hours)h to \(suggestion.toProjectName))") {
                    appState.applyAiReallocation()
                }
                .buttonStyle(.borderedProminent)
            } else {
                Text("All good — no reallocation needed.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

private struct DemoMetricPill: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label.uppercased())
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            Text(value)
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(.systemBackground))
        )
    }
}

private struct DemoProjectCard: View {
    let project: DemoProject

    private var ringColor: Color {
        switch project.priority {
        case 0: .cyan
        case 1: .blue
        default: .purple
        }
    }

    var body: some View {
        HStack(spacing: 14) {
            DemoProgressRing(progress: project.progressToCap, tint: ringColor)
                .frame(width: 54, height: 54)

            VStack(alignment: .leading, spacing: 6) {
                Text(project.name)
                    .font(.headline)
                    .lineLimit(1)

                Text("\(project.spentHours, specifier: "%.1f")h / \(project.weeklyCapHours)h")
                    .font(.subheadline.monospacedDigit())
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text("\(Int((project.progressToCap * 100).rounded()))%")
                .font(.headline.monospacedDigit())
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

private struct DemoProgressRing: View {
    let progress: Double
    let tint: Color

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), style: StrokeStyle(lineWidth: 10, lineCap: .round))

            Circle()
                .trim(from: 0, to: max(0, min(progress, 1)))
                .stroke(tint, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.spring(response: 0.35, dampingFraction: 0.9), value: progress)
        }
        .accessibilityLabel("Progress ring")
        .accessibilityValue("\(Int((progress * 100).rounded())) percent")
    }
}
