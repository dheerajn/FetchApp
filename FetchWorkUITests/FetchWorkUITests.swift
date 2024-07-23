//
//  FetchWorkUITests.swift
//  FetchWorkUITests
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import XCTest

final class FetchWorkUITests: XCTestCase {
    private let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["isRunningUITests"]
    }

    func testDessertFlow() {
        mock(requestURL: "https://themealdb.com/api/json/v1/1/filter.php?c", withResource: "Desserts")
        app.launch()
        XCTAssertTrue(app.staticTexts["Carrot Cake"].exists)
        app.scrollToBottom()
        XCTAssertTrue(app.staticTexts["White chocolate creme brulee"].exists)
    }
}

private extension FetchWorkUITests {
    func mock(requestURL: String, withResource: String) {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: withResource, ofType: "json") {
            do {
                let data: String
                if #available(iOS 16.0, *) {
                    data = try String(contentsOf: URL(filePath: path))
                } else {
                    data = try String(contentsOf: URL(fileURLWithPath: path))
                }
                app.launchEnvironment[requestURL] = data
            } catch {
                XCTFail("Failed to load JSON: \(error.localizedDescription)")
            }
        } else {
            XCTFail("Failed to find JSON")
        }
    }
}

private extension XCUIApplication {
    func scrollToBottom() {
        // This is hardcoded for now but once we have actual data we will calculate based on business logic
        var maxScrolls = 5
        while maxScrolls > 0 {
            swipeUp()
            maxScrolls -= 1
        }
    }
}
