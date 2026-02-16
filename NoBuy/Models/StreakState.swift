import Foundation

// MARK: - Streak, check-ins, urges

struct StreakState: Codable {
    var currentStreakStart: Date?
    var lastCheckInDate: Date?
    var totalMoneySaved: Double = 0
    var urgesResisted: Int = 0
    var checkInsCompleted: Int = 0
    var slipLogs: [SlipLog] = []
    var checkInHistory: [CheckInRecord] = []
    
    var currentStreakDays: Int {
        guard let start = currentStreakStart else { return 0 }
        let calendar = Calendar.current
        let days = calendar.dateComponents([.day], from: calendar.startOfDay(for: start), to: calendar.startOfDay(for: Date())).day ?? 0
        return max(0, days)
    }
    
    var longestStreakDays: Int {
        // Simplified: use current if no history yet
        return max(currentStreakDays, 0)
    }
}

struct SlipLog: Codable, Identifiable {
    let id: UUID
    let date: Date
    let trigger: SlipTrigger?
    let amountSpent: Double?
    
    init(id: UUID = UUID(), date: Date = Date(), trigger: SlipTrigger? = nil, amountSpent: Double? = nil) {
        self.id = id
        self.date = date
        self.trigger = trigger
        self.amountSpent = amountSpent
    }
}

enum SlipTrigger: String, Codable, CaseIterable, Identifiable {
    case boredom = "Boredom"
    case stress = "Stress"
    case socialMedia = "Social media ad"
    case dealSale = "Saw a deal/sale"
    case emotionalComfort = "Emotional comfort"
    case peerPressure = "Peer pressure"
    case other = "Other"
    var id: String { rawValue }
}

struct CheckInRecord: Codable, Identifiable {
    let id: UUID
    let date: Date
    let isMorning: Bool
    let didImpulseBuy: Bool?
    let mood: Mood?
    
    init(id: UUID = UUID(), date: Date = Date(), isMorning: Bool, didImpulseBuy: Bool? = nil, mood: Mood? = nil) {
        self.id = id
        self.date = date
        self.isMorning = isMorning
        self.didImpulseBuy = didImpulseBuy
        self.mood = mood
    }
}

enum Mood: String, Codable, CaseIterable, Identifiable {
    case happy = "😊"
    case neutral = "😐"
    case stressed = "😰"
    case frustrated = "😤"
    case proud = "🥳"
    var id: String { rawValue }
}
