import SwiftUI

struct OnboardingMonthlyWasteView: View {
    @Binding var profile: UserProfile
    var onNext: () -> Void
    
    private var yearlyAmount: Int { profile.monthlyWasteEstimate * 12 }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text("How much do you spend monthly on things you don't need?")
                    .font(NoBuyTheme.largeTitle)
                    .foregroundColor(NoBuyTheme.textPrimary)
                
                VStack(spacing: 16) {
                    Text("$\(profile.monthlyWasteEstimate)")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(NoBuyTheme.primary)
                    Slider(value: Binding(
                        get: { Double(profile.monthlyWasteEstimate) },
                        set: { profile.monthlyWasteEstimate = Int($0) }
                    ), in: 10...500, step: 10)
                    .tint(NoBuyTheme.primary)
                    HStack {
                        Text("$10")
                            .font(NoBuyTheme.caption)
                            .foregroundColor(NoBuyTheme.textSecondary)
                        Spacer()
                        Text("$500+")
                            .font(NoBuyTheme.caption)
                            .foregroundColor(NoBuyTheme.textSecondary)
                    }
                }
                .padding(20)
                .background(NoBuyTheme.cardBackground)
                .cornerRadius(NoBuyTheme.cardRadius)
                
                Text("That's **$\(yearlyAmount)** per year")
                    .font(NoBuyTheme.title2)
                    .foregroundColor(NoBuyTheme.textPrimary)
                
                Text("Most people underestimate this. The average American wastes $250/month on impulse buys.")
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
