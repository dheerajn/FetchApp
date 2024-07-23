//
//  AsyncImageView.swift
//  Fetch
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import SwiftUI

/// A SwiftUI view that asynchronously loads an image from a URL and displays either a placeholder or the loaded image once available.
///
/// The AsyncImageloader struct encapsulates the asynchronous loading of an image from a specified URL. It leverages SwiftUI's "imageLoader" environment key to handle the image loading process asynchronously. This allows the view to display a placeholder while the image is being fetched and to show the image once it's ready.
struct AsyncImageloader<Content, Placeholder>: View where Content : View, Placeholder: View {
    private let content: (Image) -> Content
    private let placeholder: () -> Placeholder
    private let url: URL
    
    @Environment(\.imageLoader) private var imageLoader
    
    /// To use AsyncImageloader, provide a URL pointing to the image, and define two views using SwiftUI's ViewBuilder:
    /// - Parameters:
    ///   - url: URL pointing to the image
    ///   - content: A view builder closure that takes an Content and returns Image.
    ///   - placeholder: A view builder closure that returns Placeholder, typically used to show a placeholder while the image is loading.
    init(url: URL, @ViewBuilder content: @escaping (Image) -> Content, @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }

    @State private var imageToSend: Image?
    
    var body: some View {
        VStack {
            if let imageToSend {
                content(imageToSend)
            } else {
                placeholder()
            }
        }
        .task {
            do {
                self.imageToSend = try await imageLoader.downloadImage(url)
            } catch {
                self.imageToSend = nil
            }
        }
    }
}

