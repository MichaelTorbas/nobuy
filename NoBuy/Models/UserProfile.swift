import Foundation

// MARK: - Onboarding & user data

struct UserProfile: Codable {
    var spendingWeaknesses: Set<SpendingWeakness> = []
    var impulseFrequency: ImpulseFrequency?
    var monthlyWasteEstimate: Int = 100
    var identityChoice: IdentityOption?
    var savingsGoal: SavingsGoal?
    var visionText: String = ""
    var dailyPledge: String = ""
    var morningCheckInTime: Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date()
    var eveningCheckInTime: Date = Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date()) ?? Date()
    var notificationsEnabled: Bool = true
    var startDate: Date = Date()
    var incomePerMonth: Int = 4000
}

enum SpendingWeakness: String, Codable, CaseIterable, Identifiable {
    case onlineShopping = "Online shopping (Amazon, TikTok Shop)"
    case eatingOut = "Eating out / delivery apps"
    case clothesFashion = "Clothes & fashion"
    case subscriptions = "Subscriptions I don't use"
    case impulseStores = "Impulse buys at stores"
    case entertainment = "Entertainment / going out"
    var id: String { rawValue }
}

enum ImpulseFrequency: String, Codable, CaseIterable, Identifiable {
    case daily = "Daily"
    case fewTimesWeek = "A few times a week"
    case weekly = "Weekly"
    case fewTimesMonth = "A few times a month"
    var id: String { rawValue }
}

enum IdentityOption: String, Codable, CaseIterable, Identifiable {
    case spendsIntentionally = "Spends intentionally, not impulsively"
    case savesForWhatMatters = "Saves for what truly matters"
    case doesntNeedStuff = "Doesn't need stuff to feel good"
    case inControl = "Is in complete control of their money"
    case buildsWealth = "Builds wealth instead of wasting it"
    var id: String { rawValue }
}

enum SavingsGoal: String, Codable, CaseIterable, Identifiable {
    case travel = "Travel & Experiences"
    case payOffDebt = "Pay Off Debt"
    case emergencyFund = "Emergency Fund"
    case bigPurchase = "Big Purchase"
    case investing = "Investing & Wealth"
    case stopWasting = "Just Stop Wasting Money"
    var id: String { rawValue }
}
