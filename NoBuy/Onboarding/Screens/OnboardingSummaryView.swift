import SwiftUI

struct OnboardingSummaryView: View {
    let profile: UserProfile
    var onNext: () -> Void
    
    private var yearlyAmount: Int { profile.monthlyWasteEstimate * 12 }
    private var saved30Days: Int { profile.monthlyWasteEstimate }
    
    private let checks = [
        "Identified your spending triggers",
        "Calculated your yearly waste",
        "Chose your new identity",
        "Set your savings goal",
        "Wrote your personal vision",
        "Created your daily pledge",
        "Set your start date"
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Look What You Just Built!")
                    .font(NoBuyTheme.largeTitle)
                    .foregroundColor(NoBuyTheme.textPrimary)
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(Array(checks.enumerated()), id: \.offset) { _, text in
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(NoBuyTheme.primary)
                            Text(text == "Calculated your yearly waste" ? "Calculated your yearly waste ($\(yearlyAmount))" : text)
                                .font(NoBuyTheme.body)
                                .foregroundColor(NoBuyTheme.textPrimary)
                        }
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(NoBuyTheme.cardBackground)
                .cornerRadius(NoBuyTheme.cardRadius)
                
                Text("Your personalized NoBuy plan is ready.")
                    .font(NoBuyTheme.headline)
                    .foregroundColor(NoBuyTheme.textSecondary)
                
                HStack(spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("30 days")
                            .font(NoBuyTheme.caption)
                            .foregroundColor(NoBuyTheme.textSecondary)
                        Text("$\(saved30Days)")
                            .font(NoBuyTheme.title2)
                            .foregroundColor(NoBuyTheme.primary)
                    }
                    Text("|")
                        .foregroundColor(NoBuyTheme.textSecondary)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("1 year")
                            .font(NoBuyTheme.caption)
                            .foregroundColor(NoBuyTheme.textSecondary)
                        Text("$\(yearlyAmount)")
                            .font(NoBuyTheme.title2)
                            .foregroundColor(NoBuyTheme.primary)
                    }
                    Spacer()
                }
                .padding(16)
                .background(NoBuyTheme.cardBackground)
                .cornerRadius(NoBuyTheme.cardRadius)
                
                Text("Estimated savings in 30 days: $\(saved30Days) · In 1 year: $\(yearlyAmount)")
                    .font(NoBuyTheme.caption)
                    .foregroundColor(NoBuyTheme.textSecondary)
                
                Spacer(minLength: 24)
                
                Button(action: {
                    HapticManager.light()
                    onNext()
                }) {
                    Text("See My Plan")
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
