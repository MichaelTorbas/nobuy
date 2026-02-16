import SwiftUI

struct UrgeModeView: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var isPresented: Bool
    @State private var phase: UrgePhase = .breathing
    @State private var breathScale: CGFloat = 0.8
    @State private var questionIndex = 0
    @State private var resisted = false
    
    private let questions: [String] = [
        "Do you NEED it or just WANT it?",
        "Will you care about this in 30 days?",
        "How many hours of work does this cost you?",
        "Is this aligned with your goal?",
        "What would future you think about this purchase?"
    ]
    
    var body: some View {
        ZStack {
            NoBuyTheme.background.ignoresSafeArea()
            switch phase {
            case .breathing:
                breathingView
            case .questions:
                questionsView
            case .result:
                resultView
            }
        }
    }
    
    private var breathingView: some View {
        VStack(spacing: 32) {
            Text("4-7-8 Breathing")
                .font(NoBuyTheme.title)
                .foregroundColor(NoBuyTheme.textPrimary)
            Text("Inhale 4 · Hold 7 · Exhale 8")
                .font(NoBuyTheme.callout)
                .foregroundColor(NoBuyTheme.textSecondary)
            ZStack {
                Circle()
                    .fill(NoBuyTheme.primary.opacity(0.3))
                    .frame(width: 180, height: 180)
                    .scaleEffect(breathScale)
                Circle()
                    .stroke(NoBuyTheme.primary, lineWidth: 3)
                    .frame(width: 180, height: 180)
                    .scaleEffect(breathScale)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                    breathScale = 1.25
                }
            }
            Button("Continue to questions") {
                phase = .questions
            }
            .font(NoBuyTheme.headline)
            .foregroundColor(NoBuyTheme.background)
            .frame(width: 220)
            .frame(height: 48)
            .background(NoBuyTheme.primary)
            .cornerRadius(NoBuyTheme.cardRadius)
            .padding(.top, 24)
        }
    }
    
    private var questionsView: some View {
        VStack(spacing: 28) {
            if questionIndex < questions.count {
                Text(questions[questionIndex])
                    .font(NoBuyTheme.title2)
                    .foregroundColor(NoBuyTheme.textPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                HStack(spacing: 20) {
                    Button("Yes / True") {
                        nextQuestion()
                    }
                    .font(NoBuyTheme.headline)
                    .foregroundColor(NoBuyTheme.background)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(NoBuyTheme.primary)
                    .cornerRadius(NoBuyTheme.cardRadius)
                    Button("No / False") {
                        nextQuestion()
                    }
                    .font(NoBuyTheme.headline)
                    .foregroundColor(NoBuyTheme.textPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(NoBuyTheme.cardBackground)
                    .cornerRadius(NoBuyTheme.cardRadius)
                }
                .padding(.horizontal, 24)
            } else {
                Text("You've got this.")
                    .font(NoBuyTheme.title)
                    .foregroundColor(NoBuyTheme.textPrimary)
                phase = .result
            }
        }
    }
    
    private var resultView: some View {
        VStack(spacing: 32) {
            Text("What did you decide?")
                .font(NoBuyTheme.title)
                .foregroundColor(NoBuyTheme.textPrimary)
            Button(action: {
                HapticManager.success()
                dataStore.updateStreak { $0.urgesResisted += 1 }
                resisted = true
                isPresented = false
            }) {
                HStack {
                    Text("I Resisted!")
                    Image(systemName: "hand.thumbsup.fill")
                }
                .font(NoBuyTheme.headline)
                .foregroundColor(NoBuyTheme.background)
                .frame(maxWidth: .infinity)
                .frame(height: NoBuyTheme.buttonHeight)
                .background(NoBuyTheme.primary)
                .cornerRadius(NoBuyTheme.cardRadius)
            }
            .padding(.horizontal, 24)
            Button("I bought it anyway") {
                isPresented = false
            }
            .font(NoBuyTheme.callout)
            .foregroundColor(NoBuyTheme.textSecondary)
        }
    }
    
    private func nextQuestion() {
        if questionIndex < questions.count - 1 {
            questionIndex += 1
        } else {
            phase = .result
        }
    }
}

private enum UrgePhase {
    case breathing, questions, result
}
