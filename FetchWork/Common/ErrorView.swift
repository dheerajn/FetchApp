//
//  ErrorView.swift
//  FetchWork
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import SwiftUI

struct ErrorView: View {
    private let errorString = "Error fetching data."
    var body: some View {
        if #available(iOS 17.0, *) {
            ContentUnavailableView(errorString, systemImage: "exclamationmark.icloud")
        } else {
            Text(errorString)
        }
    }
}

#Preview {
    ErrorView()
}
