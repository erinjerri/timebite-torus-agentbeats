//
//  RealityCheckView.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//

import SwiftUI

struct RealityCheckView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.dismiss) private var dismiss

    let plan: DailyPlan

    @State private var appResult: ReflectionResult = .partial
    @State private var incomeResult: ReflectionResult = .partial
    @State private var brandResult: ReflectionResult = .partial
    @State private var note = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Today") {
                    ReflectionPickerRow(title: plan.appFocus, selection: $appResult)
                    ReflectionPickerRow(title: plan.incomeFocus, selection: $incomeResult)

                    if let brandFocus = plan.brandFocus {
                        ReflectionPickerRow(title: brandFocus, selection: $brandResult)
                    }
                }

                Section("Note") {
                    TextField("What matched reality?", text: $note, axis: .vertical)
                        .lineLimit(4...8)
                }
            }
            .navigationTitle("Reflection")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        appState.completeReflection(
                            appResult: appResult,
                            incomeResult: incomeResult,
                            brandResult: plan.brandFocus == nil ? nil : brandResult,
                            note: note
                        )
                        dismiss()
                    }
                    .disabled(note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

private struct ReflectionPickerRow: View {
    let title: String
    @Binding var selection: ReflectionResult

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)

            Picker(title, selection: $selection) {
                ForEach(ReflectionResult.allCases) { result in
                    Text(result.title).tag(result)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding(.vertical, 4)
    }
}
