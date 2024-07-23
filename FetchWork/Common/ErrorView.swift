//
//  ErrorView.swift
//  FetchWork
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        ContentUnavailableView("Error fetching data.", systemImage: "exclamationmark.icloud")
    }
}

#Preview {
    ErrorView()
}
