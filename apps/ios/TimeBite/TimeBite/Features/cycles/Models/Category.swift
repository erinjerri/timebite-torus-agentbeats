//
//  Category.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//

import Foundation
import SwiftUI

enum FocusCategory: String, CaseIterable, Identifiable {
    case app
    case income
    case brand

    var id: String { rawValue }

    var title: String {
        switch self {
        case .app:
            "App"
        case .income:
            "Income"
        case .brand:
            "Brand"
        }
    }

    var defaultSeconds: Int {
        switch self {
        case .app, .income:
            7_200
        case .brand:
            3_600
        }
    }

    var sortOrder: Int {
        switch self {
        case .app: 0
        case .income: 1
        case .brand: 2
        }
    }

    var color: Color {
        switch self {
        case .app:
            .blue
        case .income:
            .green
        case .brand:
            .orange
        }
    }
}

enum PlanStatus: String, CaseIterable, Identifiable {
    case planned
    case inProgress = "in_progress"
    case completed

    var id: String { rawValue }
}

enum ReflectionResult: String, CaseIterable, Identifiable {
    case done
    case partial
    case missed

    var id: String { rawValue }

    var title: String { rawValue.capitalized }
}
