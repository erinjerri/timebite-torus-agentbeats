import SwiftUI

struct RootTabView: View {
    enum Tab: Hashable {
        case action
        case track
        case goals
        case dash
    }

    @State private var selectedTab: Tab = .action

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                ActionTabView()
            }
            .tabItem {
                Label("Action", systemImage: "bolt.fill")
            }
            .tag(Tab.action)

            NavigationStack {
                TrackTabView()
            }
            .tabItem {
                Label("Track", systemImage: "waveform.path.ecg")
            }
            .tag(Tab.track)

            NavigationStack {
                GoalsTabView()
            }
            .tabItem {
                Label("Goals", systemImage: "flag.checkered")
            }
            .tag(Tab.goals)

            NavigationStack {
                DashTabView()
            }
            .tabItem {
                Label("Dash", systemImage: "rectangle.grid.2x2.fill")
            }
            .tag(Tab.dash)
        }
        .tint(AgentBeatsPalette.accent)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(AgentBeatsPalette.panel.opacity(0.9), for: .tabBar)
    }
}
