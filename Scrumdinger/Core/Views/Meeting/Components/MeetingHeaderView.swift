//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 27/04/24.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsReaining: Int
    let theme: Theme
    
    private var totalSeconds: Int {
        secondsElapsed + secondsReaining
    }
    
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    private var minutesRemaining: Int {
        secondsReaining / 60
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(.scrumProgress(theme))
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    
                    Label(
                        title: { Text(secondsElapsed, format: .number) },
                        icon: { Icon.hourglassTopHalfFill.systemImage }
                    )
                    .labelStyle(.trailingIcon)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    
                    Label(
                        title: { Text(secondsReaining, format: .number) },
                        icon: { Icon.hourglassBottomHalfFill.systemImage }
                    )
                
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) Minutes")
        .padding([.top, .horizontal])
    }
}

#Preview {
    MeetingHeaderView(secondsElapsed: 300, secondsReaining: 600, theme: .yellow)
}
