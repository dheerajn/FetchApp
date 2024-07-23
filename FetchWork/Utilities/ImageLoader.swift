//
//  ImageLoader.swift
//  Fetch
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import SwiftUI

/// ImageLoader is a Swift actor designed to manage asynchronous downloading and caching of images from remote URLs. It leverages Swift's concurrency model introduced in Swift 5.5, utilizing async/await for non-blocking operations.
actor Imageloader {
    enum FetchError:Error{
        case badID
        case badImage
    }

    enum CacheEntry {
        case inProgress(Task<Image, Error>)
        case ready(Image)
    }

    private var cache = [URL: CacheEntry]()
    
    init() {
        print("imageLoader init")
    }
    
    /// Asynchronously downloads an image from a given URL.
    /// - Parameter url: The URL from which to download the image.
    /// - Returns: An optional Image. If the image is successfully downloaded and cached, returns the image. If the image is already cached, returns it immediately.
    func downloadImage(_ url: URL) async throws -> Image? {
        if let value = cache[url] {
            switch value {
            case .inProgress(let runningTask):
                return try await runningTask.value
                
            case .ready(let image):
                return image
            }
        }
        let downloadingImageTask = Task {
            try await downloadImageFrom(url)
        }
        cache[url] = .inProgress(downloadingImageTask)
        
        do {
            let downloadedImage = try await downloadingImageTask.value
            cache[url] = .ready(downloadedImage)
            return downloadedImage
        } catch {
            throw FetchError.badImage
        }
    }
    
    /// Handles the actual downloading of an image from a URL.
    /// - Parameter imageUrl:  The URL from which to download the image.
    /// - Returns: An Image object created from the downloaded data.
    private func downloadImageFrom(_ imageUrl: URL) async throws -> Image {
        try Task.checkCancellation()
        let imageRequest = URLRequest(url: imageUrl)
        let (data, imageResponse) = try await URLSession.shared.data(for: imageRequest)
        guard let image = UIImage(data: data), (imageResponse as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.badImage
        }
        return Image(uiImage: image)
    }
}
