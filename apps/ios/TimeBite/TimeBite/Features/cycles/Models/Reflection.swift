//
//  Reflection.swift
//  TimeBite
//
//  Created by Erin Jerri on 4/3/26.
//

import Foundation

final class Reflection {
    var id: UUID
    var appResultRaw: String
    var incomeResultRaw: String
    var brandResultRaw: String?
    var note: String
    var createdAt: Date
    var plan: DailyPlan?

    init(
        appResult: ReflectionResult,
        incomeResult: ReflectionResult,
        brandResult: ReflectionResult? = nil,
        note: String,
        createdAt: Date = .now
    ) {
        self.id = UUID()
        self.appResultRaw = appResult.rawValue
        self.incomeResultRaw = incomeResult.rawValue
        self.brandResultRaw = brandResult?.rawValue
        self.note = note
        self.createdAt = createdAt
    }

    var appResult: ReflectionResult {
        get { ReflectionResult(rawValue: appResultRaw) ?? .partial }
        set { appResultRaw = newValue.rawValue }
    }

    var incomeResult: ReflectionResult {
        get { ReflectionResult(rawValue: incomeResultRaw) ?? .partial }
        set { incomeResultRaw = newValue.rawValue }
    }

    var brandResult: ReflectionResult? {
        get { brandResultRaw.flatMap(ReflectionResult.init(rawValue:)) }
        set { brandResultRaw = newValue?.rawValue }
    }
}
