import SwiftUI

// MARK: - NoBuy Design System
// Dark mode only, premium feel — I Am Sober × Cash App

enum NoBuyTheme {
    // Colors
    static let background = Color(hex: "1A1A2E")
    static let cardBackground = Color(hex: "252540")
    static let primary = Color(hex: "00D09C")      // Mint green
    static let primaryMuted = Color(hex: "00D09C").opacity(0.8)
    static let textPrimary = Color(hex: "F5F5F5")
    static let textSecondary = Color(hex: "B0B0B0")
    static let gold = Color(hex: "FFD700")         // Milestones, confetti
    static let coral = Color(hex: "FF6B6B")        // Warnings, yearly waste
    static let coralMuted = Color(hex: "FF6B6B").opacity(0.9)
    
    // Typography
    static let largeTitle = Font.system(size: 28, weight: .bold)
    static let title = Font.system(size: 22, weight: .bold)
    static let title2 = Font.system(size: 20, weight: .semibold)
    static let headline = Font.system(size: 17, weight: .semibold)
    static let body = Font.system(size: 16, weight: .regular)
    static let callout = Font.system(size: 15, weight: .regular)
    static let caption = Font.system(size: 13, weight: .regular)
    
    // Hero streak counter
    static let streakFont = Font.system(size: 48, weight: .bold)
    static let streakFontLarge = Font.system(size: 56, weight: .bold)
    
    // Layout
    static let cardRadius: CGFloat = 16
    static let cardShadowRadius: CGFloat = 8
    static let cardShadowY: CGFloat = 4
    static let horizontalPadding: CGFloat = 24
    static let buttonHeight: CGFloat = 56
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
