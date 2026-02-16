import SwiftUI

struct OnboardingSavingsGoalView: View {
    @Binding var profile: UserProfile
    var onNext: () -> Void
    
    private let goals: [(SavingsGoal, String)] = [
        (.travel, "leaf.fill"),
        (.payOffDebt, "link"),
        (.emergencyFund, "banknote.fill"),
        (.bigPurchase, "car.fill"),
        (.investing, "chart.line.uptrend.xyaxis"),
        (.stopWasting, "dollarsign")
    ]
    private let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("What are you saving for?")
                    .font(NoBuyTheme.largeTitle)
                    .foregroundColor(NoBuyTheme.textPrimary)
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(goals, id: \.0.id) { goal, icon in
                        let isSelected = profile.savingsGoal == goal
                        Button {
                            HapticManager.light()
                            profile.savingsGoal = goal
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: icon)
                                    .font(.system(size: 32))
                                    .foregroundColor(isSelected ? NoBuyTheme.primary : NoBuyTheme.textSecondary)
                                Text(goal.rawValue)
                                    .font(NoBuyTheme.caption)
                                    .foregroundColor(NoBuyTheme.textPrimary)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 8)
                            .background(NoBuyTheme.cardBackground)
                            .cornerRadius(NoBuyTheme.cardRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: NoBuyTheme.cardRadius)
                                    .stroke(isSelected ? NoBuyTheme.primary : Color.clear, lineWidth: 2)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                Spacer(minLength: 24)
                
                Button(action: {
                    guard profile.savingsGoal != nil else { return }
                    HapticManager.light()
                    onNext()
                }) {
                    Text("Next")
                        .font(NoBuyTheme.headline)
                        .foregroundColor(NoBuyTheme.background)
                        .frame(maxWidth: .infinity)
                        .frame(height: NoBuyTheme.buttonHeight)
                        .background(profile.savingsGoal == nil ? NoBuyTheme.primary.opacity(0.5) : NoBuyTheme.primary)
                        .cornerRadius(NoBuyTheme.cardRadius)
                }
                .disabled(profile.savingsGoal == nil)
            }
            .padding(NoBuyTheme.horizontalPadding)
            .padding(.bottom, 48)
        }
    }
}
