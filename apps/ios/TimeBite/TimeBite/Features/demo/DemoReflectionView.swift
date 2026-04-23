//
//  DemoReflectionView.swift
//  TimeBite
//

import SwiftUI

struct DemoReflectionView: View {
    @EnvironmentObject private var appState: AppState
    @State private var note: String = ""

    var body: some View {
        Form {
            Section("Outcomes") {
                ForEach(Array(appState.projects.enumerated()), id: \.element.id) { index, project in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(project.name)
                            .font(.headline)

                        Picker("Result", selection: Binding(
                            get: { appState.projects[index].reflectionResult ?? .partial },
                            set: { value in
                                appState.projects[index].reflectionResult = value
                                appState.saveDemoState()
                            }
                        )) {
                            ForEach(DemoReflectionResult.allCases) { result in
                                Text(result.title).tag(result)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.vertical, 6)
                }
            }

            Section("Reflection") {
                TextField("One sentence: what happened today?", text: $note, axis: .vertical)
                    .lineLimit(2...5)
            }

            Section("Score") {
                HStack {
                    Text("Reflection score")
                    Spacer()
                    Text("\(appState.reflectionScore)/100")
                        .font(.headline.monospacedDigit())
                }
            }

            Section {
                Button("Save Reflection") {
                    appState.saveDemoState()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle("Reflect")
    }
}

