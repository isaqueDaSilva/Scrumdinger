//
//  ScrumProgressViewStyle.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 27/04/24.
//

import SwiftUI

struct ScrumProgressViewStyle: ProgressViewStyle {
    let theme: Theme
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(theme.accentColor)
                .frame(height: 20)
            
            if #available(iOS 15, *) {
                ProgressView(configuration)
                    .tint(theme.mainColor)
                    .frame(height: 12)
                    .padding(.horizontal)
            } else {
                ProgressView(configuration)
                    .frame(height: 12)
                    .padding(.horizontal)
            }
        }
    }
}

extension ProgressViewStyle where Self == ScrumProgressViewStyle {
    static func scrumProgress(_ theme: Theme) -> Self {
        Self(theme: theme)
    }
}

#Preview {
    ProgressView(value: 0.5)
        .progressViewStyle(.scrumProgress(.yellow))
        .padding()
}
