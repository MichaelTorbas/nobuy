import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var showCheckIn = false
    @State private var showUrgeMode = false
    @State private var showConfetti = false
    
    private let milestones: [(days: Int, label: String)] = [
        (1, "1 day"), (3, "3 days"), (7, "7 days"), (14, "14 days"),
        (30, "30 days"), (60, "60 days"), (90, "90 days"), (180, "6 months"), (365, "1 year")
    ]
    
    var body: some View {
        ZStack {
            NoBuyTheme.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 24) {
                    if showConfetti {
                        ConfettiView()
                            .frame(height: 200)
                            .allowsHitTesting(false)
                    }
                    
                    StreakCounterView(streakStart: dataStore.streakState.currentStreakStart)
                    
                    MoneySavedView(amount: dataStore.moneySaved())
                    
                    if !dataStore.userProfile.dailyPledge.isEmpty {
                        pledgeCard
                    }
                    
                    Button(action: {
                        HapticManager.light()
                        showCheckIn = true
                    }) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Daily Check-In")
                                .font(NoBuyTheme.headline)
                        }
                        .foregroundColor(NoBuyTheme.background)
                        .frame(maxWidth: .infinity)
                        .frame(height: NoBuyTheme.buttonHeight)
                        .background(NoBuyTheme.primary)
                        .cornerRadius(NoBuyTheme.cardRadius)
                    }
                    .padding(.horizontal, NoBuyTheme.horizontalPadding)
                    
                    Button(action: {
                        HapticManager.medium()
                        showUrgeMode = true
                    }) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                            Text("Feeling an Urge?")
                                .font(NoBuyTheme.headline)
                        }
                        .foregroundColor(NoBuyTheme.coral)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(NoBuyTheme.background)
                        .overlay(
                            RoundedRectangle(cornerRadius: NoBuyTheme.cardRadius)
                                .stroke(NoBuyTheme.coral, lineWidth: 2)
                        )
                        .cornerRadius(NoBuyTheme.cardRadius)
                    }
                    .padding(.horizontal, NoBuyTheme.horizontalPadding)
                    
                    milestoneProgressSection
                }
                .padding(.vertical, 24)
            }
        }
        .sheet(isPresented: $showCheckIn) {
            DailyCheckInSheet(isPresented: $showCheckIn)
                .environmentObject(dataStore)
        }
        .fullScreenCover(isPresented: $showUrgeMode) {
            UrgeModeView(isPresented: $showUrgeMode)
                .environmentObject(dataStore)
        }
        .onAppear {
            if !UserDefaults.standard.bool(forKey: "nobuy_welcome_confetti_shown") {
                showConfetti = true
                UserDefaults.standard.set(true, forKey: "nobuy_welcome_confetti_shown")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    showConfetti = false
                }
            }
        }
    }
    
    private var pledgeCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Your pledge today")
                .font(NoBuyTheme.caption)
                .foregroundColor(NoBuyTheme.textSecondary)
            Text(dataStore.userProfile.dailyPledge)
                .font(NoBuyTheme.headline)
                .foregroundColor(NoBuyTheme.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(NoBuyTheme.cardBackground)
        .cornerRadius(NoBuyTheme.cardRadius)
        .shadow(color: .black.opacity(0.2), radius: NoBuyTheme.cardShadowRadius, y: NoBuyTheme.cardShadowY)
        .padding(.horizontal, NoBuyTheme.horizontalPadding)
    }
    
    private var milestoneProgressSection: some View {
        let current = dataStore.streakState.currentStreakDays
        let next = milestones.first { $0.days > current } ?? (days: 365, label: "1 year")
        let prev = milestones.last { $0.days <= current }
        let progress = prev.map { p in
            Double(current - p.days) / Double(next.days - p.days)
        } ?? Double(current) / Double(next.days)
        
        return VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Next milestone")
                    .font(NoBuyTheme.caption)
                    .foregroundColor(NoBuyTheme.textSecondary)
                Spacer()
                Text("\(current) of \(next.days) days")
                    .font(NoBuyTheme.caption)
                    .foregroundColor(NoBuyTheme.primary)
            }
            GeometryReader { g in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(NoBuyTheme.cardBackground)
                        .frame(height: 10)
                    RoundedRectangle(cornerRadius: 6)
                        .fill(NoBuyTheme.primary)
                        .frame(width: g.size.width * min(1, max(0, progress)), height: 10)
                }
            }
            .frame(height: 10)
            HStack {
                Image(systemName: "trophy.fill")
                    .foregroundColor(NoBuyTheme.gold)
                Text(next.label)
                    .font(NoBuyTheme.callout)
                    .foregroundColor(NoBuyTheme.textPrimary)
            }
        }
        .padding(20)
        .background(NoBuyTheme.cardBackground)
        .cornerRadius(NoBuyTheme.cardRadius)
        .padding(.horizontal, NoBuyTheme.horizontalPadding)
    }
    
}

// Live-ticking streak: days : hours : minutes : seconds (updates every second via TimelineView)
struct StreakCounterView: View {
    let streakStart: Date?
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: 1.0)) { context in
            let seconds = streakStart.map { context.date.timeIntervalSince($0) } ?? 0
            let s = max(0, Int(seconds))
            let days = s / 86400
            let hours = (s % 86400) / 3600
            let mins = (s % 3600) / 60
            let secs = s % 60
            VStack(spacing: 8) {
                Text("No-Spend Streak")
                    .font(NoBuyTheme.headline)
                    .foregroundColor(NoBuyTheme.textSecondary)
                HStack(spacing: 4) {
                    TimeUnit(value: days, label: "days")
                    Text(":")
                        .font(NoBuyTheme.streakFont)
                        .foregroundColor(NoBuyTheme.textPrimary)
                    TimeUnit(value: hours, label: "hours")
                    Text(":")
                        .font(NoBuyTheme.streakFont)
                        .foregroundColor(NoBuyTheme.textPrimary)
                    TimeUnit(value: mins, label: "min")
                    Text(":")
                        .font(NoBuyTheme.streakFont)
                        .foregroundColor(NoBuyTheme.textPrimary)
                    TimeUnit(value: secs, label: "sec")
                }
            }
            .padding(.vertical, 24)
        }
    }
}

private struct TimeUnit: View {
    let value: Int
    let label: String
    var body: some View {
        VStack(spacing: 2) {
            Text(String(format: "%02d", value))
                .font(NoBuyTheme.streakFont)
                .foregroundColor(NoBuyTheme.primary)
            Text(label)
                .font(NoBuyTheme.caption)
                .foregroundColor(NoBuyTheme.textSecondary)
        }
        .frame(minWidth: 56)
    }
}

struct MoneySavedView: View {
    let amount: Double
    @State private var displayed: Double = 0
    
    var body: some View {
        VStack(spacing: 4) {
            Text("Money saved")
                .font(NoBuyTheme.caption)
                .foregroundColor(NoBuyTheme.textSecondary)
            Text("$\(Int(displayed))")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(NoBuyTheme.primary)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) { displayed = amount }
        }
        .onChange(of: amount) { newValue in
            withAnimation(.easeOut(duration: 0.5)) { displayed = newValue }
        }
    }
}
