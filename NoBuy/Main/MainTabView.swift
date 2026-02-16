import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            StatsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Stats")
                }
                .tag(1)
            MilestonesView()
                .tabItem {
                    Image(systemName: "trophy.fill")
                    Text("Milestones")
                }
                .tag(2)
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(3)
        }
        .tint(NoBuyTheme.primary)
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor(NoBuyTheme.cardBackground)
        }
    }
}
