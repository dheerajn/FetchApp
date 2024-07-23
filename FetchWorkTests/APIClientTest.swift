//
//  APIClientTest.swift
//  FetchWorkTests
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import XCTest
@testable import FetchWork
import Foundation
import XCTest
import Combine

class MockURLSession: URLSessionProtocol {
    var nextData: Data?
    var nextError: Error?
    var response: URLResponse?

    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        if let error = nextError {
            throw error
        }
        guard let data = nextData, let response = response else {
            throw URLError(.badServerResponse)
        }
        return (data, response)
    }
}

class APIClientTests: XCTestCase {
    func testFetchDessertsSuccess() async throws {
        let mockSession = MockURLSession()
        let apiClient = APIClient(urlSession: mockSession)
        let expectedDesserts = Desserts(meals: [Meal(strMeal: "meal", strMealThumb: "thumb", idMeal: "id")])
        let jsonData = try JSONEncoder().encode(expectedDesserts)
        mockSession.nextData = jsonData
        mockSession.response = HTTPURLResponse(url: URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let desserts = try await apiClient.fetchDesserts()
        
        XCTAssertEqual(desserts.meals.first?.strMeal, expectedDesserts.meals.first?.strMeal)
        XCTAssertEqual(desserts.meals.first?.strMealThumb, expectedDesserts.meals.first?.strMealThumb)
        XCTAssertEqual(desserts.meals.first?.idMeal, expectedDesserts.meals.first?.idMeal)
    }

    func testFetchDessertsFailure() async throws {
        let mockSession = MockURLSession()
        let apiClient = APIClient(urlSession: mockSession)

        mockSession.nextError = URLError(.badServerResponse)

        do {
            _ = try await apiClient.fetchDesserts()
        } catch {
            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
        }
    }

    func testFetchMealDetailsSuccess() async throws {
        let mockSession = MockURLSession()
        let apiClient = APIClient(urlSession: mockSession)

        let expectedMealDetails = MealsContainer(meals: [MealData(
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
        )])
        let jsonData = try JSONEncoder().encode(expectedMealDetails)
        mockSession.nextData = jsonData
        mockSession.response = HTTPURLResponse(url: URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=testid")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        let mealDetails = try await apiClient.fetchMealDetails(id: "testid")

        XCTAssertEqual(mealDetails.meals.first?.strMeal, expectedMealDetails.meals.first?.strMeal)
    }

    func testFetchMealDetailsFailure() async throws {
        let mockSession = MockURLSession()
        let apiClient = APIClient(urlSession: mockSession)

        mockSession.nextError = URLError(.badServerResponse)

        do {
            _ = try await apiClient.fetchMealDetails(id: "testid")
        } catch {
            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
        }
    }
}
