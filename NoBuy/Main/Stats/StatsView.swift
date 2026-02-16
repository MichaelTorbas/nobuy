import SwiftUI

struct StatsView: View {
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        ZStack {
            NoBuyTheme.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Your Stats")
                        .font(NoBuyTheme.largeTitle)
                        .foregroundColor(NoBuyTheme.textPrimary)
                    
                    VStack(spacing: 16) {
                        statCard(title: "Total money saved", value: "$\(Int(dataStore.moneySaved()))", color: NoBuyTheme.primary)
                        statCard(title: "Current streak", value: "\(dataStore.streakState.currentStreakDays) days", color: NoBuyTheme.primary)
                        statCard(title: "Longest streak", value: "\(dataStore.streakState.longestStreakDays) days", color: NoBuyTheme.textPrimary)
                        statCard(title: "Urges resisted", value: "\(dataStore.streakState.urgesResisted)", color: NoBuyTheme.gold)
                        statCard(title: "Check-ins completed", value: "\(dataStore.streakState.checkInsCompleted)", color: NoBuyTheme.textPrimary)
                    }
                    
                    Text("Monthly savings (last 6 months)")
                        .font(NoBuyTheme.headline)
                        .foregroundColor(NoBuyTheme.textPrimary)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(NoBuyTheme.cardBackground)
                        .frame(height: 120)
                        .overlay(
                            Text("Chart placeholder")
                                .foregroundColor(NoBuyTheme.textSecondary)
                        )
                    
                    Text("Spending trigger breakdown")
                        .font(NoBuyTheme.headline)
                        .foregroundColor(NoBuyTheme.textPrimary)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(NoBuyTheme.cardBackground)
                        .frame(height: 120)
                        .overlay(
                            Text("Pie chart placeholder")
                                .foregroundColor(NoBuyTheme.textSecondary)
                        )
                }
                .padding(NoBuyTheme.horizontalPadding)
                .padding(.bottom, 48)
            }
        }
    }
    
    private func statCard(title: String, value: String, color: Color) -> some View {
        HStack {
            Text(title)
                .font(NoBuyTheme.body)
                .foregroundColor(NoBuyTheme.textSecondary)
            Spacer()
            Text(value)
                .font(NoBuyTheme.title2)
                .foregroundColor(color)
        }
        .padding(20)
        .background(NoBuyTheme.cardBackground)
        .cornerRadius(NoBuyTheme.cardRadius)
    }
}
