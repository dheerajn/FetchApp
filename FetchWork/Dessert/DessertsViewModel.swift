//
//  DessertsViewModel.swift
//  FetchWork
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import SwiftUI

class DessertsViewModel: ObservableObject {
    enum DessertStatus {
        case inProgress
        case ready
        case error
    }

    private(set) var desserts = [Meal]()
    private let apiClient: APIClientProtocol
    
    @Published var status = DessertStatus.inProgress
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchDesserts() async {
        do {
            let meals = try await apiClient.fetchDesserts().meals
            await MainActor.run {
                self.desserts = meals.sorted(by: { $0.strMeal < $1.strMeal })
                status = .ready
            }
        } catch {
            status = .error
        }
    }
}
