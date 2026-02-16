import SwiftUI

struct OnboardingIdentityView: View {
    @Binding var profile: UserProfile
    var onNext: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("I see myself as someone who...")
                    .font(NoBuyTheme.largeTitle)
                    .foregroundColor(NoBuyTheme.textPrimary)
                Text("Choose what resonates most")
                    .font(NoBuyTheme.body)
                    .foregroundColor(NoBuyTheme.textSecondary)
                
                VStack(spacing: 12) {
                    ForEach(IdentityOption.allCases) { option in
                        let isSelected = profile.identityChoice == option
                        Button {
                            HapticManager.light()
                            profile.identityChoice = option
                        } label: {
                            HStack {
                                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(isSelected ? NoBuyTheme.primary : NoBuyTheme.textSecondary)
                                Text(option.rawValue)
                                    .font(NoBuyTheme.callout)
                                    .foregroundColor(NoBuyTheme.textPrimary)
                                    .multilineTextAlignment(.leading)
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
                    guard profile.identityChoice != nil else { return }
                    HapticManager.light()
                    onNext()
                }) {
                    Text("Next")
                        .font(NoBuyTheme.headline)
                        .foregroundColor(NoBuyTheme.background)
                        .frame(maxWidth: .infinity)
                        .frame(height: NoBuyTheme.buttonHeight)
                        .background(profile.identityChoice == nil ? NoBuyTheme.primary.opacity(0.5) : NoBuyTheme.primary)
                        .cornerRadius(NoBuyTheme.cardRadius)
                }
                .disabled(profile.identityChoice == nil)
            }
            .padding(NoBuyTheme.horizontalPadding)
            .padding(.bottom, 48)
        }
    }
}
