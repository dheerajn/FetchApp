//
//  TestDetector.swift
//  FetchWork
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import Foundation

/// Helps to detect if the app is running UI test cases
struct TestDetector {
    /// Tell if the app is runnning UI test cases
    static var isRunningUITests: Bool {
        ProcessInfo.processInfo.arguments.contains("isRunningUITests")
    }
    
    /// This dictionary will contain all the metadata when the app is launched. It also includes mocked response of the API is loaded before launching the app
    static var mockedRequest: [String: String] {
        ProcessInfo.processInfo.environment
    }
}
