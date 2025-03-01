//
//  CardView.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 27/04/24.
//

import SwiftUI

struct CardView: View {
    let scrum: DailyScrum
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(scrum.title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityAddTraits(.isHeader)
            
            HStack {
                Label(
                    title: { Text(scrum.attendees.count, format: .number) },
                    icon: { Icon.person3.systemImage }
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityLabel("\(scrum.attendees.count) attendees")
                
                Label(
                    title: { Text(scrum.lengthInMinutes, format: .number) },
                    icon: { Icon.clock.systemImage }
                )
                .labelStyle(.trailingIcon)
                .accessibilityLabel("\(scrum.lengthInMinutes) minute meeting")
            }
            .font(.caption)
        }
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
    }
}

#Preview {
    let sampleScrum: DailyScrum = .sampleData[0]
    
    return CardView(scrum: sampleScrum)
        .background {
            sampleScrum.theme.mainColor
        }
}
