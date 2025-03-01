//
//  MainScene.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 2/28/25.
//

import SwiftUI

struct MainScene: Scene {
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
