import SwiftUI

struct OnboardingStartDateView: View {
    @Binding var profile: UserProfile
    var onNext: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("When do you want to start?")
                    .font(NoBuyTheme.largeTitle)
                    .foregroundColor(NoBuyTheme.textPrimary)
                
                DatePicker("Start date", selection: $profile.startDate, in: Date()..., displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .tint(NoBuyTheme.primary)
                    .padding(16)
                    .background(NoBuyTheme.cardBackground)
                    .cornerRadius(NoBuyTheme.cardRadius)
                
                Text("Your spending-free journey begins now.")
                    .font(NoBuyTheme.body)
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
