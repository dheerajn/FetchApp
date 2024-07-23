//
//  DessertsDetailsViewModelTests.swift
//  FetchWorkTests
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import XCTest
@testable import FetchWork

final class DessertsDetailsViewModelTests: XCTestCase {
    func testSuccessfulFetchDesserts() async throws {
        let mockAPIClient = MockAPIClient()
        let mockMealData = MealData(idMeal: "1",
                                    meal: "Spaghetti Carbonara",
                                    instructions: "Some instructions",
                                    ingredient1: "1",
                                    ingredient2: "2",
                                    ingredient3: "3",
                                    ingredient4: "4",
                                    ingredient5: "5",
                                    ingredient6: "",
                                    ingredient7: "",
                                    ingredient8: "",
                                    ingredient9: "",
                                    ingredient10: "",
                                    ingredient11: "",
                                    ingredient12: "",
                                    ingredient13: "",
                                    ingredient14: "",
                                    ingredient15: "",
                                    ingredient16: "",
                                    ingredient17: "",
                                    ingredient18: "",
                                    ingredient19: "",
                                    ingredient20: "")

        mockAPIClient.fetchMealsContainerReturnValue = MealsContainer(meals: [mockMealData])
        let viewModel = DessertDetailsViewModel(mealId: "1234", apiClient: mockAPIClient)
        
        XCTAssertEqual(viewModel.dessertAPICall, .inProgress)
        
        viewModel.fetchMealDetails()
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        XCTAssertEqual(viewModel.dessertAPICall, .ready)
        let dessertDetailsInfo = try XCTUnwrap(viewModel.dessertDetailsInfo)
        XCTAssertEqual(dessertDetailsInfo.mealName, "Spaghetti Carbonara")
        XCTAssertEqual(dessertDetailsInfo.instructions, "Some instructions")
        XCTAssertFalse(dessertDetailsInfo.allIngredients.isEmpty)
    }

    func testFailurefulFetchDesserts() async throws {
        let mockAPIClient = MockAPIClient()
        mockAPIClient.fetchMealsContainerError = NSError(domain: "domain", code: -1000)
        let viewModel = DessertDetailsViewModel(mealId: "1234", apiClient: mockAPIClient)
        XCTAssertEqual(viewModel.dessertAPICall, .inProgress)
        
        viewModel.fetchMealDetails()
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        XCTAssertEqual(viewModel.dessertAPICall, .error)
    }
}
