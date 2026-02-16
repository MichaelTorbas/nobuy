import SwiftUI

struct DailyCheckInSheet: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var isPresented: Bool
    @State private var isMorning = true
    @State private var didImpulseBuy: Bool?
    @State private var selectedTrigger: SlipTrigger?
    @State private var amountSpent: String = ""
    @State private var selectedMood: Mood?
    @State private var showCelebration = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                NoBuyTheme.background.ignoresSafeArea()
                if showCelebration {
                    VStack(spacing: 16) {
                        Text("Amazing!")
                            .font(NoBuyTheme.title)
                            .foregroundColor(NoBuyTheme.primary)
                        Text("That's $\(Int(dataStore.dailyWasteRate)) saved today. Keep it going!")
                            .font(NoBuyTheme.headline)
                            .foregroundColor(NoBuyTheme.textPrimary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(32)
                    .frame(maxWidth: .infinity)
                    .background(NoBuyTheme.cardBackground.opacity(0.95))
                    .cornerRadius(NoBuyTheme.cardRadius)
                    .padding(.horizontal, 24)
                    .zIndex(1)
                    ConfettiView()
                        .allowsHitTesting(false)
                }
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        if !dataStore.userProfile.dailyPledge.isEmpty {
                            Text(dataStore.userProfile.dailyPledge)
                                .font(NoBuyTheme.title2)
                                .foregroundColor(NoBuyTheme.textPrimary)
                                .padding(16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(NoBuyTheme.cardBackground)
                                .cornerRadius(NoBuyTheme.cardRadius)
                        }
                        
                        Toggle("Morning check-in", isOn: $isMorning)
                            .tint(NoBuyTheme.primary)
                            .foregroundColor(NoBuyTheme.textPrimary)
                        
                        if isMorning {
                            Text("What's your commitment today?")
                                .font(NoBuyTheme.headline)
                                .foregroundColor(NoBuyTheme.textPrimary)
                            Button(action: {
                                HapticManager.success()
                                dataStore.updateStreak { _ in }
                                isPresented = false
                            }) {
                                Text("I'm ready for a no-spend day")
                                    .font(NoBuyTheme.headline)
                                    .foregroundColor(NoBuyTheme.background)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: NoBuyTheme.buttonHeight)
                                    .background(NoBuyTheme.primary)
                                    .cornerRadius(NoBuyTheme.cardRadius)
                            }
                        } else {
                            Text("Did you impulse buy today?")
                                .font(NoBuyTheme.headline)
                                .foregroundColor(NoBuyTheme.textPrimary)
                            HStack(spacing: 16) {
                                Button("No") {
                                    HapticManager.success()
                                    didImpulseBuy = false
                                    showCelebration = true
                                    dataStore.updateStreak { state in
                                        state.checkInsCompleted += 1
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                        isPresented = false
                                    }
                                }
                                .font(NoBuyTheme.headline)
                                .foregroundColor(NoBuyTheme.background)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(NoBuyTheme.primary)
                                .cornerRadius(NoBuyTheme.cardRadius)
                            Button("Yes") {
                                didImpulseBuy = true
                            }
                                .font(NoBuyTheme.headline)
                                .foregroundColor(NoBuyTheme.coral)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(NoBuyTheme.cardBackground)
                                .overlay(
                                    RoundedRectangle(cornerRadius: NoBuyTheme.cardRadius)
                                        .stroke(NoBuyTheme.coral, lineWidth: 2)
                                )
                                .cornerRadius(NoBuyTheme.cardRadius)
                            }
                            
                            if didImpulseBuy == true {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("What triggered it?")
                                        .font(NoBuyTheme.callout)
                                        .foregroundColor(NoBuyTheme.textPrimary)
                                    ForEach(SlipTrigger.allCases) { trigger in
                                        Button(action: { selectedTrigger = trigger }) {
                                            HStack {
                                                Text(trigger.rawValue)
                                                    .foregroundColor(NoBuyTheme.textPrimary)
                                                Spacer()
                                                if selectedTrigger == trigger {
                                                    Image(systemName: "checkmark.circle.fill")
                                                        .foregroundColor(NoBuyTheme.primary)
                                                }
                                            }
                                            .padding(12)
                                            .background(NoBuyTheme.cardBackground)
                                            .cornerRadius(8)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                    TextField("Amount spent (optional)", text: $amountSpent)
                                        .keyboardType(.decimalPad)
                                        .padding(12)
                                        .background(NoBuyTheme.cardBackground)
                                        .cornerRadius(8)
                                        .foregroundColor(NoBuyTheme.textPrimary)
                                }
                                
                                Text("It's okay — every day is a fresh start. You've still saved $\(Int(dataStore.moneySaved())) total.")
                                    .font(NoBuyTheme.caption)
                                    .foregroundColor(NoBuyTheme.textSecondary)
                                
                                Button("Done") {
                                    dataStore.updateStreak { state in
                                        state.currentStreakStart = nil
                                        state.slipLogs.append(SlipLog(
                                            trigger: selectedTrigger,
                                            amountSpent: amountSpent.isEmpty ? nil : Double(amountSpent)
                                        ))
                                    }
                                    isPresented = false
                                }
                                .font(NoBuyTheme.headline)
                                .foregroundColor(NoBuyTheme.primary)
                            }
                        }
                        
                        Text("How are you feeling?")
                            .font(NoBuyTheme.callout)
                            .foregroundColor(NoBuyTheme.textSecondary)
                        HStack(spacing: 12) {
                            ForEach(Mood.allCases) { mood in
                                Button(action: { selectedMood = mood }) {
                                    Text(mood.rawValue)
                                        .font(.title)
                                }
                                .buttonStyle(.plain)
                                .opacity(selectedMood == mood ? 1 : 0.6)
                            }
                        }
                    }
                    .padding(NoBuyTheme.horizontalPadding)
                    .padding(.bottom, 48)
                }
            }
            .navigationTitle("Daily Check-In")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(NoBuyTheme.background, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { isPresented = false }
                        .foregroundColor(NoBuyTheme.primary)
                }
            }
        }
    }
}
