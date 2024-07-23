//
//  MockAPIClient.swift
//  FetchWorkTests
//
//  Created by Dheeraj Neelam on 7/22/24.
//

@testable import FetchWork

final class MockAPIClient: APIClientProtocol {
    var fetchDessetsError: Error?
    var fetchDessertReturnValue: Desserts?
    
    func fetchDesserts() async throws -> FetchWork.Desserts {
        if let fetchDessetsError {
            throw fetchDessetsError
        }
        return fetchDessertReturnValue!
    }
    
    var fetchMealsContainerError: Error?
    var fetchMealsContainerReturnValue: MealsContainer?
    func fetchMealDetails(id: String) async throws -> FetchWork.MealsContainer {
        if let fetchMealsContainerError {
            throw fetchMealsContainerError
        }
        return fetchMealsContainerReturnValue!
    }
}
