import SwiftUI

struct OnboardingYearlyRevealView: View {
    let profile: UserProfile
    var onNext: () -> Void
    
    @State private var showButton = false
    @State private var shake = false
    private var yearlyAmount: Int { profile.monthlyWasteEstimate * 12 }
    
    var body: some View {
        VStack(spacing: 28) {
            Spacer()
            Text("Here's What Your Impulse Buying Really Costs")
                .font(NoBuyTheme.largeTitle)
                .foregroundColor(NoBuyTheme.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("$\(yearlyAmount) PER YEAR")
                .font(.system(size: 42, weight: .bold))
                .foregroundColor(NoBuyTheme.coral)
                .offset(x: shake ? -4 : 0)
                .animation(.default.repeatCount(3, autoreverses: true).speed(6), value: shake)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { shake = true }
                }
            
            Text("That's a vacation. A down payment. Your freedom.")
                .font(NoBuyTheme.title2)
                .foregroundColor(NoBuyTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            
            Spacer()
            
            if showButton {
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
                .padding(.horizontal, NoBuyTheme.horizontalPadding)
                .padding(.bottom, 48)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeOut(duration: 0.4)) { showButton = true }
            }
        }
    }
}
