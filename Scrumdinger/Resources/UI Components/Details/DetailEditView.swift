//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 27/04/24.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section("Meeting Info") {
                TextField("Title", text: $scrum.title)
                
                HStack {
                    Slider(
                        value: $scrum.lengthInMinutesAsDouble,
                        in: 5...30,
                        step: 1
                    ) {
                        Text("Lengh")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                
                ThemePicker(selection: $scrum.theme)
            }
            
            Section("Attendees") {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indexSet in
                    scrum.attendees.remove(atOffsets: indexSet)
                }
                
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    
                    Button {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                        
                    } label: {
                        Icon.plusCircleFill.systemImage
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

#Preview {
    DetailEditView(scrum: .constant(.sampleData[0]))
}
