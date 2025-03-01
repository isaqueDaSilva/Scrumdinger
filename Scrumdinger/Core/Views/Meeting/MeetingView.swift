//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 26/04/24.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    
    @State private var isRecording = false
    
    @State var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    private var player: AVPlayer { .sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(
                    secondsElapsed: scrumTimer.secondsElapsed,
                    secondsReaining: scrumTimer.secondsRemaining,
                    theme: scrum.theme
                )
                
                MeetingTimerView(
                    speakers: scrumTimer.speakers,
                    theme: scrum.theme, 
                    isRecording: isRecording
                )
                
                MeetingFooterView(
                    speakers: scrumTimer.speakers,
                    skipAction: scrumTimer.skipSpeaker
                )
            }
            .navigationTitle("Timer")
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding()
        .onAppear {
            startScrum()
        }
        .onDisappear {
            endScrum()
        }
        .foregroundStyle(scrum.theme.accentColor)
    }
}

extension MeetingView {
    fileprivate func startScrum() {
        scrumTimer.resert(
            lengthInMinutes: scrum.lengthInMinutes,
            attendees: scrum.attendees
        )
        
        scrumTimer.speakerChangeAction = {
            player.seek(to: .zero)
            player.play()
        }
        
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        scrumTimer.startScrum()
    }
    
    fileprivate func endScrum() {
        scrumTimer.stopScrum()
        speechRecognizer.stopTranscribing()
        isRecording = false
        let newHistoty = History(
            attendees: scrum.attendees,
            transcript: speechRecognizer.transcript
        )
        scrum.history.insert(newHistoty, at: 0)
    }
}

#Preview {
    NavigationStack {
        MeetingView(scrum: .constant(.emptyScrum))
    }
}
