import SwiftUI

struct MilestonesView: View {
    @EnvironmentObject var dataStore: DataStore
    
    private let milestones: [(days: Int, icon: String)] = [
        (1, "star.fill"),
        (3, "flame.fill"),
        (7, "leaf.fill"),
        (14, "bolt.fill"),
        (30, "crown.fill"),
        (60, "diamond.fill"),
        (90, "trophy.fill"),
        (180, "medal.fill"),
        (365, "gift.fill")
    ]
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            NoBuyTheme.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Your Trophy Case")
                        .font(NoBuyTheme.largeTitle)
                        .foregroundColor(NoBuyTheme.textPrimary)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(milestones, id: \.days) { days, icon in
                            MilestoneCard(
                                days: days,
                                icon: icon,
                                isUnlocked: dataStore.streakState.currentStreakDays >= days,
                                moneySavedAtMilestone: dataStore.dailyWasteRate * Double(days)
                            )
                        }
                    }
                }
                .padding(NoBuyTheme.horizontalPadding)
                .padding(.bottom, 48)
            }
        }
    }
}

struct MilestoneCard: View {
    let days: Int
    let icon: String
    let isUnlocked: Bool
    let moneySavedAtMilestone: Double
    @State private var showShare = false
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(isUnlocked ? NoBuyTheme.gold.opacity(0.3) : NoBuyTheme.cardBackground)
                    .frame(width: 64, height: 64)
                if isUnlocked {
                    Image(systemName: icon)
                        .font(.system(size: 28))
                        .foregroundColor(NoBuyTheme.gold)
                } else {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 24))
                        .foregroundColor(NoBuyTheme.textSecondary)
                }
            }
            Text("\(days) day\(days == 1 ? "" : "s")")
                .font(NoBuyTheme.caption)
                .foregroundColor(isUnlocked ? NoBuyTheme.textPrimary : NoBuyTheme.textSecondary)
            if isUnlocked {
                Text("$\(Int(moneySavedAtMilestone)) saved")
                    .font(NoBuyTheme.caption)
                    .foregroundColor(NoBuyTheme.primary)
                Button("Share") {
                    showShare = true
                }
                .font(NoBuyTheme.caption)
                .foregroundColor(NoBuyTheme.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(NoBuyTheme.cardBackground)
        .cornerRadius(NoBuyTheme.cardRadius)
        .opacity(isUnlocked ? 1 : 0.7)
    }
}
