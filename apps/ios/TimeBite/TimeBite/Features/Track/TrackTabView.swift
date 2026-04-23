import SwiftUI

struct TrackTabView: View {
    @EnvironmentObject private var environment: AgentBeatsEnvironment

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                infoCard
                logCard
            }
            .padding(16)
        }
        .navigationTitle("Track")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var infoCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Telemetry")
                .font(.headline)
            Text("Local mock signals only. This tab will later reuse the platform app's shared tracking UI.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            HStack {
                Label("\(environment.dailyLog.actionsStarted) starts", systemImage: "play.fill")
                Label("\(environment.dailyLog.actionsStopped) stops", systemImage: "pause.fill")
                Label("\(environment.dailyLog.actionsCompleted) done", systemImage: "checkmark.circle.fill")
            }
            .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var logCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recent Events")
                .font(.headline)
            ForEach(environment.recentLogs()) { log in
                Text("• \(log.headline)")
                    .font(.subheadline)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
