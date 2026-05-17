//
//  ParallelSessionsRowView.swift
//  IOSDevuk26
//

import SwiftUI

/// A row displaying two parallel sessions side by side.
struct ParallelSessionsRowView: View {
    let session: Session

    var body: some View {
        HStack(alignment: .top) {
            TimeColumnView(startTime: session.startTimeText, endTime: session.endTimeText)

            HStack(alignment: .top) {
                ForEach(session.contentIDs, id: \.self) { talkID in
                    ParallelTalkCardView(talkID: talkID, session: session)
                }
            }
        }
        .padding()
    }
}

// MARK: - Preview

#Preview {
    let viewModel = ViewModel()
    let session = viewModel.confData.sessions.flatMap { $0 }.first { $0.containsTalk }!
    NavigationStack {
        ScrollView {
            LazyVStack(spacing: 0) {
                ParallelSessionsRowView(session: session)
            }
        }
    }
    .environment(viewModel)
}
