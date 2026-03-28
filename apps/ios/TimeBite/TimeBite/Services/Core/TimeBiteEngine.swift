//
//  TimeBiteEngine.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//
import Foundation
import Combine

class TimeBiteEngine: ObservableObject {
    @Published var categories: [String: Double] = [
        "engineering": 3600,
        "writing": 3600,
        "research": 3600
    ]
    
    private var timer: Timer?
    private var activeCategory: String?

    func start(category: String) {
        activeCategory = category
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.tick()
        }
    }
    
    func stop() {
        timer?.invalidate()
        activeCategory = nil
    }
    
    private func tick() {
        guard let category = activeCategory else { return }
        guard let remaining = categories[category] else { return }
        
        categories[category] = max(remaining - 1, 0)
    }
}
