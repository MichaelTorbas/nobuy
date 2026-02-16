import SwiftUI

@main
struct NoBuyApp: App {
    @StateObject private var dataStore = DataStore.shared
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(dataStore)
                .preferredColorScheme(.dark)
        }
    }
}
