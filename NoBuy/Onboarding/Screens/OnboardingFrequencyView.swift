import SwiftUI

struct OnboardingFrequencyView: View {
    @Binding var profile: UserProfile
    var onNext: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("How often do you impulse buy?")
                    .font(NoBuyTheme.largeTitle)
                    .foregroundColor(NoBuyTheme.textPrimary)
                
                VStack(spacing: 12) {
                    ForEach(ImpulseFrequency.allCases) { freq in
                        let isSelected = profile.impulseFrequency == freq
                        Button {
                            HapticManager.light()
                            profile.impulseFrequency = freq
                        } label: {
                            HStack {
                                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(isSelected ? NoBuyTheme.primary : NoBuyTheme.textSecondary)
                                Text(freq.rawValue)
                                    .font(NoBuyTheme.headline)
                                    .foregroundColor(NoBuyTheme.textPrimary)
                                Spacer()
                            }
                            .padding(16)
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
                    guard profile.impulseFrequency != nil else { return }
                    HapticManager.light()
                    onNext()
                }) {
                    Text("Next")
                        .font(NoBuyTheme.headline)
                        .foregroundColor(NoBuyTheme.background)
                        .frame(maxWidth: .infinity)
                        .frame(height: NoBuyTheme.buttonHeight)
                        .background(profile.impulseFrequency == nil ? NoBuyTheme.primary.opacity(0.5) : NoBuyTheme.primary)
                        .cornerRadius(NoBuyTheme.cardRadius)
                }
                .disabled(profile.impulseFrequency == nil)
            }
            .padding(NoBuyTheme.horizontalPadding)
            .padding(.bottom, 48)
        }
    }
}
