import SwiftUI

struct OnboardingWelcomeView: View {
    var onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            Image(systemName: "leaf.circle.fill")
                .font(.system(size: 100))
                .foregroundStyle(NoBuyTheme.primary)
                .symbolEffect(.bounce, value: 1)
            
            VStack(spacing: 12) {
                Text("Ready to Take Control of Your Spending?")
                    .font(NoBuyTheme.largeTitle)
                    .foregroundColor(NoBuyTheme.textPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Text("You've already taken the biggest step — showing up.")
                    .font(NoBuyTheme.body)
                    .foregroundColor(NoBuyTheme.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            Button(action: {
                HapticManager.light()
                onNext()
            }) {
                Text("Let's Do This")
                    .font(NoBuyTheme.headline)
                    .foregroundColor(NoBuyTheme.background)
                    .frame(maxWidth: .infinity)
                    .frame(height: NoBuyTheme.buttonHeight)
                    .background(NoBuyTheme.primary)
                    .cornerRadius(NoBuyTheme.cardRadius)
            }
            .padding(.horizontal, NoBuyTheme.horizontalPadding)
            .padding(.bottom, 48)
        }
    }
}
