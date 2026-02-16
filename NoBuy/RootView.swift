import SwiftUI

struct RootView: View {
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        Group {
            if !dataStore.hasCompletedOnboarding {
                OnboardingContainerView()
            } else if !dataStore.hasSeenPaywall && !dataStore.isSubscribed {
                PaywallView()
            } else {
                MainTabView()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: dataStore.hasCompletedOnboarding)
        .animation(.easeInOut(duration: 0.3), value: dataStore.hasSeenPaywall)
    }
}
