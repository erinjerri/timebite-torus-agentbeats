import SwiftUI

struct ActionTabView: View {
    @EnvironmentObject private var environment: AgentBeatsEnvironment

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                actionControls
                actionLog
            }
            .padding(16)
        }
        .navigationTitle("Action")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Reset") {
                    environment.resetEnvironment()
                }
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Benchmark Layer")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            Text(environment.scenario.title)
                .font(.title2.bold())
            Text(environment.scenario.mission)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var actionControls: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Action State")
                .font(.headline)

            Picker("Selected Action", selection: Binding(
                get: { environment.selectedAction?.id ?? UUID() },
                set: { newValue in
                    if let action = environment.actions.first(where: { $0.id == newValue }) {
                        environment.select(action)
                    }
                }
            )) {
                ForEach(environment.actions) { action in
                    Text("\(action.title) - \(action.phaseLabel)").tag(action.id)
                }
            }
            .pickerStyle(.menu)

            if let selectedAction = environment.selectedAction {
                VStack(alignment: .leading, spacing: 8) {
                    Text(selectedAction.title)
                        .font(.headline)
                    Text(selectedAction.context)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("State: \(selectedAction.phaseLabel) | \(selectedAction.completionLabel)")
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 12) {
                    Button("Start") { environment.startSelectedAction() }
                        .buttonStyle(.borderedProminent)
                        .disabled(selectedAction.state == .running || selectedAction.state == .completed)

                    Button("Stop") { environment.stopSelectedAction() }
                        .buttonStyle(.bordered)
                        .disabled(selectedAction.state != .running)

                    Button("Complete") { environment.completeSelectedAction() }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                        .disabled(selectedAction.state == .completed)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var actionLog: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Action Log")
                .font(.headline)

            ForEach(environment.recentLogs()) { log in
                VStack(alignment: .leading, spacing: 4) {
                    Text(log.headline)
                        .font(.subheadline.weight(.semibold))
                    Text(log.timestamp.formatted(date: .omitted, time: .shortened))
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                    if let note = log.note, !note.isEmpty {
                        Text(note)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
