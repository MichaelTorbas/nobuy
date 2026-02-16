import SwiftUI

struct OnboardingCompleteView: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var showConfetti = false
    
    var body: some View {
        ZStack {
            NoBuyTheme.background.ignoresSafeArea()
            VStack(spacing: 32) {
                Spacer()
                if showConfetti {
                    ConfettiView()
                        .allowsHitTesting(false)
                }
                Text("Welcome to Day 1")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(NoBuyTheme.textPrimary)
                if !dataStore.userProfile.dailyPledge.isEmpty {
                    Text(dataStore.userProfile.dailyPledge)
                        .font(NoBuyTheme.title2)
                        .foregroundColor(NoBuyTheme.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                Spacer()
                Button(action: {
                    HapticManager.success()
                    dataStore.completeOnboarding()
                    dataStore.updateStreak { state in
                        state.currentStreakStart = dataStore.userProfile.startDate
                    }
                }) {
                    Text("Start My Journey")
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
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) { showConfetti = true }
        }
    }
}
