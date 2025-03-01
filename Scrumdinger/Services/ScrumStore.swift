//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 28/04/24.
//

import Foundation
import Observation

@Observable
@MainActor
final class ScrumStore {
    var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        .appending(path: "scrums.data")
    }
    
    func load() async throws {
        let task = Task<[DailyScrum], Error> {
            let fileURL = try Self.fileURL()
            
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            
            let decoder = JSONDecoder()
            let dailyScrums = try decoder.decode([DailyScrum].self, from: data)
            
            return dailyScrums
        }
        
        let scrums = try await task.value
        self.scrums = scrums
    }
    
    func save(scrums: [DailyScrum]) async throws {
        let task = Task {
            let encoder = JSONEncoder()
            let data = try encoder.encode(scrums)
            let outFile = try Self.fileURL()
            try data.write(to: outFile)
        }
        
        _ = try await task.value
    }
}
