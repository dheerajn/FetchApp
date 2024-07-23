//
//  DessertDetailsViewModel.swift
//  FetchWork
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import SwiftUI

@Observable // from iOS 17
class DessertDetailsViewModel {
    struct DessertDetailsInfo {
        var mealName: String
        var instructions: String
        var allIngredients: [String]
    }

    enum DessertDetailsAPICall {
        case inProgress
        case ready
        case error
    }

    private let mealId: String
    private let apiClient: APIClientProtocol
    private(set) var dessertDetailsInfo: DessertDetailsInfo?

    var dessertAPICall: DessertDetailsAPICall = .inProgress

    init(mealId: String, apiClient: APIClientProtocol = APIClient()) {
        self.mealId = mealId
        self.apiClient = apiClient
    }
    
    /// Fetches the meal details using the identifier passed
    func fetchMealDetails() {
        Task {
            do {
                let mealContainer = try await apiClient.fetchMealDetails(id: mealId)
                
                guard let validMeal = mealContainer.meals.first else {
                    dessertAPICall = .error
                    return
                }
                await MainActor.run {
                    dessertDetailsInfo = DessertDetailsInfo(mealName: validMeal.strMeal,
                                                            instructions: validMeal.strInstructions,
                                                            allIngredients: validMeal.allIngredients)
                    dessertAPICall = .ready
                }
            } catch {
                dessertAPICall = .error
            }
        }
    }
}
