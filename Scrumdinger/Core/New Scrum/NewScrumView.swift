//
//  NewScrumView.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 28/04/24.
//

import SwiftUI

struct NewScrumView: View {
    @Binding var isPresentingNewScrumView: Bool
    @Binding var scrums: [DailyScrum]
    
    @State private var newScrum = DailyScrum.emptyScrum
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewScrumView = false
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            scrums.append(newScrum)
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
}

#Preview {
    NewScrumView(isPresentingNewScrumView: .constant(true), scrums: .constant(DailyScrum.sampleData))
}
