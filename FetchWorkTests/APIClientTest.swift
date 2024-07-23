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

        let expectedMealDetails = MealsContainer(meals: [MealData(idMeal: "1",
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
                                                                  ingredient20: "")])
        let jsonData = try JSONEncoder().encode(expectedMealDetails)
        mockSession.nextData = jsonData
        mockSession.response = HTTPURLResponse(url: URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=testid")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        let mealDetails = try await apiClient.fetchMealDetails(id: "testid")

        XCTAssertEqual(mealDetails.meals.first?.meal, expectedMealDetails.meals.first?.meal)
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
