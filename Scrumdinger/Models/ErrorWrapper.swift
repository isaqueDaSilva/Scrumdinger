//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 28/04/24.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id = UUID()
    let error: Error
    let guidance: String
}
