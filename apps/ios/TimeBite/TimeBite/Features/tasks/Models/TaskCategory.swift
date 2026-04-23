//
//  TaskCategory.swift
//  TimeBite
//
//  Created by Erin Jerri on 4/3/26.
//

import Foundation
import SwiftUI

enum TaskCategory: String, CaseIterable, Identifiable {
    case admin
    case work
    case fitness

    var id: String { rawValue }

    var title: String {
        switch self {
        case .admin:
            "Admin / Chores"
        case .work:
            "Work"
        case .fitness:
            "Fitness"
        }
    }

    var color: Color {
        switch self {
        case .admin:
            .orange
        case .work:
            .blue
        case .fitness:
            .green
        }
    }
}

enum TaskDurationPreset: String, CaseIterable, Identifiable {
    case five = "5 min"
    case thirty = "30 min"
    case sixty = "1 hour"
    case custom = "Custom"

    var id: String { rawValue }

    var minutes: Int? {
        switch self {
        case .five:
            5
        case .thirty:
            30
        case .sixty:
            60
        case .custom:
            nil
        }
    }
}

enum TaskStatus: String, CaseIterable, Identifiable {
    case ready
    case running
    case paused
    case completed

    var id: String { rawValue }
}

enum TaskCaptureSource: String, CaseIterable, Identifiable {
    case typed
    case visionKit
    case speech

    var id: String { rawValue }
}
