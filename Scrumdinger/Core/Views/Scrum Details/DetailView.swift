//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 27/04/24.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section("Meeting Info") {
                NavigationLink {
                    MeetingView(scrum: $scrum)
                } label: {
                    Label(
                        title: { Text("Start Meeting") },
                        icon: { Icon.timer.systemImage }
                    )
                    .font(.headline)
                    .foregroundStyle(Color.accentColor)
                }
                
                HStack {
                    Label(
                        title: { Text("Length") },
                        icon: { Icon.clock.systemImage }
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                
                HStack {
                    Label(
                        title: { Text("Theme") },
                        icon: { Icon.paintPalette.systemImage }
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundStyle(scrum.theme.accentColor)
                        .background {
                            scrum.theme.mainColor
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                .accessibilityElement(children: .combine)
                
            }
            
            Section("Attendees") {
                ForEach(scrum.attendees) { attendee in
                    Label(
                        title: { Text(attendee.name) },
                        icon: { Icon.person.systemImage }
                    )
                }
            }
            
            Section("History") {
                if scrum.history.isEmpty {
                    Label(
                        title: { Text("No meetings yet") },
                        icon: { Icon.calendarBadgeExclamtionMark.systemImage }
                    )
                } else {
                    ForEach(scrum.history) { history in
                        NavigationLink(
                            destination: HistoryView(history: history)
                        ) {
                            HStack {
                                Icon.calendar.systemImage
                                Text(history.date, style: .date)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
        .sheet(isPresented: $isPresentingEditView) {
            EditScrumView(
                scrum: $scrum,
                isPresentingEditView: $isPresentingEditView
            )
        }
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(scrum: .constant(.sampleData[0]))
    }
}
