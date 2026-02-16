import SwiftUI

struct ConfettiView: View {
    @State private var particles: [ConfettiParticle] = []
    @State private var animate = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(particles) { p in
                    Circle()
                        .fill(p.color)
                        .frame(width: p.size, height: p.size)
                        .position(
                            x: p.startX + (animate ? p.deltaX : 0),
                            y: p.startY + (animate ? geo.size.height : 0)
                        )
                        .opacity(animate ? 0 : 1)
                }
            }
            .onAppear {
                let colors: [Color] = [NoBuyTheme.gold, NoBuyTheme.primary, NoBuyTheme.coral, NoBuyTheme.textPrimary]
                particles = (0..<50).map { _ in
                    ConfettiParticle(
                        startX: CGFloat.random(in: 0...geo.size.width),
                        startY: CGFloat.random(in: 0...geo.size.height * 0.5),
                        deltaX: CGFloat.random(in: -80...80),
                        size: CGFloat.random(in: 4...10),
                        color: colors.randomElement() ?? NoBuyTheme.gold
                    )
                }
                withAnimation(.easeOut(duration: 2.0)) { animate = true }
            }
        }
    }
}

private struct ConfettiParticle: Identifiable {
    let id = UUID()
    let startX: CGFloat
    let startY: CGFloat
    let deltaX: CGFloat
    let size: CGFloat
    let color: Color
}
