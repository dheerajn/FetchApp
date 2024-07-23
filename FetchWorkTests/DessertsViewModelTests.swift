//
//  DessertsViewModelTests.swift
//  FetchWorkTests
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import XCTest
@testable import FetchWork

final class DessertsViewModelTests: XCTestCase {
    func testSuccessfulFetchDesserts() async {
        let mockAPIClient = MockAPIClient()
        mockAPIClient.fetchDessertReturnValue = Desserts(meals: [Meal(strMeal: "strMeal", strMealThumb: "strMeanThumb", idMeal: "idMeal")])
        let viewModel = DessertsViewModel(apiClient: mockAPIClient)
        XCTAssertEqual(viewModel.status, .inProgress)
        
        await viewModel.fetchDesserts()
        
        XCTAssertEqual(viewModel.status, .ready)
        XCTAssertEqual(viewModel.desserts.count, 1)
        XCTAssertEqual(viewModel.desserts.first?.strMeal, "strMeal")
        XCTAssertEqual(viewModel.desserts.first?.strMealThumb, "strMeanThumb")
        XCTAssertEqual(viewModel.desserts.first?.idMeal, "idMeal")
    }

    func testFailFetchDesserts() async {
        let mockAPIClient = MockAPIClient()
        mockAPIClient.fetchDessetsError = NSError(domain: "domani", code: -1000)
        let viewModel = DessertsViewModel(apiClient: mockAPIClient)
        XCTAssertEqual(viewModel.status, .inProgress)
        
        await viewModel.fetchDesserts()
        
        XCTAssertEqual(viewModel.status, .error)
    }
}
