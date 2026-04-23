//
//  TaskStore.swift
//  TimeBite
//
//  Created by Erin Jerri on 4/3/26.
//

import Foundation

struct TaskStore {
    private let fileURL: URL

    init(fileURL: URL = TaskStore.defaultFileURL()) {
        self.fileURL = fileURL
    }

    func loadTodayTasks() -> [TaskItem] {
        let dayKey = DayKeyFormatter.key(for: .now)
        return load().filter { $0.dayKey == dayKey }
    }

    func load() -> [TaskItem] {
        guard let data = try? Data(contentsOf: fileURL) else { return [] }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return (try? decoder.decode([TaskItem].self, from: data)) ?? []
    }

    func save(tasks: [TaskItem]) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601

        guard let data = try? encoder.encode(tasks) else { return }
        try? data.write(to: fileURL, options: [.atomic])
    }

    private static func defaultFileURL() -> URL {
        let directory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
            ?? FileManager.default.temporaryDirectory
        let appDirectory = directory.appendingPathComponent("TimeBite", isDirectory: true)
        try? FileManager.default.createDirectory(at: appDirectory, withIntermediateDirectories: true)
        return appDirectory.appendingPathComponent("tasks.json")
    }
}
