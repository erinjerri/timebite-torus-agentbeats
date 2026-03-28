//
//  TimeBiteApp.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/11/26.
//

import SwiftUI
import SwiftData

@main
struct TimeBiteApp: App {
    @StateObject var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
