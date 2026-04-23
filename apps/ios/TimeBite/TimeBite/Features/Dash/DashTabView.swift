import SwiftUI

struct DashTabView: View {
    @EnvironmentObject private var environment: AgentBeatsEnvironment

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                scoreCard
                notesCard
            }
            .padding(16)
        }
        .navigationTitle("Dash")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var scoreCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Benchmark Score")
                .font(.headline)
            Text("\(environment.benchmarkScore)/100")
                .font(.system(size: 44, weight: .bold, design: .rounded))
            Text("Derived from local state transitions and log coverage.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var notesCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Porting Notes")
                .font(.headline)
            Text("This repo is intentionally thin. Shared UI and models should move in from timebite-platform later.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
