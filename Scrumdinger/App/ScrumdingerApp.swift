//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 26/04/24.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var errorWrapper: ErrorWrapper?
    @State private var store = ScrumStore()
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) {
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch let error {
                        errorWrapper = .init(
                            error: error,
                            guidance: "Try again later."
                        )
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch let error {
                    errorWrapper = .init(
                        error: error,
                        guidance: "Scrumdinger will load sample data and continue."
                    )
                }
            }
            .sheet(item: $errorWrapper) {
                store.scrums = DailyScrum.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }

        }
    }
}
