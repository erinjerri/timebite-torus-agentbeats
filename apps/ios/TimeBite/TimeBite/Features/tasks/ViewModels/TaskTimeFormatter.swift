//
//  TaskTimeFormatter.swift
//  TimeBite
//
//  Created by Erin Jerri on 4/3/26.
//

import Foundation

enum TaskTimeFormatter {
    static func format(seconds: Int) -> String {
        let safeSeconds = max(seconds, 0)
        let hours = safeSeconds / 3_600
        let minutes = (safeSeconds % 3_600) / 60
        let remainingSeconds = safeSeconds % 60

        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, remainingSeconds)
        }

        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}
