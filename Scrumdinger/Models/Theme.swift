//
//  Theme.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 26/04/24.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    case bubblegum
    case buttercup
    case indigo = "indigo-my"
    case lavender
    case magenta = "magenta-my"
    case navy
    case orange = "orange-my"
    case oxblood
    case periwinkle
    case poppy
    case purple = "purple-my"
    case seafoam
    case sky
    case tan
    case teal = "teal-my"
    case yellow = "yellow-my"
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow:
            return .black
        case .indigo, .magenta, .navy, .oxblood, .purple:
            return .white
        }
    }
    
    var mainColor: Color {
        Color(rawValue)
    }
    
    var name: String { rawValue.capitalized }
    
    var id: Self { self }
}
