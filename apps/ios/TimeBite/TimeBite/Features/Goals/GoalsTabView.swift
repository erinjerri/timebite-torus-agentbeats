import SwiftUI

struct GoalsTabView: View {
    @EnvironmentObject private var environment: AgentBeatsEnvironment

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                goalList
                scenarioSummary
            }
            .padding(16)
        }
        .navigationTitle("Goals")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Environment Framing")
                .font(.headline)
            Text("Goals stay lightweight here so the canonical product UI can be ported in later.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var goalList: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Mock Goals")
                .font(.headline)
            ForEach(environment.goals) { goal in
                VStack(alignment: .leading, spacing: 2) {
                    Text(goal.title)
                        .font(.subheadline.weight(.semibold))
                    Text(goal.detail)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var scenarioSummary: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Scenario")
                .font(.headline)
            Text(environment.scenario.scoringNotes)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
