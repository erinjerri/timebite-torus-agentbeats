//
//  DemoIntentSetupView.swift
//  TimeBite
//

import SwiftUI

struct DemoIntentSetupView: View {
    @EnvironmentObject private var appState: AppState
    @State private var intentDraft: String = ""

    var body: some View {
        Form {
            Section("Today’s Intent") {
                TextField("What matters today?", text: $intentDraft, axis: .vertical)
                    .lineLimit(3...6)
                    .onAppear {
                        intentDraft = appState.dailyIntent
                    }
                    .onChange(of: intentDraft) { _, value in
                        appState.dailyIntent = value
                        appState.saveDemoState()
                    }
            }

            Section("Active Projects (3)") {
                ForEach(Array(appState.projects.enumerated()), id: \.element.id) { index, project in
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("Project name", text: Binding(
                            get: { appState.projects[index].name },
                            set: { newValue in
                                appState.projects[index].name = newValue
                                appState.saveDemoState()
                            }
                        ))

                        HStack {
                            Text("Weekly cap")
                            Spacer()
                            Stepper(
                                "\(appState.projects[index].weeklyCapHours)h/week",
                                value: Binding(
                                    get: { appState.projects[index].weeklyCapHours },
                                    set: { hours in
                                        appState.projects[index].weeklyCapSeconds = max(hours, 0) * 3_600
                                        appState.saveDemoState()
                                    }
                                ),
                                in: 0...60,
                                step: 1
                            )
                        }
                    }
                    .padding(.vertical, 6)
                }
            }

            Section("Demo Controls") {
                Picker("Timer attribution", selection: $appState.selectedProjectId) {
                    ForEach(appState.projects) { project in
                        Text(project.shortName).tag(project.id)
                    }
                }
                .pickerStyle(.segmented)

                Button("Reset Demo Scenario") {
                    appState.resetDemoScenario()
                }
                .foregroundStyle(.red)
            }
        }
        .navigationTitle("Intent")
    }
}
