//
//  DemoFocusState.swift
//  TimeBite
//
//  Hackathon demo state for the 3-project dashboard scenario.
//

import Foundation

enum DemoReflectionResult: String, CaseIterable, Identifiable, Codable {
    case done
    case partial
    case missed

    var id: String { rawValue }

    var title: String { rawValue.capitalized }

    var scoreValue: Double {
        switch self {
        case .done: 1.0
        case .partial: 0.5
        case .missed: 0.0
        }
    }
}

struct DemoProject: Identifiable, Codable, Hashable {
    var id: UUID
    var name: String
    var weeklyCapSeconds: Int
    var spentSeconds: Int
    var priority: Int
    var reflectionResultRaw: String?

    init(
        id: UUID = UUID(),
        name: String,
        weeklyCapSeconds: Int,
        spentSeconds: Int = 0,
        priority: Int,
        reflectionResultRaw: String? = nil
    ) {
        self.id = id
        self.name = name
        self.weeklyCapSeconds = weeklyCapSeconds
        self.spentSeconds = spentSeconds
        self.priority = priority
        self.reflectionResultRaw = reflectionResultRaw
    }

    var weeklyCapHours: Int {
        max(weeklyCapSeconds / 3_600, 0)
    }

    var shortName: String {
        let lower = name.lowercased()
        if lower.contains("hackathon") { return "Hack" }
        if lower.contains("startup") { return "Startup" }
        if lower.contains("job") { return "Job" }
        return String(name.split(separator: " ").first ?? "Proj")
    }

    var spentHours: Double {
        Double(spentSeconds) / 3_600.0
    }

    var progressToCap: Double {
        guard weeklyCapSeconds > 0 else { return 0 }
        return min(max(Double(spentSeconds) / Double(weeklyCapSeconds), 0), 1)
    }

    var reflectionResult: DemoReflectionResult? {
        get {
            guard let reflectionResultRaw else { return nil }
            return DemoReflectionResult(rawValue: reflectionResultRaw)
        }
        set {
            reflectionResultRaw = newValue?.rawValue
        }
    }
}

struct DemoFocusState: Codable {
    var dailyIntent: String
    var projects: [DemoProject]
    var updatedAt: Date

    static func `default`() -> DemoFocusState {
        DemoFocusState(
            dailyIntent: "Ship the AgentBeats demo: dashboard rings + AI reallocation + telemetry.",
            projects: [
                DemoProject(name: "Hackathon Repo", weeklyCapSeconds: 10 * 3_600, spentSeconds: 2 * 3_600, priority: 0),
                DemoProject(name: "Startup Repo", weeklyCapSeconds: 12 * 3_600, spentSeconds: 8 * 3_600, priority: 1),
                DemoProject(name: "Job Search", weeklyCapSeconds: 6 * 3_600, spentSeconds: 4 * 3_600, priority: 2),
            ],
            updatedAt: .now
        )
    }
}

struct DemoFocusStore {
    private let fileURL: URL

    init(fileURL: URL = DemoFocusStore.defaultFileURL()) {
        self.fileURL = fileURL
    }

    func load() -> DemoFocusState {
        guard let data = try? Data(contentsOf: fileURL) else { return .default() }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return (try? decoder.decode(DemoFocusState.self, from: data)) ?? .default()
    }

    func save(_ state: DemoFocusState) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601
        guard let data = try? encoder.encode(state) else { return }
        try? data.write(to: fileURL, options: [.atomic])
    }

    private static func defaultFileURL() -> URL {
        let directory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
            ?? FileManager.default.temporaryDirectory
        let appDirectory = directory.appendingPathComponent("TimeBite", isDirectory: true)
        try? FileManager.default.createDirectory(at: appDirectory, withIntermediateDirectories: true)
        return appDirectory.appendingPathComponent("demo_state.json")
    }
}
