import SwiftUI

struct OnboardingSpendingWeaknessView: View {
    @Binding var profile: UserProfile
    var onNext: () -> Void
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("What's your spending weakness?")
                    .font(NoBuyTheme.largeTitle)
                    .foregroundColor(NoBuyTheme.textPrimary)
                Text("Select all that apply — no judgment.")
                    .font(NoBuyTheme.body)
                    .foregroundColor(NoBuyTheme.textSecondary)
                
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(SpendingWeakness.allCases) { weakness in
                        let isSelected = profile.spendingWeaknesses.contains(weakness)
                        Button {
                            HapticManager.light()
                            if isSelected {
                                profile.spendingWeaknesses.remove(weakness)
                            } else {
                                profile.spendingWeaknesses.insert(weakness)
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(isSelected ? NoBuyTheme.primary : NoBuyTheme.textSecondary)
                                Text(weakness.rawValue)
                                    .font(NoBuyTheme.callout)
                                    .foregroundColor(NoBuyTheme.textPrimary)
                                    .multilineTextAlignment(.leading)
                                Spacer(minLength: 0)
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
                    guard !profile.spendingWeaknesses.isEmpty else { return }
                    HapticManager.light()
                    onNext()
                }) {
                    Text("Next")
                        .font(NoBuyTheme.headline)
                        .foregroundColor(NoBuyTheme.background)
                        .frame(maxWidth: .infinity)
                        .frame(height: NoBuyTheme.buttonHeight)
                        .background(profile.spendingWeaknesses.isEmpty ? NoBuyTheme.primary.opacity(0.5) : NoBuyTheme.primary)
                        .cornerRadius(NoBuyTheme.cardRadius)
                }
                .disabled(profile.spendingWeaknesses.isEmpty)
            }
            .padding(NoBuyTheme.horizontalPadding)
            .padding(.bottom, 48)
        }
    }
}
