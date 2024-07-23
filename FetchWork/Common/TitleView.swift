//
//  TitleView.swift
//  FetchWork
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import SwiftUI

/// The TitleView struct provides a simple way to display a title string in SwiftUI with a predefined font style.
struct TitleView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.title)
    }
}

#Preview {
    TitleView(title: "Title")
}
