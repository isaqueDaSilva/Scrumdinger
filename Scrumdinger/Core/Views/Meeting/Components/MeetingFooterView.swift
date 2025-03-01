//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 28/04/24.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    var skipAction: (() -> Void)
    
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted } ) else {
            return nil
        }
        
        return index + 1
    }
    
    private var isLastSpeaker: Bool {
        speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    
    private var speakerText: String {
        guard let speakerNumber else { return "No more Speakers" }
        
        let textForNonLastSpeaker = "Speaker \(speakerNumber) of \(speakers.count)"
        let textForLastSpeaker = "Last Speaker"
        
        return isLastSpeaker ? textForLastSpeaker : textForNonLastSpeaker
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(speakerText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    skipAction()
                } label: {
                    Icon.forwardFill.systemImage
                }
                .accessibilityLabel("Next speaker")
            }
        }
        .padding([.bottom, .horizontal])
    }
}

#Preview {
    MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers) { }
}
