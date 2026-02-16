import Foundation
import Combine

final class DataStore: ObservableObject {
    static let shared = DataStore()
    
    @Published var userProfile: UserProfile
    @Published var streakState: StreakState
    @Published var hasCompletedOnboarding: Bool
    @Published var hasSeenPaywall: Bool
    @Published var isSubscribed: Bool
    
    private let profileKey = "nobuy_user_profile"
    private let streakKey = "nobuy_streak_state"
    private let onboardingKey = "nobuy_onboarding_done"
    private let paywallKey = "nobuy_paywall_seen"
    private let subscribedKey = "nobuy_subscribed"
    
    init() {
        self.userProfile = (try? DataStore.load(UserProfile.self, key: "nobuy_user_profile")) ?? UserProfile()
        self.streakState = (try? DataStore.load(StreakState.self, key: "nobuy_streak_state")) ?? StreakState()
        self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "nobuy_onboarding_done")
        self.hasSeenPaywall = UserDefaults.standard.bool(forKey: "nobuy_paywall_seen")
        self.isSubscribed = UserDefaults.standard.bool(forKey: "nobuy_subscribed")
    }
    
    private static func load<T: Codable>(_ type: T.Type, key: String) throws -> T {
        guard let data = UserDefaults.standard.data(forKey: key) else { throw NSError(domain: "DataStore", code: -1, userInfo: nil) }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private func saveProfile() {
        if let data = try? JSONEncoder().encode(userProfile) {
            UserDefaults.standard.set(data, forKey: profileKey)
        }
    }
    
    private func saveStreak() {
        if let data = try? JSONEncoder().encode(streakState) {
            UserDefaults.standard.set(data, forKey: streakKey)
        }
    }
    
    func updateProfile(_ update: (inout UserProfile) -> Void) {
        update(&userProfile)
        saveProfile()
    }
    
    func setProfile(_ newProfile: UserProfile) {
        userProfile = newProfile
        saveProfile()
    }
    
    func updateStreak(_ update: (inout StreakState) -> Void) {
        update(&streakState)
        saveStreak()
    }
    
    func completeOnboarding() {
        hasCompletedOnboarding = true
        UserDefaults.standard.set(true, forKey: onboardingKey)
    }
    
    func markPaywallSeen() {
        hasSeenPaywall = true
        UserDefaults.standard.set(true, forKey: paywallKey)
    }
    
    func setSubscribed(_ value: Bool) {
        isSubscribed = value
        UserDefaults.standard.set(value, forKey: subscribedKey)
    }
    
    // Daily waste rate for live counter
    var dailyWasteRate: Double {
        Double(userProfile.monthlyWasteEstimate) / 30.0
    }
    
    // Money saved so far based on streak
    func moneySaved(upTo date: Date = Date()) -> Double {
        guard let start = streakState.currentStreakStart else { return streakState.totalMoneySaved }
        let calendar = Calendar.current
        let startDay = calendar.startOfDay(for: start)
        let endDay = calendar.startOfDay(for: date)
        let days = calendar.dateComponents([.day], from: startDay, to: endDay).day ?? 0
        let fromStreak = max(0, days) * dailyWasteRate
        return streakState.totalMoneySaved + fromStreak
    }
    
    // Seconds since streak start for live counter
    var secondsSinceStreakStart: TimeInterval {
        guard let start = streakState.currentStreakStart else { return 0 }
        return Date().timeIntervalSince(start)
    }
}
