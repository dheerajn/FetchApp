//
//  CaptionView.swift
//  FetchWork
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import SwiftUI

/// The CaptionView struct provides a simple way to display a title string in SwiftUI with a predefined font style.
struct CaptionView: View {
    let caption: String
    
    var body: some View {
        Text(caption)
            .font(.caption)
    }
}

#Preview {
    CaptionView(caption: "Caption")
}
