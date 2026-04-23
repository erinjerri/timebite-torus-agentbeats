//
//  TaskCaptureVisionKitService.swift
//  TimeBite
//
//  Created by Erin Jerri on 4/3/26.
//

import Foundation

protocol TaskCaptureService {
    func captureText() async throws -> String
}

struct TaskCaptureVisionKitService: TaskCaptureService {
    func captureText() async throws -> String {
        // VisionKit wiring comes later. This adapter keeps the pipeline ready.
        throw NSError(domain: "TaskCaptureVisionKitService", code: 1, userInfo: [
            NSLocalizedDescriptionKey: "VisionKit capture is not wired yet."
        ])
    }
}
