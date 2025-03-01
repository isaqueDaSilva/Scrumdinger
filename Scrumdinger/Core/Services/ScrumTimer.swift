//
//  ScrumTimer.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 27/04/24.
//

import Foundation
import Observation

@Observable
@MainActor
final class ScrumTimer {
    var activeSpeaker = ""
    var secondsElapsed = 0
    var secondsRemaining = 0
    
    private(set) var speakers: [Speaker] = []
    private(set) var lengthInMinutes: Int
    
    var speakerChangeAction: (() -> Void)?
    
    private weak var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    
    private var secondsPerSpeaker: Int {
        (lengthInMinutes * 60) / speakers.count
    }
    
    private var secondsElapsedForSpeaker = 0
    private var speakerIndex: Int = 0
    private var speakerText: String {
        "Speaker \(speakerIndex + 1): \(speakers[speakerIndex].name)"
    }
    
    private var startDate: Date?
    
    func startScrum() {
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            guard let self else { return }
            self.update()
        }
        
        timer?.tolerance = 0.1
        changeToSpeaker(at: 0)
    }
    
    func stopScrum() {
        timer?.invalidate()
        timerStopped = true
    }
    
    nonisolated func skipSpeaker() {
        Task { @MainActor in
            changeToSpeaker(at: speakerIndex + 1)
        }
    }
    
    private func changeToSpeaker(at index: Int) {
        if index > 0 {
            let previousSpeaker = index - 1
            speakers[previousSpeaker].isCompleted = true
        }
        
        secondsElapsedForSpeaker = 0
        
        guard index < speakers.count else { return }
        
        speakerIndex = index
        
        activeSpeaker = speakerText
        
        secondsElapsed = index * secondsPerSpeaker
        secondsRemaining = lengthInSeconds - secondsElapsed
        startDate = .now
    }
    
    nonisolated private func update() {
        Task { @MainActor in
            guard let startDate, !timerStopped else { return }
            
            let secondsElapsed = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            secondsElapsedForSpeaker = secondsElapsed
            self.secondsElapsed = secondsPerSpeaker * speakerIndex + secondsElapsedForSpeaker
            
            guard secondsElapsed <= secondsPerSpeaker else { return }
            
            secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)
            
            if secondsElapsedForSpeaker >= secondsPerSpeaker {
                changeToSpeaker(at: speakerIndex + 1)
                speakerChangeAction?()
            }
        }
    }
    
    func resert(
        lengthInMinutes: Int,
        attendees: [DailyScrum.Attendee]
    ) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
    }
    
    init(
        lengthInMinutes: Int = 0,
        attendees: [DailyScrum.Attendee] = []
    ) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
}

extension ScrumTimer {
    struct Speaker: Identifiable {
        let id = UUID()
        var name: String
        var isCompleted: Bool = false
    }
}

extension Array<DailyScrum.Attendee> {
    var speakers: [ScrumTimer.Speaker] {
        if isEmpty {
            return [ScrumTimer.Speaker(name: "Speaker 1")]
        } else {
            return map { ScrumTimer.Speaker(name: $0.name) }
        }
    }
}
