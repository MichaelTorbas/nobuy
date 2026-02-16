import SwiftUI

struct OnboardingVisionView: View {
    @Binding var profile: UserProfile
    var onNext: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("What becomes possible when you stop wasting money?")
                    .font(NoBuyTheme.largeTitle)
                    .foregroundColor(NoBuyTheme.textPrimary)
                Text("This will be your personal motivation, shown to you daily.")
                    .font(NoBuyTheme.body)
                    .foregroundColor(NoBuyTheme.textSecondary)
                
                TextField("e.g., I'll finally take that trip to Japan...", text: $profile.visionText, axis: .vertical)
                    .font(NoBuyTheme.body)
                    .foregroundColor(NoBuyTheme.textPrimary)
                    .padding(16)
                    .lineLimit(4...8)
                    .background(NoBuyTheme.cardBackground)
                    .cornerRadius(NoBuyTheme.cardRadius)
                
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
