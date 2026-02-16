import SwiftUI

struct OnboardingPainPointsView: View {
    var onNext: () -> Void
    
    private let items = [
        "Buyer's remorse after almost every purchase",
        "Hiding purchases from partner or family",
        "Anxiety when checking your bank balance",
        "Using shopping as emotional comfort",
        "Packages arriving you forgot you ordered"
    ]
    @State private var visibleCount = 0
    @State private var showNext = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Do any of these sound familiar?")
                .font(NoBuyTheme.largeTitle)
                .foregroundColor(NoBuyTheme.textPrimary)
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    if index < visibleCount {
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(NoBuyTheme.primary)
                            Text(item)
                                .font(NoBuyTheme.body)
                                .foregroundColor(NoBuyTheme.textPrimary)
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(NoBuyTheme.cardBackground)
                        .cornerRadius(NoBuyTheme.cardRadius)
                        .transition(.opacity.combined(with: .move(edge: .leading)))
                    }
                }
            }
            
            Spacer()
            
            if showNext {
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
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .padding(NoBuyTheme.horizontalPadding)
        .padding(.bottom, 48)
        .onAppear {
            for i in 1...items.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.35) {
                    withAnimation(.easeOut(duration: 0.3)) { visibleCount = i }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(items.count) * 0.35 + 0.5) {
                withAnimation(.easeOut(duration: 0.3)) { showNext = true }
            }
        }
    }
}
