//
//  History.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 28/04/24.
//

import Foundation

struct History: Identifiable, Hashable, Codable {
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    var transcript: String?

    init(
        id: UUID = UUID(),
        date: Date = .now,
        attendees: [DailyScrum.Attendee],
        transcript: String?
    ) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.transcript = transcript
    }
}
