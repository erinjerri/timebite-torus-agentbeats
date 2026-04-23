//
//  TaskCategorizer.swift
//  TimeBite
//
//  Created by Erin Jerri on 4/3/26.
//

import Foundation

enum TaskCategorizer {
    static func suggestedCategory(for title: String) -> TaskCategory {
        let lowercased = title.lowercased()

        if containsAny(lowercased, ["run", "walk", "gym", "workout", "exercise", "fitness"]) {
            return .fitness
        }

        if containsAny(lowercased, ["grocer", "laundry", "clean", "dish", "errand", "admin", "chores", "budget"]) {
            return .admin
        }

        if containsAny(lowercased, ["code", "build", "ship", "portfolio", "design", "write", "debug", "project", "work"]) {
            return .work
        }

        return .work
    }

    private static func containsAny(_ text: String, _ keywords: [String]) -> Bool {
        keywords.contains { text.contains($0) }
    }
}
