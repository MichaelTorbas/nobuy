import SwiftUI

struct OnboardingContainerView: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var currentPage = 0
    private let totalPages = 16
    
    var body: some View {
        ZStack(alignment: .top) {
            NoBuyTheme.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                OnboardingProgressBar(progress: Double(currentPage + 1) / Double(totalPages))
                    .padding(.horizontal, NoBuyTheme.horizontalPadding)
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                
                TabView(selection: $currentPage) {
                    OnboardingWelcomeView(onNext: { currentPage = 1 }).tag(0)
                    OnboardingSpendingWeaknessView(profile: $dataStore.userProfile, onNext: { currentPage = 2 }).tag(1)
                    OnboardingFrequencyView(profile: $dataStore.userProfile, onNext: { currentPage = 3 }).tag(2)
                    OnboardingMonthlyWasteView(profile: $dataStore.userProfile, onNext: { currentPage = 4 }).tag(3)
                    OnboardingYearlyRevealView(profile: dataStore.userProfile, onNext: { currentPage = 5 }).tag(4)
                    OnboardingPainPointsView(onNext: { currentPage = 6 }).tag(5)
                    OnboardingIdentityView(profile: $dataStore.userProfile, onNext: { currentPage = 7 }).tag(6)
                    OnboardingSavingsGoalView(profile: $dataStore.userProfile, onNext: { currentPage = 8 }).tag(7)
                    OnboardingVisionView(profile: $dataStore.userProfile, onNext: { currentPage = 9 }).tag(8)
                    OnboardingDailyPledgeView(profile: $dataStore.userProfile, onNext: { currentPage = 10 }).tag(9)
                    OnboardingCheckInTimesView(profile: $dataStore.userProfile, onNext: { currentPage = 11 }).tag(10)
                    OnboardingStartDateView(profile: $dataStore.userProfile, onNext: { currentPage = 12 }).tag(11)
                    OnboardingSummaryView(profile: dataStore.userProfile, onNext: { currentPage = 13 }).tag(12)
                    OnboardingPaywallPlaceholderView(onNext: {
                        dataStore.markPaywallSeen()
                        dataStore.setSubscribed(true)
                        currentPage = 14
                    }).tag(13)
                    OnboardingNotificationPermissionView(onNext: { currentPage = 15 }).tag(14)
                    OnboardingCompleteView().tag(15)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 0.35), value: currentPage)
            }
        }
    }
}

struct OnboardingProgressBar: View {
    let progress: Double
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(NoBuyTheme.cardBackground)
                    .frame(height: 6)
                RoundedRectangle(cornerRadius: 4)
                    .fill(NoBuyTheme.primary)
                    .frame(width: geo.size.width * CGFloat(progress), height: 6)
                    .animation(.easeInOut(duration: 0.3), value: progress)
            }
        }
        .frame(height: 6)
    }
}
