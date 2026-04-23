import SwiftUI

enum AgentBeatsPalette {
    static let background = Color(red: 0.03, green: 0.04, blue: 0.08)
    static let panel = Color.white.opacity(0.06)
    static let panelStrong = Color.white.opacity(0.10)
    static let border = Color.white.opacity(0.12)
    static let accent = Color(red: 0.35, green: 0.88, blue: 0.81)
    static let accent2 = Color(red: 0.54, green: 0.76, blue: 1.0)
    static let accent3 = Color(red: 1.0, green: 0.76, blue: 0.27)
    static let textMuted = Color.white.opacity(0.68)
}

struct AgentBeatsBackdrop: View {
    var body: some View {
        ZStack {
            AgentBeatsPalette.background
                .ignoresSafeArea()

            LinearGradient(
                colors: [
                    AgentBeatsPalette.accent.opacity(0.18),
                    .clear,
                    AgentBeatsPalette.accent2.opacity(0.20),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .blur(radius: 50)
            .ignoresSafeArea()

            Circle()
                .fill(AgentBeatsPalette.accent.opacity(0.10))
                .frame(width: 240, height: 240)
                .blur(radius: 70)
                .offset(x: 140, y: -280)

            Circle()
                .fill(AgentBeatsPalette.accent2.opacity(0.09))
                .frame(width: 300, height: 300)
                .blur(radius: 80)
                .offset(x: -140, y: 420)
        }
    }
}

struct AgentBeatsCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(AgentBeatsPalette.panel)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .stroke(AgentBeatsPalette.border, lineWidth: 1)
                    )
            )
    }
}

struct AgentBeatsSectionHeader: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title.uppercased())
                .font(.caption.weight(.semibold))
                .tracking(2.6)
                .foregroundStyle(AgentBeatsPalette.textMuted)
            Text(subtitle)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
        }
    }
}

struct AgentBeatsMetricPill: View {
    let label: String
    let value: String
    var tint: Color = AgentBeatsPalette.accent

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label.uppercased())
                .font(.caption2.weight(.semibold))
                .tracking(1.3)
                .foregroundStyle(AgentBeatsPalette.textMuted)
            Text(value)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(tint.opacity(0.12))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(tint.opacity(0.24), lineWidth: 1)
                )
        )
    }
}

struct AgentBeatsStatusChip: View {
    let text: String
    var tint: Color = AgentBeatsPalette.accent

    var body: some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule(style: .continuous)
                    .fill(tint.opacity(0.22))
                    .overlay(Capsule(style: .continuous).stroke(tint.opacity(0.40), lineWidth: 1))
            )
    }
}

struct AgentBeatsProgressBar: View {
    let progress: Double
    var tint: Color = AgentBeatsPalette.accent
    var height: CGFloat = 10

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white.opacity(0.08))
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [tint, AgentBeatsPalette.accent2],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: max(min(width * max(0, min(progress, 1)), width), 0))
            }
        }
        .frame(height: height)
    }
}

struct AgentBeatsRing: View {
    let progress: Double
    var tint: Color = AgentBeatsPalette.accent
    var label: String
    var detail: String

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.08), lineWidth: 14)

            Circle()
                .trim(from: 0, to: max(0, min(progress, 1)))
                .stroke(
                    LinearGradient(
                        colors: [tint, AgentBeatsPalette.accent2],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: 14, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.spring(response: 0.38, dampingFraction: 0.9), value: progress)

            VStack(spacing: 4) {
                Text(label)
                    .font(.caption.weight(.semibold))
                    .tracking(1.6)
                    .foregroundStyle(AgentBeatsPalette.textMuted)
                Text(detail)
                    .font(.system(.title2, design: .rounded).weight(.semibold))
                    .foregroundStyle(.white)
            }
        }
    }
}
