import SwiftUI

struct OnboardingDailyPledgeView: View {
    @Binding var profile: UserProfile
    var onNext: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Write your daily commitment")
                    .font(NoBuyTheme.largeTitle)
                    .foregroundColor(NoBuyTheme.textPrimary)
                Text("You'll see this every morning as a reminder.")
                    .font(NoBuyTheme.body)
                    .foregroundColor(NoBuyTheme.textSecondary)
                
                TextField("e.g., I only buy what I truly need today", text: $profile.dailyPledge, axis: .vertical)
                    .font(NoBuyTheme.body)
                    .foregroundColor(NoBuyTheme.textPrimary)
                    .padding(16)
                    .lineLimit(2...4)
                    .background(NoBuyTheme.cardBackground)
                    .cornerRadius(NoBuyTheme.cardRadius)
                
                Text("This pledge will appear in your daily check-in")
                    .font(NoBuyTheme.caption)
                    .foregroundColor(NoBuyTheme.textSecondary)
                
                Spacer(minLength: 24)
                
                Button(action: {
                    HapticManager.light()
                    onNext()
                }) {
                    Text("Next")
                        .font(NoBuyTheme.headline)
                        .foregroundColor(NoBuyTheme.background)
                        .frame(maxWidth: .infinity)
                        .frame(height: NoBuyTheme.buttonHeight)
                        .background(NoBuyTheme.primary)
                        .cornerRadius(NoBuyTheme.cardRadius)
                }
            }
            .padding(NoBuyTheme.horizontalPadding)
            .padding(.bottom, 48)
        }
    }
}
