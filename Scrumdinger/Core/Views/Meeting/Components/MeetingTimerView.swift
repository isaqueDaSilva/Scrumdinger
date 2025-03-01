//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 29/04/24.
//

import SwiftUI

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme
    let isRecording: Bool
    
    private var currentSpeaker: String {
        speakers.first(where: { !$0.isCompleted })?.name ?? "Someone"
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    
                    Text("Is speaking")
                    
                    Group {
                        if isRecording {
                            Icon.mic.systemImage
                        } else {
                            Icon.micSlash.systemImage
                        }
                    }
                    .font(.title)
                    .padding(.top)
                    .accessibilityLabel(isRecording ? "With transcription" : "Without transcription")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted,
                       let speakerIndex = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(in: speakerIndex, for: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12)
                    }
                }
            }
            .padding(.horizontal)
    }
}

#Preview {
    var speakers: [ScrumTimer.Speaker] {
            [ScrumTimer.Speaker(name: "Bill", isCompleted: true), ScrumTimer.Speaker(name: "Cathy", isCompleted: false)]
        }
    
    return MeetingTimerView(speakers: speakers, theme: .bubblegum, isRecording: true)
        .padding()
}
