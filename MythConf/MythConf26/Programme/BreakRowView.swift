//
//  BreakRowView.swift
//  IOSDevuk26
//

import SwiftUI

/// A full-width row for non-session slots such as breaks, lunch, and social events.
struct BreakRowView: View {
    @Environment(ViewModel.self) private var viewModel
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    let session: Session

    /// Tint opacity is bumped in Dark Mode so the themed colour stays
    /// visible against a near-black background instead of fading out.
    private var tintOpacity: Double {
        colorScheme == .dark ? 0.3 : 0.12
    }

    var body: some View {
        HStack {
            TimeColumnView(startTime: session.startTimeText, endTime: session.endTimeText)

            VStack(alignment: .leading) {
                Text(session.sessionType.displayName)
                    .italic()
                    .foregroundStyle(.primary)
                if let talkID = session.contentIDs.first {
                    Text(viewModel.locationNameFrom(talkID: talkID))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(theme.color(for: session.sessionType).opacity(tintOpacity))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(breakAccessibilityLabel)
    }

    private var breakAccessibilityLabel: String {
        let timeLabel = "\(session.startTimeText) to \(session.endTimeText)"
        if let talkID = session.contentIDs.first {
            return "\(session.sessionType.displayName), \(timeLabel), in \(viewModel.locationNameFrom(talkID: talkID))"
        }
        return "\(session.sessionType.displayName), \(timeLabel)"
    }
}

// MARK: - Preview

#Preview {
    let viewModel = ViewModel()
    let breakSession = viewModel.confData.sessions.flatMap { $0 }.first { !$0.containsTalk }!
    BreakRowView(session: breakSession)
        .environment(viewModel)
}
