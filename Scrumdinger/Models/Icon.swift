//
//  Icon.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 26/04/24.
//

import SwiftUI

enum Icon: String {
    case hourglassTopHalfFill = "hourglass.tophalf.fill"
    case hourglassBottomHalfFill = "hourglass.bottomhalf.fill"
    case forwardFill = "forward.fill"
    case person = "person"
    case person3 = "person.3"
    case clock = "clock"
    case timer = "timer"
    case plus = "plus"
    case plusCircleFill = "plus.circle.fill"
    case paintPalette = "paintpalette"
    case calendar = "calendar"
    case calendarBadgeExclamtionMark = "calendar.badge.exclamationmark"
    case mic = "mic"
    case micSlash = "mic.slash"
    
    var systemImage: Image {
        .init(systemName: rawValue)
    }
}
