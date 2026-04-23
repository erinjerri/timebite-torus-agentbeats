import SwiftUI

@main
struct AgentBeatsTimeBiteApp: App {
    @StateObject private var environment = AgentBeatsEnvironment()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(environment)
        }
    }
}
