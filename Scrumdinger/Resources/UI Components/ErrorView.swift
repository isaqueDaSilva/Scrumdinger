//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by Isaque da Silva on 28/04/24.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                    .frame(maxHeight: .infinity, alignment: .top)
            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .toolbar {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    enum SampleError: Error {
        case requiredError
    }
    
    var sampleWrapper: ErrorWrapper {
        ErrorWrapper(
            error: SampleError.requiredError,
            guidance: "You can safely ignore this error."
        )
    }
    
    return ErrorView(errorWrapper: sampleWrapper)
}
