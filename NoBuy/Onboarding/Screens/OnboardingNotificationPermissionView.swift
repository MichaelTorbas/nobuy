import SwiftUI
import UserNotifications

struct OnboardingNotificationPermissionView: View {
    var onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 28) {
            Spacer()
            Image(systemName: "bell.badge.fill")
                .font(.system(size: 72))
                .foregroundColor(NoBuyTheme.primary)
            
            Text("Turn on reminders to stay on track")
                .font(NoBuyTheme.largeTitle)
                .foregroundColor(NoBuyTheme.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Users with reminders are 3x more likely to hit 30 days")
                .font(NoBuyTheme.body)
                .foregroundColor(NoBuyTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                HapticManager.light()
                requestNotificationPermission()
                onNext()
            }) {
                Text("Enable Notifications")
                    .font(NoBuyTheme.headline)
                    .foregroundColor(NoBuyTheme.background)
                    .frame(maxWidth: .infinity)
                    .frame(height: NoBuyTheme.buttonHeight)
                    .background(NoBuyTheme.primary)
                    .cornerRadius(NoBuyTheme.cardRadius)
            }
            .padding(.horizontal, NoBuyTheme.horizontalPadding)
            
            Button("Maybe Later") {
                onNext()
            }
            .font(NoBuyTheme.callout)
            .foregroundColor(NoBuyTheme.textSecondary)
            .padding(.bottom, 48)
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
    }
}
