//
//  EnvironmentValuesExtension.swift
//  Fetch
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import SwiftUI

struct ImageloaderKey: EnvironmentKey {
    static var defaultValue = Imageloader()
}

extension EnvironmentValues {
//    @Entry var imageLoader = Imageloader() // work on Xcode 16 beta
    var imageLoader: Imageloader {
        get {
            self[ImageloaderKey.self]
        }
        set {
            self[ImageloaderKey.self] = newValue
        }
    }
}
