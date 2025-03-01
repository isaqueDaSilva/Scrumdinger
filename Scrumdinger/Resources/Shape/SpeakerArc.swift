//
//  SpeakerArc.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 29/04/24.
//

import SwiftUI

struct SpeakerArc: Shape {
    let speakerIndex: Int
    let totalSpeakers: Int
    
    private var degressPerSpeaker: Double {
        360 / Double(totalSpeakers)
    }
    
    private var startAngle: Angle {
        .init(degrees: degressPerSpeaker * Double(speakerIndex) + 1.0)
    }
    
    private var endAngle: Angle {
        .init(degrees: startAngle.degrees + degressPerSpeaker - 1.0)
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        return Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false
            )
        }
    }
    
    init(in speakerIndex: Int, for totalSpeakers: Int) {
        self.speakerIndex = speakerIndex
        self.totalSpeakers = totalSpeakers
    }
}

#Preview {
    SpeakerArc(in: 2, for: 4)
        .stroke(lineWidth: 10)
}
