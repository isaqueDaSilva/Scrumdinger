//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 27/04/24.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresentingNewScrum = false
    
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink {
                    DetailView(scrum: $scrum)
                } label: {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button {
                    isPresentingNewScrum = true
                } label: {
                    Icon.plus.systemImage
                }
                .accessibilityLabel("New Scrum")
            }
            .sheet(isPresented: $isPresentingNewScrum) {
                NewScrumView(
                    isPresentingNewScrumView: $isPresentingNewScrum,
                    scrums: $scrums
                )
            }
            .onChange(of: scenePhase) { oldValue, newValue in
                guard newValue != oldValue else { return }
                
                if newValue == .inactive {
                    saveAction()
                }
            }
        }
    }
}

#Preview {
    ScrumsView(scrums: .constant(DailyScrum.sampleData)) { }
}
