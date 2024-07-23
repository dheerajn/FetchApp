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
        let mockMealData = MealData(
            idMeal: "1",
            strMeal: "Spaghetti Carbonara",
            strDrinkAlternate: "Non-Alcoholic Version",
            strCategory: "Pasta",
            strArea: "Italian",
            strInstructions: "Some instructions",
            strMealThumb: "https://example.com/spaghetti.jpg",
            strTags: "italian,pasta,creamy",
            strYoutube: "https://youtube.com/watch?v=12345",
            strIngredient1: "1",
            strIngredient2: "2",
            strIngredient3: "3",
            strIngredient4: "4",
            strIngredient5: "5",
            strIngredient6: "",
            strIngredient7: "",
            strIngredient8: "",
            strIngredient9: "",
            strIngredient10: "",
            strIngredient11: "",
            strIngredient12: "",
            strIngredient13: "",
            strIngredient14: "",
            strIngredient15: "",
            strIngredient16: "",
            strIngredient17: "",
            strIngredient18: "",
            strIngredient19: "",
            strIngredient20: "",
            strMeasure1: "200g",
            strMeasure2: "100g",
            strMeasure3: "2",
            strMeasure4: "1/2 cup",
            strMeasure5: "To taste",
            strMeasure6: "",
            strMeasure7: "",
            strMeasure8: "",
            strMeasure9: "",
            strMeasure10: "",
            strMeasure11: "",
            strMeasure12: "",
            strMeasure13: "",
            strMeasure14: "",
            strMeasure15: "",
            strMeasure16: "",
            strMeasure17: "",
            strMeasure18: "",
            strMeasure19: "",
            strMeasure20: "",
            strSource: "https://example.com/recipe",
            strImageSource: "https://example.com/spaghetti.jpg",
            strCreativeCommonsConfirmed: "Yes",
            dateModified: "2024-07-22"
        )

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
