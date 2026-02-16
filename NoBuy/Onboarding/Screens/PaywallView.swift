import SwiftUI

// Full paywall shown after onboarding (and from RootView when !hasSeenPaywall && !isSubscribed)
struct PaywallView: View {
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            NoBuyTheme.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 24) {
                    HStack {
                        Spacer()
                        Button("Restore") {
                            // Placeholder: RevenueCat/Superwall restore
                            dataStore.setSubscribed(true)
                            dataStore.markPaywallSeen()
                        }
                        .font(NoBuyTheme.caption)
                        .foregroundColor(NoBuyTheme.textSecondary)
                        .padding(.top, 8)
                    }
                    
                    Text("Start Your Free Trial")
                        .font(NoBuyTheme.largeTitle)
                        .foregroundColor(NoBuyTheme.textPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text("Join 12,000+ others taking control of their spending")
                        .font(NoBuyTheme.callout)
                        .foregroundColor(NoBuyTheme.primary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(NoBuyTheme.primary.opacity(0.2))
                        .cornerRadius(8)
                    
                    HStack(spacing: 4) {
                        ForEach(0..<5, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(NoBuyTheme.gold)
                        }
                        Text("4.9")
                            .font(NoBuyTheme.headline)
                            .foregroundColor(NoBuyTheme.textPrimary)
                    }
                    
                    Text("I saved $2,400 in my first 3 months — this app changed my relationship with money.")
                        .font(NoBuyTheme.callout)
                        .foregroundColor(NoBuyTheme.textSecondary)
                        .italic()
                        .padding(16)
                        .background(NoBuyTheme.cardBackground)
                        .cornerRadius(NoBuyTheme.cardRadius)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        featureRow("No-spend streak tracker")
                        featureRow("Real-time savings calculator")
                        featureRow("Daily check-ins with personal pledge")
                        featureRow("Urge-resistance tools")
                        featureRow("Milestone rewards & trophies")
                        featureRow("Spending trigger insights")
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(NoBuyTheme.cardBackground)
                    .cornerRadius(NoBuyTheme.cardRadius)
                    
                    HStack(spacing: 12) {
                        planCard(title: "Weekly", price: "$4.99/week", selected: false)
                        planCard(title: "Yearly", price: "$24.99/year", subtitle: "Best Value", selected: true)
                    }
                    
                    Button(action: {
                        HapticManager.medium()
                        dataStore.setSubscribed(true)
                        dataStore.markPaywallSeen()
                    }) {
                        Text("Try for $0.00")
                            .font(NoBuyTheme.headline)
                            .foregroundColor(NoBuyTheme.background)
                            .frame(maxWidth: .infinity)
                            .frame(height: NoBuyTheme.buttonHeight)
                            .background(NoBuyTheme.primary)
                            .cornerRadius(NoBuyTheme.cardRadius)
                    }
                    
                    Text("7-day free trial, then $24.99/year. Cancel anytime.")
                        .font(NoBuyTheme.caption)
                        .foregroundColor(NoBuyTheme.textSecondary)
                        .multilineTextAlignment(.center)
                    
                    Button("View all plans") { }
                        .font(NoBuyTheme.callout)
                        .foregroundColor(NoBuyTheme.primary)
                }
                .padding(NoBuyTheme.horizontalPadding)
                .padding(.bottom, 48)
            }
        }
    }
    
    private func featureRow(_ text: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(NoBuyTheme.primary)
            Text(text)
                .font(NoBuyTheme.body)
                .foregroundColor(NoBuyTheme.textPrimary)
        }
    }
    
    private func planCard(title: String, price: String, subtitle: String? = nil, selected: Bool) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            if let sub = subtitle {
                Text(sub)
                    .font(NoBuyTheme.caption)
                    .foregroundColor(NoBuyTheme.primary)
            }
            Text(title)
                .font(NoBuyTheme.caption)
                .foregroundColor(NoBuyTheme.textSecondary)
            Text(price)
                .font(NoBuyTheme.headline)
                .foregroundColor(NoBuyTheme.textPrimary)
            if title == "Yearly" {
                Text("$2.08/month")
                    .font(NoBuyTheme.caption)
                    .foregroundColor(NoBuyTheme.textSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(selected ? NoBuyTheme.primary.opacity(0.15) : NoBuyTheme.cardBackground)
        .cornerRadius(NoBuyTheme.cardRadius)
        .overlay(
            RoundedRectangle(cornerRadius: NoBuyTheme.cardRadius)
                .stroke(selected ? NoBuyTheme.primary : Color.clear, lineWidth: 2)
        )
    }
}

// Shown inside onboarding flow (screen 14) — same content but advances to notification screen
struct OnboardingPaywallPlaceholderView: View {
    var onNext: () -> Void
    
    var body: some View {
        PaywallContentForOnboarding(onNext: onNext)
    }
}

struct PaywallContentForOnboarding: View {
    var onNext: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            NoBuyTheme.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        Button("Restore") { onNext() }
                            .font(NoBuyTheme.caption)
                            .foregroundColor(NoBuyTheme.textSecondary)
                            .padding(.top, 8)
                    }
                    Text("Start Your Free Trial")
                        .font(NoBuyTheme.largeTitle)
                        .foregroundColor(NoBuyTheme.textPrimary)
                    Text("Join 12,000+ others taking control of their spending")
                        .font(NoBuyTheme.callout)
                        .foregroundColor(NoBuyTheme.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(NoBuyTheme.primary.opacity(0.2))
                        .cornerRadius(8)
                    HStack(spacing: 4) {
                        ForEach(0..<5, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(NoBuyTheme.gold)
                        }
                        Text("4.9")
                            .font(NoBuyTheme.headline)
                            .foregroundColor(NoBuyTheme.textPrimary)
                    }
                    Text("I saved $2,400 in my first 3 months — this app changed my relationship with money.")
                        .font(NoBuyTheme.callout)
                        .foregroundColor(NoBuyTheme.textSecondary)
                        .italic()
                        .padding(12)
                        .background(NoBuyTheme.cardBackground)
                        .cornerRadius(NoBuyTheme.cardRadius)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(NoBuyTheme.primary)
                            Text("No-spend streak tracker")
                                .font(NoBuyTheme.body)
                                .foregroundColor(NoBuyTheme.textPrimary)
                        }
                        HStack(spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(NoBuyTheme.primary)
                            Text("Daily check-ins with personal pledge")
                                .font(NoBuyTheme.body)
                                .foregroundColor(NoBuyTheme.textPrimary)
                        }
                        HStack(spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(NoBuyTheme.primary)
                            Text("Urge-resistance tools & milestones")
                                .font(NoBuyTheme.body)
                                .foregroundColor(NoBuyTheme.textPrimary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(NoBuyTheme.cardBackground)
                    .cornerRadius(NoBuyTheme.cardRadius)
                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Weekly")
                                .font(NoBuyTheme.caption)
                                .foregroundColor(NoBuyTheme.textSecondary)
                            Text("$4.99/week")
                                .font(NoBuyTheme.headline)
                                .foregroundColor(NoBuyTheme.textPrimary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                        .background(NoBuyTheme.cardBackground)
                        .cornerRadius(NoBuyTheme.cardRadius)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Best Value")
                                .font(NoBuyTheme.caption)
                                .foregroundColor(NoBuyTheme.primary)
                            Text("Yearly")
                                .font(NoBuyTheme.caption)
                                .foregroundColor(NoBuyTheme.textSecondary)
                            Text("$24.99/year")
                                .font(NoBuyTheme.headline)
                                .foregroundColor(NoBuyTheme.textPrimary)
                            Text("$2.08/month")
                                .font(NoBuyTheme.caption)
                                .foregroundColor(NoBuyTheme.textSecondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                        .background(NoBuyTheme.primary.opacity(0.15))
                        .cornerRadius(NoBuyTheme.cardRadius)
                        .overlay(
                            RoundedRectangle(cornerRadius: NoBuyTheme.cardRadius)
                                .stroke(NoBuyTheme.primary, lineWidth: 2)
                        )
                    }
                    Button(action: {
                        HapticManager.medium()
                        onNext()
                    }) {
                        Text("Try for $0.00")
                            .font(NoBuyTheme.headline)
                            .foregroundColor(NoBuyTheme.background)
                            .frame(maxWidth: .infinity)
                            .frame(height: NoBuyTheme.buttonHeight)
                            .background(NoBuyTheme.primary)
                            .cornerRadius(NoBuyTheme.cardRadius)
                    }
                    Text("7-day free trial, then $24.99/year. Cancel anytime.")
                        .font(NoBuyTheme.caption)
                        .foregroundColor(NoBuyTheme.textSecondary)
                }
                .padding(NoBuyTheme.horizontalPadding)
                .padding(.bottom, 48)
            }
        }
    }
}
