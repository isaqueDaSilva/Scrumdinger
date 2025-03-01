//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 27/04/24.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) {
                ThemeView(theme: $0)
                    .tag($0.id)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

#Preview {
    ThemePicker(selection: .constant(.orange))
}
