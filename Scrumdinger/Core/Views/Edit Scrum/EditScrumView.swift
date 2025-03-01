//
//  EditScrumView.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 28/04/24.
//

import SwiftUI

struct EditScrumView: View {
    @Binding var scrum: DailyScrum
    @Binding var isPresentingEditView: Bool
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $scrum)
                .navigationTitle(scrum.title)
                .toolbar {
                    Button("Done") {
                        isPresentingEditView = false
                    }
                }
        }
    }
}

#Preview {
    EditScrumView(
        scrum: .constant(.sampleData[0]),
        isPresentingEditView: .constant(true)
    )
}
