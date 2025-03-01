//
//  HistoryView.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 29/04/24.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                
                Text("Attendees")
                    .font(.headline)
                
                Text(history.attendeeString)
                
                if let transcript = history.transcript {
                    Text("Transcription")
                        .font(.headline)
                        .padding(.top)
                    
                    Text(transcript)
                }
            }
        }
        .navigationTitle("\(history.date, style: .date)")
        .padding()
    }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name } )
    }
}

#Preview {
    let history = History(
        attendees: [
            .init(name: "Jon"),
            .init(name: "Darla"),
            .init(name: "Luis")
        ],
        transcript: "Darla, would you like to start today? Sure, yesterday I reviewed Luis' PR and met with the design team to finalize the UI..."
    )
    
    return NavigationStack { HistoryView(history: history) }
}
