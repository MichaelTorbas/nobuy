import SwiftUI

struct OnboardingCheckInTimesView: View {
    @Binding var profile: UserProfile
    var onNext: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Set Your Daily Check-Ins")
                    .font(NoBuyTheme.largeTitle)
                    .foregroundColor(NoBuyTheme.textPrimary)
                
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "sunrise.fill")
                            .foregroundColor(NoBuyTheme.gold)
                        Text("Morning Pledge")
                            .font(NoBuyTheme.headline)
                            .foregroundColor(NoBuyTheme.textPrimary)
                        Spacer()
                        DatePicker("", selection: $profile.morningCheckInTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .tint(NoBuyTheme.primary)
                    }
                    .padding(16)
                    .background(NoBuyTheme.cardBackground)
                    .cornerRadius(NoBuyTheme.cardRadius)
                    Text("Start your day with intention")
                        .font(NoBuyTheme.caption)
                        .foregroundColor(NoBuyTheme.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Image(systemName: "moon.fill")
                            .foregroundColor(NoBuyTheme.primary)
                        Text("Evening Review")
                            .font(NoBuyTheme.headline)
                            .foregroundColor(NoBuyTheme.textPrimary)
                        Spacer()
                        DatePicker("", selection: $profile.eveningCheckInTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .tint(NoBuyTheme.primary)
                    }
                    .padding(16)
                    .background(NoBuyTheme.cardBackground)
                    .cornerRadius(NoBuyTheme.cardRadius)
                    Text("Reflect on your spending today")
                        .font(NoBuyTheme.caption)
                        .foregroundColor(NoBuyTheme.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Toggle(isOn: $profile.notificationsEnabled) {
                        Text("Push notifications")
                            .font(NoBuyTheme.headline)
                            .foregroundColor(NoBuyTheme.textPrimary)
                    }
                    .tint(NoBuyTheme.primary)
                    .padding(16)
                    .background(NoBuyTheme.cardBackground)
                    .cornerRadius(NoBuyTheme.cardRadius)
                }
                
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
